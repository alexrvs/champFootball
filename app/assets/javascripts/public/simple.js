$(document).ready(function () {

    $(".dropdown-button").dropdown();

    $("#card-alert .close").click(function() {
        $(this).closest("#card-alert").fadeOut("slow")
    });
});