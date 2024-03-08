extends Control

# Update Components visible based on window size
func update_layout():
	# Store the screen size
	var screen_size = get_tree().get_root().size
	
	if screen_size.x < 600:
		$VBoxContainer/Title["theme_override_font_sizes/font_size"] = 55
		
	else:
		$VBoxContainer/Title["theme_override_font_sizes/font_size"] = 100
	
	if screen_size.y < 300:
		# Hide the title and top ribbon buttons
		$VBoxContainer/OptionsContainer.visible = false
	
	# If the Y component of the screen is less than 500 pixels
	if screen_size.y < 400:
		# Hide the title and top ribbon buttons
		$VBoxContainer/Title.visible = false
	# Otherwise, bring the title and top ribbon back into sight
	else:
		$VBoxContainer/Title.visible = true
		$VBoxContainer/OptionsContainer.visible = true

# Immediately before the first screen display
func _ready():
	# Set the minium dimensions of the screen in terms of pixels
	DisplayServer.window_set_min_size(Vector2(325,250))
	
	# Every time the size of screen changes, update the layout
	get_tree().get_root().size_changed.connect(update_layout)
	
	# Update the layout
	update_layout()
