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
