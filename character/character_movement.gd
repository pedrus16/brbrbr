extends Node

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var moveSpeed = 300

onready var kinematicBody = $KinematicBody
#onready var cameraJoint = $KinematicBody/CameraJoint
#onready var cameraArm = $CameraArm

var _velocity = Vector3.ZERO


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var velocity = _velocity
	
	velocity.x = direction.x * moveSpeed * delta
	velocity.z = direction.y * moveSpeed * delta
	velocity.y -= gravity * delta
	
	_velocity = kinematicBody.move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true)
