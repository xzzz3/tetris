extends Tetris_Base
class_name Tetris_I

# Called when the node enters the scene tree for the first time.
func _ready():
	verticesAt0 = [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]
	verticesAt90 = [Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]
	verticesAt180 = [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]
	verticesAt270 = [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]
	currVertices = verticesAt0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
