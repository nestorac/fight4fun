extends Control

const MAX_ACTIONS = 15
var action = load("res://Scenes/action_ui.tscn")


@onready var h_box_container = $HBoxContainer

func add_action(action_name:String):
	if h_box_container.get_child_count() >= MAX_ACTIONS:
		return
	var action_inst = action.instantiate()
	action_inst.action_name = action_name
	h_box_container.add_child(action_inst)

# For debugging.
func _input(event):
	if event.is_action_released("l_click"):
		add_action("test")


func _on_button_button_up():
	#var actions_queued = h_box_container.get_children()
	for action_queued in h_box_container.get_children():
		print(action_queued.name, " ", action_queued.action_name)
		action_queued.queue_free()
		
#TODO
## Add custom actions: attack, walk, run...
## Pass the actions to the pigs.
## The pig prints the actions.