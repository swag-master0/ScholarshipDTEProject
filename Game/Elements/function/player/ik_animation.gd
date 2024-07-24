extends Node

@export var interpolation : float = 0.025
@export var walking_distance : float = 1
@export var idle_distance : float = 0.5


@onready var player = $"../.."

@onready var right_leg_ik = $Armature/Skeleton3D/RightLegIK
@onready var left_leg_ik = $Armature/Skeleton3D/LeftLegIK

@onready var legR_ik_root = $"LegR-IKRoot"
@onready var legL_ik_root = $"LegL-IKRoot"

@onready var legR_ik_base = $"LegR-Base"
@onready var legL_ik_base = $"LegL-Base"
@onready var legR_base_walking = $"LegR-BaseWalking"
@onready var legL_base_walking = $"LegL-BaseWalking"

var if_stepping = false


func _ready():
	right_leg_ik.start()
	left_leg_ik.start()


func _process(_delta):
	if (legR_ik_root.global_position.distance_to(legR_ik_base.global_position) > walking_distance) and player.velocity and !if_stepping:
		RightWalkingStep()
	
	if (legL_ik_root.global_position.distance_to(legL_ik_base.global_position) > walking_distance) and player.velocity and !if_stepping:
		LeftWalkingStep()
	
	
	
	if (legR_ik_root.global_position.distance_to(legR_ik_base.global_position) > idle_distance) and !player.velocity and !if_stepping:
		RightIdleStep()
	
	if (legL_ik_root.global_position.distance_to(legL_ik_base.global_position) > idle_distance) and !player.velocity and !if_stepping:
		LeftIdleStep()
	
	
	
	
	if !player.is_on_floor():
		legL_ik_root.global_position = legL_ik_base.global_position
		legR_ik_root.global_position = legR_ik_base.global_position
		
		right_leg_ik.stop()
		left_leg_ik.stop()
	elif player.is_on_floor():
		right_leg_ik.start()
		left_leg_ik.start()
		
	

func RightWalkingStep():
	if_stepping = true
	
	var target_pos = legR_base_walking.global_position
	var half_way = (legR_ik_root.global_position + target_pos) / 2
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(legR_ik_root, "global_position", half_way + (owner.basis.y) / 4, interpolation)
	tween.tween_property(legR_ik_root, "global_position", target_pos, interpolation)
	tween.tween_callback(func(): if_stepping = false)


func LeftWalkingStep():
	if_stepping = true
	
	var target_pos = legL_base_walking.global_position
	var half_way = (legL_ik_root.global_position + target_pos) / 2
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(legL_ik_root, "global_position", half_way + (owner.basis.y) / 4, interpolation)
	tween.tween_property(legL_ik_root, "global_position", target_pos, interpolation)
	tween.tween_callback(func(): if_stepping = false)



func RightIdleStep():
	if_stepping = true
	
	var target_pos = legR_ik_base.global_position
	var half_way = (legR_ik_root.global_position + target_pos) / 2
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(legR_ik_root, "global_position", half_way + (owner.basis.y) / 4, interpolation)
	tween.tween_property(legR_ik_root, "global_position", target_pos, interpolation)
	tween.tween_callback(func(): if_stepping = false)


func LeftIdleStep():
	if_stepping = true
	
	var target_pos = legL_ik_base.global_position
	var half_way = (legL_ik_root.global_position + target_pos) / 2
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(legL_ik_root, "global_position", half_way + (owner.basis.y) / 4, interpolation)
	tween.tween_property(legL_ik_root, "global_position", target_pos, interpolation)
	tween.tween_callback(func(): if_stepping = false)









