class_name GoblinStats
extends Resource
## Stats de un tipo de goblin. Los valores se ajustan desde los .tres en data/.
## Cada goblin trabaja sobre su propia copia, así una mejora a uno no afecta al resto.
## Todo cambio emite `changed` para que el goblin dueño se actualice.

@export var max_health: int = 5:
	set(value):
		max_health = value
		emit_changed()

@export var damage: int = 1:
	set(value):
		damage = value
		emit_changed()

## Segundos entre ataques. PLACEHOLDER: falta definir en el GDD.
@export var attack_cooldown: float = 1.0:
	set(value):
		attack_cooldown = value
		emit_changed()

## Distancia en píxeles (de centro a centro) para poder atacar. PLACEHOLDER.
@export var attack_range: float = 40.0:
	set(value):
		attack_range = value
		emit_changed()

## Píxeles por segundo. PLACEHOLDER.
@export var move_speed: float = 60.0:
	set(value):
		move_speed = value
		emit_changed()
