chrome.browserAction.onClicked.addListener (tab) ->
  tabOptions = url: 'http://cnpx.hzdesign.com:8080'
  tab = chrome.tabs.create(tabOptions)
  return
