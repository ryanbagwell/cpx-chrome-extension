$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
require 'backbone-fetch-cache'

class BaseCollection extends Backbone.Collection

  name: null

  dataType: 'html'

  initialize: (models, @options={}) ->
    super @options

  fetch: (opts) ->

    defaults =
      dataType: 'html'
      cache: true
      expires: 3600
      prefill: true
      prefillExpires: 3600

    opts = _.extend {}, defaults, opts

    super(opts)

  getAutoCompleteList: ->
    null

module.exports = BaseCollection
