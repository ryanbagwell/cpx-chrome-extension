#
# Execute the provided callback if the
# cnp url has been set
#
module.exports = (trueCallback=null, falseCallback=null) ->

  chrome.storage.local.get {'cnp-url': ''}, (result) ->

    if result['cnp-url']

        trueCallback(result['cnp-url']) if trueCallback

    else

        falseCallback(result['cnp-url']) if falseCallback
