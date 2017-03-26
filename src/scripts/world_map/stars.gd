extends TileMap

func _ready():
	self.hide()
	for pos in self.get_used_cells():
		print('star type ', self.get_cell(pos[0], pos[1]), ' at position ', pos)
