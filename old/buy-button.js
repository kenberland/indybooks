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
    var address = document.getElementById('contextualIngressPtLabel_deliveryShortLine').children[1].innerText;
    var zipCode = address.substring(address.length - 6);
    console.log(zipCode);

    // Body needs to be an entry into a vuejs template that we can render zipCode into
    var body = document.getElementsByTagName("BODY")[0];
    var newNodes = jQuery.parseXML(html)
	.firstElementChild
    var insertedNode = body.insertBefore(newNodes, body.firstChild);

    // Right now, the easiest thing I could do is put the stores.json into a localStorage key to test.
    const url = chrome.runtime.getURL("templates/stores.json");
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

