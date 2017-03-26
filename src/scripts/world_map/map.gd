extends Node2D

var boundaries
var hex_lengths
var pixel_offsets

func _ready():
	self.boundaries = CONFIG.map_boundaries
	var size = CONFIG.hex_size
	var side = size/sqrt(3)
	self.hex_lengths = {
		'width': size,
		'halfwidth': size/2,
		'side': int(side),
		'halfside': int(side/2),
		'rowheight': int(side*1.5),
	}
	self.pixel_offsets = [0, 0]

func _draw():
	for x in range(self.boundaries[0], self.boundaries[2]):
		for y in range(self.boundaries[1], self.boundaries[3]):
			self.draw_hex([x,y])

func draw_hex(pos):
	var center = self.pos_to_pixel(pos)
	var start = Vector2(center[0] - self.hex_lengths['halfwidth'], center[1] - self.hex_lengths['halfside'])
	var end = Vector2(center[0], center[1] - self.hex_lengths['side'])
	self.draw_line(start, end, CONFIG.grid_color, 1)
	start = end
	end.x += self.hex_lengths['halfwidth']
	end.y += self.hex_lengths['halfside']
	self.draw_line(start, end, CONFIG.grid_color, 1)
	start = end
	end.y += self.hex_lengths['side']
	self.draw_line(start, end, CONFIG.grid_color, 1)

func pos_to_pixel(pos):
	var x = (self.hex_lengths['width'] * (pos[0] - self.boundaries[0])) \
		+ (self.hex_lengths['halfwidth'] * (self.boundaries[3] - pos[1])) + self.pixel_offsets[0]
	var y = (self.hex_lengths['rowheight'] * (self.boundaries[3] - pos[1])) + self.pixel_offsets[1]
	return [x,y]