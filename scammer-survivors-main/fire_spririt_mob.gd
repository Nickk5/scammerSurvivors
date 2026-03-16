extends CharacterBody2D


@onready var player = get_tree().get_first_node_in_group("player")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var spawnPos : Vector2

func _ready():
	global_position = spawnPos

func _physics_process(delta: float) -> void:
	move_and_slide()
