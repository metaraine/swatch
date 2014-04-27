(function() {
  var attachEventHandlers, baseExists, render;

  attachEventHandlers = function() {
    return $('#option-groupbyname').on('click', function() {
      console.log('test');
      return false;
    });
  };

  baseExists = function(colorName) {
    return _.contains(colors, getBaseColor(colorName));
  };

  render = function() {
    var color, colorEl, colorgroups, _i, _len, _results;
    colorgroups = _.groupBy(colors, function(color) {
      console.log('color', color.name, isComponent(color.name));
      if (isComponent(color.name)) {
        return getBaseColor(color.name);
      } else {
        return color.name;
      }
    });
    console.log(colorgroups);
    _results = [];
    for (_i = 0, _len = colors.length; _i < _len; _i++) {
      color = colors[_i];
      colorEl = $("<div class='color'>" + color.name + "</div>").css({
        backgroundColor: color.name
      }).addClass(isLight(color.rgb) ? '.text-dark' : '.text-light');
      _results.push($('#colors').append(colorEl));
    }
    return _results;
  };

  $(function() {
    render();
    return attachEventHandlers();
  });

}).call(this);
