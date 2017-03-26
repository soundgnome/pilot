extends TileMap

func _ready():
	var map = self.get_node('../map')
	self.hide()
	for pos in self.get_used_cells():
		map.add_star({'pos': pos, 'type': self.get_cell(pos[0], pos[1])})
