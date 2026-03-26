class_name SkillNode
extends Node

# if this gets deleted i will maul whoever deleted it - nick <3
# i do not think this needs documentation as reading the code explains the code
# how to use: refer to the 50 other times i instantiated something

var skCost : int
var prev : Array
func _init(cost: int = 0, back: Array = []) -> void:
	skCost = cost
	prev = back
	
func getPrev() -> Array:
	return prev

func setPrev(newPrev) -> Array:
	prev = newPrev
	return prev

func getCost() -> int:
	return skCost

func setCost(newCost) -> int:
	skCost = newCost
	return skCost

func checkReq(arr) -> bool:
	for i in prev:
		if(!arr.has(i)):
			return false
	return true

func toString() -> void:
	print(toString1())

func toString1() -> String:
	var output = str(skCost) + " ["
	if(prev.is_empty()):
		pass
	else:
		for i in prev:
			output = output + i.toString1() + " "
	output = output + "]"
	return output
