@AL.module "ContentApp", (ContentApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = true

  # ContentApp is global router/API for the AL app
  #
  class ContentApp.Router extends Marionette.AppRouter
    appRoutes:
      "": "startContent"
      "authors": "startAuthors"
      "places": "startPlaces"
      "works": "startWorks"
      "author/:author_id": "showAuthor"
      # TODO: getting authors per cat should be a route
      # "authors/:category_id": "showAuthors"
      "works/:author_id": "authorWorks"
      "workpassages/:src/:work_id": "workPassages"
      "search/:q": "searchPassages"


  API =
    startContent: ->
      # console.log ' in AL.ContentApp.API.startContent()'
      Backbone.history.navigate("works", true)
      AL.ContentApp.Show.Controller.startContent()

    startAuthors: ->
      # console.log 'API.startAuthors fired'
      # Backbone.history.navigate("authors")
      AL.AuthorsApp.List.Controller.startAuthors()

    startPlaces: ->
      # console.log 'API.startPlaces fired'
      AL.PlacesApp.List.Controller.startPlaces()

    startWorks: ->
      # console.log 'API.startWorks fired'
      # Backbone.history.navigate("works")
      AL.WorksApp.List.Controller.startWorks()

    showAuthor: (author_id)->
      # console.log 'ContentApp.Router, showAuthor()'
      App.vent.trigger "map:reset"
      # get author model from id, forward to showAuthor()
      App.request "author:entity", author_id, (author) =>
        AL.AuthorsApp.Show.Controller.showAuthor(author)
        # returns current author
        App.reqres.setHandler "author:model", ->
          return author

    authorWorks: (author_id) ->
      App.request "author:entity", author_id, (author) =>
        AL.AuthorsApp.Show.Controller.listWorks author

    workPassages: (src,work_id) ->
      # console.log 'workPassages: '+src, work_id
      # get work model from id, forward to sub-app controller
      App.request "work:entity", work_id, (work) =>
        if src == 'a'
          AL.AuthorsApp.Show.Controller.listWorkPassages(work)
        else if src == 'w'
          AL.WorksApp.Show.Controller.showWork(work)
        # returns current work
        App.reqres.setHandler "work:model", ->
          return work

    searchPassages: (q) ->
      # console.log 'ContentApp router API searchPassages',q
      AL.WorksApp.List.Controller.searchPassages q


  ContentApp.on "start", ->
    new ContentApp.Router
      controller: API
    API.startContent()


  # App.addInitializer ->
  #   new ContentApp.Router
  #     controller: API
    # API.startAuthors()