$ = require 'jquery'
_ = require 'underscore'
require 'jquery-ui'
Backbone = require 'backbone'
JobTicketCollection = require 'models/collection.jobticket'
JobTaskCollection = require 'models/collection.tasks.job'
ifCNP = require 'lib/ifCNP'


class CPView extends Backbone.View

  events:
    'focus #COST_JOB_NUM': 'setJobTicketList'
    'focus #COST_TASK': 'setJobTasks'

  el: $('#main')

  jobTicketCollection: null

  taskCollection: null

  jobTicketList: null

  taskList: null

  jobField: $('#COST_JOB_NUM')

  taskField: $('#COST_TASK')

  initialize: (@options={}) ->
    super @options

    @injectContentScript()

    @jobTicketCollection = new JobTicketCollection()

    @jobTicketCollection.fetch()

    @JobTaskCollection = new JobTaskCollection()

    @on 'message', (data) =>

      @removeAutocompleteFields()

      @setAutocompleteFields()


  removeAutocompleteFields: ->

    try
      @getJobField().autocomplete 'destroy'
      @getTaskField().autocomplete 'destroy'
    catch


  setAutocompleteFields: ->

    jobField = @getJobField()

    taskField = @getTaskField()

    jobField.autocomplete
    	minLength: 0,
      appendTo: jobField.parent()
      select: (e, ui) =>

        data =
          J_NUM: ui.item.value

        @JobTaskCollection.fetch({reset: true}, data)

    taskField.autocomplete
      minLength: 0
      appendTo: taskField.parent()

  setJobTicketList: (e) ->

    @removeNativeHandlers()

    @setAutocompleteFields()

    @getJobField().autocomplete 'option',
                                'source',
                                @jobTicketCollection.getAutoCompleteList()

    @getJobField().autocomplete 'search', @getJobField().val()

  setJobTasks: () ->

    @getTaskField().autocomplete 'option',
                                 'source',
                                 @JobTaskCollection.getAutoCompleteList()

    @getTaskField().autocomplete 'search', @getTaskField().val()

  getJobField: () ->

    $('#COST_JOB_NUM')

  getTaskField: () ->

    $('#COST_TASK')


  injectContentScript: ->

    s = document.createElement "script"
    s.src = chrome.extension.getURL "dist/globalaccess.js"
    document.getElementsByTagName("head")[0].appendChild(s)

  removeNativeHandlers: ->

    $jobField = @getJobField()

    $jobField.removeAttr('onkeydown onchange onfocus title')


ifCNP ->

  view = new CPView()

  document.getElementsByTagName('body')[0].addEventListener 'message', (e) ->

    view.trigger 'message', e.detail
