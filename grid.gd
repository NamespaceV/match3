extends Node2D

var grid = []

func _ready() -> void:
	fill_grid()
	Console.add_command("reset", reset)

func fill_grid():
	for x in 10:
		grid.append([])
		for y in 10:
			var randomType = randi_range(0,6) as Tile.TileType
			var t = Tile.create(randomType)
			add_child(t)
			grid[x].append(t)
			t.position = tile_position(x,y)

func tile_position(x,y):
	return Vector2(x * 50, y * 50)

func reset():
	print("reset")
	get_tree().change_scene_to_file("res://game.tscn")
