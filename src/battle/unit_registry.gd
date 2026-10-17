class_name UnitRegistry
extends RefCounted
## Lleva la cuenta de los goblins vivos de una pelea y responde consultas
## sobre ellos (enemigos, tribus en pie). Los goblins se sacan solos al morir.

signal unit_removed(goblin: Goblin)

var _units: Array[Goblin] = []


func register(goblin: Goblin) -> void:
	_units.append(goblin)
	goblin.died.connect(_on_unit_died)


func get_units() -> Array[Goblin]:
	return _units.duplicate()


func find_nearest_enemy(of: Goblin) -> Goblin:
	var nearest: Goblin = null
	var nearest_distance := INF
	for unit in _units:
		if not unit.is_enemy_of(of) or not unit.is_alive():
			continue
		var distance := of.global_position.distance_squared_to(unit.global_position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest = unit
	return nearest


func get_alive_tribes() -> Array[TribeData]:
	var tribes: Array[TribeData] = []
	for unit in _units:
		if unit.is_alive() and not tribes.has(unit.tribe):
			tribes.append(unit.tribe)
	return tribes


func _on_unit_died(goblin: Goblin) -> void:
	_units.erase(goblin)
	unit_removed.emit(goblin)
