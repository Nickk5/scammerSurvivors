extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")

const SPEED = 0.0

var spawnPos : Vector2

func _ready():
	global_position = spawnPos

func _physics_process(delta: float) -> void:
	if (Input.is_key_pressed(KEY_K)):
		queue_free()
	move_and_slide()
