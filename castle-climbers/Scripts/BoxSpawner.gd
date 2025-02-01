extends Node2D

var box = preload("res://Scenes/Box.tscn")
var box_path
var box_animation

@export var flip_h = false
@export var flip_v = false

func _ready():
	box_path = $BoxPath/Path2D/PathFollow2D
	box_animation = $BoxPath/Path2D/AnimationPlayer
	box_animation.play("box_movement")
	$AnimatedSprite2D.play("pig_throw")




func _process(delta):
	$AnimatedSprite2D.flip_h = flip_h
	$AnimatedSprite2D.flip_v = flip_v
	
	if box_path.progress_ratio >= 1:
		box_path.progress_ratio = 0
		Global.enable_spawning()
		box_animation.play("box_movement")
		
	if box_path.progress_ratio == 0:
		$AnimatedSprite2D.play("pig_throw")
		
		
func _on_timer_timeout():
	$AnimatedSprite2D.play("pig_idle")
	if box_path.get_child_count() <= 0 and Global.can_spawn == true:
		var spawned_box = box.instantiate()
		box_path.add_child(spawned_box)
