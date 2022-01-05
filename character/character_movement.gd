extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var moveSpeed = 300

onready var kinematicBody = $KinematicBody
onready var cameraJoint = $KinematicBody/CameraJoint
onready var cameraArm = $CameraArm

var _velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var velocity = _velocity
	
	velocity.x = direction.x * moveSpeed * delta
	velocity.z = direction.y * moveSpeed * delta
	velocity.y -= gravity * delta
	
	_velocity = kinematicBody.move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true)
