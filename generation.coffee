terrain = (seed) ->
	instance = Object.create terrain.Terrain
	instance.noise = new SimplexNoise seed or Math.random
	instance.layers = []
	return instance



terrain.Terrain =

	z: (x, y) ->
		z = 0;
		for layer in @layers
			z = layer.z @noise, x, y, z
		return z





layer = (from) ->
	return Object.create from



layer.Layer =
	stretch: 1
	amplify: 1
	z: (noise, x, y, z) ->
		z += noise.noise2D(x / @stretch, y / @stretch) * @amplify
		return z



layer.Base = Object.create layer.Layer
layer.Base.stretch = 100
layer.Base.amplify = 20

layer.Minimum = Object.create layer.Layer
layer.Minimum.minimum = 10
layer.Minimum.z = (noise, x, y, z) ->
	return if z < @minimum then @minimum else z

layer.Maximum = Object.create layer.Layer
layer.Maximum.maximum = 30
layer.Maximum.z = (noise, x, y, z) ->
	return if z > @maximum then @maximum else z

layer.Relief = Object.create layer.Layer
layer.Relief.stretch = 2
layer.Relief.amplify = .1
layer.Relief.z = (noise, x, y, z) ->
	z += noise.noise2D(x * @stretch, y * @stretch) * @amplify * z / 30
	return z
