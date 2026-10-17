class_name SquadData
extends Resource
## Los goblins que una tribu manda a una pelea.

@export var tribe: TribeData
@export var goblin_stats: GoblinStats
@export_range(1, 50) var goblin_count: int = 5
