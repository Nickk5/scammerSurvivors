extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")

@export var SPEED = 100.0

var spawnPos : Vector2
@export var DAMAGE = 100
@export var health = 75
@export var xp = 5
func _ready():
	global_position = spawnPos
func damaged(damage):
	health-=damage
func on_kill():
	if(health <= 0):
		player.get_child(3).addXP(xp)
		queue_free()

func _physics_process(delta: float) -> void:

	if(get_child(0).get_child_count() > 0):
		$Sprite2D/AnimationPlayer.play("default")

	if(Input.is_key_pressed(KEY_K)):
		queue_free()
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var angle = Vector2.RIGHT.rotated(global_position.angle_to_point(player_pos))
	velocity = angle * SPEED
	if($HurtBox.overlaps_body(player)):
		healthBar.damaged((DAMAGE-player.defense)*delta)
		if(player.cactus):
			health = 0
			healthBar.damaged((DAMAGE-player.defense))
			on_kill()
	move_and_slide()
	on_kill()
