#
# This file will be run in the browser window context
# and will have access to the C&P js. You can interact with the
# C&P Prototypejs object and Ajax methods here to change
# the behavior of the standard C&P interface.
#
# For example, you can remove the event handler that causes
# a list of job number to open when hitting the tab key
#
#

if Ajax?

  Ajax.Responders.register

    onComplete: (request, XMLHttpRequest, result)=>

      if request.url.match(/time_card/) or request.url.match(/home_edit_time/)

        message =
          action: 'navigate'
          url: request.url

        messageEvent = document.createEvent 'CustomEvent'
        messageEvent.initCustomEvent 'message', true, true, message
        bodyElem = document.getElementsByTagName('body')[0]
        bodyElem.dispatchEvent(messageEvent)

document.getElementsByTagName('body')[0].addEventListener 'disableNativeHandlers', (e) ->

  window.popup_jobs = ->
    console.log('jobs popup disabled')

  window.popup_tasks = ->
    console.log('tasks popup disabled')
