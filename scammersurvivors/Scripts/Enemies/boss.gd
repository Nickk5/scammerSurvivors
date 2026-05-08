extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")
@onready var rng = RandomNumberGenerator.new()

var SPEED = 100.0

var spawnPos : Vector2
const DAMAGE = 100
const HIT_RADIUS = 75
var health = 10000
var phaseTwo = false
func _ready():
	global_position = spawnPos
func damaged(damage):
	health-=damage
	if((health <= 10000)):
		phaseTransition()
func on_kill():
	if(health <= 0):
		player.get_child(3).addXP(5)
		queue_free()
func phaseTransition():
	SPEED = 0
	phaseTwo = true
	$Timer.wait_time = 3.0 
	
func _physics_process(delta: float) -> void:


	if(Input.is_key_pressed(KEY_K)):
		queue_free()
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var angle = Vector2.RIGHT.rotated(global_position.angle_to_point(player_pos))
	velocity = angle * SPEED
	if(global_position.distance_to(player_pos) <=HIT_RADIUS):
		healthBar.damaged(DAMAGE*delta)
	move_and_slide()
	on_kill()


func _on_timer_timeout() -> void:
	if(!phaseTwo):
		if(SPEED==400):
			SPEED = 100
		else:
			SPEED = 400
	else:
		var player_pos = get_tree().get_first_node_in_group("player").global_position
		var my_random_number = rng.randf_range(0.0, 2*PI)
		position.x =  player_pos.x - (500*cos(my_random_number))
		position.y =  player_pos.y - (500*sin(my_random_number))
		var tween = create_tween()
		tween.tween_property(self, "position", Vector2((player_pos.x) - (500*cos(my_random_number+PI)), (player_pos.y)-(500*sin(my_random_number+PI))), 1)

		
