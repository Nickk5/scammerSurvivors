extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")
@export var SPEED = 100.0
@export var SPEED_UP = 10
@export var CHARGE_DISTANCE = 500
@export var DAMAGE = 10
@export var HIT_RADIUS = 75
@export var health = 100
@export var spawnPos : Vector2
func _ready():
	global_position = spawnPos
func damaged(damage):
	health-=damage
func on_kill():
	if(health <= 0):
		player.get_child(3).addXP(20)
		queue_free()
func _physics_process(delta: float) -> void:
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var angle = Vector2.RIGHT.rotated(global_position.angle_to_point(player_pos))
	velocity = angle * SPEED
	$AnimatedSprite2D.play("default")
	if($HurtBox.overlaps_body(player)):
		healthBar.damaged((DAMAGE-player.defense)*delta)
		if(player.cactus):
			health = 0
			healthBar.damaged((DAMAGE-player.defense))
			on_kill()
	if(player_pos.distance_to(global_position) <= CHARGE_DISTANCE):
		velocity*=SPEED_UP
		if(!$AudioStreamPlayer2D.playing):
			$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.pause()
		$AnimatedSprite2D.play("sprint")
	else:
		velocity = angle*SPEED
		if($AudioStreamPlayer2D.playing):
			$AudioStreamPlayer2D.stop()
		$AnimatedSprite2D.pause()
		$AnimatedSprite2D.play("default")
	move_and_slide()
	on_kill()
