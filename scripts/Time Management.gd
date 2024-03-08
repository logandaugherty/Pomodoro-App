extends VBoxContainer

var time_remaining_s = 0
var time_target_s = 1
var time_enabled = false
var pomodoro_focused = true

var pomos_complete = 0
var pomos_target = 2

const POMODORO_DURATION_MIN = 25
const SHORT_BREAK_DURATION_MIN = 5
const LONG_BREAK_DURATION_MIN = 20

const LONG_BREAK_INTERVAL = 4

func _ready():
	set_pomodoro_time_min(POMODORO_DURATION_MIN)
	update_timer()
	update_end_time()
	update_pomos_left()

func increment_pomos():
	pomos_complete += 1

func time_complete():
	$AudioStreamPlayer2D.play()
	disable_timer()
	if pomodoro_focused:
		pomodoro_complete()
	else:
		break_complete()
	update_timer()
	update_end_time()

func pomodoro_complete():
	pomodoro_focused = false
	pomos_complete += 1
	update_pomos_left()
	if pomos_complete%LONG_BREAK_INTERVAL == 0:
		set_pomodoro_time_min(LONG_BREAK_DURATION_MIN)
	else:
		set_pomodoro_time_min(SHORT_BREAK_DURATION_MIN)


func break_complete():
	pomodoro_focused = true
	set_pomodoro_time_min(POMODORO_DURATION_MIN)

func set_pomodoro_time_min(minutes):
	$TimeLeftContainer/Skip.visible = false
	var seconds = int(minutes*60)
	time_remaining_s = seconds
	time_target_s = seconds

func set_pomodoro_time_s(seconds):
	time_remaining_s = seconds
	time_target_s = seconds

func decrement_pomodoro_time_s():
	time_remaining_s -= 1

func get_pomodoro_remaining_s():
	return time_remaining_s

func get_pomodoro_target_s():
	return time_target_s


func update_pomos_left():
	var display = "%d/%d" % [pomos_complete, pomos_target]
	$EndCondtions/PomosLeft.text = "Pomos: " + display

func update_progress_bar():
	$ProgressTimeLeft.value = get_pomodoro_remaining_s()/get_pomodoro_target_s()

func display_end_time(seconds_after_now):
	var current_time = Time.get_time_dict_from_system()
	var end_time = current_time
	end_time["second"] += seconds_after_now
	end_time["minute"] += int(end_time["second"] / 60)
	end_time["hour"] += int(end_time["minute"] / 60)
	
	end_time["second"] = end_time["second"] % 60
	end_time["minute"] = end_time["minute"] % 60
	end_time["hour"] = end_time["hour"] % 12
	
	if end_time["hour"] == 0:
		end_time["hour"] = 12
	
	var display = "%02d:%02d" % [end_time["hour"],end_time["minute"]]
	
	$EndCondtions/EndTime.text = "End Time: " + display
	

func calculate_end_time():
	var seconds_left_in_session = 0
	
	if not pomodoro_focused && pomos_complete < pomos_target:
		seconds_left_in_session += get_pomodoro_remaining_s()
	
	var iterations = pomos_target-pomos_complete
	
	for i in range(iterations):
		seconds_left_in_session += int(POMODORO_DURATION_MIN * 60)
		if i == iterations-1:
			continue
		if i % LONG_BREAK_INTERVAL == 0:
			seconds_left_in_session += int(LONG_BREAK_DURATION_MIN*60)
		else:
			seconds_left_in_session += int(SHORT_BREAK_DURATION_MIN*60)
	
	return seconds_left_in_session

func update_end_time():
	var seconds_left_in_session = calculate_end_time()
	display_end_time(seconds_left_in_session)

func update_timer():
	var time_min = floor(get_pomodoro_remaining_s()/60)
	var time_s = get_pomodoro_remaining_s()%60
	var display = "%02d:%02d" % [time_min,time_s]
	$TimeLeftContainer/TimeLeft.text = "[center]" + display + "[/center]"

func disable_timer():
	time_enabled = false
	$Timer.stop()
	$StartButton.text = "Start"

func enable_timer():
	time_enabled = true
	$Timer.start()
	$StartButton.text = "Stop"

func _on_start_button_pressed():
	update_end_time()
	$TimeLeftContainer/Skip.visible = true
	if time_enabled:
		disable_timer()
	else:
		enable_timer()


func _on_pomodoro_button_pressed():
	pomodoro_focused = true
	disable_timer()
	set_pomodoro_time_min(POMODORO_DURATION_MIN)
	update_timer()
	update_end_time()


func _on_short_break_button_pressed():
	pomodoro_focused = false
	disable_timer()
	set_pomodoro_time_min(SHORT_BREAK_DURATION_MIN)
	update_timer()
	update_end_time()


func _on_long_break_button_pressed():
	pomodoro_focused = false
	disable_timer()
	set_pomodoro_time_min(LONG_BREAK_DURATION_MIN)
	update_timer()
	update_end_time()

func _on_timer_timeout():
	if get_pomodoro_remaining_s() <= 1:
		time_complete()
	else:
		decrement_pomodoro_time_s()
		update_timer()

func _on_skip_pressed():
	time_complete()
