chrome.browserAction.onClicked.addListener(function(tab) {
	var tabOptions = {
		url: 'http://cnpx.hzdesign.com:8080'
	};
	var tab = chrome.tabs.create(tabOptions);
});