extends CSGBox3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapseds time since the previous frame.
func _process(delta):
	translate_object_local(transform.basis.y * 0.01)

	
