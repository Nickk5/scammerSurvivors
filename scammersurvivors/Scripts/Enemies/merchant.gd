extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var merchant_ui = preload("res://Scenes/Game/merchant_ui.tscn")
@onready var main = get_tree().get_first_node_in_group("main")
const smoochDistance = 50
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if(global_position.distance_to(player.global_position) <= smoochDistance):
		var instance = merchant_ui.instantiate()
		player.add_child(instance)
		instance.global_position = player.global_position
		queue_free()
		get_tree().paused = true
