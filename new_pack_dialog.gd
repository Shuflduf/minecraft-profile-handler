extends Window


func _on_new_pack_pressed() -> void:
	show()
	%Name.text = ""


func _on_confirm_pressed() -> void:
	if %Name.text.is_empty():
		return
	DirAccess.make_dir_absolute(Global.minecraft_dir + "/PROFILE " + %Name.text)
	get_parent().add_profile(%Name.text)
	hide()


func _on_close_requested() -> void:
	hide()


func _on_cancel_pressed() -> void:
	_on_close_requested()
