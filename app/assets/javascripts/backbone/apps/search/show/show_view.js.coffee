@AL.module 'SearchApp.Show', (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "search/show/templates/show_layout"

    regions:
      headerRegion: "#searchbox"
      resultsRegion: "#results_region_search"

    events: {
      "click .clear-search": "clearSearch"
      "click button": "queryPassages"
    }
    clearSearch: ->
      console.log 'clearSearch'
      # List.Controller.startWorks()
      $("#results_region_search").html('<img src="assets/images/drop-of-thames_320w.png" />
        <br/>A Drop of Thames Water <br/><em>Punch magazine (1850), via Wikimedia Commons</em>')
      $("#q_input").val('')

    queryPassages: (e) =>
      # console.log $(e.currentTarget)
      q = $("#q_input").val()
      Backbone.history.navigate("search/" + q, true)
      # List.Controller.searchPassages($("#q_input").val())


  # TODO: refactor? same functionality elsewhere
  class Show.SearchResult extends App.Views.ItemView
    template: "search/show/templates/_passage"
    tagName: "p"
    events: {
      "click span.passage-link": "showOnePassage"
    }

    showOnePassage: (e) ->
      # console.log 'popup passage', $(e.currentTarget).context.attributes.val.value
      id = $(e.currentTarget).context.attributes.val.value
      # TODO: load passage in right panel
      AL.MapApp.Show.Controller.showOnePassage(id)

  #
  class Show.SearchResults extends App.Views.CompositeView
    template: "search/show/templates/_passages"
    childView: Show.SearchResult
    childViewContainer: "div"
