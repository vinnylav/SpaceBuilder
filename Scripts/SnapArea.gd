extends Area3D

class_name SnapArea

signal indicator_pressed(pos, normal, orientation, left)

var target_rot = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	#_change_model()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_page_up"):
		target_rot.x += PI/2
	if Input.is_action_just_pressed("ui_page_down"):
		target_rot.x -= PI/2
	if Input.is_action_just_pressed("ui_home"):
		target_rot.y += PI/2
	if Input.is_action_just_pressed("ui_end"):
		target_rot.y -= PI/2
	
	target_rot = normalize_angle_vec(target_rot)
	
func normalize_angle_vec(vec:Vector3)->Vector3:
	vec.x = normalize_angle(vec.x)
	vec.y = normalize_angle(vec.y)
	vec.z = normalize_angle(vec.z)
	return vec
	
#avoid large angles transition
func normalize_angle(angle:float)->float:
	angle =  fmod(angle,2*PI)
	angle = fmod((angle + 2*PI), 2*PI)
	if angle > PI:
		angle -= 2*PI
	return angle


#func _change_model():
#	var model = load(get_parent().get_parent().selected[1]).duplicate(true)
#	var mat = $Indicator/IndicatorShape.get_surface_material(0)
#	$Indicator/IndicatorShape.mesh = model
#	for surface in range($Indicator/IndicatorShape.mesh.get_surface_count()):
#		$Indicator/IndicatorShape.mesh.surface_set_material(surface, mat)
#	pass

func _on_input_event(_camera, event, _position, click_position:Vector3, click_normal:Vector3, normal, shape_idx):
	if event is InputEventMouseButton:
		var rot:Vector3 = get_parent().rotation + $Indicator.rotation
		if event.button_index == MOUSE_BUTTON_MASK_RIGHT and event.pressed:
			emit_signal(
				"indicator_pressed", 
				click_position, 
				click_normal, 
				rot.snapped(Vector3.ONE*PI/2), 
				false)
		if event.button_index == MOUSE_BUTTON_MASK_LEFT and event.pressed:
			emit_signal(
				"indicator_pressed", 
				click_normal + global_transform.origin, 
				click_normal, 
				rot.snapped(Vector3.ONE*PI/2), 
				true)
	if event is InputEventMouseMotion:
		$Indicator.global_transform.origin = click_normal*2 + global_transform.origin
	pass


func _on_mouse_entered():
	$Indicator.visible = true
	pass 

func _on_mouse_exited():
	$Indicator.visible = false
	pass 
