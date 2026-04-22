extends CharacterBody2D

@onready var main = get_tree().get_root().get_node("main")
@onready var enemy = load("res://Scenes/Enemies/mob.tscn")
@onready var cloaker = load("res://Scenes/Enemies/cloaker.tscn")
@onready var merchant = load("res://Scenes/Enemies/merchant.tscn")
@onready var playerAnimation: AnimatedSprite2D = $playerAnimation
@onready var slashAnimation: AnimatedSprite2D = $Slash
@onready var slashHitBox = $AttackArea/CollisionShape2D
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")

const SPEED = 300.0
const CLOAKER_CHANCE = 25
const total_scams = 11
var artifacts = []
var scams = []
var base_dmg = 10
var dmg = 0
var additional_dmg = 0
var credit_card = false
var used_dead_ringer = false
var cactus = false
var long_term_scaling = false
var glass_canon = false
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * SPEED

func _ready():
	scams.resize(total_scams)
	scams.fill(0)
	playerAnimation.play("default")
	slashAnimation.animation = "idle"
	slashAnimation.animation_finished.connect(_on_slash_finished)
func _physics_process(delta: float) -> void:
	artifacts.sort()
#	var directionX = 0.0
#	var directionY = 0.0
#	if(Input.is_key_pressed(KEY_A)):
#		directionX -= 1
#	if(Input.is_key_pressed(KEY_D)):
#		directionX += 1
#		
#	if(Input.is_key_pressed(KEY_W) and !Input.is_key_pressed(KEY_S)):
#		directionY -= 1
#	if(Input.is_key_pressed(KEY_S) and !Input.is_key_pressed(KEY_W)):
#		directionY += 1
#	
#	velocity.x = (directionX * SPEED)
#	velocity.y = (directionY * SPEED)
#	if(directionX != 0 and directionY != 0):
#		velocity.x = (directionX * SPEED)/sqrt(2)
#		velocity.y = (directionY * SPEED)/sqrt(2)
#	if(directionY == 0):
#		velocity.x = (directionX * SPEED)
#		velocity.y = 1
#	//MOVEMENT
	get_input()
	move_and_slide()
	if Input.is_action_just_pressed("up"):
		playerAnimation.play("idle_forward");
	elif Input.is_action_just_pressed("down"):
		playerAnimation.play("idle_backward")
	elif Input.is_action_just_pressed("left"):
		playerAnimation.play("idle_left")
	elif Input.is_action_just_pressed("right"):
		playerAnimation.play("idle_right")
	#ARTIFACTS AND SCAMS
	for i in artifacts:
		if(i == 0):
			credit_card = true;
		if(i == 1):
			additional_dmg = 500
		if(i == 2):
			if(not used_dead_ringer):
				scams = []
				scams.resize(total_scams)
				healthBar.MAX_HP -=20
		if(i==3):
			pass
		if(i == 4):
			pass
		if(i == 5):
			long_term_scaling = true
		if(i == 6):
			cactus = true
		if(i == 7):
			base_dmg*=1.02**(1/delta)
		if(i == 8):
			glass_canon = true
		dmg = base_dmg
		if(glass_canon):
			dmg*=20
		dmg+=additional_dmg
		if(long_term_scaling):
			dmg = 0
	if slashAnimation.animation != "default":  # your attack anim
			#slashAnimation.play("default")
			slashAnimation.play("default")
			perform_attack()


				
		
				
		

func spawnEnemy():
	var instance
	if (randi_range(1,100) <= CLOAKER_CHANCE):
		instance = cloaker.instantiate() #was cloaker before
	else:
		instance = enemy.instantiate()
	var spawnLoc = randi_range(1, 4)
	var xOffset
	var yOffset
	if(spawnLoc == 1):
		xOffset = randi_range(-1250, -1000)
		yOffset = randi_range(-500, 500)
	elif(spawnLoc == 2):
		xOffset = randi_range(1000, 1250)
		yOffset = randi_range(-500, 500)
	elif(spawnLoc == 3):
		xOffset = randi_range(-900, 900)
		yOffset = randi_range(600, 750)
	else:
		xOffset = randi_range(-900, 900)
		yOffset = randi_range(-750, -600)
	instance.spawnPos = Vector2(global_position.x - xOffset, global_position.y - yOffset)
	main.add_child.call_deferred(instance)

func _on_spawn_timer_timeout() -> void:
	spawnEnemy()
	pass # Replace with function body.
	
	
func _on_slash_finished():
	if slashAnimation.animation == "default":
		slashAnimation.animation = "idle"
		slashHitBox.disabled = true

func perform_attack():
	# Returns an Array of PhysicsBody2D (StaticBody, CharacterBody, etc.)
	print("In the perform attack function")
	slashHitBox.disabled = false

func _on_attack_area_area_entered(area: Area2D) -> void:
	await get_tree().physics_frame
	
	if(area.is_in_group("enemy")):
		area.get_parent().damaged(dmg)
		
		
		
	


func _on_merchant_timer_timeout() -> void:
	var instance = merchant.instantiate()
	var spawnLoc = randi_range(1, 4)
	var xOffset
	var yOffset
	if(spawnLoc == 1):
		xOffset = randi_range(-1250, -1000)
		yOffset = randi_range(-500, 500)
	elif(spawnLoc == 2):
		xOffset = randi_range(1000, 1250)
		yOffset = randi_range(-500, 500)
	elif(spawnLoc == 3):
		xOffset = randi_range(-900, 900)
		yOffset = randi_range(600, 750)
	else:
		xOffset = randi_range(-900, 900)
		yOffset = randi_range(-750, -600)
	instance.global_position = Vector2(global_position.x - xOffset, global_position.y - yOffset)
	main.add_child.call_deferred(instance)
