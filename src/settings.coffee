$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

class Settings extends Backbone.View

  settingsInputs: {
    'cnp-url': ''
    'native-ui-disabled': true
    'background-updates-enabled': true
  }

  events:
    'submit': 'save'

  initialize: (@options) ->
    super @options

    @on 'saved', => @alertSuccess()

    chrome.storage.local.get @settingsInputs, (settings) =>

      for key, val of settings

        $el = @$el.find("[name='#{key}']").first()

        if $el.attr('type') == 'checkbox'
          $el.get(0).checked = val
        else
          $el.val val

  save: (e) ->
    e.preventDefault()

    for setting, defaultValue of @settingsInputs

      $el = @$el.find("[name='#{setting}']").first()

      if $el.attr('type') == 'checkbox'
        val = $el.get(0).checked
      else
        val = $el.val()

      chrome.storage.local.set {"#{setting}": val}

    @trigger('saved')

  alertSuccess: ->

    $('.alert-success').text('Settings Saved!').removeClass('fade-out').addClass('fade-in')

    _.delay (=>
        $('.alert-success').addClass('fade-out').removeClass('fade-in')
    ), 5000


s = new Settings(el: $('form'))
