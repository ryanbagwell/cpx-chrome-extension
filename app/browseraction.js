chrome.browserAction.onClicked.addListener(function(tab) {

    var url = localStorage.cnpURL;

    if (_.isEmpty(url) || _.isUndefined(url) || url == '') {
        alert('Please set a C&P URL in the options page first.')
        return;
    }

    var tabOptions = {
		url: url
	};

	var tab = chrome.tabs.create(tabOptions);
});