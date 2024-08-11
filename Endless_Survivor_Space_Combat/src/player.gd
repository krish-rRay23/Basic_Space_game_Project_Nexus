extends CharacterBody2D

@export var acceleration := 1500.0
@export var max_speed := 400.0
@export var friction := 600.0
@export var rotation_speed := 1.5
@export var max_fuel := 100.0
@export var fuel_consumption_rate := 10.0  # Fuel units consumed per second

@onready var muzzle = $Muzzle
@onready var fuel_bar = $CanvasLayer/FuelBar
@onready var fuel_label = $FuelLabel

var fuel: float = max_fuel
var laser_scene = preload("res://scenes/laser.tscn")

signal laser_shot(laser)

func _ready():
	fuel_bar.init_fuel(max_fuel)

func _physics_process(delta):
	if fuel > 0:
		var rotation_direction = Input.get_axis("rotate_left", "rotate_right")
		var move_direction = Input.get_axis("move_down", "move_up")
		
		var direction = Vector2(0, -1).rotated(rotation)
		var target_velocity = direction * move_direction * max_speed
		
		if move_direction != 0:
			velocity = velocity.move_toward(target_velocity, acceleration * delta)
			fuel -= fuel_consumption_rate * delta * abs(move_direction)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
		if velocity.length() > 0:
			velocity = velocity.limit_length(max_speed)
			move_and_slide()
		
		rotation += rotation_direction * rotation_speed * delta

	# Ensure fuel doesn't go negative
	fuel = max(fuel, 0)
	fuel_bar.fuel = fuel

	# Screen wrapping
	var screen_size = get_viewport_rect().size
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0

	# Update fuel label
	if fuel_label:
		fuel_label.text = "Fuel Remaining: " + str(int(fuel))

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()

func shoot_laser():
	var l = laser_scene.instantiate()
	l.global_position = muzzle.global_position
	l.rotation = rotation
	emit_signal("laser_shot", l)
