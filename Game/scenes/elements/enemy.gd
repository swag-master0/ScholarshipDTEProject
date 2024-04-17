extends CharacterBody3D

@export var speed = 5
@export var accel = 10

@onready var nav : NavigationAgent3D = $NavigationAgent3D


func _physics_process(delta):
	
	var direction = Vector3()
	
	for i in range(self.get_parent_node_3d().get_children().size()):
		
		if self.get_parent_node_3d().get_children()[i] is CharacterBody3D and self.get_parent_node_3d().get_children()[i].is_in_group("player"):
			var player = self.get_parent_node_3d().get_children()[i]
			
			
			nav.target_position = player.global_position
			
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
