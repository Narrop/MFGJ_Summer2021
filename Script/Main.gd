extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	if $Player.position.x < 2400 and $Player.position.x > 250:
		$Camera2D.position.x = $Player.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
