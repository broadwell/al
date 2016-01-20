@AL.module "AuthorsApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "authors/list/templates/list_layout"

    regions:
      # headerRegion: "#title_region"
      # dimensionsRegion: "#dimensions_region"
      categoriesRegion: "#categories_region"
      authorlistRegion: "#authorlist_region"

    events: {
      "click .clear": "removeFilter"
      'click input': 'aggAuthors'
    }

    initialize: ->
      @checked = []
      console.log '@checked', @checked

    # targeting renderPlaces(params, key, clear=true)
    # or removePlaces(key)
    aggAuthors: (e) ->
      # console.clear()
      console.log 'checked = ', @checked
      selected = parseInt($(e.currentTarget).context.value)
      key = 'auth_'+selected
      if @checked.indexOf(selected) < 0
        @checked.push(selected)
        console.log 'added', selected + ', checked[] now', @checked
        console.log 'need to renderPlaces(selected,key,clear=false)', key
      else # selected in checked[] already
        console.log 'need to removePlaces(key) ', key

      # authArray = @$(':checked').map(->
      # authArray = $(':checked').map(->
      #   parseInt $(this).val()
      # ).get()
      # console.log 'selected, authArray: ' + selected, authArray
      # if authArray.indexOf(selected) >= 0
      #   key = 'auth_'+selected
      #   console.log 'need to removePlaces() ', key
      # else
      #   console.log 'need to renderPlaces()'
      # TODO:
      # is (parseInt $(this).val()) in authArray or not?
      # if id has been added, call renderPlaces, if removed, call removePlace

      # for map
      # App.vent.trigger "authors:show", authArray
      # e.g. App.vent.trigger "authors:remove", 'author_'+<<author_id>>

    removeFilter: ->
      # console.log 'remove filter'
      $("#selected_cat_authors").html('')
      App.request "authors:category", 0, (authors) =>
        List.Controller.listCatAuthors(authors)
        App.vent.trigger("map:reset")

  class List.Title extends App.Views.ItemView
    template: "authors/list/templates/_title"
    events:
      "click .toggle-authors": "onToggle"
    onToggle:
      AL.AuthorsApp.List.Controller.togglePanel

  class List.Author extends App.Views.ItemView
    template: "authors/list/templates/_author"
    tagName: "span"
    events: {
      'click a': 'authByRoute'
      # 'click input': 'aggAuthors'
    }

    authByRoute: ->
      # $("#spin_authors").removeClass('hidden')
      $activeAuthor = this.model
      author = this.model
      @route = "authors/" + author.get('author_id')
      # runs AuthorsApp.Show.Controller.showAuthor()
      Backbone.history.navigate(@route, true)

  class List.Authors extends App.Views.CompositeView
    template: "authors/list/templates/_authors"
    childView: List.Author
    emptyView: List.Empty
    childViewContainer: "div"


  class List.Empty extends App.Views.ItemView
    template: "authors/list/templates/_empty"
    tagName: "p"
