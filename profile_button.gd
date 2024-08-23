extends PanelContainer

var text: String:
	set(value):
		$Label.text = value
	get:
		return $Label.text


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
				print("KAJSHJHG")
			if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
				$RightClick.position = event.global_position - Vector2(10, 10)
				$RightClick.show()

func _on_right_click_index_pressed(index: int) -> void:
	match index:
		0:
			var path = ProjectSettings.globalize_path("testingdir/" + "PROFILE " + text)
			print(path)
			OS.shell_show_in_file_manager(path)


func _on_right_click_mouse_exited() -> void:
	$RightClick.hide()
