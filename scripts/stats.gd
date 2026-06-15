extends VBoxContainer

@onready var click_label: Label = $moneyLabel
@onready var per_click: Label = $perClick

func update_labels():
	var main = get_tree().current_scene

	click_label.text = "Rp " + str(main.clicks)
	per_click.text = "Per Click: Rp " + str(main.amount_per_click)

func _ready():
	update_labels()

func _on_control_clicks_changed(amount):
	update_labels()
