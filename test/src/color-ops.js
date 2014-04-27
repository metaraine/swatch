(function() {
  var componentNames, getBaseColor, isComponent, isLight, luma, _;

  if ((typeof _ === "undefined" || _ === null) && (typeof require !== "undefined" && require !== null)) {
    _ = require('lodash');
  }

  componentNames = ['light', 'medium', 'dark', 'deep', 'dim', 'pale'];

  isLight = function(rgb) {
    return luma(rgb >= 165);
  };

  luma = function(rgb) {
    return 0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b;
  };

  isComponent = function(colorName) {
    return _.some(componentNames, function(component) {
      return _.contains(colorName.toLowerCase(), component);
    });
  };

  getBaseColor = function(color) {
    return color.replace(new RegExp(componentNames.join('|'), 'gi'), '');
  };

  if (typeof module !== "undefined" && module !== null) {
    module.exports = {
      componentNames: componentNames,
      isLight: isLight,
      luma: luma,
      isComponent: isComponent,
      getBaseColor: getBaseColor
    };
  }

}).call(this);
