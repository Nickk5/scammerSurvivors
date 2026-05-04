extends CharacterBody2D

@onready var main = get_tree().get_root().get_node("main")
@onready var enemy = load("res://Scenes/Enemies/mob.tscn")
@onready var cloaker = load("res://Scenes/Enemies/cloaker.tscn")
@onready var merchant = load("res://Scenes/Enemies/merchant.tscn")
@onready var rug = load("res://Scenes/Enemies/rug.tscn")
@onready var creditor = load("res://Scenes/Enemies/creditor.tscn")
@onready var playerAnimation: AnimatedSprite2D = $playerAnimation
@onready var slashAnimation: AnimatedSprite2D = $Slash
@onready var slashHitBox = $AttackArea/CollisionShape2D
@onready var healthBar = get_tree().get_first_node_in_group("healthBar")
@onready var enemy_timer = get_tree().get_first_node_in_group("enemy_timer")
@onready var dmg_label = get_tree().get_first_node_in_group("dmg_label")
const SPEED = 300.0
const CLOAKER_CHANCE = 25
const total_scams = 5
var artifacts = []
var scams = []
var base_dmg = 100
var dmg = 0
var additional_dmg = 0
var start_time
var seconds
#Artifact variables
var credit_card = false
var used_dead_ringer = false
var cactus = false
var long_term_scaling = false
var glass_canon = false
var repel = 0
var lure = 0
var repel_time
var lure_time
var bank_time
var bank
# Scam variables
var creditors = 0
var skims = 1
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * SPEED

func _ready():
	scams.resize(total_scams)
	scams.fill(0)
	start_time = Time.get_ticks_msec()
	seconds = 0
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
	#ARTIFACTS
	for i in artifacts:
		if(i == 0):
			credit_card = true;
		if(i == 1):
			additional_dmg = max(0,500-(Time.get_ticks_msec()-start_time)/1000)
		if(i == 2):
			if(not used_dead_ringer):
				scams = []
				scams.resize(total_scams)
				scams.fill(0)
				healthBar.MAX_HP -=20
				healthBar.hp = min(healthBar.hp,healthBar.MAX_HP)
				creditors = 0
				skims = 0
				get_parent().modulate = Color(1.0/(1+skims),1.0/(1+skims),1.0/(1+skims))
				used_dead_ringer = true
				
		if(i==3):
			if(lure == 0): 
				lure_time = Time.get_ticks_msec()
				enemy_timer.wait_time = 0.4
				lure = 1
			if(lure == 1):
				if(Time.get_ticks_msec()-lure_time>=60000):
					enemy_timer.wait_time = 2
					lure = 2
		if(i == 4):
			if(repel == 0): 
				repel_time = Time.get_ticks_msec()
				enemy_timer.wait_time = 900
				repel = 1
			if(repel == 1):
				if(Time.get_ticks_msec()-repel_time>=30000):
					enemy_timer.wait_time = 2
					repel = 2
		if(i == 5):
			long_term_scaling = true
		if(i == 6):
			cactus = true
		if(i == 7):
			if(not bank):
				bank = true
				bank_time = Time.get_ticks_msec()
			else:
				if(floor(Time.get_ticks_msec()-bank_time) > seconds):
					seconds+=1
					base_dmg*=1.0004
				
		if(i == 8):
			if(not glass_canon):
				healthBar.MAX_HP-=70
				healthBar.hp = min(healthBar.hp,healthBar.MAX_HP)
			glass_canon = true
		dmg = base_dmg
		if(glass_canon):
			dmg*=20
		dmg+=additional_dmg
		if(long_term_scaling):
			if(Time.get_ticks_msec()-start_time <= 3600000):
				dmg = 0
			else:
				dmg*=1.01
		dmg_label.text = "DMG: "+str(dmg)
	#SCAMS
	for i in range(len(scams)):
		for j in range(scams[i]):
			if(i == 0):
				scams[0]-=1
				scams[randi_range(1,total_scams-1)]+=1
			if(i == 1):
				healthBar.damaged(healthBar.hp-1)
				scams[1]-=1
			if(i == 2):
				skims+=1
				get_parent().modulate = Color(1.0/(1+skims),1.0/(1+skims),1.0/(1+skims))
				scams[2]-=1
			if(i == 3):
				spawnEnemy(rug)
				scams[3]-=1
			if(i == 4):
				creditors+=1
				scams[4]-=1
			
	if slashAnimation.animation != "default":  # your attack anim
			#slashAnimation.play("default")
			slashAnimation.play("default")
			perform_attack()


				
		
				
		

func spawnEnemy(mob):
	var instance
	instance = mob.instantiate()
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
	if (randi_range(1,100) <= CLOAKER_CHANCE):
		spawnEnemy(cloaker) #was cloaker before
	else:
		spawnEnemy(enemy)
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
	spawnEnemy(merchant)


func _on_creditor_timer_timeout() -> void:
	for i in range(creditors):
		spawnEnemy(creditor)
