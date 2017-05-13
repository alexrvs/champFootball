// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
//= require_tree ./public
//= require jquery-ui
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/position
//= require jquery-ui/widgets/sortable

$(document).ready(function () {

    $(".dropdown-button").dropdown();

    $("#card-alert .close").click(function() {
        $(this).closest("#card-alert").fadeOut("slow")
    });

    $('#sortable').sortable({

        stop: function(event, ui) {

            var result = [];
            ui.item.find('.newRank').data('newrank',parseInt(ui.item.index()+1));

            $('.newRank').each(function(){
                var result_vote = {
                    user_id:'',
                    rank:''
                };

//                var result_vote = [];

                var user_id = $(this).find('.user_id_vote_rank').val();
                var new_rank = $(this).data('newrank');
                console.log(user_id,new_rank);
/*

                result_vote['user_id'] = user_id;
                result_vote['rank'] = new_rank;
*/
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
