#
# Execute the provided callback if the
# current url matches the host
#
module.exports = (trueCallback=null, falseCallback=null) ->

  chrome.storage.local.get 'cnp-url', (result) ->

    if result['cnp-url'].match(new RegExp(window.location.host))

        trueCallback(result['cnp-url']) if trueCallback

    else

        falseCallback(result['cnp-url']) if falseCallback
