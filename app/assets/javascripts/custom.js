window.onload = function(){

	// Toggles hide and show for table rows
	$(".toggle-row").on("click", function(){
		$(this).parent().siblings().toggle();
	});

	// Toggles hide and show for table columns
    $(".toggle-col").on("click", function(){
		var col = $(this).parent().children().index($(this));
		//nth child is apparently 1-indexed
    	var header = $(this).toggle();
    	var $column_items = $("td:nth-child("+(col+1)+")").toggle();

    	var $show_element = $("<a>"+$(this).text()+"</a>");
    	$show_element.on("click", function(){
    		$column_items.show();
    		header.show();
    		$(this).remove();
    	});
    	$("#show-col").append($show_element);
    });
}