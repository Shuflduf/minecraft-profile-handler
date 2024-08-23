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
			change_colour(Color.DARK_GRAY)
		else:
			change_colour(Color.DIM_GRAY)


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
		1:
			$ChangeName.show()
			$ChangeName/NewName.text = name
		2:
			OS.move_to_trash(get_mods_path())
			queue_free()

func get_mods_path() -> String:
	return Global.minecraft_dir + "/PROFILE " + text


func _on_right_click_mouse_exited() -> void:
	$RightClick.hide()


func _on_change_name_close_requested() -> void:
	$ChangeName.hide()


func _on_new_name_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	DirAccess.rename_absolute(get_mods_path(), Global.minecraft_dir + "/PROFILE " + new_text)
	text = new_text
	name = new_text
	$ChangeName.hide()

func change_colour(new_colour: Color):
	var stylebox = get_theme_stylebox("panel").duplicate()
	stylebox.bg_color = new_colour
	add_theme_stylebox_override("panel", stylebox)
