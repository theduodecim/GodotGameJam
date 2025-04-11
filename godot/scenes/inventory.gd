extends Control

@onready var grid_container = $GridContainer
const SLOT_SCENE = preload("res://scenes/InventorySlot.tscn")

func add_item(texture: Texture2D) -> void:
	var slot = SLOT_SCENE.instantiate()
	
	# Make sure it's a TextureRect before assigning
	if slot is TextureRect:
		slot.texture = texture
		grid_container.add_child(slot)
	else:
		print("ERROR: Slot is not a TextureRect!")
