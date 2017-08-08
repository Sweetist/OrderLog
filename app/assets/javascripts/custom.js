var ready = function(){
    $(".toggle-row").on("click", toggle_row);
    
    //Temporarily hidden
    $('.dropdown-menu a').on("click", self_toggle_column);

    $("#toggle-form").on("click", function(){
        $(".display-form-group").toggle(500);
    });

    $(".toggle-hidden-field").on("click", function(){
        $(this).parent().children(".hidden-field").toggle(250);
    });

    clock = $("#clock");

    load_dropdown();
    update_time();
    time_to_local();
};

// Toggles hide and show for table rows
var toggle_row = function toggle_row(){
    var siblings = $(this).parent().siblings().toggleClass("hidden-row");
    update_display(siblings);
};

// Toggles hide and show for table columns
var self_toggle_column = function self_toggle_column(){
    hide_column($(this));
};

var hide_column = function hide_column(element){
    var $header = $("#"+element.attr('data-value'));
    var colInd = $header.parent().children().index($header);
    //nth child is apparently 1-indexed
    var $column_items = $("td:nth-child("+(colInd+1)+")");
    $column_items.toggleClass("hidden-col")
    $header.toggle();
    update_display($column_items);
}

var update_display = function update_display(elements){
    elements.each(function(){
        $this = $(this)
        if ($this.hasClass("hidden-row") || $this.hasClass("hidden-col")){
            $this.hide();
        } 
        else {
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
    $(".date").each(function(){
        $(this).text(new Date($(this).text()).toDateString());
    });
}

var load_dropdown = function load_dropdown(){   
    $( '.dropdown-menu a' ).on( 'click', function( event ) {
     var val = $(this).attr( 'data-value' );
     $(this).children("input").each(
        function(){
            $(this).prop('checked', !$(this).prop('checked') );      
        });     
        return false;
    });

    $(".dropdown-menu a :not(input:checkbox:checked)").each(function(){
        hide_column($(this).parent());
    });
}


$(document).on('turbolinks:load', ready);