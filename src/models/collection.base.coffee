BaseCollection = Backbone.Collection.extend(
  name: null
  dataType: 'html'
  initialize: (models, options) ->
    console.log options
    if options
      @options = options
    @on 'reset', @stash
    @query()
    this
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
)
