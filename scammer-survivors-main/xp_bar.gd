extends ProgressBar


var BASE_XP = 20
var level = 1
var Max_XP = BASE_XP * level * level;
var current_xp = 0;




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
	print("Level:", level, "Max XP for this level:", Max_XP, "Current XP:", current_xp)

func levelUp():
	if(current_xp == Max_XP):
		level += 1
		current_xp = 0
		updateXP(level)
	

func addXP(amount):
	current_xp += amount	
	updateXP(level)
	
