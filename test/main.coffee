ColorOps = require './src/color-ops.js'
assert = require 'assert'

mediumPurple =
	name: 'MediumPurple',
	hex: 	'9370DB',
	rgb: { r: 147, g: 112, b: 219 }

purple =
	name: 'Purple',
	hex: 	'800080',
	rgb: { r: 128, g: 0, b: 128 }

blueViolet =
	name: 'BlueViolet',
	hex: 	'8A2BE2',
	rgb: { r: 138, g: 43, b: 226 }

describe 'ColorOps.getBaseColor', ()->

	it 'should strip off light, dark, medium, etc', ()->
		assert.equal ColorOps.getBaseColor(mediumPurple.name), 'Purple'

	it 'should return non-component colors as-is', ()->
		assert.equal ColorOps.getBaseColor(blueViolet.name), 'BlueViolet'

	it 'should return base colors as-is', ()->
		assert.equal ColorOps.getBaseColor(purple.name), 'Purple'

describe 'isComponent', ()->

	it 'should return true for colors with "light", "dark", "medium", etc in their name', ()->
		assert.equal ColorOps.isComponent(mediumPurple.name), true

	it 'should return false for colors without "light", "dark", "medium", etc in their name', ()->
		assert.equal ColorOps.isComponent(purple.name), false
		assert.equal ColorOps.isComponent(blueViolet.name), false