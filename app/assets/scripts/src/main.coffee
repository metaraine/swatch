isLight = (rgb)->
	luma rgb >= 165

luma = (rgb)->
	0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b; # SMPTE C, Rec. 709 weightings

for color in colors

	colorEl = $("<div class='color'>#{color.name}</div>")
		.css 
			backgroundColor: color.name
		.addClass if isLight color.rgb then '.text-dark' else '.text-light'

	$('#colors').append colorEl