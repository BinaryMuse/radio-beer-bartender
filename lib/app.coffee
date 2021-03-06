{RfidScanView, RfidScansView, RfidScan, RfidScansCollection} = require('lib/rfid_scans')
{BeerView, BeersView, Beer, BeersCollection} = require('lib/beers')
{Router} = require('lib/router')

class App
  constructor: (dbName, appName, rootEl, navEl) ->
    Backbone.couch_connector.config.collection_field_identifier = 'type'
    Backbone.couch_connector.config.db_name = dbName
    Backbone.couch_connector.config.ddoc_name = appName
    Backbone.couch_connector.config.global_changes = false
    @rootEl = rootEl
    @navEl = navEl

  run: =>
    @setupScans()
    @setupBeers()
    @setupBlanks()
    @router = new Router(@rootEl)
    Backbone.history.start()

  setupScans: =>
    collection = new RfidScansCollection()
    view = new RfidScansView({ collection: collection })
    @rootEl.find('#region-scans').append(view.$el)
    collection.fetch()

  setupBeers: =>
    collection = new BeersCollection()
    view = new BeersView({ collection: collection })
    @rootEl.find('#region-beers').append(view.$el)
    collection.fetch()

  setupBlanks: =>
    @rootEl.find('#region-taps').html("<h1>TODO: Taps</h1>")
    @rootEl.find('#region-readers').html("<h1>TODO: Readers</h1>")

exports.App = App
