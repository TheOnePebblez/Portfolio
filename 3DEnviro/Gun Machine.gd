extends Node3D


# Called when the node enters the scene tree for the first time.
var ammo = 8
var reload = 8
var totalammo = 32
var spentammo = 0
func ammocheck():
	if Input.is_action_just_pressed("Reload") or ammo == 0:
		spentammo = 8 - ammo
		totalammo = totalammo - spentammo
		ammo = 8
	elif totalammo == 0:
		pass
	else:
		pass
func shootammo():
	if Input.is_action_just_pressed("Shoot") and totalammo != 0:
		ammo = ammo - 1
		print(ammo)
		
		
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ammocheck()
	shootammo()
