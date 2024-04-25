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

var game_running : bool

# game layer variables
var board_layer : int = 0
var active_layer : int = 1

# shape variables
var shapes := [Tetris_I, Tetris_T, Tetris_J, Tetris_L, Tetris_O, Tetris_S, Tetris_Z]
var shapes_full := shapes.duplicate()

# movement variables
const start_pos := Vector2i(5,1)
var curr_pos : Vector2i
var steps : Array
const steps_req : int = 50
var speed : float
const ACCEL : float = 0.25
const directions := [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.DOWN]

# score variables
var score : int
const REWARD : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$HUD.get_node("Button").pressed.connect(restart)
	
func new_game():
	# reset variables
	game_running = true
	score = 0
	speed = 1.0
	steps = [0,0,0] # left, right, down
	$HUD.get_node("GameOverLabel").hide()
	
	piece_class = pick_piece_class()
	piece_atlas = Vector2i(shapes_full.find(piece_class), 0)
	next_piece_class = pick_piece_class()
	next_piece_atlas = Vector2i(shapes_full.find(next_piece_class), 0)
	create_piece()

func restart():
	# clear all previous
	clear_board()
	clear_panel()
	clear_piece()
	
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not game_running:
		return
	
	# input keys
	if Input.is_action_pressed("ui_down"):
		steps[2] += 10
	elif Input.is_action_pressed("ui_right"):
		steps[1] += 10
	elif Input.is_action_pressed("ui_left"):
		steps[0] += 10
	elif Input.is_action_just_pressed("ui_up"):
		rotate_piece()
	
	# apply downward movement every frame
	steps[2] += speed
	
	# update movement
	for direction in range(steps.size()):
		if (steps[direction] > steps_req):
			move_piece(directions[direction])
			steps[direction] = 0
	 
func pick_piece_class():
	var piece
	if shapes.is_empty():
		shapes = shapes_full.duplicate()
	shapes.shuffle()
	piece = shapes.pop_front()
	return piece
	
func create_piece():
	# reset variables
	steps = [0,0,0]
	curr_pos = start_pos
	active_piece = piece_class.new()
	get_parent().add_child(active_piece)
	active_piece.rotate(rotation_index)
	draw_piece(active_piece, curr_pos, piece_atlas)
	
	# draw next piece
	var next_piece_preview = next_piece_class.new()
	get_parent().add_child(next_piece_preview)
	draw_piece(next_piece_preview, Vector2i(15,6), next_piece_atlas)

func clear_piece():
	for coord in active_piece.getCurrVertices():
		erase_cell(active_layer, curr_pos + coord)

func draw_piece(piece, pos, atlas):
	for coord in piece.getCurrVertices():
		set_cell(active_layer, pos + coord, tile_id, atlas)
		
func move_piece(direction):
	if (can_move(direction)):
		clear_piece()
		curr_pos += direction
		draw_piece(active_piece, curr_pos, piece_atlas)
	else:
		if direction == Vector2i.DOWN:
			land_piece()
			check_rows()
			piece_class = next_piece_class
			piece_atlas = next_piece_atlas
			next_piece_class = pick_piece_class()
			next_piece_atlas = Vector2i(shapes_full.find(next_piece_class), 0)
			clear_panel()
			create_piece()
			check_game_over()

func rotate_piece():
	if can_rotate():
		clear_piece()
		active_piece.rotateClockise()
		draw_piece(active_piece, curr_pos, piece_atlas)

func is_free(coord):
	return get_cell_source_id(board_layer, coord) == -1
	
func can_move(direction):
	# check if there is space to move
	for coord in active_piece.getCurrVertices():
		if not is_free(coord + curr_pos + direction):
			return false
	return true

func can_rotate():
	for coord in active_piece.getRotatedVertices():
		if not is_free(coord + curr_pos):
			return false
	return true

func land_piece():
	# remove from active layer and move to board layer
	for coord in active_piece.getCurrVertices():
		erase_cell(active_layer, curr_pos + coord)
		set_cell(board_layer, curr_pos + coord, tile_id, piece_atlas)
		
func clear_panel():
	for x in range(14,19):
		for y in range(5,9):
			erase_cell(active_layer, Vector2i(x,y))

func check_rows():
	var row : int = ROWS
	while row > 0:
		var count = 0
		for idx in range(COLS):
			if not is_free(Vector2i(idx + 1, row)):
				count += 1
		if count == COLS:
			shift_rows(row)
			score += REWARD
			$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
			speed += ACCEL
		else:
			row -= 1
			
func shift_rows(row):
	var atlas
	for i in range(row, 1, -1):
		for j in range(COLS):
			atlas = get_cell_atlas_coords(board_layer, Vector2i(j + 1, i - 1))
			if atlas == Vector2i(-1, -1):
				erase_cell(board_layer, Vector2i(j+1, i))
			else:
				set_cell(board_layer, Vector2i(j+1,i), tile_id, atlas)

func clear_board():
	for row in range(ROWS):
		for col in range(COLS):
			erase_cell(board_layer, Vector2i(col+1,row+1))

func check_game_over():
	for coord in active_piece.getCurrVertices():
		if not is_free(coord + curr_pos):
			land_piece()
			$HUD.get_node("GameOverLabel").show()
			game_running = false
