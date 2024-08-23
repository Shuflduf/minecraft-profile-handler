extends Control

@export var profile_scene: PackedScene

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
			load_mods("testingdir/" + "PROFILE " + i.text)
			)


func load_mods(path: String):
	for i in %Mods.get_children():
		i.queue_free()

	for i in DirAccess.get_files_at(path):
		var new_label = Label.new()
		new_label.text = i
		%Mods.add_child(new_label)
		print(i)
