extends Control

func _ready() -> void:
	$TextureRect/AnimationPlayer.play("Logo")
	$TextureRect/AnimationPlayer.animation_finished.connect(_on_animation_player_animation_finished)
const SAVE_PATH = "user://email_seen.save"

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name != "Logo":
		return

	if is_first_launch():
		set_first_launch_false()
		get_tree().change_scene_to_file("res://scenes/email.tscn")
	else:
		get_tree().change_scene_to_file("res://MainMenu.tscn")


func is_first_launch() -> bool:
	if !FileAccess.file_exists(SAVE_PATH):
		return true

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	file.close()

	if typeof(data) == TYPE_DICTIONARY:
		return data.get("first_launch", true)

	return true


func set_first_launch_false() -> void:
	var data = {}

	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		data = file.get_var()
		file.close()

	if typeof(data) != TYPE_DICTIONARY:
		data = {}

	data["first_launch"] = false

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(data)
	file.close()
