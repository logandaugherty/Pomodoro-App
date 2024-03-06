extends HBoxContainer

signal open_overlay(type:String)

func _on_schedule_button_pressed():
	open_overlay.emit("Schedule")

func _on_stats_button_pressed():
	open_overlay.emit("Stats")

func _on_settings_button_pressed():
	open_overlay.emit("Settings")
