jQuery(function() {
  var $form = $("#signupForm");
  $form.form({
    displayName: {
      identifier: 'user[display_name]',
      rules: [
        {
          type: 'empty',
          prompt: 'Please choose a Display Name'
        }
      ]
    },
    email: {
      identifier: 'user[email]',
      rules: [
        {
          type: 'empty',
          prompt: 'Please enter a valid Email Address'
        },
        {
          type: 'email',
          prompt: 'Please enter a valid Email Address'
        }
      ]
    },
    password: {
      identifier: 'user[password]',
      rules: [
        {
          type: 'empty',
          prompt: 'Please enter a password'
        },
        {
          type: 'length[6]',
          prompt: 'Your Password needs to be at least 6 characters long'
        }
      ]
    }
  }, {
    inline: true,
    on: 'blur'
  });
});





// Email Checker
//
//isEmailAvailable = function(email, callback) {
//  $.get('/api/v1/users/exists', {email: email}, function(data) {
//    // Check if call was successful && if the email is available
//    var result = !!(data.success && !data.exists);
//
//    callback(result);
//  });
//};