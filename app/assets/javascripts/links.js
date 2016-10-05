$(function() {
  $( document ).ajaxComplete(function() {
    $('#create-link-overlay').removeClass('hidden').fadeTo(500, 0.9);
  });
  var anotherOne = $("#make-another");
  var createLinkOverlay = $('#create-link-overlay');
  anotherOne.on('click',function(){
    createLinkOverlay.fadeTo(500, 0.0, function(){
      createLinkOverlay.addClass('hidden');
    });
  });
  var close = $("#close-button");
  close.on('click', function(){
    createLinkOverlay.fadeTo(500, 0.0, function(){
      createLinkOverlay.addClass('hidden');
    });
  });
  var clip = new Clipboard("#copy-button");
});

$(function() {

// Apply the filter
  $("#links_table thead input").on( 'keyup change', function () {
      table
          .column( $(this).parent().index()+':visible' )
          .search( this.value )
          .draw();
  } );
  $('.showHideColumn').on( 'click', function () {
    var tableColumn = table.column($(this).attr('data-columnindex'));
    tableColumn.visible(!tableColumn.visible());
  });
  $('.showHideColumn').on( 'click', function () {
    $(this).toggleClass('selected');
  });
});

$(function() {
    // Get the modal
  var modal = document.getElementById('myModal');

  // Get the button that opens the modal
  var btn = document.getElementById("share-links-button");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
      if (event.target == modal) {
          modal.style.display = "none";
      }
  };
});
