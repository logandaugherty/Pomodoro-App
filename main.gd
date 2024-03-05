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

func overlay_triggered():
	for child in $Overlay.get_children():
		child.visible = false
	$Overlay/OverlayBackButton.visible = true
	$Overlay.visible = true

func _on_schedule_button_pressed():
	overlay_triggered()
	$Overlay/StatsGroup.visible = true


func _on_stats_button_pressed():
	overlay_triggered()
	$Overlay/ScheduleGroup.visible = true


func _on_settings_button_pressed():
	overlay_triggered()
	$Overlay/SettingsGroup.visible = true
