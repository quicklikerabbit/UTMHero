$(function() {
  var submitNew = $("#submit-button");
  submitNew.on('click', function(){
    var data = {
      full_name: $("#full_name").val(),
      email: $("#email").val(),
      phone_number: $("#phone_number").val()
    };
    $.post('/contacts', data, function(data){
      $('.table').append($('<tr class="contact-row">' + '<td>' + element.full_name + '</td>' + '<td>' + element.email + '</td>' + '<td>' + element.phone_number + '</td> </tr>'));
    });
  });
});
