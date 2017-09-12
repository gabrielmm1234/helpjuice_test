function build_articles_table(response) {
  $("#table-body").empty();
  response.forEach(function(article) {
    $("#table-body").append(
      '<tr>' +
        '<td>' + article.name + '</td>' +
        '<td>' + article.search_times + '</td>' +
      '</tr>'
    );
  });
}

function captureInput() {
  var typingTimer;                //timer identifier
  var doneTypingInterval = 2500;  //time in ms (3.5 seconds)

  //on keyup, start the countdown
  $('#article_input').keyup(function(){
      $("#spinner_gif").show();

      if($('#article_input').val() == '') {
        $("#spinner_gif").hide();
        $("#table-body").empty();
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

function clearStats() {
  $('#clear_stats').click(function(){
    $.ajax({
      method: 'DELETE',
      url: 'articles/destroy'
    });
  });
}

$(document).ready(function () {
  $("#spinner_gif").hide();
  captureInput();
  clearStats();
});
