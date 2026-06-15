extends Control

@onready var bag: MarginContainer = $Bag

var clicks = 0
var amount_per_click = 1

signal clicks_changed(amount)
const save_path = "user://userdata.save"

func _ready() -> void:
	load_data()
	emit_signal("clicks_changed", clicks)
	print("Loaded clicks:", clicks)
	print("Loaded amount_per_click:", amount_per_click)
	
func save_data():
	var data = {
		"clicks": clicks,
		"amount_per_click": amount_per_click
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	file.close()
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var data = file.get_var()
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			clicks = data.get("clicks", 0)
			amount_per_click = data.get("amount_per_click", 1)
	else:
		save_data()
func _on_click_button_button_down() -> void:
	clicks += amount_per_click
	emit_signal("clicks_changed", clicks)
	save_data()
	print("clicked")
	

func _on_bag_button_button_down() -> void:
	bag.visible = !bag.visible
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		bag.visible = !bag.visible
