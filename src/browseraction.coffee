ifUrlSet = require 'lib/ifUrlSet'

###
# Listen for a click of the icon.
###
chrome.browserAction.onClicked.addListener (tab) ->

  ifUrlSet (url) ->
    tab = chrome.tabs.create(url: url)
  , ->
    goThere = confirm 'Please set a C&P URL in the options page first.\n\nGo there now?'

    if goThere
      chrome.runtime.openOptionsPage()
