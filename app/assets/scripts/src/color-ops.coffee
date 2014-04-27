if not _? and require? then _ = require 'lodash'

componentNames = ['light', 'medium', 'dark', 'deep', 'dim', 'pale']

isLight = (rgb)->
	luma rgb >= 165

luma = (rgb)->
	0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b; # SMPTE C, Rec. 709 weightings

isComponent = (colorName)->
	_.some componentNames, (component)->
		_.contains colorName.toLowerCase(), component

getBaseColor = (color)->
	color.replace new RegExp(componentNames.join('|'), 'gi'), ''

if module? then module.exports =
	componentNames: componentNames
	isLight: isLight
	luma: luma
	isComponent: isComponent
	getBaseColor: getBaseColor
