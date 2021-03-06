attachEventHandlers = ()->

	# toggle settings panel
	$('#settings-toggle').on 'click', ()->
		$('#settings-panel').fadeToggle();
		$('#content').toggleClass('backfade');
		false

	# click outside settings panel to dismiss
	# $(document).on 'click', (e)->
		# console.log this, e.target, e.srcElement

baseExists = (colorName)->
	_.contains colors, ColorOps.getBaseColor colorName

render = ()->

	# group the colors by base name
	colorgroups = _.groupBy colors, (color)->
		if ColorOps.isComponent color.name
			ColorOps.getBaseColor color.name
		else
			color.name

	# create a horizontal group for each base name
	for name of colorgroups
		group = colorgroups[name]
		groupEl = $("<div class='cols'>");

		# add individual colors to horizontal group
		for color in group
			colorEl = $("<div class='color'><span class='color-text'>#{color.name}</span></div>")
				.css 
					backgroundColor: color.name
				.addClass if ColorOps.isLight color.rgb then 'text-dark' else 'text-light'
			groupEl.append colorEl

		$('#colors').append groupEl


$ ()->
	render()
	attachEventHandlers()
