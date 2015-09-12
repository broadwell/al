@AL.module 'PlacesApp.List', (List, App, Backbone, Marionette, $, _) ->
  
  List.Controller =

    listPlaces: ->
      App.request "place:entities", (places) =>
        # console.log places

        @layout = @getLayoutView()

        @layout.on "show", =>
          @showHeader places
          @showPlaces places

        App.placesRegion.show @layout      

    showHeader: (places) ->
      # headerView = @getHeaderView places
      # for now, a static map in _places.jst.eco
      # @layout.headerRegion.show headerView

    showPlaces: (places) ->
      placesView = @getPlacesView places
      #console.log 'placesView', placesView
      @layout.placesRegion.show placesView

    getPlacesView: (places) ->
      new List.Places
        collection: places
        # trying to filter this

    getHeaderView: (places) ->
      new List.Header
        collection: places

    getLayoutView: ->
      new List.Layout