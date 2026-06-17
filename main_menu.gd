extends Control

const MAIN_MENU_SAVE := "user://main_menu_intro.save"
const START_INTRO_SAVE := "user://start_intro.save"


func _ready() -> void:
	if not has_seen_main_menu_intro():
		await get_tree().create_timer(5.0).timeout

		Dialogic.start("main menu")
		set_main_menu_intro_seen()


func _on_start_button_button_down() -> void:
	if not has_seen_start_intro():
		set_start_intro_seen()

		Dialogic.start("opening")

	else:
		get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_options_button_button_down() -> void:
	print("options button pressed")


func _on_exit_button_button_down() -> void:
	get_tree().quit()


func has_seen_main_menu_intro() -> bool:
	if not FileAccess.file_exists(MAIN_MENU_SAVE):
		return false

	var file = FileAccess.open(MAIN_MENU_SAVE, FileAccess.READ)
	return file.get_var()


func set_main_menu_intro_seen() -> void:
	var file = FileAccess.open(MAIN_MENU_SAVE, FileAccess.WRITE)
	file.store_var(true)


func has_seen_start_intro() -> bool:
	if not FileAccess.file_exists(START_INTRO_SAVE):
		return false

	var file = FileAccess.open(START_INTRO_SAVE, FileAccess.READ)
	return file.get_var()


func set_start_intro_seen() -> void:
	var file = FileAccess.open(START_INTRO_SAVE, FileAccess.WRITE)
	file.store_var(true)
