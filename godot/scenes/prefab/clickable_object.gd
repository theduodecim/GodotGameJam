extends Sprite2D

func _ready():
	# Create Area2D for clicking
	var area = Area2D.new()
	area.name = "ClickArea"

	# Create collision shape that matches sprite
	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()

	var size = texture.get_size() if texture != null else Vector2(128, 128)
	rect.size = size
	shape.shape = rect
	shape.position = -size / 2  # center align

	area.add_child(shape)
	area.input_pickable = true
	area.input_event.connect(_on_click)

	add_child(area)

func _on_click(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("🎯 Sprite clicked!")
