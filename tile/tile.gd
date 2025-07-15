class_name Tile
extends Node2D

static var scene : PackedScene = load("res://tile/tile.tscn")

enum TileType
{
	red,
	blue,
	green,
	yellow,
	black,
	violet,
}

var type : TileType

static func create(type:TileType) -> Tile:
	var o = scene.instantiate()
	o.set_type(type)
	return o

func set_type(new_type:TileType) -> void:
	type = new_type
	$Polygon2D.color = get_color(new_type)

func get_color(type:TileType) -> Color:
	match type:
		TileType.red: return Color.RED
		TileType.blue: return Color.BLUE
		TileType.green: return Color.GREEN
		TileType.yellow: return Color.YELLOW
		TileType.black: return Color.BLACK
		TileType.violet: return Color.VIOLET
	push_error("color not found %s" % [type])
	return Color.WHITE
