extends ProgressBar

var MAX_HP = 100
var hp = 50
var damage_amount = 20
@onready var  health_bar = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = hp
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
