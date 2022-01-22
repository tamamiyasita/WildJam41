extends Area2D

onready var mouse := $Body/BossMouse/Bigshot_Position2D
onready var big_shot_anime := $Body/BossMouse/Bigshot_AnimationPlayer

export (PackedScene) var Bullet 

var shot_time := false

func _ready() -> void:
	add_to_group("enemy")
	add_to_group("take_damage")
	
func big_shot():
	print("shot!")
	var bullet = Bullet.instance()
	bullet.global_position = mouse.global_position
	mouse.add_child(bullet)



func _on_ShotArea2D_area_entered(area):
	if shot_time:
		big_shot_anime.play("bigshot")
#		call_deferred("big_shot")
#		shot()
		shot_time = false
		$ShotArea2D/ShotTimer.start()


func _on_ShotTimer_timeout():
	shot_time = true



func _on_BossArea2D_area_entered(area):
	
	if area.name =="ExpArea":
		var d = randi() % 3 +1
		get_tree().call_group("ui", "update_boss_hp", d)
	
