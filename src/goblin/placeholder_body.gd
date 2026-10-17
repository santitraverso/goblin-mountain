class_name PlaceholderBody
extends Node2D
## Dibujo temporal del goblin hasta que haya sprites.

@export var radius: float = 12.0
@export var color: Color = Color.WHITE:
	set(value):
		color = value
		queue_redraw()

var _flash_tween: Tween


func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 24, Color.BLACK, 1.5, true)


## Destello corto al recibir daño.
func flash() -> void:
	if _flash_tween:
		_flash_tween.kill()
	modulate = Color(2.5, 2.5, 2.5)
	_flash_tween = create_tween()
	_flash_tween.tween_property(self, "modulate", Color.WHITE, 0.15)
