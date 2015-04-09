//
// Login Modal
//

// Open Session Modal
$(function() {
   $(document).on('click', '#login', function() {
       var modal = $("#sessionModal");
       modal.modal({
           onShow: function() {
               $(this).find("#registerTabAction h2").removeClass('active');
               $(this).find("#loginTabAction h2").addClass('active');
               $(this).find("#loginTab").show();
               $(this).find("#registerTab").hide();
           }
       });
       modal.modal('show');
   });
});

$(function() {
    $(document).on('click', '#register', function() {
        var modal = $("#sessionModal");
        modal.modal({
            onShow: function() {
                $(this).find("#registerTabAction h2").addClass('active');
                $(this).find("#loginTabAction h2").removeClass('active');
                $(this).find("#registerTab").show();
                $(this).find("#loginTab").hide();
            }
        });
        modal.modal('show');
    });
});


// Tab in Session Modals

