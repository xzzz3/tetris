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

func rotate(currAngle):
	if (currAngle == 0):
		currVertices = verticesAt90
		angle = 90
	elif (currAngle == 90):
		currVertices = verticesAt180
		angle = 180
	elif (currAngle == 180):
		currVertices = verticesAt270
		angle = 270
	elif (currAngle == 270):
		currVertices = verticesAt0
		angle = 0

func rotateClockise():
	rotate(getRotationAngle())
	
func getRotatedVertices():
	if (angle == 0):
		return verticesAt90
	elif (angle == 90):
		return verticesAt180
	elif (angle == 180):
		return verticesAt270
	elif (angle == 270):
		return verticesAt0

func getCurrVertices():
	return currVertices

func getRotationAngle():
	return angle
