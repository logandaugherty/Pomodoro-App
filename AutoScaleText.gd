extends VBoxContainer

var SCALE_SIZE_TIME = 0.8
var SCALE_SIZE_GOAL = 0.7

func update_text():
	$TimeLeft["theme_override_font_sizes/normal_font_size"] = $TimeLeft.size.y * SCALE_SIZE_TIME
	$EndCondtions/PomosLeft["theme_override_font_sizes/font_size"] = $EndCondtions/PomosLeft.size.y * SCALE_SIZE_GOAL
	$EndCondtions/EndTime["theme_override_font_sizes/font_size"] = $EndCondtions/PomosLeft.size.y * SCALE_SIZE_GOAL

func _process(delta):
	if DisplayServer.window_get_mode() == 2:
		update_text()
	elif DisplayServer.window_get_mode() == 0:
		update_text()

func _ready():
	get_tree().get_root().size_changed.connect(update_text)
	$TimeLeft.text = "[center]25:00[/center]"
	update_text()
