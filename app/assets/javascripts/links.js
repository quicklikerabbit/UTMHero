$(function() {
  new Clipboard('.btn');
  var clip = new Clipboard("#copy-button");
});

$(function() {
  $('.modal-trigger').leanModal();
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
