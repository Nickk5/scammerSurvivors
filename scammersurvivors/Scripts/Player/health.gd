extends ProgressBar
var MAX_HP = 100
var hp = 100
@onready var  health_bar = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = hp
	
func damaged(damage):
	hp -= damage
	if(hp >= MAX_HP):
		hp = MAX_HP
	if(hp <= 0):
		hp = 0
	health_bar.value = hp
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(hp >= MAX_HP):
		hp = MAX_HP
	if(hp <= 0):
		hp = 0
