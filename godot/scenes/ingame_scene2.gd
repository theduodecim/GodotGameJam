extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var dialog_box = $DialogBox
@onready var dialog_label = $DialogBox/Label
var scene3 = preload("res://scenes/ingame_scene3.tscn")
func _ready() -> void:
	$Navegation1.pressed.connect(_on_navegation1_pressed)
	$Book.pressed.connect(_on_book_pressed)
	$Mushroom1.pressed.connect(_on_mushroom1_pressed)
	$BookOpen.pressed.connect(_on_bookOpen_pressed)
	$Animal1.pressed.connect(_on_animal_pressed)
	fade_overlay.visible = true
	dialog_label.text = "Por fin llegue al campamento pero parece que no hay nada, mejor busco alrededor…"
	dialog_box.visible = true
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
		
func _on_book_pressed():
	dialog_label.text = "El bosque esta destinado a ser destruido la maldita corporación lo va a deforestar pero, La isla de los Césares donde los gigantes habitan pueden detener a (ilegible)"
	dialog_box.visible = true
	$Book.visible = false
	$BookOpen.visible = true
	
func _on_bookOpen_pressed():
	dialog_label.text = "¡¿la isla de los gigantes?! ¡Sabía que existía y las personas a las que les contaba no me creían!"
	dialog_box.visible = true
	$BookOpen.visible = false
	dialog_box.visible = false
	
	# Delay here (2 seconds)
	await get_tree().create_timer(2.0).timeout
	
	dialog_box.visible = true
	$Animal1.visible = true
	dialog_label.text = "ahh eso es lo que necesito si me lo entregas te lo cambio por este mapa, creo que será de mucha ayuda."

	
	
func _on_animal_pressed():
	dialog_label.text = "Genial, ahora con este mapa puedo ir a la isla de los gigantes !"
	dialog_box.visible = true
	$Animal1.visible = false
	$Navegation1.visible = true
	
	
func _on_navegation1_pressed():
	get_tree().change_scene_to_packed(scene3)
	
	
func _on_mushroom1_pressed():
	dialog_label.text = "Q-que esta ungh pasando, ugh que paso? la fogata! Esta prendida?"
	dialog_box.visible = true
	$Book.visible = true
	$Mushroom1.visible = false
	$Music.play()
