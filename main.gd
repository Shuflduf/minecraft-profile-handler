extends Control

@export var profile_scene: PackedScene

var current_profile: Profile

func _ready() -> void:
	for i in DirAccess.get_directories_at("testingdir"):
		if !i.begins_with("PROFILE "):
			continue

		var new_button = profile_scene.instantiate()
		new_button.name = i.lstrip("PROFILE ")
		new_button.text = new_button.name
		%Profiles.add_child(new_button)
	connect_buttons()

func connect_buttons():
	for i in %Profiles.get_children():
		i.pressed.connect(func():
			for j in %Profiles.get_children():
				j.selected = false
			i.selected = true
			current_profile = i
			view_mods("testingdir/" + "PROFILE " + i.text)
			)


func view_mods(path: String):
	for i in %Mods.get_children():
		i.queue_free()

	for i in DirAccess.get_files_at(path):
		var new_label = Label.new()
		new_label.text = i
		%Mods.add_child(new_label)


func _on_load_pack_pressed() -> void:
	for i in DirAccess.get_files_at("testingdir/mods"):
		DirAccess.remove_absolute("testingdir/mods/" + i)

	for i in DirAccess.get_files_at(current_profile.get_mods_path()):
		var path = current_profile.get_mods_path() + "/" + i
		DirAccess.copy_absolute(path,  ProjectSettings.localize_path("res://testingdir/mods/"))
