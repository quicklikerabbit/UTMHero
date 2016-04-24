$(function() {
  var submitButton = $("#lndpg-submit-button");
  addButton.on('click',function(){
    $('.contact-row').empty();
    $('.addButton').addClass('active');
    $('.showAll').removeClass('active');
    $('.hidden').toggleClass('hidden table');
  });
});
