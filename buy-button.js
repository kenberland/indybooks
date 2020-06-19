var indyBooks = {
  loadModal: function(input) {
    console.log("loadReceipt: " + input);
    const url = chrome.runtime.getURL("templates/modal.html");
    fetch(url)
      .then(function(response) {
	response.text().then((data) => indyBooks.showModal(data));
      });
  },
  showModal: function(html){
    console.log(html);
    const url = chrome.runtime.getURL("templates/stores.json");
    debugger;
    var body = document.getElementsByTagName("BODY")[0];
    var new_nodes = jQuery.parseXML(html)
	.firstElementChild
    var insertedNode = body.insertBefore(new_nodes, body.firstChild);
    fetch(url)
      .then(function(response) {
        response.text().then((data) => indyBooks.testStoresInLocalStorage(data));
      });
  },
  testStoresInLocalStorage: function(json){
    localStorage.setItem('indybooks:stores', json);
  },
  populateModal: function(foo){
    console.log("populate modal " + foo);
  },
  dismissModal: function(){
    console.log("FOO");
    $("#indyModal").remove();
  }
};

window.onload = function() {
  console.log("2 onload for buy-button.js");

  $(document).keyup(function(e) {
    if (e.key === "Escape") {
      indyBooks.dismissModal();
    }
  });

  var buyNewInner = document.getElementById('buyNow_feature_div');
  var foo = "hello world";
  var new_html = '<a id="indyRef" href="foo.com"><div id="indy"><div id="indyText">Buy at Ms. Dalloway\'s</div></div></a>';
  var new_nodes = jQuery.parseXML(new_html)
      .firstElementChild
  var insertedNode = buyNewInner
      .insertAdjacentElement("afterend", new_nodes);
  $( "#indyRef" ).on( "click", function( event ) {
    event.preventDefault();
    indyBooks.loadModal($( this ).text());
  });
};

