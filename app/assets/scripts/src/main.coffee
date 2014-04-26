componentNames = ['light', 'medium', 'dark', 'deep', 'dim', 'pale']

isLight = (rgb)->
	luma rgb >= 165

luma = (rgb)->
	0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b; # SMPTE C, Rec. 709 weightings

isComponent = (color)->
	_.some(componentNames, (component)->
		_.contains color.name, component
	) and 
	_.contains colors, getBaseColor color

getBaseColor = (color)->
	return color.replace new RegExp(componentNames.join('|'), 'g'), ''

attachEventHandlers = ()->
	$('#option-groupbyname').on 'click', ()->
		console.log 'test'

		false

render = ()->

	colorgroups = _.groupBy colors, (color)->
		if isComponent color
			getBaseColor color.name
		else
			color.name

	console.log colorgroups

	for color in colors

		colorEl = $("<div class='color'>#{color.name}</div>")
			.css 
				backgroundColor: color.name
			.addClass if isLight color.rgb then '.text-dark' else '.text-light'

		$('#colors').append colorEl


$ ()->
	render()
	attachEventHandlers()
