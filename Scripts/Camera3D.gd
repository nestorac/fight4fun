extends Camera3D

@onready var scene_manager = $".."
@onready var ray = $RayCast3D
@onready var test_unit = $"../Units Node Container/4PigsUnit"

var distance_from_camera = 100
var is_unit_selected = false
var is_unit_positioned = false

signal unit_placed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
		
	if event is InputEventMouseMotion:
		if not is_unit_selected:
			return
		if scene_manager.turn_state == scene_manager.DEPLOYMENT:
			var from = project_ray_origin((event.position))
			var to = from + project_ray_normal(event.position) * distance_from_camera
			
			var space_state = get_world_3d().get_direct_space_state()
			
			var query = PhysicsRayQueryParameters3D.create(from,to)
			
			var hit = space_state.intersect_ray(query)
			
			if hit.size() != 0:
				# collider will be the node you hit
				test_unit.position = Vector3( hit.position.x, 1, hit.position.z )
	if event.is_action_pressed("l_click"):
		if scene_manager.turn_state == scene_manager.DEPLOYMENT:
			print("Click on deployment.")
		elif scene_manager.turn_state == scene_manager.MOVEMENT:
			var from = project_ray_origin((event.position))
			var to = from + project_ray_normal(event.position) * distance_from_camera
			
			var space_state = get_world_3d().get_direct_space_state()
			
			var query = PhysicsRayQueryParameters3D.create(from,to)
			
			var hit = space_state.intersect_ray(query)
			
			if hit.size() != 0:
				print (hit.collider)
				if hit.collider.is_in_group("Units"):
					var unit = hit.collider
					print ("It is indeed in group Units.")
					unit.unit_state = unit.MOVEMENT_SELECTED
		elif scene_manager.turn_state == scene_manager.SPELLS:
			print("Click on spells.")
		elif scene_manager.turn_state == scene_manager.ATTACK:
			print("Click on attack.")
			
	if event.is_action_released("l_click") and is_unit_selected:
		is_unit_selected = false
		test_unit.unit_state = test_unit.DEPLOY_NOT_SELECTED
		emit_signal("unit_placed")
