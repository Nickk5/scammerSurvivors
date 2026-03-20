class_name SkillNode
extends Node

# if this gets deleted i will maul whoever deleted it - nick <3
# i do not think this needs documentation as reading the code explains the code
# how to use: refer to the 50 other times i instantiated something

@onready var skillCost
@onready var prev = Array([])

var cost : int
var back : Array
func _ready() -> void:
	skillCost = cost
	
func getPrev() -> Array:
	return prev

func setPrev(newPrev) -> Array:
	prev = newPrev
	return prev

func getCost() -> int:
	return skillCost

func setCost(newCost) -> int:
	cost = newCost
	return cost

func checkReq(arr) -> bool:
	var tempArr = arr
	for i in prev:
		if(!tempArr.has(prev[i])):
			return false
	return true
