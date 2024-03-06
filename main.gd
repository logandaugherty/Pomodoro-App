extends Control

# Update Components visible based on window size
func update_layout():
	# Store the screen size
	var screen_size = get_tree().get_root().size
	
	# If the Y component of the screen is less than 500 pixels
	if screen_size.y < 500:
		# Hide the title and top ribbon buttons
		$VBoxContainer/Title.visible = false
		$VBoxContainer/OptionsContainer.visible = false
	
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
