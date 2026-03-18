extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")

const SPEED = 100.0
const DAMAGE = 20
const HIT_RADIUS = 75

var spawnPos : Vector2

func _ready():
	global_position = spawnPos

func _physics_process(delta: float) -> void:
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var angle = Vector2.RIGHT.rotated(global_position.angle_to_point(player_pos))
	velocity = angle * SPEED
	if(global_position.distance_to(player_pos) <=HIT_RADIUS):
		player.get_child(2).damaged(DAMAGE*delta)
	move_and_slide()
