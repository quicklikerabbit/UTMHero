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
});
$(function() {
  $( '#links_table').DataTable( {
      "scrollX": true,
      "order": [[ 2, "desc" ]],
      "sDom": '<"top"fli>rt<"bottom"p><"clear">',
      initComplete: function () {
        this.api().columns(0).every( function () {
          var column = this;
          var select = $('<select><option value=""></option></select>')
            .appendTo( $(column.footer()).empty() )
              .on( 'change', function () {
                var val = $.fn.dataTable.util.escapeRegex(
                  $(this).val()
                );
                column
                  .search( val ? '^'+val+'$' : '', true, false )
                  .draw();
              });
              column.data().unique().sort().each(function(d, j) {
                select.append( '<option value="'+d+'">'+d+'</option>');
              });
        });
      }
  });
});
