extends Control
@onready var skillNodes = load("res://Scripts/Systems/skillNode.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	testSkNode()
	pass # Replace with function body.

func testSkNode() -> void:
	var skInstanstance = skillNodes.new(10, [])
	skInstanstance.toString()
	var test = skillNodes.new(10, [skInstanstance])
	var test2 = skillNodes.new(10, [skInstanstance, test])
	var arrTest = [skInstanstance] 
	var arrTest2 = []
	var arrTest3 = [test, skInstanstance]
	test.toString()
	print("Should return true: " + str(test.checkReq(arrTest)))
	print("Should return false: " + str(test.checkReq(arrTest2)))
	test2.toString()
	print("Should return false: " + str(test2.checkReq(arrTest)))
	print("Should return true: " + str(test2.checkReq(arrTest3)))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/mainGame.tscn")
	pass # Replace with function body.
