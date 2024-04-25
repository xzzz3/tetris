extends Tetris_Base
class_name Tetris_T

# Called when the node enters the scene tree for the first time.
func _ready():
	verticesAt0 = [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
	verticesAt90 = [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
	verticesAt180 = [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
	verticesAt270 = [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
	currVertices = verticesAt0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
