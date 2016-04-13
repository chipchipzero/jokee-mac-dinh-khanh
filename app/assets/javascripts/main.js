$(function(){

    'use strict';
    var votes = Cookies.getJSON('jokee_votes');
    $(window).on('load', function() {
        showJoke();
    });

    $('.vote-button button').each(function() {
      $(this).click(function() {
        var temp = { id: $('#joke_id').val(), score: $(this).attr('vote-data') };
        votes.push(temp);
        Cookies.set('jokee_votes', JSON.stringify(votes));
        showJoke();
      });
    });

    function showJoke() {
      if(votes === undefined) {
        votes = [];
      }
      
      $.ajax({
        async: false,
        method: 'post',
        url: '/api/v1/api1',
        data: {votes: votes},
        dataType: 'json',
        beforeSend: function() {
          $('.vote-button button').each(function() {
            $(this).attr('disabled', true);
          });
          $('.vote-button').hide();
        },
        success: function(res) {
          if(res.status == 1) {
            $('#joke_id').val(res.data.id);
            $('.joke-content').removeClass('text-center').html(nl2br(res.data.content));
            $('.vote-button button').each(function() {
              $(this).removeAttr('disabled');
            });
            $('.vote-button').show();
          } else if(res.status == 2) {
            $('.joke-content').addClass('text-center').text(res.message);
            Cookies.remove('jokee_votes');
          } else {
            alert("Error.");
          }
        },
        error: function() {
          alert("Error.");
        }
      });
    }

    function nl2br (str, is_xhtml) {   
      var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br />' : '<br>';
      return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1'+ breakTag +'$2');
    }
});
