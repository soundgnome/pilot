extends Node2D

var boundaries = CONFIG.map_boundaries
var hex_lengths
var pixel_offsets = CONFIG.map_offsets
var stars = []


func add_star(star):
	self.stars.append(star)

func _ready():
	var size = CONFIG.hex_size
	var side = size/sqrt(3)
	self.hex_lengths = {
		'width': size,
		'halfwidth': size/2,
		'side': int(side),
		'halfside': int(side/2),
		'rowheight': int(side*1.5),
	}


func _draw():
	self._draw_stars()
	self._draw_grid()


func _draw_grid():
	for x in range(self.boundaries[0], self.boundaries[2]):
		if (x == 0):
			for y in range(self.boundaries[1], self.boundaries[3]-1):
				self._draw_hex([x,y], [0,1,2,3,4])
			self._draw_hex([x, self.boundaries[3]-1], [0,1,2,3,4,5])
		else:
			for y in range(self.boundaries[1], self.boundaries[3]-1):
				self._draw_hex([x,y], [2,3,4])
			self._draw_hex([x, self.boundaries[3]-1], [2,3,4,5,0])


func _draw_hex(pos, sides):
	var corners = self._get_hex_corners(pos)
	for side in sides:
		draw_line(corners[side], corners[(side+1)%6], CONFIG.grid_color)


func _draw_star(star):
	var center = self._pos_to_pixel(star['pos'])
	self.draw_circle(Vector2(center[0], center[1]), CONFIG.star_sizes[star['type']], CONFIG.star_color)


func _draw_stars():
	for star in self.stars:
		self._draw_star(star)


func _get_hex_corners(pos):
	var center = self._pos_to_pixel(pos)
	var xs = [
		center[0] - self.hex_lengths['halfwidth'],
		center[0],
		center[0] + self.hex_lengths['halfwidth'],
	]
	var ys = [
		center[1] - self.hex_lengths['side'],
		center[1] - self.hex_lengths['halfside'],
		center[1] + self.hex_lengths['halfside'],
		center[1] + self.hex_lengths['side'],
	]
	var corners = [
		Vector2(xs[1], ys[3]),
		Vector2(xs[0], ys[2]),
		Vector2(xs[0], ys[1]),
		Vector2(xs[1], ys[0]),
		Vector2(xs[2], ys[1]),
		Vector2(xs[2], ys[2]),
	]
	return corners


func _pos_to_pixel(pos):
	var x = (self.hex_lengths['width'] * (pos[0] - self.boundaries[0])) \
		+ (self.hex_lengths['halfwidth'] * pos[1]) + self.pixel_offsets[0]
	var y = (self.hex_lengths['rowheight'] * pos[1]) + self.pixel_offsets[1]
	return [x,y]
