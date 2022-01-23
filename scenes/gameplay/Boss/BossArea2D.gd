extends Area2D

onready var mouse := $Body/BossMouse/Bigshot_Position2D
onready var big_shot_anime := $Body/BossMouse/Bigshot_AnimationPlayer
onready var dead_anime := $DeadSprite/DeadAnimationPlayer
onready var canon_timar := $Body/CanonInTimer

var DeadExp = preload("res://scenes/gameplay/particle/DeadExplosion.tscn")

export (PackedScene) var Bullet 
export var dead_color = Color(1,1,1,1)
export var dead_scale = Vector2(1, 1)


var shot_time := false
var canon_in = false

func _ready() -> void:
	add_to_group("enemy")
	add_to_group("take_damage")
	
func big_shot():
	print("shot!")
	var bullet = Bullet.instance()
	bullet.global_position = mouse.global_position
	mouse.add_child(bullet)

func damage():
	var d = DeadExp.instance()
	d.exp_mod = dead_color
	d.exp_scale = dead_scale
	get_parent().add_child(d)
	d.global_position = global_position
	d.dead()

func _on_ShotArea2D_area_entered(area):
	if shot_time:
		big_shot_anime.play("bigshot")
#		call_deferred("big_shot")
#		shot()
		shot_time = false
		$Body/ShotArea2D/ShotTimer.start()


func _on_ShotTimer_timeout():
	shot_time = true



func _on_BossArea2D_area_entered(area):
	if area.name =="ExpArea":
#	if area.name =="ExpArea" or area.name == "CanonArea":
		var d = randi() % 3 + 2
		damage()
		get_tree().call_group("ui", "update_boss_hp", d)
	elif area.name == "CanonArea":	
		canon_in = true
#		get_tree().call_group("ui", "update_boss_hp", 1)
		canon_timar.start()



func _on_CanonInTimer_timeout():
	if canon_in:
		damage()
		get_tree().call_group("ui", "update_boss_hp", 1)
		canon_timar.start()

func _on_BossArea2D_area_exited(area):
	if area.name == "CanonArea":	
		canon_in = false
	
