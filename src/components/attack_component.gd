class_name AttackComponent
extends Node
## Le pega a un HealthComponent respetando alcance y tiempo de recarga.
## No decide a quién atacar: eso es trabajo del comportamiento del dueño.

signal attacked(target: HealthComponent, damage: int)

var damage: int = 1
var cooldown: float = 1.0
var attack_range: float = 40.0

var _cooldown_left: float = 0.0


func _physics_process(delta: float) -> void:
	_cooldown_left = maxf(_cooldown_left - delta, 0.0)


func is_ready() -> bool:
	return _cooldown_left <= 0.0


func is_in_range(from: Vector2, to: Vector2) -> bool:
	return from.distance_to(to) <= attack_range


func try_attack(target: HealthComponent) -> bool:
	if not is_ready() or target == null or target.is_dead():
		return false
	_cooldown_left = cooldown
	target.take_damage(damage)
	attacked.emit(target, damage)
	return true
