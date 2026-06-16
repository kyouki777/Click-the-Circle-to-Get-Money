extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_button_down() -> void:
	print("start button pressed")


func _on_options_button_button_down() -> void:
	print("options button pressed")


func _on_exit_button_button_down() -> void:
	print("exit button pressed")
