class_name BattleResultLabel
extends Label
## Muestra el ganador cuando termina la pelea.

@export var battle: Battle


func _ready() -> void:
	hide()
	battle.battle_ended.connect(_on_battle_ended)


func _on_battle_ended(winner: TribeData) -> void:
	if winner:
		text = "Ganó la %s" % winner.display_name
		modulate = winner.color
	else:
		text = "Empate"
	show()
