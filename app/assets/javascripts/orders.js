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
    	var dol = "$"
    	var lb = " lb"

     	var numOfPackages = parseFloat($(this).val());
      	var parentTr = $(this).parents("tr");
      	var parentTable = $(this).parents("table");
      	var weight = parseFloat($(parentTr).find(".js-weight").attr('data-weight'));
      	var price = parseFloat($(parentTr).find(".js-lb-price").attr('data-lb-price'));
      	$(parentTr).find(".js-price").html(((numOfPackages * weight * price).toFixed(2)));
      	$(parentTr).find(".js-lbs").html((numOfPackages * weight).toFixed(2));
        
        var table = document.getElementById('sumtable');
        var table_rows = table.rows;
        var height = parseInt(table_rows.length);
        var lb_total = 0;      
        var money_total = 0;
        var cell;	
      	for (var i = 1, iLen = height - 1; i < iLen; i++) {
            cell = table_rows[i].cells[5];
            lb_total += Number(cell.textContent);
        }
        for (var j = 1, jLen = height - 1; j < jLen; j++) {
        	cell = table_rows[j].cells[6];
        	money_total += Number(cell.textContent);
        }
        
       
		$(parentTable).find(".js-lb-total").html(lb_total.toFixed(2) + lb);
		$(parentTable).find(".js-price-total").html(dol + money_total.toFixed(2));
    });

});
