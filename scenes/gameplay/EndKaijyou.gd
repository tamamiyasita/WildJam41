extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreLabel.text = "Your Fishing SCORE " + str(Info.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
