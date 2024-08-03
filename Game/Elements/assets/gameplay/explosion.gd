extends Node3D

@onready var timer = $Timer
@onready var area = $Area3D
@onready var center = $Center

@export var force : float = 1000
@export var damage : float = 8

var triggered = false
var affected = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in $Area3D.get_overlapping_bodies():
		
		if i is RigidBody3D and !(affected.has(i)):
			i.apply_force((i.global_position - center.global_position).normalized() * force)
			affected.append(i)
			
		if (i.is_in_group("player") or i.is_in_group("enemy")) and !(affected.has(i)):
			affected.append(i)
			for x in i.get_children():
				if x.is_in_group("info"):
					x.Damage(damage)
	
	
	if !triggered:
		triggered = true
		
		$Particles.emitting = true
		
		$ExplosionSFX.pitch_scale = randf_range(75, 125) / 100
		$ExplosionSFX.play()
		$ExplosionSFX.reparent(self.get_parent())
		
		
		timer.start() # not doing this results in timer constantly restarting, which means it never deletes itself.
	

func _on_particles_finished():
	await get_tree().create_timer(0.1).timeout
	$OmniLight3D.light_energy = 0

func _on_timer_timeout():
	self.queue_free()







