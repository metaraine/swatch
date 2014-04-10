for color in colors

	colorEl = $("<div class='color'>#{color.name}</div>")
		.css 
			backgroundColor: color.name
			color: if isLight color.rgb then '#111' else '#eee'

	$('#colors').append colorEl