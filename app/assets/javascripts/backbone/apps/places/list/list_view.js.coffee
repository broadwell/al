@AL.module "PlacesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "places/list/templates/list_layout"

    regions:
      titleRegion: "#title-region"
      navmapRegion: "#navmap-region"
      arealistRegion: "#arealist-region"

  class List.Title extends App.Views.ItemView
    template: "places/list/templates/_title"
    events:
      "click .toggle-places": "onToggle"
    onToggle:
      AL.PlacesApp.List.Controller.togglePanel

  class List.Navmap extends App.Views.ItemView
    template: "places/list/templates/_navmap"

  class List.Area extends App.Views.ItemView
    template: "places/list/templates/_area"
    tagName: "span"
    events: {
      "click a": "areaByRoute"
      "mouseenter a": "onAreaEnter"
      "mouseleave a": "onAreaLeave"
    }

    areaByRoute: ->
      window.activePlace = this.model
      area = this.model
      if area.get("area_type") == "borough"
        # indirectly yo showBorough() in controller
        Backbone.history.navigate("boroughs/"+area.get("id"), true)
      else
        # indirectly yo showBorough() in controller
        Backbone.history.navigate("hoods/"+area.get("id"), true)

    onAreaEnter: (e) ->
      id = this.getAreaIdFromEvent(e);
      # console.log 'enter area model #', id
      App.vent.trigger('area:highlight', id);

    onAreaLeave: (e) ->
      id = this.getAreaIdFromEvent(e);
      # console.log 'left area a'
      App.vent.trigger('area:unhighlight', id);

    getAreaIdFromEvent: (e) ->
      Number($(e.currentTarget).context.attributes.data_id.value);

  class List.Areas extends App.Views.CompositeView
    template: "places/list/templates/_areas"
    childView: List.Area
    emptyView: List.Empty
    childViewContainer: "arealist"

  # places not used yet
  # class List.Place extends App.Views.ItemView
  #   template: "places/list/templates/_place"
  #   tagName: "span"
  #
  # class List.Places extends App.Views.CompositeView
  #   template: "places/list/templates/_places"
  #   childView: List.Place
  #   emptyView: List.Empty
  #   childViewContainer: "arealist"

  class List.Empty extends App.Views.ItemView
    template: "places/list/templates/_empty"
    tagName: "p"
