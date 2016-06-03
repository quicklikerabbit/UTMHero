$(function() {
  $("#get-started-button").click(function() {
    $('html, body').animate({
        scrollTop: $("#link-form").offset().top
    }, 1000);
  });
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
  // Setup - add a text input to each footer cell
  $('#links_table thead tr#filterrow th').each( function () {
      var title = $('#links_table thead th').eq( $(this).index() ).text();
      $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
  } );

// Apply the filter
  $("#links_table thead input").on( 'keyup change', function () {
      table
          .column( $(this).parent().index()+':visible' )
          .search( this.value )
          .draw();
  } );
  // DataTable
  var table = $('#links_table').removeAttr('width').DataTable( {
        orderCellsTop: true,
        order: [[ 2, "desc" ]],
        sDom: '<"top"fli>rt<"bottom"p><"clear">',
        autoWidth: false,
        columns: [
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" },
          { width: "150px" }
        ],
        fixedColumns : true
    });
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

  // When the user clicks the button, open the modal
  btn.onclick = function() {
      modal.style.display = "block";
  };

  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
      modal.style.display = "none";
  };

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
      if (event.target == modal) {
          modal.style.display = "none";
      }
  };
});
