class_name HealthBar
extends Node2D
## Barra de vida chica que se dibuja sola escuchando a un HealthComponent.

@export var health: HealthComponent
@export var size: Vector2 = Vector2(28, 4)
@export var background_color: Color = Color(0, 0, 0, 0.7)
@export var fill_color: Color = Color(0.35, 0.9, 0.35)

var _ratio: float = 1.0


func _ready() -> void:
	health.health_changed.connect(_on_health_changed)
	_on_health_changed(health.current_health, health.max_health)


func _draw() -> void:
	var origin := -size / 2.0
	draw_rect(Rect2(origin, size), background_color)
	draw_rect(Rect2(origin, Vector2(size.x * _ratio, size.y)), fill_color)


func _on_health_changed(current: int, maximum: int) -> void:
	_ratio = clampf(float(current) / float(maximum), 0.0, 1.0)
	queue_redraw()
