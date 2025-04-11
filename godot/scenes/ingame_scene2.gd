extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var dialog_box = $DialogBox
@onready var dialog_label = $DialogBox/Label
var scene2 = preload("res://scenes/ingame_scene2.tscn")
func _ready() -> void:
	fade_overlay.visible = true

	if SaveGame.has_save():
		SaveGame.load_game(get_tree())

	pause_overlay.game_exited.connect(_save_game)

	

func _input(event) -> void:
	
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true
	if event is InputEventMouseButton and event.pressed:
		if dialog_box.visible and not $DialogBox.get_global_rect().has_point(event.position):
			dialog_box.visible = false	
func _save_game() -> void:
	SaveGame.save_game(get_tree())

func _on_ClickableObject_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Clickable object clicked!")
		

func _on_mushroom_pressed():
	#$Animal1.visible = true
	dialog_label.text = "A glowing mushroom. It hums softly with magical energy."
	dialog_box.visible = true
	#$Mushroom.visible = false;

func _on_book_pressed():
	dialog_label.text = "An old, leather-bound book. Its pages whisper forgotten secrets."
	dialog_box.visible = true
	
func _on_branch_pressed():
	get_tree().change_scene_to_packed(scene2)
	dialog_label.text = ""
	dialog_box.visible = true
	
func _on_animal1_pressed():
	#$Branch.visible = true
	dialog_label.text = "An old, leather-bound book. Its pages whisper forgotten secrets."
	dialog_box.visible = true
	
