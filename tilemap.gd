extends TileMap

const COLS : int = 10
const ROWS : int = 20

# game content variables
var piece_class
var next_piece_class
var rotation_index : int = 0
var active_piece

var tile_id : int = 0
var piece_atlas : Vector2i
var next_piece_atlas : Vector2i

# game layer variables
var board_layer : int = 0
var active_layer : int = 1

# shape variables
var shapes := [Tetris_I, Tetris_T, Tetris_J, Tetris_L, Tetris_O, Tetris_S, Tetris_Z]
var shapes_full := shapes.duplicate()

# movement variables
const start_pos := Vector2i(5,1)
var curr_pos : Vector2i
var steps : int
const steps_req : int = 50
var speed : float

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	
func new_game():
	# reset variables
	speed = 1.0
	steps = 0
	
	piece_class = pick_piece_class()
	piece_atlas = Vector2i(shapes_full.find(piece_class), 0)
	create_piece()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# apply downward movement every frame
	steps += speed
	if (steps > steps_req):
		move_piece(Vector2i.DOWN)
		steps = 0
	
func pick_piece_class():
	var piece
	if shapes.is_empty():
		shapes = shapes_full.duplicate()
	shapes.shuffle()
	piece = shapes.pop_front()
	return piece
	
func create_piece():
	# reset variables
	curr_pos = start_pos
	active_piece = piece_class.new()
	get_parent().add_child(active_piece)
	active_piece.rotate(rotation_index)
	draw_piece(active_piece, curr_pos, piece_atlas)

func clear_piece():
	for coord in active_piece.getCurrVertices():
		erase_cell(active_layer, curr_pos + coord)
	

func draw_piece(piece, pos, atlas):
	for coord in piece.getCurrVertices():
		set_cell(active_layer, pos + coord, tile_id, atlas)
		
func move_piece(direction):
	clear_piece()
	curr_pos += direction
	draw_piece(active_piece, curr_pos, piece_atlas)
