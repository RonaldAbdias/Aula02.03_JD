extends CharacterBody2D

# Variáveis globais
var speed = 300
var gravity = 980
var jumpVelocity = -400
var attempJump = 0
@onready var animacao: AnimatedSprite2D = $AnimatedSprite2D

#

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	# Verificar se não está no chão e aplicar efeito da gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Executar movimentos laterais eixo X
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	
	# Verificar se o personagem está no chão
	if is_on_floor():
		attempJump = 0
	
	# Pulo e pulo duplo
	if Input.is_action_just_pressed("jump"):
		attempJump += 1
		if attempJump <= 2:
			velocity.y = jumpVelocity
		else:
			print("Sem pulos restantes")

	move_and_slide()
	
	#animacao
	if is_on_floor():
		if velocity.x ==0:
			animacao.play("idle")
		else:
			animacao.play("walk")
	else:
		if velocity.y < 0:
			animacao.play("jump")
		else:
			animacao.play("fall")
		
	if direction < 0:
		animacao.flip_h=true
	elif direction> 0:
		animacao.flip_h=false
		 
