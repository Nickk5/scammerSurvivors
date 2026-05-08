extends ProgressBar


var BASE_XP = 20
var level = 1
var Max_XP = BASE_XP * level * level;
var current_xp = 0;
@onready var label: Label = $"../Label"
@onready var skill_ui = preload("res://Scenes/Game/skill_ui.tscn")
@onready var player = get_tree().get_first_node_in_group("player")



@onready var XP_Bar = $"."
# vCalled when the node enters the scene tree for the first time.
func _ready() -> void:
	XP_Bar.value = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	
func updateXP(level):
	
	Max_XP = BASE_XP * level * level;
	XP_Bar.max_value = Max_XP
	XP_Bar.value = current_xp  # update to player's current XP

func levelUp():
	if(current_xp >= Max_XP):
		level += 1
		current_xp = 0
		label.text = "LV "+str(level)
		updateXP(level)
		var instance = skill_ui.instantiate()
		player.add_child(instance)
		instance.global_position = player.global_position
		get_tree().paused = true
	

func addXP(amount):
	current_xp += amount	
	levelUp()
	updateXP(level)
	
