#
# Execute the provided callback if the
# current url matches the host
#
$ = require 'jquery'

module.exports = (trueCallback=null, falseCallback=null) ->

  chrome.storage.local.get {'cnp-url': ''}, (result) ->

    if result['cnp-url'].match(new RegExp(window.location.host)) and window.location.pathname.match(/validate/)

        trueCallback(result['cnp-url']) if trueCallback

    else

        falseCallback(result['cnp-url']) if falseCallback
