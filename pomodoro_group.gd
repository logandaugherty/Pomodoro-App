extends Control

var SCALE_SIZE_TIME = 0.8
var SCALE_SIZE_GOAL = 0.7

func update_text():
	$TimeManagement/TimeLeft["theme_override_font_sizes/normal_font_size"] = $TimeManagement/TimeLeft.size.y * SCALE_SIZE_TIME
	$TimeManagement/EndCondtions/PomosLeft["theme_override_font_sizes/font_size"] = $TimeManagement/EndCondtions/PomosLeft.size.y * SCALE_SIZE_GOAL
	$TimeManagement/EndCondtions/EndTime["theme_override_font_sizes/font_size"] = $TimeManagement/EndCondtions/EndTime.size.y * SCALE_SIZE_GOAL

func _process(delta):
	if DisplayServer.window_get_mode() == 2:
		update_text()
	elif DisplayServer.window_get_mode() == 0:
		update_text()

func _ready():
	get_tree().get_root().size_changed.connect(update_text)
	update_text()


func _on_select_class_pressed():
	$ClassList.visible = true

func _on_button_pressed():
	$ClassList.visible = false

func _on_item_list_item_selected(index):
	$ClassList.visible = false
	var index_of_selected = $ClassList.get_selected_items()[0]
	var text_of_selected = $ClassList.get_item_text(index_of_selected)
	$TimeManagement/SelectClass.text = text_of_selected
