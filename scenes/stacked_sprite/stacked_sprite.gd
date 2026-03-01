@tool
extends Node2D
class_name StackedSprite

@export var texture: Texture2D
@export var sprite_hframes: int =10
@export var vertical_spacing: float= 1.0

@export var sprite_rotation: float =0.0
@export var spin_sprite: bool = false
@export var spin_speed:float = 1.0

@warning_ignore("unused_private_class_variable")
@export_tool_button("Stack Sprite!") var _restack_button: Callable = func():
	_stack_sprites()

func _ready() -> void:
	_stack_sprites()

func _physics_process(delta: float) -> void:
	if get_child_count() > 0:
		for i in get_children():
			if spin_sprite:
				i.rotation_degrees += spin_speed * delta
			else:
				i.rotation_degrees = sprite_rotation

func _stack_sprites():
	if get_child_count() > 0:
		for child in get_children():
			child.queque_free()
		
	if texture == null:
		push_warning("No texture assigned!")
		return
	
	for i in range(sprite_hframes):
		var stacked_sprite: Sprite2D = Sprite2D.new()
		stacked_sprite.texture = texture
		
		stacked_sprite.hframes = sprite_hframes
		stacked_sprite.frame = i
		
		stacked_sprite.position.y = -i * vertical_spacing
		add_child.call_deferred(stacked_sprite)
