@AL.module "MapApp", (MapApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  App.vent.on "author:show", (author) ->
    # console.log "map heard author:show -->", author.get('author_id')
    # placerefs for all passages by an author
    API.filterByAuthor author

  App.vent.on "category:authors:show", (id) ->
    console.log 'map heard category:authors:show --> ', id
    # placerefs for all passages by set of authors
    API.filterByAuthorCategory id

  App.vent.on "category:works:show", (works) ->
    console.log 'map heard category:works:show '
    # placerefs for all passages in works of a category
    API.filterByWorkCategory works

  App.vent.on "place:focus", (area) ->
    # console.log 'map_app place:focus', area
    API.focusPlace(area)

  App.vent.on "map:swap", (id) ->
    MapApp.Show.Controller.swapBase id

  API =
    # swapBase: (id) ->
    #   MapApp.Show.Controller.swapBase()

    showMap: ->
      MapApp.Show.Controller.showMap()

    filterByAuthor: (author) ->
      id = author.get("author_id")
      dyear = author.get("death_year")
      # console.log  'MapApp.API.filterByAuthor()', id
      MapApp.Show.Controller.setFilter 'author', (placeref) ->
        # console.log placeref
        placeref.get("author_id") == id

    filterByAuthors: (author_ids, id) ->
      # console.log author.get("author_id")
      MapApp.Show.Controller.setFilter 'authors', (placeref) ->
        author_ids.indexOf(placeref.get("author_id")) > -1

    filterByAuthorCategory: (id) ->
      # build collection of authors having 'id'
      # id = cat.get("id")
      author_ids = []
      App.request "authors:category", id, (authors) =>
        _.each authors.models, (a) =>
          author_ids.push a.get("author_id")
        @filterByAuthors author_ids, id
        console.log 'filterByAuthorCategory '+id+ ': ', author_ids

    filterByWork: (work) ->
      id = work.get("work_id")
      MapApp.Show.Controller.setFilter 'work', (placeref) ->
        placeref.get("work_id") == id

    filterByWorks: (work_ids) ->
      # console.log author.get("author_id")
      MapApp.Show.Controller.setFilter 'works', (placeref) ->
        work_ids.indexOf(placeref.get("work_id")) > -1

    filterByWorkCategory: (works) ->
      # id = cat.get("id")
      work_ids = []
      _.each works.models, (w) =>
        work_ids.push w.get("work_id")
      @filterByWorks work_ids
      console.log 'filterByWorkCategory ' # +id+ ': ', author_ids

    focusPlace: (area) ->
      #
      # area model in list has been clicked, need to
      # 1) zoom to its voronoi extents
      # 2) get resulting viewport extents\
      # 3) filter placerefs for viewport w/o filtering map
      #
      window.area = area
      window.hbounds = turf.polygon(wellknown(area.get("geom_poly_wkt")).coordinates)
      # console.log 'hbounds from this:', wellknown(area.get("geom_poly_wkt")).coordinates

      MapApp.Show.Controller.zoomTo 'area', area

      # run this to filter on hood voronoi bounds...
      # or comment and let Show.Controller.zoomTo initiate filtering on viewport\
      MapApp.Show.Controller.filterByArea "area", hbounds

    resetMap: ->
      $("#place_passages_region").fadeOut("slow")
      # clear all filters
      MapApp.Show.Controller.clearFilters()
      # map.addLayer(l_osmLayer)


  # TODO: part of refactoring for areas - single area:show

  App.vent.on "map:reset", ->
    API.resetMap()

  App.vent.on "work:show", (work) ->
    API.filterByWork work

  App.vent.on "placeref:click", (prid) ->
    # console.log 'map_app heard highlight id#', iid
    MapApp.Show.Controller.onClickPlaceref prid

  App.vent.on "placeref:highlight", (prid) ->
    # console.log 'map_app heard highlight id#', id
    MapApp.Show.Controller.onHighlightFeature prid

  App.vent.on "placeref:unhighlight", (prid) ->
    # console.log 'map_app heard unhighlight, id#', id
    MapApp.Show.Controller.onUnhighlightFeature prid

  App.vent.on "area:highlight", (id) ->
    # console.log 'map_app heard highlight id#', id
    MapApp.Show.Controller.onHighlightFeature 'area', id

  App.vent.on "area:unhighlight", (id) ->
    # console.log 'map_app heard unhighlight, id#', id
    MapApp.Show.Controller.onUnhighlightFeature 'area', id

  App.vent.on "area:unhighlightAll", ->
    MapApp.Show.Controller.unhighlightAll()


  MapApp.on "start", ->
    controller: API
    API.showMap()
