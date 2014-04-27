attachEventHandlers = ()->
	$('#option-groupbyname').on 'click', ()->
		console.log 'test'
		false

baseExists = (colorName)->
	_.contains colors, ColorOps.getBaseColor colorName

render = ()->

	# TODO: fix luma
	# TODO: sort base name first within group
	# TODO: sort single groups before multi groups

	# group the colors by base name
	colorgroups = _.groupBy colors, (color)->
		if ColorOps.isComponent color.name
			ColorOps.getBaseColor color.name
		else
			color.name

	# create a horizontal group for each base name
	for name of colorgroups
		group = colorgroups[name]
		groupEl = $("<div class='horizontal-group'>");

		# add individual colors to horizontal group
		for color in group
			colorEl = $("<div class='color'>#{color.name}</div>")
				.css 
					backgroundColor: color.name
				.addClass if ColorOps.isLight color.rgb then '.text-dark' else '.text-light'
			groupEl.append colorEl

		$('#colors').append groupEl


$ ()->
	render()
	attachEventHandlers()
