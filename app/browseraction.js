function addScripts(tabId) {
    chrome.tabs.executeScript(tabId, {file:'lib/jquery/jquery.min.js'});
    chrome.tabs.executeScript(tabId, {file:'lib/jquery-ui/ui/jquery-ui-1.8.18.custom.min.js'});
    chrome.tabs.executeScript(tabId, {file:'lib/underscore/underscore-min.js'});
    chrome.tabs.executeScript(tabId, {file:'lib/backbone/backbone-min.js'});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.base.js"});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.jobticket.js"});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.tasks.js"});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.tasks.job.js"});
    chrome.tabs.executeScript(tabId, {file:"app/controller.js"});

    chrome.tabs.insertCSS(tabId, {file:"lib/jquery-ui/css/ui-lightness/jquery-ui-1.8.18.custom.css"});

}

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


chrome.tabs.onUpdated.addListener(function(tabId) {
    chrome.tabs.get(tabId, function(tab) {

        var matchURL = localStorage['cnpURL'];

        if (matchURL)


        if (tab.url.indexOf(localStorage['cnpURL']+'validate') > -1) {
            console.log("it's a C&P site");
            addScripts(tab.id);
        }
    });
});

