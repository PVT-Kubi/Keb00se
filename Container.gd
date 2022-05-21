extends Container


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport = get_viewport_rect();
	self.set_size(Vector2(viewport.size.x, 250))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
