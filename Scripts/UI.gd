extends Control

signal next_turn_state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	



func _on_next_state_button_button_up():
	emit_signal("next_turn_state")
