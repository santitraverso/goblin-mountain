class_name GoblinBehavior
extends RefCounted
## Estrategia que decide qué hace un goblin en cada frame.
## Las órdenes que den las cartas van a ser nuevas subclases asignadas con
## Goblin.set_behavior(), sin tener que tocar Goblin.


func enter(_goblin: Goblin) -> void:
	pass


func exit(_goblin: Goblin) -> void:
	pass


func physics_update(_goblin: Goblin, _delta: float) -> void:
	pass
