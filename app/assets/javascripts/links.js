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
  var table = $('#links_table');
  // $('#links_table').removeAttr('width').DataTable( {
  //       orderCellsTop: true,
  //       order: [[ 2, "desc" ]],
  //       sDom: '<"top"fli>rt<"bottom"p><"clear">',
  //       autoWidth: false,
  //       columns: [
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" },
  //         { width: "150px" }
  //       ],
  //       fixedColumns : true
  //   });
  // $('.showHideColumn').on( 'click', function () {
  //   var tableColumn = table.column($(this).attr('data-columnindex'));
  //   tableColumn.visible(!tableColumn.visible());
  // });
  // $('.showHideColumn').on( 'click', function () {
  //   $(this).toggleClass('selected');
  // });
});

$(function() {
  $('.modal-trigger').leanModal({
    dismissible: true, // Modal can be dismissed by clicking outside of the modal
    opacity: 0.5, // Opacity of modal background
    in_duration: 300, // Transition in duration
    out_duration: 200, // Transition out duration
    starting_top: '4%', // Starting top style attribute
    ending_top: '10%', // Ending top style attribute
    ready: function() {}, // Callback for Modal open
    complete: function() {} // Callback for Modal close
  }
);

});
