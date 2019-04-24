extends RigidBody2D

func _on_Timer_timeout():
	$anim.play("shutdown")
