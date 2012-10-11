$(document).ready(function(){
	$(".savings").hottie({
	  colorArray : [ 
	    "#fec864",
	    "#339933"
	  ]
	});

   $(".stripe").click(function(e){ 	
   		   e.preventDefault();

		    // load the html file using ajax
		    $.get("pay.html.erb", function(resp){
		        var data = $('<div></div>').append(resp);
    		});
	});

   
    $(".js-package").change(function(){
      var numOfPackages = parseFloat($(this).val());
      var parentTr = $(this).parents("tr");
      var weight = parseFloat($(parentTr).find(".js-weight").attr('data-weight'));
      var price = parseFloat($(parentTr).find(".js-lb-price").attr('data-lb-price'));
      $(parentTr).find(".js-price").html(numOfPackages * weight * price);
      $(parentTr).find(".js-lbs").html(numOfPackages * weight);
    });
     

});
