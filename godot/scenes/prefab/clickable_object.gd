extends Sprite2D

func _ready():
	# Create Area2D
	var area = Area2D.new()
	area.name = "ClickArea"
	add_child(area)

	# Create CollisionShape2D
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()

	# Size the shape to match the sprite texture
	if texture:
		shape.size = texture.get_size()
	else:
		shape.size = Vector2(64, 64)  # fallback size

	collision.shape = shape
	area.add_child(collision)

	# Enable input and connect signal
	area.set_pickable(true)
	area.input_event.connect(_on_sprite_click)

func _on_sprite_click(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("🎯 Sprite clicked!")
