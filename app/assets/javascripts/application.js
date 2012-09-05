// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .



$(document).ready(function() {

//document.getElementById("#search_form_text_field").focus(); //calismiyor

    // $('div.index').hide();
    // $('div.index').fadeIn('slow');


    $('#search_form')[0].reset();

    var request = $.ajax({
        url: "jobs/search_autocomplete",
        type: "GET"
    });

//     request.success(function(){
//        alert('guney');
//    });

//    $('#search_form_text_field').live('input', function() {
//            var params = {};
//            params[this.name] = this.value;
//            $.get('jobs/search', params);
//           $('search_form_text_field').focusin();
//        });


    $('#new_comment_link').click ( function() {
        $('#new_comment_link').hide();
    });

// for dynamically added content you must use live method for click event
// Internet den ogrendim.
    $('#new_comment_cancel').live('click', function() {
        $('#new_comment').slideUp();
        $('#new_comment_link').show();
        $("html").scrollTop(0);
    });

    $("#forgot_my_password").click ( function () {
        $('#password_reset').slideDown();
    });

    $("#cancel_password_reset").click ( function () {
        $('#password_reset').slideUp();
    });


    locale = $("div.set_locale").text();

    $('a.show').click(function() {
        $link = $(this);

        if (locale == "tr"){
            $link.text("Gösteriyor...") }

        if (locale == "en"){
            $link.text("Showing...") }

    });

    $("div.references").hide();

    $('a.link_references').click(function()
    {
        $("div.references").animate(
            {
                opacity: 'toggle',
                height: 'toggle'

            },

            'slow');
    });


//var m = $("hr").outerWidth;
//var n = $("h1.listing_jobs").outerWidth;
    var p = $("div.menu a");
    p.slideUp('slow', function() {
        p.css("color", "#0066cc");  // p.css({}) yerine this.css({}) yaparsan calismiyor.
    })
        .slideDown('slow');

//p.hide();
//p.css({position: 'relative'}).fadeIn('slow').animate({left: m - n}, 'slow');
//p.animate({left: m - n}, 'slow');

    /*$("h1.listing_jobs")
     .css({position: 'relative'})
     .fadeTo('fast', 0.5)
     .animate({left: m - n}, 'slow')
     .fadeTo('slow', 1.0);*/




});



