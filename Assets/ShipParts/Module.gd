@tool
extends CollisionShape3D

class_name BuildModule

signal block_add(pos, normal, orientation)
signal block_remove(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_snap_area_indicator_pressed(pos, normal, orientation):
	if Input.is_action_pressed("left_click"):
		emit_signal("block_add", pos, normal, orientation)
	else:
		emit_signal("block_remove", self)
	pass

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func align_with_z(xform, new_z):
	xform.basis.z = -new_z
	xform.basis.x = -xform.basis.y.cross(new_z)
	xform.basis = xform.basis.orthonormalized()
	return xform
