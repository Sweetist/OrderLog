var ready = function(){
    $(".toggle-row").on("click", toggle_row);
    $(".hide-col").on("click", hide_column);
    
    $("#toggle-form").on("click", function(){
        $(".display-form-group").toggle(500);
    });

    $(".hidden-col").trigger("click");
    $(".toggle-hidden-field").on("click", function(){
        $(this).parent().children(".hidden-field").toggle(250);
    });
};

// Toggles hide and show for table rows
var toggle_row = function toggle_row(){
    var siblings = $(this).parent().siblings().toggleClass("hidden-row");
    update_display(siblings);
};

// Toggles hide and show for table columns
var hide_column = function hide_column(){
    var col = $(this).parent().children().index($(this));
    //nth child is apparently 1-indexed
    var header = $(this).toggle();
    var $column_items = $("td:nth-child("+(col+1)+")").addClass("hidden-col");
    update_display($column_items);
    var $show_element = $("<a>"+$(this).text()+"</a>");
    
    $show_element.on("click", function(){
        $column_items.removeClass("hidden-col");
        header.show();
        $(this).remove();
        update_display($column_items);
    });
    $("#show-col").append($show_element);
};

var update_display = function update_display(elements){
    elements.each(function(){
        $this = $(this)
        if ($this.hasClass("hidden-row") || $this.hasClass("hidden-col")){
            $this.hide();
        }
        else{
            $this.show();
        }
    });
};

//$(document).ready(ready);
$(document).on('turbolinks:load', ready);