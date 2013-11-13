$(document).ready(function(){
    $("[data-behaviour~='datepicker']").datepicker({
        format: 'd. M yyyy',
        language: 'nb'
    });
    $(".edit_animal").bind('ajax:success', function(xhr, data, status){
        $("#display-details").find("[data-behaviour~='datepicker']").datepicker({
            format: 'yyyy-mm-dd',
            language: 'nb'
        });
        //$("[data-behaviour~='datepicker']").datepicker();
    });

    $(".new_animal").bind('ajax:success', function(xhr, data, status){
        $("#display-details").find("[data-behaviour~='datepicker']").datepicker({
            format: 'yyyy-mm-dd',
            language: 'nb'
        });
    });

});
