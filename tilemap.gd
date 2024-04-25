extends TileMap

const COLS : int = 10
const ROWS : int = 20

var piece_type
var next_piece_type
var rotation_index : int = 0
var active_piece : Array

var tile_id : int = 0
var piece_atlas : Vector2i
var next_piece_atlas : Vector2i

var board_layer : int = 0
var active_layer : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var block = Tetris_L.new()
	get_parent().add_child(block)
	draw_piece(block, Vector2i(5,1), Vector2i(5,0))

func draw_piece(piece, pos, atlas):
	for coord in piece.getCurrVertices():
		set_cell(active_layer, pos + coord, tile_id, atlas)
