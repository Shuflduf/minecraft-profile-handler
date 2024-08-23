extends Window




func _on_new_pack_pressed() -> void:
	show()
	%Name.text = ""


func _on_confirm_pressed() -> void:
	if %Name.text.is_empty():
		return
	DirAccess.make_dir_absolute("testingdir/" + %Name.text)
