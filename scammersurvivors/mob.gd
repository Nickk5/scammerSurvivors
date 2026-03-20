extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")
const SPEED = 100.0

var spawnPos : Vector2
const DAMAGE = 100
const HIT_RADIUS = 75
func _ready():
	global_position = spawnPos

func _physics_process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_K)):
		queue_free()
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var angle = Vector2.RIGHT.rotated(global_position.angle_to_point(player_pos))
	velocity = angle * SPEED
	if(global_position.distance_to(player_pos) <=HIT_RADIUS):
		healthBar.damaged(DAMAGE*delta)
	move_and_slide()
