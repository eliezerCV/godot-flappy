extends CharacterBody2D


const UP = Vector2.UP
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10
const WALL = preload("res://Walls.tscn")

var score = 0

func _physics_process(delta):
	velocity.y += GRAVITY 
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED
	if Input.is_action_just_pressed("FLAP"):
		velocity.y = -FLAP
	move_and_slide()

func wall_reset(): 
	var wall_instance = WALL.instantiate()
	wall_instance.position = Vector2(450, randf_range(-60, 60))
	get_parent().call_deferred("add_child", wall_instance)

func _on_resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		wall_reset()

func _on_detect_area_entered(area):
	if area.name == "PointArea": 
		score += 1
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)


func _on_detect_body_entered(body):
	if body.name == "Walls":
		get_tree().reload_current_scene()
