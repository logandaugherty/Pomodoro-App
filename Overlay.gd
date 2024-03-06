extends Control

func reset_overlay():
	for child in get_children():
		child.visible = false
	visible = false

func open_overlay(type):
	if type == "Stats":
		$StatsGroup.visible = true
	elif type == "Schedule":
		$ScheduleGroup.visible = true
	elif type == "Settings":
		$SettingsGroup.visible = true
	else:
		printerr("Invalid Overlay Attempted to Open: " + type)
	$OverlayBackButton.visible = true
	visible = true

func _on_overlay_back_button_pressed():
	reset_overlay()

func _on_options_container_open_overlay(type):
	reset_overlay()
	open_overlay(type)

