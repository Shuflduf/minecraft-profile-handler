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


func _on_select_button_pressed() -> void:
	$TabContainer/Select/FileDialog.show()


func _on_file_dialog_files_selected(paths: PackedStringArray) -> void:
	for i in paths:
		DirAccess.copy_absolute(i, \
				get_parent().get_mods_path().strip_edges() + "/" + i.get_file())
	get_parent().pressed.emit()


func _on_link_button_pressed() -> void:
	var url: String = %LinkLineEdit.text
	%LinkLineEdit.text = ""
	if url.is_empty():
		%LinkStatus.text = "Empty URL"
		return
	%LinkStatus.text = "Downloading..."
	%HTTPRequest.request(url)
	%HTTPRequest.download_file = get_parent().get_mods_path().strip_edges() + "/" + url.get_file()


func _on_http_request_request_completed(_r, r_code, _h, _b) -> void:
	if r_code == 200:
		get_parent().pressed.emit()
		%LinkStatus.text = "Download Finished"
	else:
		%LinkStatus.text = "Error: " + str(r_code)
