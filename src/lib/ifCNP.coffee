#
# Execute the provided callback if the
# current url matches the host
#
module.exports = (callback = ->) ->

  chrome.storage.local.get 'cnpURL', (result) ->

    return unless result.cnpURL.match(new RegExp(window.location.host))

    callback()
