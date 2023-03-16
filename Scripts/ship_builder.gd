extends Node3D

var modules:Array = [
	["res://Assets/ShipParts/thruster_module.tscn","res://Assets/ShipParts/thruster_module.tres"],
	["res://Assets/ShipParts/armor_module.tscn","res://Assets/ShipParts/armor_module.tres"]
]

var selected:Array = modules[0]

var orientation:Vector3 = Vector3.ZERO
var pos:Vector3
var normal:Vector3



# Called when the node enters the scene tree for the first time.
func _ready():
	$BaseModule.block_add.connect(_block_added(pos, normal, orientation))
	$BaseModule.block_remove.connect(_block_removed())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _block_removed():
	remove_child(self)
	pass
	

func _block_added(pos:Vector3, normal:Vector3, orientation:Vector3):
	print("add")
	var new_module_scene = load(selected[0]).duplicate(true)
	var new_module = new_module_scene.instantiate()
	new_module.translate_object_local(to_local(pos + normal))
	add_child(new_module)
	new_module.block_add.connect(_block_added(pos, normal, orientation))
	new_module.block_remove.connect(_block_removed())
	new_module.rotation = orientation
	pass
	
func _unhandled_key_input(event):
	if event is InputEventKey:
		var evt:InputEventKey = event
		if evt.pressed:
			match event.scancode:
				KEY_1:
					selected = modules[0]
				KEY_2:
					selected = modules[1]
