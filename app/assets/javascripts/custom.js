var ready = function(){
    $(".toggle-row").on("click", toggle_row);
    
    //Temporarily hidden
    //$(".hide-col").on("click", hide_column);
    //$(".hidden-col").trigger("click");
    $(".hidden-col").each(hide_column);


    $("#toggle-form").on("click", function(){
        $(".display-form-group").toggle(500);
    });


    $(".toggle-hidden-field").on("click", function(){
        $(this).parent().children(".hidden-field").toggle(250);
    });

    clock = $("#clock");
    
    update_time();
    time_to_local();
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

var update_time = function update_time(){
        var now = new Date();
        var clockText = (now.getHours()%12)+":"+(now.getMinutes()>=10?now.getMinutes():"0"+now.getMinutes())+":"+(now.getSeconds()>=10?now.getSeconds():"0"+now.getSeconds())+(now.getHours()<=12?" A.M.":" P.M.");
        clock.html(clockText);
        setTimeout(update_time, 1000);
};

var time_to_local = function time_to_local(){
    $(".time").each(function(){
        $(this).text(new Date($(this).text()).toTimeString());
    });
}

//$(document).ready(ready);
$(document).on('turbolinks:load', ready);
