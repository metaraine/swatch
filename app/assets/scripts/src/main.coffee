attachEventHandlers = ()->
	$('#option-groupbyname').on 'click', ()->
		console.log 'test'
		false

baseExists = (colorName)->
	_.contains colors, getBaseColor colorName

render = ()->

	colorgroups = _.groupBy colors, (color)->
		console.log 'color', color.name, isComponent color.name
		if isComponent color.name
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
