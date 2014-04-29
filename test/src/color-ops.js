(function() {
  var ColorOps, componentNames, getBaseColor, isComponent, isLight, luma;

  if ((typeof _ === "undefined" || _ === null) && (typeof require !== "undefined" && require !== null)) {
    _ = require('lodash');;
  }

  componentNames = ['light', 'medium', 'dark', 'deep', 'dim', 'pale', 'hot', 'drab'];

  isLight = function(rgb) {
    return luma(rgb) >= 150;
  };

  luma = function(rgb) {
    return 0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b;
  };

  isComponent = function(colorName) {
    return componentNames.some(function(component) {
      return _.contains(colorName.toLowerCase(), component);
    });
  };

  getBaseColor = function(color) {
    return color.replace(new RegExp(componentNames.join('|'), 'gi'), '');
  };

  ColorOps = {
    componentNames: componentNames,
    isLight: isLight,
    luma: luma,
    isComponent: isComponent,
    getBaseColor: getBaseColor
  };

  if (typeof module !== "undefined" && module !== null) {
    module.exports = ColorOps;
  } else {
    window.ColorOps = ColorOps;
  }

}).call(this);
