extends Control

@export var profile_scene: PackedScene


var current_profile: Profile

func _ready() -> void:
	if Global.minecraft_dir.is_empty():
		return
	update_profiles()


func add_profile(new_name: String):
	var new_button = profile_scene.instantiate()
	new_button.name = new_name
	new_button.text = new_button.name
	%Profiles.add_child(new_button)
	connect_profile(new_button)
	#new_button.set_deferred("selected", true)
	new_button.pressed.emit()


func update_profiles():

	for i in %Profiles.get_children():
		i.free()

	for i in DirAccess.get_directories_at(Global.minecraft_dir):
		if !i.begins_with("PROFILE "):
			continue

		var new_button = profile_scene.instantiate()
		new_button.name = i.lstrip("PROFILE ")
		new_button.text = new_button.name
		new_button.set_deferred("selected", false)
		%Profiles.add_child(new_button)
		connect_profile(new_button)

	if %Profiles.get_child_count():
		print("HGDKNM")
		current_profile = %Profiles.get_child(0)
		%Profiles.get_child(0).set_deferred("selected", true)
	_on_view_current_pressed()


func connect_profile(prof: Profile):
	prof.pressed.connect(func():
		%CurrentView.text = prof.text
		for i in %Profiles.get_children():
			i.selected = false
		prof.selected = true
		current_profile = prof
		view_mods(Global.minecraft_dir + "/PROFILE " + prof.text)
		)
	prof.tree_exiting.connect(func():
		_on_view_current_pressed())


func view_mods(path: String):
	for i in %Mods.get_children():
		i.queue_free()

	for i in DirAccess.get_files_at(path):
		var new_label = Label.new()
		new_label.text = i
		%Mods.add_child(new_label)


func _on_load_pack_pressed() -> void:
	if Global.minecraft_dir.is_empty() or !%Profiles.get_child_count():
		return

	for i in DirAccess.get_files_at(Global.minecraft_dir + "/mods"):
		DirAccess.remove_absolute(Global.minecraft_dir + "/mods/" + i)

	for i in DirAccess.get_files_at(current_profile.get_mods_path()):
		var path = current_profile.get_mods_path().path_join(i)
		DirAccess.copy_absolute(path, Global.minecraft_dir + "/mods/" + i)


func _on_view_current_pressed() -> void:
	if Global.minecraft_dir.is_empty():
		return

	%CurrentView.text = "[b]mods[/b]"

	for i in %Mods.get_children():
		i.queue_free()

	for i in DirAccess.get_files_at(Global.minecraft_dir + "/mods"):
		var new_label = Label.new()
		new_label.text = i
		%Mods.add_child(new_label)
