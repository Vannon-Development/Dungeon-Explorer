class_name MapLine
extends Sprite2D

func _ready():
	region_rect.position.y = randi_range(0, 3) * 8
