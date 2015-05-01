$ = require 'jquery'
_ = require 'underscore'
require 'jquery-ui'
Backbone = require 'backbone'
JobTicketCollection = require 'models/collection.jobticket'
JobTaskCollection = require 'models/collection.tasks.job'


class CPView extends Backbone.View

  events:
    'focus #COST_JOB_NUM': 'setJobTicketList'

  el: $('#main')

  jobTicketCollection: null

  taskCollection: null

  jobTicketList: null

  taskList: null

  initialize: ->
    console.log 'init'
    super
    @jobTicketCollection = new JobTicketCollection
    return

  setJobTicketList: (e) ->
    @_setAutoComplete e.currentTarget, @jobTicketCollection, @setTaskList
    return

  setTaskList: (e, ui) ->
    tasks = new JobTaskCollection(null, jobNumber: ui.item.value)
    tasks.on 'reset', (->
      console.log tasks
      @_setAutoComplete '#COST_TASK', tasks
      return
    ), this
    return

  _setAutoComplete: (el, collection, onSelectCallback) ->
    $(el).autocomplete
      source: collection.getAutoCompleteList()
      select: onSelectCallback or null
    return

view = new CPView()
