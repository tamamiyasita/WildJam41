extends Control

onready var score := $Score

onready var t_container := $HBoxContainer/TContainer
onready var hp_container := $HBoxContainer/HPContainer
var torpedo = preload('res://image/Torpedo3.png')
var torpedo_empty = preload('res://image/Torpedo.png')

var hart = preload('res://image/buble.png')
var hart_empty = preload('res://image/par.png')

func _ready() -> void:
	update_torpedo()
	update_hp()
	update_score(100000)


func update_score(value):
	Info.score += value
	score.bbcode_text = "Score : " + str(Info.score)


func update_hp():
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
		t.stretch_mode = TextureRect.STRETCH_KEEP
		if i < Info.torpedo_nam:
			t.texture = torpedo

		else:
			t.texture = torpedo_empty
			
		t_container.add_child(t)
		t.rect_size = Vector2(2,2)