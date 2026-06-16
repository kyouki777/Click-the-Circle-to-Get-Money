extends MarginContainer

@onready var wallet_label: Label = $VBoxContainer/HBoxContainer/walletLabel

func _ready() -> void:
	var main = get_tree().current_scene

	wallet_label.text = "Wallet: Rp " + str(main.clicks)

	main.clicks_changed.connect(_on_clicks_changed)

func _on_clicks_changed(amount):
	wallet_label.text = "Wallet: Rp " + str(amount)
	
func buy_cursor():
	var main = get_tree().current_scene
	var cost = 100

	if main.clicks >= cost:
		main.clicks -= cost
		main.amount_per_click += 1

		main.emit_signal("clicks_changed", main.clicks)
		main.save_data()
		
func buy_cursor2():
	var main = get_tree().current_scene
	var cost = 200

	if main.clicks >= cost:
		main.clicks -= cost
		main.amount_per_click += 3

		main.emit_signal("clicks_changed", main.clicks)
		main.save_data()
		
func buy_cursor3():
	var main = get_tree().current_scene
	var cost = 10000

	if main.clicks >= cost:
		main.clicks -= cost
		main.amount_per_click += 150

		main.emit_signal("clicks_changed", main.clicks)
		main.save_data()

func buy_cursor4():
	var main = get_tree().current_scene
	var cost = 100000

	if main.clicks >= cost:
		main.clicks -= cost
		main.amount_per_click += 1500

		main.emit_signal("clicks_changed", main.clicks)
		main.save_data()
		
func buy_cursor5():
	var main = get_tree().current_scene
	var cost = 1000000

	if main.clicks >= cost:
		main.clicks -= cost
		main.amount_per_click += 15000

		main.emit_signal("clicks_changed", main.clicks)
		main.save_data()

func _on_extra_click_button_down():
	buy_cursor()

func _on_extra_click_2_button_down() -> void:
	buy_cursor2()

func _on_extra_click_3_button_down() -> void:
	buy_cursor3()

func _on_extra_click_4_button_down() -> void:
	buy_cursor4()

func _on_extra_click_5_button_down() -> void:
	buy_cursor5()
