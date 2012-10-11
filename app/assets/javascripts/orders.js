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

    $('#sumtable').fixheadertable({
            
    });

   
    $(".js-package").change(function(){
    	var dol = "$"
    	var lb = " lb"

     	var numOfPackages = parseFloat($(this).val());
      	var parentTr = $(this).parents("tr");
      	var parentTable = $(this).parents("table");
      	var weight = parseFloat($(parentTr).find(".js-weight").attr('data-weight'));
      	var price = parseFloat($(parentTr).find(".js-lb-price").attr('data-lb-price'));
      	$(parentTr).find(".js-price").html(dol + ((numOfPackages * weight * price).toFixed(2)));
      	$(parentTr).find(".js-lbs").html((numOfPackages * weight).toFixed(2) + lb);
        
        var table = document.getElementById('sumtable');
        var table_rows = table.rows;
        var height = parseInt(table_rows.length);
        var lb_total = 0;      
        var money_total = 0;
        var savings_total = 0;	
      	
        for (var i = 1, iLen = height - 1; i < iLen; i++) {
        	p_cell = table_rows[i].cells[5];
        	p_value = p_cell.textContent.replace(/[^0-9-.]/g, '');
        	lb_total += Number(p_value);
        	m_cell = table_rows[i].cells[6];
            m_value = m_cell.textContent.replace(/[^0-9-.]/g, '');
            money_total += Number(m_value);
            s_cell = table_rows[i].cells[7];
            s_value = s_cell.textContent.replace(/[^0-9-.]/g, '');
            savings_total += (parseFloat(s_value) / 100) * Number(m_value);
        }
       
		$(parentTable).find(".js-lb-total").html(lb_total.toFixed(2) + lb);
		$(parentTable).find(".js-price-total").html(dol + (money_total).toFixed(2));
		$(parentTable).find(".js-savings-total").html("-" + dol + (savings_total).toFixed(2));
    });

});
