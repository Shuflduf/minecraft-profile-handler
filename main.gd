extends Control

@export var profile_scene: PackedScene


var current_profile: Profile

func _ready() -> void:
	for i in DirAccess.get_directories_at(Global.minecraft_dir):
		if !i.begins_with("PROFILE "):
			continue

		var new_button = profile_scene.instantiate()
		new_button.name = i.lstrip("PROFILE ")
		new_button.text = new_button.name
		%Profiles.add_child(new_button)
	current_profile = %Profiles.get_child(0)
	%Profiles.get_child(0).selected = true
	connect_buttons()
	_on_view_current_pressed()

func connect_buttons():
	for i in %Profiles.get_children():
		i.pressed.connect(func():
			for j in %Profiles.get_children():
				j.selected = false
			i.selected = true
			current_profile = i
			view_mods(Global.minecraft_dir + "/PROFILE " + i.text)
			)


func view_mods(path: String):
	for i in %Mods.get_children():
		i.queue_free()

	for i in DirAccess.get_files_at(path):
		var new_label = Label.new()
		new_label.text = i
		%Mods.add_child(new_label)


func _on_load_pack_pressed() -> void:
	for i in DirAccess.get_files_at(Global.minecraft_dir + "/mods"):
		DirAccess.remove_absolute(Global.minecraft_dir + "/mods/" + i)

	for i in DirAccess.get_files_at(current_profile.get_mods_path()):
		var path = current_profile.get_mods_path().path_join(i)
		DirAccess.copy_absolute(path, Global.minecraft_dir + "/mods/" + i)


func _on_view_current_pressed() -> void:
	for i in %Mods.get_children():
		i.queue_free()

	for i in DirAccess.get_files_at(Global.minecraft_dir + "/mods"):
		var new_label = Label.new()
		new_label.text = i
		%Mods.add_child(new_label)
