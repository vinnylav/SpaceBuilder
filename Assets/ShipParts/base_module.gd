extends BuildModule


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_SnapArea_indicator_pressed(pos, normal, orientation):
	if Input.is_action_pressed("left_click"):
		emit_signal("block_add", pos, normal, orientation)
	pass
