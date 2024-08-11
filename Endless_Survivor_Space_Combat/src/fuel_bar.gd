extends ProgressBar

@onready var timer = $Timer
@onready var FuelConsumptionBar = $FuelConsumptionBar

var fuel = 0 : set = _set_fuel

func _set_fuel(new_fuel):
	var prev_fuel = fuel
	fuel = min(max_value,new_fuel)
	value = fuel
	if fuel<=0:
		queue_free()
	if fuel < prev_fuel:
		timer.start()
	else:
		FuelConsumptionBar.value = fuel


func init_fuel(_fuel):
	fuel = _fuel
	max_value = fuel
	value = fuel
	FuelConsumptionBar.max_value = fuel
	FuelConsumptionBar.value = fuel
	
	
	 

func _on_timer_timeout():
	FuelConsumptionBar.value = fuel
