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

func rotate(index):
	if (index == 0):
		currVertices = verticesAt90
		angle = 90
	elif (index == 90):
		currVertices = verticesAt180
		angle = 180
	elif (index == 180):
		currVertices = verticesAt270
		angle = 270
	elif (index == 270):
		currVertices = verticesAt0
		angle = 0

func rotateClockise():
	var newAngle = (getRotationAngle() + 90) % 360
	rotate(newAngle)

func getCurrVertices():
	return currVertices

func getRotationAngle():
	return angle
