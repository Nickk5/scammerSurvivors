extends ProgressBar


var BASE_XP = 20
var level = 0
var XP = BASE_XP * level * level;




@onready var XP_Bar = $"."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
