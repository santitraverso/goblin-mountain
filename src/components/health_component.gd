class_name HealthComponent
extends Node
## Vida de una entidad. No sabe nada de goblins: cualquier cosa que pueda
## recibir daño o curación (goblins, edificios, cartas de efecto) lo puede usar.

signal health_changed(current: int, maximum: int)
signal damaged(amount: int)
signal healed(amount: int)
signal died

var max_health: int = 1
var current_health: int = 1


## Inicializa la vida al máximo.
func setup(maximum: int) -> void:
	max_health = maxi(maximum, 1)
	current_health = max_health
	health_changed.emit(current_health, max_health)


## Cambia la vida máxima sin curar; la vida actual solo se recorta si sobra.
func set_max_health(maximum: int) -> void:
	max_health = maxi(maximum, 1)
	current_health = mini(current_health, max_health)
	health_changed.emit(current_health, max_health)


func is_dead() -> bool:
	return current_health <= 0


func take_damage(amount: int) -> void:
	if amount <= 0 or is_dead():
		return
	current_health = maxi(current_health - amount, 0)
	damaged.emit(amount)
	health_changed.emit(current_health, max_health)
	if is_dead():
		died.emit()


func heal(amount: int) -> void:
	if amount <= 0 or is_dead():
		return
	var previous := current_health
	current_health = mini(current_health + amount, max_health)
	var healed_amount := current_health - previous
	if healed_amount > 0:
		healed.emit(healed_amount)
		health_changed.emit(current_health, max_health)
