extends Control

onready var score := $Score
onready var boss_hp_bar := $TextureProgress 

onready var t_container := $HBoxContainer/TContainer
onready var hp_container := $HBoxContainer/HPContainer
var torpedo = preload('res://image/Torpedo3.png')
var torpedo_empty = preload('res://image/Torpedo_empty.png')

var hart = preload("res://image/hud_heartFull.png")
#var Hart = preload("res://scenes/UI/Hart.tscn")
var hart_empty = preload("res://image/hud_heartEmpty.png")

func _ready() -> void:
	update_torpedo()
	update_hp()
	update_score(0)
	boss_hp_bar.max_value = Info.boss_hp
	boss_hp_bar.value = Info.boss_hp


func update_score(value):
	Info.score += value
	Info.hide_score += value
	score.bbcode_text = "Fishing Score : " + str(Info.score)
	$Score/AnimationPlayer.play("score")
	if Info.hide_score >= 2000:
		Info.hp += 1
		update_hp()
		Info.hide_score = 0


func update_boss_hp(value):
	Info.boss_hp -= value
	boss_hp_bar.value = Info.boss_hp


func update_hp():
	if Info.hp > Info.max_hp:
		Info.hp = Info.max_hp
		
	for c in hp_container.get_children():
		c.queue_free()
	
	for i in Info.max_hp:
		
		var h = TextureRect.new()
		h.stretch_mode = TextureRect.STRETCH_KEEP
		if i < Info.hp:
			h.texture = hart

		else:
			h.texture = hart_empty
			
		hp_container.add_child(h)
		h.rect_size = Vector2(2,2)
		

		
func update_torpedo():
	for c in t_container.get_children():
		c.queue_free()
	
	for i in Info.max_torpedo_nam:
		var t = TextureRect.new()
#		t.stretch_mode = TextureRect.STRETCH_KEEP
		if i < Info.torpedo_nam:
			t.texture = torpedo

		else:
			t.texture = torpedo_empty
			
		t_container.add_child(t)
