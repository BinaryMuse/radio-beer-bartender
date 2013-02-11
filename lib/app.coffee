{RfidScanView, RfidScansView, RfidScan, RfidScansCollection} = require('lib/rfid_scans')

class App
  constructor: (dbName, appName, rootEl, navEl) ->
    Backbone.couch_connector.config.db_name = dbName
    Backbone.couch_connector.config.ddoc_name = appName
    Backbone.couch_connector.config.global_changes = false
    @rootEl = rootEl
    @navEl = navEl

  run: =>
    @setupScans()
    @setupTabs()

    @rootEl.find('#taps').html("<h1>TODO: Taps</h1>")
    @rootEl.find('#beers').html("<h1>TODO: Beers</h1>")
    @rootEl.find('#readers').html("<h1>TODO: Readers</h1>")

  setupTabs: =>
    @navEl.find('a').click (e) =>
      target = $(e.currentTarget)

      @rootEl.find('>div').hide()
      target.closest('ul').find('li').removeClass('active')

      target.closest('li').addClass('active')
      @rootEl.find(target.attr('href')).show()

      e.preventDefault()

  setupScans: =>
    collection = new RfidScansCollection()
    view = new RfidScansView({ collection: collection })
    @rootEl.find('#scans').append(view.$el)
    collection.fetch()

exports.App = App
