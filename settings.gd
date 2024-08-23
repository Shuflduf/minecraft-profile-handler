extends Window


func _ready() -> void:
	print(Global.minecraft_dir)
	if FileAccess.file_exists("user://path.txt"):
		Global.minecraft_dir = \
				FileAccess.get_file_as_string("user://path.txt").strip_edges()
		var valid = DirAccess.dir_exists_absolute(Global.minecraft_dir + "/mods")
		$VBoxContainer/MinecraftDir/Label.text = "Valid" if valid else "Invalid"
		print(Global.minecraft_dir)

func _on_find_dir_pressed() -> void:
	$VBoxContainer/MinecraftDir/FileDialog.show()


func _on_file_dialog_dir_selected(dir: String) -> void:
	dir = dir.replace('\\', "/")
	print(dir)
	Global.minecraft_dir = dir
	var valid = DirAccess.dir_exists_absolute(dir + "/mods")
	$VBoxContainer/MinecraftDir/Label.text = "Valid" if valid else "Invalid"
	FileAccess.open("user://path.txt", FileAccess.WRITE).store_line(dir)


func _on_close_requested() -> void:
	hide()
