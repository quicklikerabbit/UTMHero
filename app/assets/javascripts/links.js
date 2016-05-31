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

  $("#links_table thead input").on( 'keyup change', function () {
      table
          .column( $(this).parent().index()+':visible' )
          .search( this.value )
          .draw();
  } );

  // DataTable
  var table = $('#links_table').DataTable( {
        "scrollX": true,
        "orderCellsTop": true,
        "order": [[ 2, "desc" ]],
        "sDom": '<"top"fli>rt<"bottom"p><"clear">'
    });

  // Apply the filter
});
