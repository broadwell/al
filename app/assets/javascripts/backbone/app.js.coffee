@AL = do (Backbone, Marionette) ->
  
  App = new (Marionette.Application)
  
  App.on 'initialize:before', ->

    # AuthorsRegion = Marionette.Region.extend(el: '#authors-region')
    # PlacesRegion = Marionette.Region.extend(el: '#places-region')

  App.addInitializer ->
    App.addRegions
      headerRegion: '#header-region'
      mapRegion: '#map-region'
      authorsRegion: 
        selector: '#authors-region'
        #regionClass: AuthorsRegion
      placesRegion: 
        selector: '#places-region'
        #regionClass: PlacesRegion
        
    App.module('HeaderApp').start()
    App.module('AuthorsApp').start()
    App.module('PlacesApp').start()
    App.module('MapApp').start()
    
  App.on 'initialize:after', ->
    if Backbone.history
      return Backbone.history.start()

    return
  
  App