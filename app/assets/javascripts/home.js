function build_articles_table(response) {
$("#table-body").empty();
$("#table-body").append(
  '<tr>' +
    '<td>Alvin</td>' +
    '<td>Eclair</td>' +
    '<td>$0.87</td>' +
  '</tr>'
);
}

function captureInput() {
  var typingTimer;                //timer identifier
  var doneTypingInterval = 2500;  //time in ms (3.5 seconds)

  //on keyup, start the countdown
  $('#article_input').keyup(function(){
      $("#spinner_gif").show();

      if($('#article_input').val() == '') {
        $("#spinner_gif").hide();
      }
      clearTimeout(typingTimer);
      if ($('#article_input').val()) {
          typingTimer = setTimeout(doneTyping, doneTypingInterval);
      }
  });

  //user has "finished typing,"
  function doneTyping () {
    var input = $('#article_input').val()
    $.ajax({
      method: 'GET',
      url: '/search_article/' + input,
      dataType: 'json',
      success: function(response) {
        $("#spinner_gif").hide();
        build_articles_table(response);
        console.log(response);
      }
    });
  }
}

$(document).ready(function () {
  $("#spinner_gif").hide();
  captureInput();
});
