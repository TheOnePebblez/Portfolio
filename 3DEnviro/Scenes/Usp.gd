extends MeshInstance3D




var CameraRotation = Vector2(0,-1)
var MouseSensitivity = 0.002
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative * MouseSensitivity
		CameraLook(MouseEvent)
		
func CameraLook(Movement: Vector2):
	CameraRotation = Movement
	CameraRotation.y = clamp(CameraRotation.y, -1.5, 0.2)
	CameraRotation.x = clamp(CameraRotation.x, 1.5, -0.2)
	
	rotate(Vector3(0, 1, 0), -CameraRotation.x)
	rotate(Vector3(1, 0, 0), -CameraRotation.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
