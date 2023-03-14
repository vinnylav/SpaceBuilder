extends BuildModule


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_snap_area_indicator_pressed(pos, normal, orientation, left):
	if left:
		emit_signal("block_add", pos, normal, orientation)
	pass # Replace with function body.
