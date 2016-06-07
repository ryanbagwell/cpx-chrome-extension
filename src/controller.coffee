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

  jobField: null

  taskField: null

  initialize: (@options={}) ->
    super @options

    @injectContentScript()

    @jobTicketCollection = new JobTicketCollection()

    @jobTicketCollection.fetch()

    @jobTaskCollection = new JobTaskCollection()

    @jobTaskCollection.on 'reset', =>
      @setJobTasks()
      @getLoadingIcon().hide()

    setTimeout(=>
      @removeNativeHandlers()
    , 2000)

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

    @getLoadingIcon()

    jobField.autocomplete
    	minLength: 0,
      appendTo: jobField.parent()
      select: (e, ui) =>
        data =
          J_NUM: ui.item.value
        @getLoadingIcon().show()
        @jobTaskCollection.fetch({reset: true}, data)

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
                                 @jobTaskCollection.getAutoCompleteList()

    @getTaskField().autocomplete 'search', @getTaskField().val()

  getLoadingIcon: ->

    if @loadingIcon?
      return @loadingIcon

    src = chrome.extension.getURL("dist/img/loading.svg");

    @getTaskField().parent().css({
      position: 'relative'
    });

    $el = $("<img src='#{src}' />").css({
      width: '23px'
      height: '23px'
      position: 'absolute'
      top: '3px'
      right: '-20px'
    }).hide()

    @getTaskField().parent().append($el)

    @loadingIcon = $el

    return @loadingIcon


  getJobField: () ->

    $('#COST_JOB_NUM')

  getTaskField: () ->

    $('#COST_TASK')

  injectContentScript: ->

    s = document.createElement "script"
    s.src = chrome.extension.getURL "dist/globalaccess.js"
    document.getElementsByTagName("head")[0].appendChild(s)

  removeNativeHandlers: ->

    chrome.storage.local.get {'native-ui-disabled': true}, (result) ->

      if result['native-ui-disabled'] is false
        return

      messageEvent = document.createEvent 'CustomEvent'
      messageEvent.initCustomEvent 'disableNativeHandlers', true, true, true
      bodyElem = document.getElementsByTagName('body')[0]
      bodyElem.dispatchEvent(messageEvent)

ifCNP ->

  view = new CPView()

  document.getElementsByTagName('body')[0].addEventListener 'message', (e) ->

    view.trigger 'message', e.detail
