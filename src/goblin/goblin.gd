class_name Goblin
extends CharacterBody2D
## Unidad que pelea en la montaña. Coordina sus componentes y expone las
## acciones básicas (moverse, frenar); qué hacer en cada momento lo decide su
## GoblinBehavior actual, que las órdenes de cartas pueden reemplazar.

signal died(goblin: Goblin)

var tribe: TribeData
var stats: GoblinStats
var registry: UnitRegistry

var _behavior: GoblinBehavior

@onready var health: HealthComponent = %HealthComponent
@onready var attack: AttackComponent = %AttackComponent
@onready var _body: PlaceholderBody = %Body
@onready var _collision: CollisionShape2D = %CollisionShape2D


## Se llama antes de agregarlo al árbol.
func setup(p_tribe: TribeData, base_stats: GoblinStats, p_registry: UnitRegistry) -> void:
	tribe = p_tribe
	stats = base_stats.duplicate()
	registry = p_registry


func _ready() -> void:
	health.setup(stats.max_health)
	_apply_stats()
	stats.changed.connect(_apply_stats)
	health.damaged.connect(_on_damaged)
	health.died.connect(_on_died)
	_body.color = tribe.color
	set_behavior(AttackNearestEnemyBehavior.new())


func _physics_process(delta: float) -> void:
	if _behavior:
		_behavior.physics_update(self, delta)


func set_behavior(behavior: GoblinBehavior) -> void:
	if _behavior:
		_behavior.exit(self)
	_behavior = behavior
	if _behavior:
		_behavior.enter(self)


func move_towards(point: Vector2) -> void:
	velocity = global_position.direction_to(point) * stats.move_speed
	move_and_slide()


func stop() -> void:
	velocity = Vector2.ZERO


func is_alive() -> bool:
	return not health.is_dead()


func is_enemy_of(other: Goblin) -> bool:
	return other.tribe != tribe


func _apply_stats() -> void:
	health.set_max_health(stats.max_health)
	attack.damage = stats.damage
	attack.cooldown = stats.attack_cooldown
	attack.attack_range = stats.attack_range


func _on_damaged(_amount: int) -> void:
	_body.flash()


func _on_died() -> void:
	set_behavior(null)
	set_physics_process(false)
	_collision.set_deferred("disabled", true)
	died.emit(self)
	queue_free()
