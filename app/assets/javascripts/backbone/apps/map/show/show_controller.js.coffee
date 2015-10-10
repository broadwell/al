@AL.module "MapApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =

    showMap: ->
      # console.log 'MapApp.Show.Controller.showMap()', authors
      @mapView = @getMapView()
      App.mapRegion.show @mapView

    getMapView: ->
      new Show.Map

    setFilter: (key, evaluator) ->
      # console.log 'setFilter() ' + key, evaluator
      @mapView.setFilter key, evaluator

    clearFilters: ->
      @mapView.clearFilters()

    zoomTo: (what, id) ->
      @mapView.zoomTo what, id

    # /**
    #  * Highlight a place.
    #  */
    onHighlightFeature: (what, id) ->
      @mapView.highlightFeature(what, id);

    # /**
    #  * Unhighlight a place.
    #  */
    onUnhighlightFeature: (what, id) ->
      @mapView.unhighlightFeature(what, id);

    # /**
    #  * Focus on a place.
    #  */
    onSelectFeature: (what, id) ->
      @mapView.selectFeature(what, id);
