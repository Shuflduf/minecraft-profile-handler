class_name Profile
extends PanelContainer

signal pressed

var text: String:
	set(value):
		$Label.text = value
	get:
		return $Label.text

var selected = false:
	set(value):
		selected = value
		if value == true:
			modulate = Color.RED
		else:
			modulate = Color.WHITE

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
				pressed.emit()
			if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
				$RightClick.position = event.global_position - Vector2(10, 10)
				$RightClick.show()

func _on_right_click_index_pressed(index: int) -> void:
	match index:
		0:
			var path = ProjectSettings.globalize_path(get_mods_path())
			OS.shell_show_in_file_manager(path)

func get_mods_path():
	return "testingdir/" + "PROFILE " + text


func _on_right_click_mouse_exited() -> void:
	$RightClick.hide()
