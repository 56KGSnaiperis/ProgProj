extends Area2D

var rotation_speed = 10

func _physics_process(delta):
	if Global.is_bomb_moving == true:
		$AnimatedSprite2D.rotation += rotation_speed * delta


func _ready():
	$AnimatedSprite2D.play("moving")

func _on_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.play("explode")
		$Timer.start()
		Global.is_bomb_moving = false
		if Global.can_hurt == true:
			body.take_damage()
			Global.is_climbing = false
			Global.is_jumping = false
		
	if body.name.begins_with("Wall"):
		$AnimatedSprite2D.play("explode")
		$Timer.start()
		Global.is_bomb_moving = false
		




func _on_timer_timeout():
	if is_instance_valid(self):
		self.queue_free()
		
		
