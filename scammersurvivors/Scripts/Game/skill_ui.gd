extends Control
@onready var player = get_tree().get_first_node_in_group("player")
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")
var skills = [
	"+10 Attack",
	"+1 Defense",
	"+50 Speed",
	"+10 Max HP",
	"+5 Regen",
	"Heal 20 hp"
]
var skill_1
var skill_2
var skill_3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	var choose = range(0,6)
	skill_1 = choose.pick_random()
	choose.erase(skill_1)
	skill_2 = choose.pick_random()
	choose.erase(skill_2)
	skill_3 = choose.pick_random()
	choose.erase(skill_3)
	get_child(0).text = skills[skill_1]
	get_child(1).text = skills[skill_2]
	get_child(2).text = skills[skill_3]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func obtain_skill(skill):
	if(skill == 0):
		player.base_dmg+=10
	if(skill == 1):
		player.defense+=1
	if(skill == 2):
		player.SPEED+=50
	if(skill == 3):
		healthBar.MAX_HP+=10
	if(skill == 4):
		player.regen+=5
	if(skill == 5):
		healthBar.damaged(-20)
		
func _process(delta: float) -> void:
	pass


func _on_skill_1_pressed() -> void:
	obtain_skill(skill_1)
	get_tree().paused = false
	queue_free()


func _on_skill_2_pressed() -> void:
	obtain_skill(skill_2)
	get_tree().paused = false
	queue_free()


func _on_skill_3_pressed() -> void:
	obtain_skill(skill_3)
	get_tree().paused = false
	queue_free()
