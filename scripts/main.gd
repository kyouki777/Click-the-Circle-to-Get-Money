extends Control

@onready var bag: MarginContainer = $Bag
@onready var story_manager: Node2D = $storyManager

var clicks = 0
var amount_per_click = 1

signal clicks_changed(amount)
const save_path = "user://userdata.save"


func _ready() -> void:
	load_data()
	emit_signal("clicks_changed", clicks)
	print("Loaded clicks:", clicks)
	print("Loaded amount_per_click:", amount_per_click)
	print('Loaded milestones:')
	print("loaded good ending points: ", Dialogic.VAR.good_ending)
	print("loaded bad ending points: ", Dialogic.VAR.bad_ending)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func save_data():
	var data = {
		"clicks": clicks,
		"amount_per_click": amount_per_click,
		"milestones": story_manager.milestones,
		"good_ending": Dialogic.VAR.good_ending,
		"bad_ending": Dialogic.VAR.bad_ending,
	
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
			
			story_manager.milestones = data.get(
				"milestones",
				story_manager.milestones)
			Dialogic.VAR.good_ending = data.get("good_ending", 0)
			Dialogic.VAR.bad_ending = data.get("bad_ending", 0)
	else:
		save_data()
		
func spend_money(cost: int) -> bool:
	if clicks >= cost:
		clicks -= cost
		emit_signal("clicks_changed", clicks)
		save_data()
		return true

	return false

func _on_click_button_button_down() -> void:
	clicks += amount_per_click
	emit_signal("clicks_changed", clicks)
	
	check_story_events()
	save_data()
	print("clicked")


func _on_bag_button_button_down() -> void:
	bag.visible = !bag.visible
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		bag.visible = !bag.visible

func check_story_events():
	for milestone in story_manager.milestones.keys():
		if clicks >= milestone and !story_manager.milestones[milestone]:
			story_manager.milestones[milestone] = true

			match milestone:
				10000:
					Dialogic.start("milestone1")
				100000:
					Dialogic.start("milestone2")
				1000000:
					Dialogic.start("milestone3")
				10000000:
					Dialogic.start("milestone4")
				100000000:
					Dialogic.start("milestone5")
				300000000:
					Dialogic.start("milestone6")
				500000000:
					Dialogic.start("milestone7")
				700000000:
					Dialogic.start("milestone8")
				800000000:
					Dialogic.start("milestone9")
				999999999:
					Dialogic.start("milestone10")

			break

func _on_dialogic_signal(argument:String) -> void:
	match argument:
		"milestone1":
			spend_money(5000)
			print("milestone1 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)

		"milestone2":
			spend_money(70000)
			print("milestone2 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)

		"milestone3":
			spend_money(790000)
			print("milestone3 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"milestone4":
			spend_money(8000000)
			print("milestone4 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"milestone5":
			spend_money(60000000)
			print("milestone5 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"milestone6":
			spend_money(100000000)
			print("milestone6 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"milestone7":
			spend_money(200000000)
			print("milestone7 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"milestone8":
			spend_money(555000000)
			print("milestone8 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"milestone9":
			spend_money(700000000)
			print("milestone9 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"milestone10":
			spend_money(999999999)
			print("milestone10 spent")
			print("bad end points: ", Dialogic.VAR.bad_ending)
			
		"end":
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/end.tscn")
