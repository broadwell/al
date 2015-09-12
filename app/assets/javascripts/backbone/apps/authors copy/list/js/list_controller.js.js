// Generated by CoffeeScript 1.9.3
(function() {
  this.AL.module('AuthorsApp.List', function(List, App, Backbone, Marionette, $, _) {
    return List.Controller = {
      listAuthors: function() {
        return App.request("author:entities", (function(_this) {
          return function(authors) {
            _this.layout = _this.getLayoutView();
            _this.layout.on("show", function() {
              _this.showHeader(authors);
              return _this.showAuthors(authors);
            });
            return App.authorsRegion.show(_this.layout);
          };
        })(this));
      },
      showHeader: function(authors) {
        var headerView;
        headerView = this.getHeaderView(authors);
        return this.layout.headerRegion.show(headerView);
      },
      showAuthors: function(authors) {
        var authorsView;
        authorsView = this.getAuthorsView(authors);
        return this.layout.authorsRegion.show(authorsView);
      },
      getAuthorsView: function(authors) {
        return new List.Authors({
          collection: authors
        });
      },
      getHeaderView: function(authors) {
        return new List.Header({
          collection: authors
        });
      },
      getLayoutView: function() {
        return new List.Layout;
      }
    };
  });

}).call(this);