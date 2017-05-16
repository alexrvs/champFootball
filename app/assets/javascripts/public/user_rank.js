$(document).ready(function(){

    $('#sortable').sortable({

        stop: function(event, ui) {
            var result = [];
            ui.item.find('.newRank').data('newrank',parseInt(ui.item.index()+1));

            $('.newRank').each(function(){

                var result_vote = {
                    user_id:'',
                    rank:''
                };
                var user_id = $(this).find('.user_id_vote_rank').val();
                var new_rank = $(this).data('newrank');
                result_vote.user_id = user_id;
                result_vote.rank = new_rank;
                result.push(result_vote);

            });

            var res = JSON.stringify(result);
            $('#vote_users').val(res);
        }
    });

    $( "#sortable" ).disableSelection();

});