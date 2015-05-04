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

    #@injectContentScript()

    @jobTicketCollection = new JobTicketCollection()

    @jobTicketCollection.fetch()

    @JobTaskCollection = new JobTaskCollection()

    @JobTaskCollection.on 'reset', =>
      @setJobTasks()

    @on 'message', (e, data)=>
      console.log data

  setAutocompleteFields: ->

    jobField = @getJobField()

    taskField = @getTaskField()

    try
      disabled = jobField.autocomplete('option', 'disabled') is true
    catch
      disabled = true

    if disabled

      jobField.autocomplete
      	minLength: 0,
        select: (e, ui) =>

          data =
            J_NUM: ui.item.value

          @JobTaskCollection.fetch({reset: true}, data)

    try
      disabled = taskField.autocomplete('option', 'disabled') is true
    catch e
      disabled = true

    if disabled

      taskField.autocomplete
        minLength: 0

  setJobTicketList: (e) ->

    @removeNativeHandlers()

    @setAutocompleteFields()

    @getJobField().autocomplete 'option',
                                'source',
                                @jobTicketCollection.getAutoCompleteList()

    @getJobField().autocomplete 'search', ''

  setJobTasks: () ->

    @getTaskField().autocomplete 'option',
                                 'source',
                                 @JobTaskCollection.getAutoCompleteList()

    @getTaskField().autocomplete 'search', ''

  getJobField: () ->

    if @jobField.length is 0
      @jobField = $('#COST_JOB_NUM')

    return @jobField

  getTaskField: () ->

    if @taskField.length is 0
      @taskField = $('#COST_TASK')

    return @taskField

  injectContentScript: ->

    s = document.createElement "script"
    s.src = chrome.extension.getURL "dist/globalaccess.js"
    document.getElementsByTagName("head")[0].appendChild(s)

  removeNativeHandlers: ->

    $jobField = @getJobField()

    $jobField.removeAttr('onkeydown onchange onfocus')


ifCNP ->

  view = new CPView()

  document.getElementsByTagName('body')[0].addEventListener 'message', (e) ->

    view.trigger 'message', e.detail
