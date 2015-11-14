@AL.module "WorksApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "works/show/templates/show_layout"
    # template: "works/show/templates/show_work"
    regions:
      titleRegion: "#title_region"
      navRegion: "#nav_region"
      workContentRegion: "#work_content_region_w"

  class Show.Title extends App.Views.ItemView
    template: "works/show/templates/_title"
    events:
      "click .crumb-works": "goHome"

    goHome: ->
      # console.log 'supposed to go home'
      Backbone.history.navigate("works", true)
      App.vent.trigger("map:reset")

  class Show.Nav extends App.Views.ItemView
    template: "works/show/templates/_nav"
  #
  # class Show.Pills extends App.Views.ItemView
  #   template: "works/show/templates/_nav"
  #   events: {
  #     "click li": "loadContent"
  #   }
  #   loadContent: (e) =>
  #     $(".nav-pills li").removeClass("active")
  #     $(e.currentTarget).addClass("active")
  #     workid = App.request("work:model").get("work_id")
  #     @pill = $(e.currentTarget).context.attributes.value.value
  #     if @pill == 'works'
  #       @route = "#works/"+workid
  #       # console.log 'loadContent, works:', @route
  #       # CHECK: is this Navigate...true right?
  #       Backbone.history.navigate(@route, true)
  #       # Show.Controller.listWorks authid
  #     else if @pill == 'biography'
  #       @route = "#authors/"+authid
  #       # console.log 'loadContent, bio:', @route
  #       Backbone.history.navigate(@route, true)
  #       # Show.Controller.showAuthor authid

  class Show.Passage extends App.Views.ItemView
    template: "works/show/templates/_passage"
    tagName: "p"
    events: {
      # "click": "highlightPlacerefs"
      "mouseenter span.place": "onPlacerefEnter"
      "mouseleave span.place": "onPlacerefLeave"
    }
    # highlightPlacerefs: ->
    #   console.log 'Show.Passage.highlightPlacerefs()'

    onPlacerefEnter: (e) ->
      id = this.getPlacerefIdFromEvent(e);
      console.log 'highlight placeref #', id
      App.vent.trigger('placeref:highlight', id);
      # App.vent.trigger('placeref:hover', e)

    onPlacerefLeave: (e) ->
      id = this.getPlacerefIdFromEvent(e);
      # console.log 'left placeref span'
      App.vent.trigger('placeref:unhighlight', id);

    getPlacerefIdFromEvent: (e) ->
      Number($(e.currentTarget).context.attributes.data_id.value);

  # passages are shown by clicking a work
  class Show.Passages extends App.Views.CompositeView
    template: "works/show/templates/_passages"
    childView: Show.Passage
    childViewContainer: "div"

  class Show.Work extends App.Views.ItemView
    template: "works/show/templates/_work"
    tagName: "li"
    events: {"click": "loadPassages"}
    loadPassages: ->
      work = this.model
      # show tab CHECK: leave visible?
      $("#passages_pill").removeClass("hidden")
      $(".nav-pills li").removeClass("active")
      $("#passages_pill").addClass("active")
      # use route for model attributes and navigation
      Backbone.history.navigate("workpassages/w/"+work.get('work_id'))

  class Show.Works extends App.Views.CompositeView
    template: "works/show/templates/_works"
    className: 'works'
    childView: Show.Work
    childViewContainer: "ul"