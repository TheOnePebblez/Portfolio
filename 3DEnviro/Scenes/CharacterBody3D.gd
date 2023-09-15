extends CharacterBody3D


@onready var MainCamera = get_node("Camera3D")



const SPEED = 5.0
const JUMP_VELOCITY = 6.0
const DOUBLE_JUMP = 4.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var CameraRotation = Vector2(0,0)
var MouseSensitivity = 0.005
var CurrentSpeed = 0.0
var checkjump = false

func double_jump():
	if not is_on_floor() and checkjump == true:
		velocity.y = JUMP_VELOCITY
		checkjump = false

func slide():
	var newcamerapos = Vector3(0, -1, 0)
	MainCamera.transform = newcamerapos
		


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative * MouseSensitivity
		CameraLook(MouseEvent)
		
func CameraLook(Movement: Vector2):
	CameraRotation += Movement
	CameraRotation.y = clamp(CameraRotation.y, -1.5, 1.2)
	
	transform.basis = Basis()
	MainCamera.transform.basis = Basis()
	
	rotate_object_local(Vector3(0, 1, 0), -CameraRotation.x)
	MainCamera.rotate_object_local(Vector3(1, 0, 0), -CameraRotation.y)




func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		if Input.is_action_just_pressed("ui_accept") and checkjump:
			double_jump()

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		checkjump = true


		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var new_speed = Input.is_action_pressed("Sprint")
	if (new_speed):
		CurrentSpeed = SPEED * 2
	else:
		CurrentSpeed = SPEED
	if direction:
		velocity.x = direction.x * CurrentSpeed
		velocity.z = direction.z * CurrentSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, CurrentSpeed)
		velocity.z = move_toward(velocity.z, 0, CurrentSpeed)

	move_and_slide()
