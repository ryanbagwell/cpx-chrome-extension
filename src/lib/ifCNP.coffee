#
# Execute the provided callback if the
# current url matches the host
#
module.exports = (trueCallback=null, falseCallback=null) ->

  chrome.storage.local.get 'cnpURL', (result) ->

    if result.cnpURL.match(new RegExp(window.location.host))

        trueCallback(result.cnpURL) if trueCallback

    else

        falseCallback(result.cnpURL) if falseCallback