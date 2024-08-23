extends Window




func _on_close_requested() -> void:
	hide()


func _on_files_dropped(files: PackedStringArray) -> void:
	if $TabContainer.current_tab != 0:
		return
	for i in files:
		DirAccess.copy_absolute(i, \
				get_parent().get_mods_path().strip_edges() + "/" + i.get_file())
	get_parent().pressed.emit()
