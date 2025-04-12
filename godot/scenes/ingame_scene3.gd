extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var dialog_box = $DialogBox
@onready var dialog_label = $DialogBox/Label
# Declare this array at the top of the script or as a class member
var collected_fragments: Array = []
func _ready() -> void:
	$Navegation1.pressed.connect(_on_navegation1_pressed)
	$Mushroom1.pressed.connect(_on_mushroom1_pressed)
	$fragment1.pressed.connect(Callable(self, "_on_fragment_pressed").bind("fragment1"))
	$fragment2.pressed.connect(Callable(self, "_on_fragment_pressed").bind("fragment2"))
	$fragment3.pressed.connect(Callable(self, "_on_fragment_pressed").bind("fragment3"))
	
	fade_overlay.visible = true
	dialog_label.text = "Llegue p-pero porque no hay nadie es como si estuviera abandonado"
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
		

	
	
func _on_navegation1_pressed():
	print("End Game")
	get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")
	
	
	
func _on_mushroom1_pressed():
	dialog_label.text = "Pedazos de una nota?, Parece que hay algo escrito tal vez si junto las 3 puedo descifrar algo"
	dialog_box.visible = true
	$fragment1.visible = true
	$fragment2.visible = true
	$fragment3.visible = true
	$Mushroom1.visible = false

func _on_fragment_pressed(fragment_name: String):
	dialog_label.text = "Pedazos de una nota?, Parece que hay algo escrito tal vez si junto las 3 puedo descifrar algo"
	dialog_box.visible = true
	if not collected_fragments.has(fragment_name):
		collected_fragments.append(fragment_name)
		
	if fragment_name == "fragment1": $fragment1.visible = false
	if fragment_name == "fragment2": $fragment2.visible = false
	if fragment_name == "fragment3": $fragment3.visible = false
	
	if "fragment1" in collected_fragments and "fragment2" in collected_fragments and "fragment3" in collected_fragments:
		print("All fragments collected!")
		dialog_label.text = "Para el que lea la nota debe de saber que lo agitadores no quieren cometer mal, solo están haciendo el trabajo que les fue asignado hace siglos, si se presenta la oportunidad de ayudarlos no importa con que deberías de hacer todo lo posible para serles de apoyo."
		dialog_box.visible = true
		$Navegation1.visible = true
		# Optionally, do something once all are collected
	
