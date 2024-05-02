extends Node3D

@onready var timer = $Timer
@onready var area = $Area3D
@onready var center = $Center

@export var force : float = 250
@export var damage : float = 7

var triggered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !triggered:
		triggered = true
		timer.start() # not doing this results in timer constantly restarting, which means it never deletes itself.
	
	
	for i in area.get_overlapping_bodies():
		if i is RigidBody3D:
			i.apply_force((i.global_position - center.global_position).normalized() * force)
		
		if i.is_in_group("player") or i.is_in_group("enemy"):
			for x in i.get_children():
				if x.is_in_group("info"):
					x.Damage(damage)
		

func _on_timer_timeout():
	self.queue_free()




