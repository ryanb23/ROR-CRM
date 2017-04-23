$(document).on("turbolinks:load", function() {
	var polygraphic_payment_delay_data =	$("#polygraphic_payment_delay").clone()
	var ecg_payment_delay_data =	$("#ecg_payment_delay").clone();
	var ecg_technical_provider_price_data = $("#ecg_technical_provider_price").clone();
	var ecg_technical_provider_delay_data = $("#ecg_technical_provider_delay").clone();
	var polygraphic_technical_provider_price_data = $("#polygraphic_technical_provider_price").clone();
	var polygraphic_technical_provider_delay_data = $("#polygraphic_technical_provider_delay").clone();

	$(".setting_payment_type").each(function() {
		var type = $(this).attr("data-payment-type")
		var value = $(this).val();
		var flag = false;

		if(value == "by patient" && type == "ecg"){
    	flag = true;
    	$("#"+ type +"_payment_delay").html(ecg_payment_delay_data.html()).hide().fadeIn(1000)
		}
		else if(value == "by patient" && type == "polygraphic"){
			flag = true;
    	$("#"+ type +"_payment_delay").html(polygraphic_payment_delay_data.html()).hide().fadeIn(1000)
		}
		if(flag == false){
    	$("#"+ type +"_payment_delay").html('').fadeOut();
  	}
	})
	$(".workflow_type").each(function() {
  	var type = $(this).attr("data-type")
		var value = $(this).val();
		var flag = false
		
		if(value == "workflow 2" && type == "ecg"){
	    flag = true;
	    $("#"+ type +"_technical_provider_price").html(ecg_technical_provider_price_data.html()).hide().fadeIn(1000)
	    $("#"+ type +"_technical_provider_delay").html(ecg_technical_provider_delay_data.html()).hide().fadeIn(1000)
		}
		else if(value == "workflow 2" && type == "polygraphic"){
			flag = true;
			$("#"+ type +"_technical_provider_price").html(polygraphic_technical_provider_price_data.html()).hide().fadeIn(1000)
	    $("#"+ type +"_technical_provider_delay").html(polygraphic_technical_provider_delay_data.html()).hide().fadeIn(1000)
		}

		if(flag == false){
			$("#"+ type +"_technical_provider_price").html('').fadeOut();
	  	$("#"+ type +"_technical_provider_delay").html('').fadeOut();
		}	
	});

	$(".setting_payment_type").on("change",function(){
		var type = $(this).attr("data-payment-type")
		var value = $(this).val()
		var flag = false;
		
		if(value == "by patient" && type == "ecg"){
    	flag = true;
    	$("#"+ type +"_payment_delay").html(ecg_payment_delay_data.html()).hide().fadeIn(1000)
		}
		else if(value == "by patient" && type == "polygraphic"){
			flag = true;
    	$("#"+ type +"_payment_delay").html(polygraphic_payment_delay_data.html()).hide().fadeIn(1000)
		}
		if(flag == false){
    	$("#"+ type +"_payment_delay").html('').fadeOut();
  	}
	})

	$(".workflow_type").on("change",function(){
		var type = $(this).attr("data-type")
		var value = $(this).val();
		var flag = false
		if(value == "workflow 2" && type == "ecg"){
	    flag = true;
	    $("#"+ type +"_technical_provider_price").html(ecg_technical_provider_price_data.html()).hide().fadeIn(1000)
	    $("#"+ type +"_technical_provider_delay").html(ecg_technical_provider_delay_data.html()).hide().fadeIn(1000)
		}
		else if(value == "workflow 2" && type == "polygraphic"){
			flag = true;
			$("#"+ type +"_technical_provider_price").html(polygraphic_technical_provider_price_data.html()).hide().fadeIn(1000)
	    $("#"+ type +"_technical_provider_delay").html(polygraphic_technical_provider_delay_data.html()).hide().fadeIn(1000)
		}

		if(flag == false){
			$("#"+ type +"_technical_provider_price").html('').fadeOut();
    	$("#"+ type +"_technical_provider_delay").html('').fadeOut();
  	}
	})

});