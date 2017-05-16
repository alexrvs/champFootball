
$(document).ready(function () {
    $('select').material_select();
    $('ul.tabs').tabs();


    $('#tournament_status_list').on('change',function () {
        var status = $(this ).find(':selected').val();
        $('#tournament_type_id').val(status)
    })
});