#
# Execute the provided callback if the
# cnp url has been set
#
module.exports = (trueCallback=null, falseCallback=null) ->

  chrome.storage.local.get 'cnpURL', (result) ->

    if result.cnpURL

        trueCallback(result.cnpURL) if trueCallback

    else

        falseCallback(result.cnpURL) if falseCallback
