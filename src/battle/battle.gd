class_name Battle
extends Node2D
## Arma una pelea en la montaña: spawnea los escuadrones de cada tribu y
## avisa cuando queda una sola tribu en pie.

signal battle_ended(winner: TribeData)

const GOBLIN_SCENE: PackedScene = preload("res://src/goblin/goblin.tscn")

@export var squads: Array[SquadData] = []
## Distancia del centro a la que aparece cada escuadrón.
@export var spawn_radius: float = 350.0
## Separación entre goblins del mismo escuadrón.
@export var goblin_spacing: float = 40.0

var registry := UnitRegistry.new()

var _is_over := false

@onready var _units: Node2D = %Units


func _ready() -> void:
	registry.unit_removed.connect(_on_unit_removed)
	_spawn_squads()


## Reparte los escuadrones en círculo alrededor del centro, cada uno en una
## fila de cara al centro. Funciona igual con 2 tribus que con 6.
func _spawn_squads() -> void:
	for i in squads.size():
		var direction := Vector2.from_angle(PI + TAU * i / squads.size())
		_spawn_squad(squads[i], direction * spawn_radius, direction.orthogonal())


func _spawn_squad(squad: SquadData, center: Vector2, row_direction: Vector2) -> void:
	for i in squad.goblin_count:
		var offset := (i - (squad.goblin_count - 1) / 2.0) * goblin_spacing
		var goblin: Goblin = GOBLIN_SCENE.instantiate()
		goblin.setup(squad.tribe, squad.goblin_stats, registry)
		goblin.position = center + row_direction * offset
		_units.add_child(goblin)
		registry.register(goblin)


func _on_unit_removed(_goblin: Goblin) -> void:
	if _is_over:
		return
	var alive_tribes := registry.get_alive_tribes()
	if alive_tribes.size() > 1:
		return
	_is_over = true
	var winner: TribeData = alive_tribes[0] if alive_tribes.size() == 1 else null
	print("Pelea terminada. Ganador: %s" % (winner.display_name if winner else "nadie"))
	battle_ended.emit(winner)
