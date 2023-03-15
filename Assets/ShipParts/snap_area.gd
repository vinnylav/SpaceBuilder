extends Area3D

class_name SnapArea

var target_rot : Vector3

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("RotateX"):
		target_rot.x += PI/4
	if Input.is_action_just_pressed("RotateY"):
		target_rot.y += PI/4



func _on_SnapArea_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseMotion:
		$Indicator.global_transform.origin = normal*2 + global_transform.origin
		print(normal)
	pass # Replace with function body.


func _on_SnapArea_mouse_entered():
	$Indicator.visible = true
	pass # Replace with function body.


func _on_SnapArea_mouse_exited():
	$Indicator.visible = false
	pass # Replace with function body.
