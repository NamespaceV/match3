extends Node2D

var grid = []
var selected_tile : Tile

func _ready() -> void:
	fill_grid()
	Console.add_command("reset", reset)

func fill_grid():
	for x in 10:
		grid.append([])
		for y in 10:
			var randomType = randi_range(0,6) as Tile.TileType
			var t = Tile.create(randomType)
			t.on_tile_clicked.connect(on_tile_clicked)
			t.x = x
			t.y = y
			add_child(t)
			grid[x].append(t)
			t.position = tile_position(x,y)

func tile_position(x,y):
	return Vector2(x * 50, y * 50)

func reset():
	print("reset")
	get_tree().change_scene_to_file("res://game.tscn")

func on_tile_clicked(tile:Tile):
	if selected_tile == null:
		selected_tile = tile
		tile.set_selected(true)
		return

	if tile == selected_tile:
		return

	if tile.is_near(selected_tile):
		var t2 = selected_tile
		selected_tile.set_selected(false)
		selected_tile = null
		swap_tiles(t2, tile)
	else:
		selected_tile.set_selected(false)
		selected_tile = tile
		tile.set_selected(true)

func swap_tiles(t1:Tile, t2:Tile):
	var t1_xy = Vector2i(t1.x, t1.y)
	t1.x = t2.x
	t1.y = t2.y
	t2.x = t1_xy[0]
	t2.y = t1_xy[1]
	t1.position = tile_position(t1.x, t1.y)
	t2.position = tile_position(t2.x, t2.y)
	grid[t1.x][t1.y] = t1
	grid[t2.x][t2.y] = t2
