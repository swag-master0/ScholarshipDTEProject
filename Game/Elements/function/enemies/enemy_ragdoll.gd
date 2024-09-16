extends Node3D

@onready var ragdoll = $Skeleton3D


func StartRagdoll():
	ragdoll.physical_bones_start_simulation()
