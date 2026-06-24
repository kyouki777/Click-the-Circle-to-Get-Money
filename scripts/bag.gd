extends MarginContainer

@onready var wallet_label: Label = $VBoxContainer/HBoxContainer/walletLabel

@onready var hold_timer: Timer = $Timer

var current_buy_function: Callable


func _ready() -> void:
	var main = get_tree().current_scene
	hold_timer.wait_time = 0.1 
	wallet_label.text = "Wallet: Rp " + str(main.clicks)

	main.clicks_changed.connect(_on_clicks_changed)


func _on_clicks_changed(amount):
	wallet_label.text = "Wallet: Rp " + str(amount)


func buy_upgrade(cost: int, amount: int):
	var main = get_tree().current_scene

	if main.spend_money(cost):
		main.amount_per_click += amount
		main.save_data()


func _on_timer_timeout() -> void:
	if current_buy_function.is_valid():
		current_buy_function.call()


# Upgrade 1
func _on_extra_click_button_down():
	current_buy_function = func(): buy_upgrade(100, 1)
	current_buy_function.call()
	hold_timer.start()


func _on_extra_click_button_up():
	hold_timer.stop()


# Upgrade 2
func _on_extra_click_2_button_down():
	current_buy_function = func(): buy_upgrade(200, 3)
	current_buy_function.call()
	hold_timer.start()


func _on_extra_click_2_button_up():
	hold_timer.stop()


# Upgrade 3
func _on_extra_click_3_button_down():
	current_buy_function = func(): buy_upgrade(10000, 150)
	current_buy_function.call()
	hold_timer.start()


func _on_extra_click_3_button_up():
	hold_timer.stop()


# Upgrade 4
func _on_extra_click_4_button_down():
	current_buy_function = func(): buy_upgrade(100000, 1500)
	current_buy_function.call()
	hold_timer.start()


func _on_extra_click_4_button_up():
	hold_timer.stop()


# Upgrade 5
func _on_extra_click_5_button_down():
	current_buy_function = func(): buy_upgrade(1000000, 15000)
	current_buy_function.call()
	hold_timer.start()


func _on_extra_click_5_button_up():
	hold_timer.stop()
