extends TextureProgressBar

@export var max_clicks := 1000000

func _ready():
	max_value = max_clicks

	var main = get_node("/root/main")

	main.clicks_changed.connect(_on_clicks_changed)

	value = main.clicks

func _on_clicks_changed(amount):
	value = min(amount, max_clicks)
