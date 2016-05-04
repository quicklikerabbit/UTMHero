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
  $('#links_table').DataTable({
    responsive: true
  });
});
