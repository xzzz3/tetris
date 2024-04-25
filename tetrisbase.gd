extends Node
class_name Tetris_Base

var currVertices
var verticesAt0
var verticesAt90
var verticesAt180
var verticesAt270
var angle

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func rotate():
	if (angle == 0):
		currVertices = verticesAt90
		angle = 90
	elif (angle == 90):
		currVertices = verticesAt180
		angle = 180
	elif (angle == 180):
		currVertices = verticesAt270
		angle = 270
	elif (angle == 270):
		currVertices = verticesAt0
		angle = 0

func getCurrVertices():
	return currVertices
