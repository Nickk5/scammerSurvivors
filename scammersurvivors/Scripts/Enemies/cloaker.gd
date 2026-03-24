extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")
const SPEED = 100.0
const SPEED_UP = 10
const CHARGE_DISTANCE = 500
const DAMAGE = 100
const HIT_RADIUS = 75
var spawnPos : Vector2
func _ready():
	global_position = spawnPos

func _physics_process(delta: float) -> void:
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var angle = Vector2.RIGHT.rotated(global_position.angle_to_point(player_pos))
	velocity = angle * SPEED
	if(global_position.distance_to(player_pos) <=HIT_RADIUS):
		healthBar.damaged(DAMAGE*delta)
	if(player_pos.distance_to(global_position) <= CHARGE_DISTANCE):
		velocity*=SPEED_UP
		if(!$AudioStreamPlayer2D.playing):
			$AudioStreamPlayer2D.play()
	else:
		velocity = angle*SPEED
		if($AudioStreamPlayer2D.playing):
			$AudioStreamPlayer2D.stop()
	move_and_slide()
