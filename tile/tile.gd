class_name Tile
extends Node2D

static var scene : PackedScene = load("res://tile/tile.tscn")

signal on_tile_clicked( tile : Tile)

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
var x:int
var y:int

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

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			on_tile_clicked.emit(self)

func set_selected(selected:bool)->void:
	if selected:
		$Selection.show()
	else :
		$Selection.hide()

func is_near(other:Tile)->bool:
	if x == other.x:
		return abs(y-other.y) == 1
	if y == other.y:
		return abs(x-other.x) == 1
	return false
