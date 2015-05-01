$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

class Settings extends Backbone.View

  events:
    'submit': 'save'

  initialize: (@options) ->
    super @options

    @on 'saved', => @alertSuccess()

    if localStorage.getItem('cnpURL')
      @$el.find('#cnp-url').val localStorage.getItem('cnpURL')

  save: (e) ->
    e.preventDefault()

    localStorage.setItem 'cnpURL', @$el.find('#cnp-url').val()

    @trigger('saved')


  alertSuccess: ->

    $('.alert-success').text('Settings Saved!').removeClass('fade-out').addClass('fade-in')

    _.delay (=>
        $('.alert-success').addClass('fade-out').removeClass('fade-in')
    ), 5000


s = new Settings(el: $('form'))
