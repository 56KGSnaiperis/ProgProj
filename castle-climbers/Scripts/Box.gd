extends Area2D

func _ready():
	$AnimatedSprite2D.play("moving")

func _on_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.play("explode")
		Global.disable_spawning()
		if Global.can_hurt == true:
			body.take_damage()
			Global.is_climbing = false
			Global.is_jumping = false
	if body.name.begins_with("Wall"):
		queue_free()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "explode":
		queue_free()
