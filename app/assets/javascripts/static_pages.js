$(document).ready(function(){
	
	$(".alert").click(function(event){
	   event.preventDefault();
	   $(this).hide("slow");
	});


	$('.row .stuff').on('click', function(e) {
	    e.preventDefault();
	    var $this = $(this);
	    var $collapse = $this.closest('.collapse-group').find('.collapse');
	    $collapse.collapse('toggle');
	});

});