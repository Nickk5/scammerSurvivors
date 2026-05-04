extends Control
@onready var player = get_tree().get_first_node_in_group("player")
@onready var artifact_1 = get_tree().get_first_node_in_group("artifact_1")
@onready var artifact_2 = get_tree().get_first_node_in_group("artifact_2")
@onready var artifact_3 = get_tree().get_first_node_in_group("artifact_3")

var a1 = 1
var a2 = 1
var a3 = 1
var s1 = 1
var s2 = 1
var s3 = 1
var name_to_artifact_list = ["Credit Card","Blade of Grass","Dead Ringer","Lure","Repel","Long Term Scaling","Essence of Cactus","Bank Interest","Glass Canon"
]
var description_to_artifact_list = [
	"Allows you to take artifacts for free without scams! (who does this belong to though?)",
	"+500 additional dmg, but this decreases with longer sessions",
	"On obtainment fake your death and removes all your scams, but removes 20 max hp",
	"Increases merchant spawn rates for 1 minutes",
	"Stops all enemy spawns for 30 seconds",
	"Scales your Damage over a long period of time. May benefit you towards the end",
	"Enemies that damage you will die",
	"Damage increases by 0.04% every second",
	"Masssively increases Damage and AOE at the cost of your hp"
]
var artifact_images = [
	"res://Assets/Sprites/Screenshot 2026-05-04 023335.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 023352.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 023423.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 023434.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 025739.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 025812.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 023733.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 023749.png",
	"res://Assets/Sprites/Screenshot 2026-05-04 023757.png"
]
var name_to_scam_list = ["Identity Theft","Advance Payment","Skimming","Rug Pull","Ponzi Scheme"]
var description_to_scam_list = [
	"Identity theft is not a joke jim, millions of people suffer from it every year (gives a random scam debuff)",
	"No money? PAY WITH YOUR LIFE!! (sets hp to 1)",
	"Gives an overlay to your screen",
	"rug",
	"Creditor Enemies will now spawn"
	]
var total_artifacts = range(0,9)
var total_scams = range(0,5)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	var i = 0
	while(i < len(total_artifacts)):
		if(player.artifacts.has(total_artifacts[i])):
			total_artifacts.erase(total_artifacts[i])
			i-=1
		i+=1
	a1 = total_artifacts.pick_random()
	total_artifacts.erase(a1)
	a2 = total_artifacts.pick_random()
	total_artifacts.erase(a2)
	a3 = total_artifacts.pick_random()
	total_artifacts.erase(a3)
	s1 = total_scams.pick_random()
	s2 = total_scams.pick_random()
	s3 = total_scams.pick_random()
	if(a1 == null):
		get_child(4).texture = load("res://Assets/Sprites/Screenshot 2026-03-26 084259.png")
		artifact_1.text = "no more artifacts left"
	else:
		get_child(4).texture = load(artifact_images[a1])
		artifact_1.text = name_to_artifact_list[a1]+" - "+description_to_artifact_list[a1]+"\n"+name_to_scam_list[s1]+" - "+description_to_scam_list[s1]
		if(player.credit_card):
			artifact_1.text = name_to_artifact_list[a1]+" - "+description_to_artifact_list[a1]
	if(a2 == null):
		get_child(5).texture = load("res://Assets/Sprites/Screenshot 2026-03-26 084259.png")
		artifact_2.text = "no more artifacts left"
	else:
		get_child(5).texture = load(artifact_images[a2])
		artifact_2.text = name_to_artifact_list[a2]+" - "+description_to_artifact_list[a2]+"\n"+name_to_scam_list[s2]+" - "+description_to_scam_list[s2]
		if(player.credit_card):
			artifact_2.text = name_to_artifact_list[a2]+" - "+description_to_artifact_list[a2]
	if(a3 == null):
		get_child(6).texture = load("res://Assets/Sprites/Screenshot 2026-03-26 084259.png")
		artifact_3.text = "no more artifacts left"
	else:
		get_child(6).texture = load(artifact_images[a3])
		artifact_3.text = name_to_artifact_list[a3]+" - "+description_to_artifact_list[a3]+"\n"+name_to_scam_list[s3]+" - "+description_to_scam_list[s3]
		if(player.credit_card):
			artifact_3.text = name_to_artifact_list[a3]+" - "+description_to_artifact_list[a3]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_artifact_1_pressed() -> void:
	if(a1 != null):
		player.artifacts.append(a1)
		player.scams[s1]+=1
		if(player.credit_card):
			player.scams[s1]-=1
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.


func _on_artifact_2_pressed() -> void:
	if(a2 != null):
		player.artifacts.append(a2)
		player.scams[s2]+=1
		if(player.credit_card):
			player.scams[s2]-=1
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.


func _on_artifact_3_pressed() -> void:
	if(a3 != null):
		player.artifacts.append(a3)
		player.scams[s3]+=1
		if(player.credit_card):
			player.scams[s3]-=1
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.
