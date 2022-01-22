extends Area2D


export (PackedScene) var Bullet 

var shot_time := false


func shot():
	print("shot!")
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	get_parent().add_child(bullet)



func _on_ShotArea2D_area_entered(area):
	if shot_time:
		call_deferred("shot")
#		shot()
		shot_time = false
		$ShotArea2D/ShotTimer.start()


func _on_ShotTimer_timeout():
	shot_time = true
