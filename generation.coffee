terrain = (seed) ->
	instance = Object.create terrain.Terrain
	instance.noise = new SimplexNoise seed or Math.random
	return instance



terrain.Terrain =

	_z: (x, y) ->
		z = 8

		# base height
		base = @noise.noise2D x / 250, y / 250
		z += base * 10

		# mountains height
		mountains = base * @noise.noise2D x / 40, y / 40
		z += mountains * 18

		# hills
		hills = Math.abs(base + mountains) * @noise.noise2D x / 10, y / 10
		z += hills * 4

		# rough surface
		roughness = mountains * @noise.noise2D x / 2, y / 2
		z += roughness * 2

		# water
		if z < 0 then z = 0

		return z
