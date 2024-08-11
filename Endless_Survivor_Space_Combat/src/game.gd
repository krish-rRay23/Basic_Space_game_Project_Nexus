extends Node2D

@onready var lasers = $Lasers
@onready var player = $Player
@onready var fuel_bar = $FuelBar

func _ready():
	player.connect("laser_shot", _on_player_laser_shot)
	fuel_bar.init_fuel(player.max_fuel)

func _process(delta):
	fuel_bar.fuel = player.fuel   

func _on_player_laser_shot(laser):
	lasers.add_child(laser)
