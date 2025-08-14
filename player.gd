extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -750

@onready var sprite: AnimatedSprite2D = $IdleFront
@onready var win_screen: CanvasLayer = get_parent().get_node("CanvasLayer")

func _ready() -> void:
	sprite.play("IdleFront") 
	print(win_screen)
	win_screen.visible = false 
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_coin_body_entered(body: Node) -> void:
	if body == self:
		print("You win!")
		win_screen.visible = true 
