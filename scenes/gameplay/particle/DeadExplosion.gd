extends Node2D

export var exp_scale := Vector2.ONE
export var exp_mod = Color(1,1,1,1)
onready var b_par := $BParticles2D
onready var anime := $AnimationPlayer

func _ready():
	scale = exp_scale
	b_par.modulate = exp_mod
	dead()

func dead():
	anime.play("burst")
	yield(anime, "animation_finished" )
	queue_free()
