@AL.module 'AuthorsApp.List', (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    startAuthors: ->
      # console.log 'startAuthors()'
      # start with all (cat 0)
      App.request "authors:category", 0, (authors) =>
        @layout = @getLayoutView()
        # console.log @layout

        @layout.on "show", =>
          @showTitle authors
          @listCatAuthors authors, 0

          @listDimensions()
          @listCategories("genre")

        # hold off rendering this
        App.authorsRegion.show @layout

    showTitle: (authors) ->
      titleView = @getTitleView authors
      @layout.headerRegion.show titleView

    getTitleView: (authors) ->
      new List.Title
        collection: authors

    # TODO: refactor?
    togglePanel: ->
      # AL.vent.trigger("map:reset")
      # console.log 'toggle from List.Title'
      if $("#authors-region").offset().left == 0
        # authors is open
        $("#authors-region").animate { 'left': -($("#authors-region").width() - 15) }, 500
        App.vent.trigger("authors-panel:close")
        $(".toggle-icon").toggle()
      else if $("#authors-region").offset().left < 0
        # authors is closed
        $("#authors-region").animate { 'left': 0 }, 500
        App.vent.trigger("authors-panel:open")
        $(".toggle-icon").toggle()
        $(".toggle-authors").addClass("hidden")

    listDimensions: ->
      # console.log 'showDimensions()'
      dimensionsView = new List.Dimensions
      @layout.dimensionsRegion.show dimensionsView

    listCategories: (dim) ->
      App.request "category:entities", (categories) =>
        # console.log 'listCategories for: ', dim
        categoriesView = @getCategoriesView categories, dim
        # categoriesView.on 'childview:authors:filtered', (childView, model) ->
        #   console.log 'heard trigger', model
        # console.log categoriesView
        @layout.categoriesRegion.show categoriesView

    getCategoriesView: (categories, dim) ->
      new List.Categories
        collection: categories
        filter: (child, index, collection) ->
          child.get('dim') == dim

    listCatAuthors: (authors, category) ->
      authorsCatView = @getCatAuthorsView authors, category
      @layout.authorlistRegion.show authorsCatView

    getCatAuthorsView: (authors, category) ->
      new List.Authors
        collection: authors

    getLayoutView: ->
      new List.Layout
