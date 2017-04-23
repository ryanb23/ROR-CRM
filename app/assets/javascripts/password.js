$( document ).on( "focus", "#user_password", function() {
	var strength = {
    0: "Worst",
    1: "Bad",
    2: "Weak",
    3: "Good",
    4: "Strong"
	}

	var password = document.getElementById('user_password');
	var meter = document.getElementById('password-strength-meter');
	var text = document.getElementById('password-strength-text');

	password.addEventListener('input', function()
	{
	  var val = password.value;
	  var result = zxcvbn(val);
	  meter.value = result.score;

	  if(val !== "") {
	    text.innerHTML = "Strength: " + "<strong>" + strength[result.score] + "</strong>" ;
	  }
	  else {
	    text.innerHTML = "";
	  }
	});
});
$(document).on("turbolinks:load", function() {
	$('input[type=password]').keyup(function() {
    var pswd = $(this).val();
    if ( pswd.length < 8 ) {
    	$('#length').removeClass('valid').addClass('invalid');
		} else {
		  $('#length').removeClass('invalid').addClass('valid');
		}
		if ( pswd.match(/[a-z]/) ) {
    	$('#lower').removeClass('invalid').addClass('valid');
		} else {
    	$('#lower').removeClass('valid').addClass('invalid');
		}
		if ( pswd.match(/[A-Z]/) ) {
    	$('#upper').removeClass('invalid').addClass('valid');
		} else {
    	$('#upper').removeClass('valid').addClass('invalid');
		}
		if ( pswd.match(/[\d]/) ) {
    	$('#number').removeClass('invalid').addClass('valid');
		} else {
    	$('#number').removeClass('valid').addClass('invalid');
		}
		if ( pswd.match(/[\W]/) ) {
    	$('#special_char').removeClass('invalid').addClass('valid');
		} else {
    	$('#special_char').removeClass('valid').addClass('invalid');
		}
	}).focus(function() {
	    $('#pswd_info').show();
	}).blur(function() {
	    $('#pswd_info').hide();
	});
});