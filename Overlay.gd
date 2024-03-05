extends Control



func _on_overlay_back_button_pressed():
	$".".visible = false

func reset_overlay():
	for child in get_children():
		child.visible = false


func _on_control_overlay_triggered():
	for child in get_children():
		child.visible = false
	$OverlayBackButton.visible = true
