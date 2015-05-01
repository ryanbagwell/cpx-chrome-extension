$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

class BaseCollection extends Backbone.Collection

  name: null

  dataType: 'html'

  initialize: (models, @options={}) ->
    super @options

    @on 'reset', @stash

    @query()

  sync: (method, model, options) ->
    `var options`
    options = $.extend({
      dataType: 'html'
      parse: @parse
    }, options)
    console.log options
    Backbone.sync.call this, method, model, options

  getAutoCompleteList: ->
    null

  query: ->
    console.log 'query'
    @fetch()
    return

  populate: (options) ->
    console.log 'populate'
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
