extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anime := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anime.play("go!")
	yield(anime, "animation_finished" )
#	Game.change_scene("res://scenes/main/main.tscn")
	hide()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
