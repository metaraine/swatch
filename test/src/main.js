(function() {
  var attachEventHandlers, baseExists, render;

  attachEventHandlers = function() {
    return $('#settings-toggle').on('click', function() {
      $('#settings-panel').fadeToggle();
      $('#content').toggleClass('fade');
      return false;
    });
  };

  baseExists = function(colorName) {
    return _.contains(colors, ColorOps.getBaseColor(colorName));
  };

  render = function() {
    var color, colorEl, colorgroups, group, groupEl, name, _i, _len, _results;
    colorgroups = _.groupBy(colors, function(color) {
      if (ColorOps.isComponent(color.name)) {
        return ColorOps.getBaseColor(color.name);
      } else {
        return color.name;
      }
    });
    _results = [];
    for (name in colorgroups) {
      group = colorgroups[name];
      groupEl = $("<div class='cols'>");
      for (_i = 0, _len = group.length; _i < _len; _i++) {
        color = group[_i];
        colorEl = $("<div class='color'>" + color.name + "</div>").css({
          backgroundColor: color.name
        }).addClass(ColorOps.isLight(color.rgb) ? 'text-dark' : 'text-light');
        groupEl.append(colorEl);
      }
      _results.push($('#colors').append(groupEl));
    }
    return _results;
  };

  $(function() {
    render();
    return attachEventHandlers();
  });

}).call(this);
