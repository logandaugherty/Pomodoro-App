extends Control

func update_layout():
	var screen_size = get_tree().get_root().size
	if screen_size.y < 500:
		$VBoxContainer/Title.visible = false
		$VBoxContainer/OptionsContainer.visible = false
	else:
		$VBoxContainer/Title.visible = true
		$VBoxContainer/OptionsContainer.visible = true

func _ready():
	DisplayServer.window_set_min_size(Vector2(325,250))
	get_tree().get_root().size_changed.connect(update_layout)
	update_layout()

