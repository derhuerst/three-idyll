landscape = (seed) ->
	instance = Object.create landscape.Landscape
	instance.noise = new SimplexNoise seed or Math.random
	return instance



landscape.Landscape =

	height: (x, y) ->
		z = 8

		# base height
		base = @noise.noise2D x / 250, y / 250
		z += base * 10 - 2

		# mountains: height
		mountains = @noise.noise2D x / 40, y / 40
		z += base * mountains * 18

		# mountains: sharp edges
		edges = Math.pow mountains, 2
		z += edges / 6

		# hills
		hills = Math.abs(base + mountains) * @noise.noise2D x / 10, y / 10
		z += hills * 4

		# rough surface
		roughness = 1   # base roughness
		roughness += 2 * mountains * @noise.noise2D x / 2, y / 2
		z += roughness / if mountains < 0 then 5 else 3

		# water
		if z < 0 then z = 0

		return z

	terrain: (size) ->
		size--
		geometry = new THREE.PlaneGeometry size, size, size, size

		i = 0
		for x in [0..size]
			for y in [0..size]
				geometry.vertices[i].z = @height x, y
				i++

		geometry.computeFaceNormals()
		geometry.computeVertexNormals()
		return geometry
