extends Control
@onready var win_label: Label = $ColorRect/winLabel
@onready var lose_label: Label = $ColorRect/loseLabel

const SAVE_PATH = "user://userdata.save"

func get_clicks() -> int:
	if !FileAccess.file_exists(SAVE_PATH):
		return 0

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	file.close()

	if typeof(data) == TYPE_DICTIONARY:
		return data.get("clicks", 0)

	return 0


func _ready() -> void:
	win_label.visible = false
	lose_label.visible = false

	var clicks = get_clicks()

	if clicks >= 1_000_000_000:
		win_label.visible = true

		$winAudio.play()
		$ColorRect/winLabel/AnimationPlayer.play("WinBlink")

		await get_tree().create_timer(15.0).timeout
		Dialogic.start("end")
		$ColorRect/winLabel/AnimationPlayer.stop()

	else:
		lose_label.visible = true

		$loseAudio.play()
		$ColorRect/loseLabel/AnimationPlayer.play("LoseBlink")

		await get_tree().create_timer(15.0).timeout
		Dialogic.start("end")
		$ColorRect/loseLabel/AnimationPlayer.stop()
