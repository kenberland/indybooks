// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

'use strict';

chrome.runtime.onInstalled.addListener(function() {
  chrome.storage.sync.set({store: null}, function() {
    console.log("No store is set.");
  });
  chrome.declarativeContent.onPageChanged.removeRules(undefined, function() {
    chrome.declarativeContent.onPageChanged.addRules([{
      conditions: [new chrome.declarativeContent.PageStateMatcher({
	pageUrl: {hostSuffix: 'amazon.com'},
      })
		  ],
      actions: [new chrome.declarativeContent.ShowPageAction()]
    }]);
  });
  chrome.runtime.onMessage.addListener(
    function(url) {
      console.log("downloading " + url);
      chrome.downloads.download({
	url: url,
	filename: "foo.json",
	saveAs: false
      },function(downloadId) {
	console.log("downloaded " + downloadId);
      }
			       );
    });
});


//chrome.tabs.query({active: true, currentWindow: true}, function(tabs){  chrome.tabs.sendMessage(tabs[0].id, {action: "open_dialog_box"}, function(response) {});});
