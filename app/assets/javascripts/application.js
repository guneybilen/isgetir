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
   // $('div.index').hide();
   // $('div.index').fadeIn('slow');

    $('a.show').click(function() {
        $link = $(this);
        $link.text('Showing...')
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
    var p = $("div#user_bar a");
    p.slideUp('slow', function() {
        p.css("color", "red");  // p.css({}) yerine this.css({}) yaparsan calismiyor.
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