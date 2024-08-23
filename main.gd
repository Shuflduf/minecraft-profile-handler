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
		connect_profile(new_button)

	if %Profiles.get_child_count():
		current_profile = %Profiles.get_child(0)
		%Profiles.get_child(0).selected = true
	_on_view_current_pressed()


func add_profile(new_name: String):
	var new_button = profile_scene.instantiate()
	new_button.name = new_name
	new_button.text = new_button.name
	%Profiles.add_child(new_button)
	connect_profile(new_button)



func connect_profile(prof: Profile):

	prof.pressed.connect(func():
		for i in %Profiles.get_children():
			i.selected = false
		prof.selected = true
		current_profile = prof
		view_mods(Global.minecraft_dir + "/PROFILE " + prof.text)
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
