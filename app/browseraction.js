

function addScripts(tabId) {
    chrome.tabs.executeScript(tabId, {file:'lib/jquery/jquery.min.js'});
    chrome.tabs.executeScript(tabId, {file:'lib/jquery-ui/ui/jquery-ui.js'});
    chrome.tabs.executeScript(tabId, {file:'lib/underscore/underscore-min.js'});
    chrome.tabs.executeScript(tabId, {file:'lib/backbone/backbone-min.js'});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.base.js"});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.jobticket.js"});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.tasks.js"});
    chrome.tabs.executeScript(tabId, {file:"app/models/collection.tasks.job.js"});
    chrome.tabs.executeScript(tabId, {file:"app/controller.js"});
    chrome.tabs.insertCSS(tabId, {file:"lib/jquery-ui/themes/smoothness/jquery-ui.min.css"});
    chrome.tabs.insertCSS(tabId, {file:"lib/jquery-ui/themes/smoothness/jquery.ui.theme.css"});
}


/*
 * Listen for a click of the icon.
 */
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



/*
 * Listen for updates to brower windows, and
 * check if we should start using autocomplete.
 */
chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {

    if (changeInfo.status != 'loading') return;

    _.mixin(_.str.exports());

    chrome.tabs.get(tabId, function(tab) {

        var matchURL = _.rtrim(localStorage['cnpURL'], '/') + '/validate';

        if (tab.url.indexOf(matchURL) > -1) {
            console.log("it's a C&P site");
            addScripts(tab.id);
        }
    });

});

