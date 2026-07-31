extends TextureRect

const PIANO_PARTICLE = preload("uid://drr73rwqqihvi")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# note to self, once notes go out of a certain range destroy them

func _process(delta: float) -> void:
	# advances particles onward
	for child in get_children():
		if child is not AnimationPlayer:
			child.position.x += delta * 100

func add_particle() -> void:
	
	var child = PIANO_PARTICLE.instantiate()
	child.region_rect = Rect2(0.0, 0.0, self.size.x / 8.0, self.size.y)
	child.position.x -= 50 # ensures they start on the left side of the screen without being seen
	child.position.y += self.size.y / 2 # centers the sprite
	
	self.add_child(child)
	
	animation_player.play('glow')
