class_name AttackNearestEnemyBehavior
extends GoblinBehavior
## Comportamiento por defecto: elige al enemigo más cercano, se acerca y le pega.
## Mantiene el objetivo hasta que muere. PLACEHOLDER: la regla de targeting
## no está definida en el GDD.

var _target: Goblin


func physics_update(goblin: Goblin, _delta: float) -> void:
	# is_instance_valid() va primero y sin pasar por funciones tipadas: el
	# objetivo puede haber sido liberado y GDScript rechaza objetos liberados
	# en argumentos tipados.
	if not is_instance_valid(_target) or not _target.is_alive():
		_target = goblin.registry.find_nearest_enemy(goblin)
	if _target == null:
		goblin.stop()
		return

	if goblin.attack.is_in_range(goblin.global_position, _target.global_position):
		goblin.stop()
		goblin.attack.try_attack(_target.health)
	else:
		goblin.move_towards(_target.global_position)
