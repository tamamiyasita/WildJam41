extends CanvasLayer


onready var shockwave := $Shockwave
onready var anime:= $Shockwave/AnimationPlayer

func shock_wave(global_position):
	shockwave.material.set_shader_param("global_position", global_position)
	anime.play("shockwave")
	