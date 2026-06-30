extends Control

@onready var texture_button: TextureButton = $ColorRect/emailContainer/TextureButton
@onready var notif_sound: AudioStreamPlayer2D = $ColorRect/emailContainer/TextureButton/notifSound

@onready var email_window: Control = $ColorRect/emailMessage
@onready var email_text: RichTextLabel = $ColorRect/emailMessage/HBoxContainer/insideEmail
@onready var typing_sound: AudioStreamPlayer2D = $ColorRect/emailMessage/HBoxContainer/insideEmail/typingSound
@onready var reply_button: Button = $ColorRect/emailMessage/replyButton

var typing := false
var skip_typing := false

func _ready():
	reply_button.visible = false
	texture_button.visible = false
	email_window.visible = false

	await get_tree().create_timer(3.0).timeout

	texture_button.visible = true
	notif_sound.play()
	print("ready")

func _on_texture_button_button_down() -> void:
	email_window.visible = true
	texture_button.visible = false

	if not typing:
		type_email()

func type_email():
	typing = true
	skip_typing = false

	var message = """
My name is Adam, and my childhood dream is to get rich.

I want to get rich by doing something as simple as clicking on this goddamn computer or whatever. I can’t work 3 jobs just to lose half of my money to live in a box and eat instant noodles every day. Why do I have to be the next Albert Einstein to prove that I deserve a roof over my head?

People think I’m greedy and selfish for wanting money, but screw them all! Screw them!!! I don’t care if this giveaway is a scam or whether this magic nonsense is real or not, I have nothing left to lose.

I want to get 1 billion rupiah in 30 days.

"""

	email_text.text = message
	email_text.visible_characters = 0

	while email_text.visible_characters < message.length():

		if skip_typing:
			email_text.visible_characters = message.length()
			break

		email_text.visible_characters += 1

		var current_char = message[email_text.visible_characters - 1]

		if current_char != " " and current_char != "\n":

			typing_sound.play()

		match current_char:
			".":
				await get_tree().create_timer(0.7).timeout

			",":
				await get_tree().create_timer(0.3).timeout

			"\n":
				await get_tree().create_timer(0.4).timeout

			_:
				await get_tree().create_timer(0.06).timeout

	typing = false
	await get_tree().create_timer(5.0).timeout
	reply_button.visible = true
	
#func _input(event):
	#if typing and event is InputEventMouseButton and event.pressed:
		#skip_typing = true


func _on_reply_button_button_down() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	print("Meow")
