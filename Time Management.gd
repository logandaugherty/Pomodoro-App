extends VBoxContainer

var time_remaining_s = 0
var time_enabled = false

var pomos_left = 0
var pomos_target = 1

func _ready():
	set_time_remaining_min(25)
	update_timer()
	update_end_time()
	update_pomos_left()

func set_time_remaining_min(minutes):
	time_remaining_s = minutes*60

func set_time_remaining_s(seconds):
	time_remaining_s = seconds

func get_time_remaining_s():
	return time_remaining_s

func update_pomos_left():
	var display = "%d/%d" % [pomos_left, pomos_target]
	$EndCondtions/PomosLeft.text = "Pomos: " + display

func update_end_time():
	var current_time = Time.get_time_dict_from_system()
	var end_time = current_time
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
	disable_timer()
	set_time_remaining_min(25)
	update_timer()


func _on_short_break_button_pressed():
	disable_timer()
	set_time_remaining_min(5)
	update_timer()


func _on_long_break_button_pressed():
	disable_timer()
	set_time_remaining_min(10)
	update_timer()
