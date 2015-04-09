$(function() {
   $("#registerTabAction").on('click', function() {
       $(this).find("h2").addClass("active");
       $("#loginTabAction").find("h2").removeClass("active");
       $("#registerTab").show();
       $("#loginTab").hide();
   })
});

$(function() {
    $("#loginTabAction").on('click', function() {
        $(this).find("h2").addClass("active");
        $("#registerTabAction").find("h2").removeClass("active");
        $("#loginTab").show();
        $("#registerTab").hide();
    })
});