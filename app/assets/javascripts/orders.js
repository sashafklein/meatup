$(document).ready(function(){
	$(".savings").hottie({
	  colorArray : [ 
	    "#fec864",
	    "#339933"
	  ]
	});
   
$(".js-package").change(function(){
	var dol = "$"
	var lb = " lb"

	// Calculate row totals
 	var numOfPackages = parseFloat($(this).val());
  	var parentTr = $(this).parents("tr");
  	var parentTable = $(this).parents("table");
  	var weight = parseFloat($(parentTr).find(".js-weight").attr('data-weight'));
  	var price = parseFloat($(parentTr).find(".js-lb-price").attr('data-lb-price'));
  	$(parentTr).find(".js-price").html(dol + ((numOfPackages * weight * price).toFixed(2)));
  	$(parentTr).find(".js-lbs").html((numOfPackages * weight).toFixed(2) + lb);
    
    // Prep for column calcs by declaring variables
    var table = document.getElementById('sumtable');
    var table_rows = table.rows;
    var height = parseInt(table_rows.length);
    var lb_total = 0;      
    var money_total = 0;
    var savings_total = 0;	
  	
  	// Column Total Calculations (row by row)
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
       
    // Value assignment
		$(parentTable).find(".js-lb-total").html(lb_total.toFixed(2) + lb);
		$(parentTable).find(".js-price-total").html(dol + (money_total).toFixed(2));
		$(parentTable).find(".js-savings-total").html("[" + dol + (savings_total).toFixed(2) + "]");
    });

});

function UpdateTableHeaders() {
   $(".persist-area").each(function() {
   console.log("anything");
       var el             = $(this),
           offset         = el.offset(),
           scrollTop      = $(window).scrollTop(),
           floatingHeader = $(".floatingHeader", this)
       
       if ((scrollTop > offset.top) && (scrollTop < offset.top + el.height())) {
           floatingHeader.css({
            "visibility": "visible"
           });
       } else {
           floatingHeader.css({
            "visibility": "hidden"
           });      
       };
   });
}

// DOM Ready      
$(function() {

   var clonedHeaderRow;

   $(".persist-area").each(function() {
     clonedHeaderRow = $(".persist-header", this);
     clonedHeaderRow
       .before(clonedHeaderRow.clone())
       .css("width", clonedHeaderRow.width())
       .addClass("floatingHeader");
   });
   
   $(window)
    .scroll(UpdateTableHeaders)
    .trigger("scroll");
   
});
