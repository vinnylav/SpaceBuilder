extends Node3D

var rotation_speed = PI/2
# zoom settings
@export var max_zoom = 3.0
@export var min_zoom = 0.5
@export var zoom_speed = 0.09

var zoom = 1.5

func get_input_keyboard(delta):
	# Rotate BuildCamera around y axis
	var y_rotation = 0
	if Input.is_action_pressed("cam_right"):
		y_rotation += 1
	if Input.is_action_pressed("cam_left"):
		y_rotation += -1
	rotate_object_local(Vector3.UP, y_rotation * rotation_speed * delta)
	# Rotate InnerGimbal around local x axis
	var x_rotation = 0
	if Input.is_action_pressed("cam_up"):
		x_rotation += -1
	if Input.is_action_pressed("cam_down"):
		x_rotation += 1
	$InnerGimbal.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)

func _unhandled_input(event):
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("cam_zoom_out"):
		zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)

func _process(delta):
	get_input_keyboard(delta)
	#limit_floor_rot()
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	
func limit_floor_rot():
	$InnerGimbal.rotation.x = clamp($InnerGimbal.rotation.x, -1.4, -0.01)

# Called when the node enters the scene tree for the first time.
func _ready():pass

