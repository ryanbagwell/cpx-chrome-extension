$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

class BaseCollection extends Backbone.Collection

  name: null

  dataType: 'html'

  initialize: (models, @options={}) ->
    super @options

    @on 'reset', @stash

  fetch: (opts) ->

    defaults =
      dataType: 'html'

    opts = _.extend {}, defaults, opts

    super(opts)

  getAutoCompleteList: ->
    null

  populate: (options) ->

    models = localStorage.getItem(@name)

    if models
      console.log 'using local storage'
      @add models
      @trigger 'reset'
    else
      @query options
    return

  stash: ->
    console.log 'stash'
    localStorage.setItem @name, @models
    return

module.exports = BaseCollection
