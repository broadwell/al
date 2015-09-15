// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.AL.module("MapApp.Show", function(Show, App, Backbone, Marionette, $, _) {
    return Show.Map = (function(superClass) {
      extend(Map, superClass);

      function Map() {
        return Map.__super__.constructor.apply(this, arguments);
      }

      Map.prototype.template = "map/show/templates/show_map";

      return Map;

    })(Marionette.ItemView);
  });

}).call(this);
