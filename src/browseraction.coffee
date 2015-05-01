addScripts = (tabId) ->
  chrome.tabs.executeScript tabId, file: 'lib/jquery/jquery.min.js'
  chrome.tabs.executeScript tabId, file: 'lib/jquery-ui/ui/jquery-ui.js'
  chrome.tabs.executeScript tabId, file: 'lib/underscore/underscore-min.js'
  chrome.tabs.executeScript tabId, file: 'lib/backbone/backbone-min.js'
  chrome.tabs.executeScript tabId, file: 'app/models/collection.base.js'
  chrome.tabs.executeScript tabId, file: 'app/models/collection.jobticket.js'
  chrome.tabs.executeScript tabId, file: 'app/models/collection.tasks.js'
  chrome.tabs.executeScript tabId, file: 'app/models/collection.tasks.job.js'
  chrome.tabs.executeScript tabId, file: 'app/controller.js'
  chrome.tabs.insertCSS tabId, file: 'lib/jquery-ui/themes/smoothness/jquery-ui.min.css'
  chrome.tabs.insertCSS tabId, file: 'lib/jquery-ui/themes/smoothness/jquery.ui.theme.css'
  return


###
# Listen for a click of the icon.
###
chrome.browserAction.onClicked.addListener (tab) ->
  `var tab`
  url = localStorage.cnpURL
  if _.isEmpty(url) or _.isUndefined(url) or url == ''
    alert 'Please set a C&P URL in the options page first.'
    return
  tabOptions = url: url
  tab = chrome.tabs.create(tabOptions)
  return

###
# Listen for updates to brower windows, and
# check if we should start using autocomplete.
###

chrome.tabs.onUpdated.addListener (tabId, changeInfo, tab) ->
  if changeInfo.status != 'loading'
    return
  _.mixin _.str.exports()
  chrome.tabs.get tabId, (tab) ->
    matchURL = _.rtrim(localStorage['cnpURL'], '/') + '/validate'
    if tab.url.indexOf(matchURL) > -1
      console.log 'it\'s a C&P site'
      addScripts tab.id
    return
  return
