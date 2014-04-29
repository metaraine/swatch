if not _? and require?
	`_ = require('lodash');`

componentNames = ['light', 'medium', 'dark', 'deep', 'dim', 'pale', 'hot', 'drab']

isLight = (rgb)->
	luma(rgb) >= 150

luma = (rgb)->
	0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b # SMPTE C, Rec. 709 weightings

isComponent = (colorName)->
	componentNames.some (component)->
		_.contains colorName.toLowerCase(), component

getBaseColor = (color)->
	color.replace new RegExp(componentNames.join('|'), 'gi'), ''

ColorOps =
	componentNames: componentNames
	isLight: isLight
	luma: luma
	isComponent: isComponent
	getBaseColor: getBaseColor

if module?
	module.exports = ColorOps
else
	window.ColorOps = ColorOps
