extends VBoxContainer

var time_remaining_s = 0
var time_target_s = 1
var time_enabled = false
var pomodoro_focused = true

var pomos_complete = 1
var pomos_target = 1

const POMODORO_DURATION_MIN = 25
const SHORT_BREAK_DURATION_MIN = 5
const LONG_BREAK_DURATION_MIN = 20

const LONG_BREAK_INTERVAL = 4

func _ready():
	
	set_time_remaining_min(25)
	update_timer()
	update_end_time()
	update_pomos_left()

func set_pomodoro_time_min(minutes):
	set_time_remaining_min(minutes)
	time_target_s = minutes * 60

func set_pomodoro_time_s(seconds):
	set_time_remaining_s(seconds)
	time_target_s = seconds

func set_time_remaining_min(minutes):
	time_remaining_s = minutes*60

func set_time_remaining_s(seconds):
	time_remaining_s = seconds

func get_time_remaining_s():
	return time_remaining_s

func update_pomos_left():
	var display = "%d/%d" % [pomos_complete, pomos_target]
	$EndCondtions/PomosLeft.text = "Pomos: " + display

func update_progress_bar():
	$ProgressTimeLeft.value = get_time_remaining_s()/time_target_s

func update_end_time():
	var current_time = Time.get_time_dict_from_system()
	var end_time = current_time
	
	var seconds_left_in_session = 0
	
	if not pomodoro_focused:
		seconds_left_in_session += get_time_remaining_s()
	
	for i in range(pomos_target-pomos_complete):
		seconds_left_in_session += POMODORO_DURATION_MIN * 60
		if i % LONG_BREAK_INTERVAL == 0:
			seconds_left_in_session += LONG_BREAK_DURATION_MIN
		else:
			seconds_left_in_session += SHORT_BREAK_DURATION_MIN
	
	end_time["second"] += time_remaining_s
	end_time["minute"] += floor(end_time["second"] / 60)
	end_time["hour"] += floor(end_time["minute"] / 60)
	
	end_time["second"] = end_time["second"] % 60
	end_time["minute"] = end_time["minute"] % 60
	end_time["hour"] = end_time["hour"] % 12
	
	if end_time["hour"] == 0:
		end_time["hour"] = 12
	
	var display = "%02d:%02d" % [end_time["hour"],end_time["minute"]]
	
	$EndCondtions/EndTime.text = "End Time: " + display

func update_timer():
	var time_min = floor(time_remaining_s/60)
	var time_s = time_remaining_s%60
	var display = "%02d:%02d" % [time_min,time_s]
	$TimeLeft.text = "[center]" + display + "[/center]"

func disable_timer():
	time_enabled = false
	$Timer.stop()
	$StartButton.text = "Start"

func enable_timer():
	time_enabled = true
	$Timer.start()
	$StartButton.text = "Stop"

func _on_timer_timeout():
	if time_remaining_s <= 0:
		disable_timer()
	else:
		time_remaining_s -= 1
		update_timer()

func _on_start_button_pressed():
	if time_enabled:
		disable_timer()
	else:
		enable_timer()



func _on_pomodoro_button_pressed():
	pomodoro_focused = true
	disable_timer()
	set_time_remaining_min(POMODORO_DURATION_MIN)
	update_timer()
	update_end_time()


func _on_short_break_button_pressed():
	pomodoro_focused = false
	disable_timer()
	set_time_remaining_min(SHORT_BREAK_DURATION_MIN)
	update_timer()
	update_end_time()


func _on_long_break_button_pressed():
	pomodoro_focused = false
	disable_timer()
	set_time_remaining_min(LONG_BREAK_DURATION_MIN)
	update_timer()
	update_end_time()
