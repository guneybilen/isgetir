// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


function url_parameters(str) {
    var ary = [];
    ary = str.split("&");
//                                    alert(ary[0]);
    var pattern = /^_=\d+/;
//                                     alert(ary[0].match(pattern));
    if (ary[0].match(pattern) != null) {
        delete ary[0];
//                                     alert(ary);
    }
    ary = ary.toString();
    ary = ary.replace(/^,/, "");
    ary = ary.replace(/,\s*/gi, "&");
    alert(ary);
    document.location.hash = "ajaxing?" + str;
}

$(document).ready(function() {

//document.getElementById("#search_form_text_field").focus(); //calismiyor

    // $('div.index').hide();
    // $('div.index').fadeIn('slow');

//  DIKKAT! $('#search_form')[0].reset(); breaks almost everything on this file.
//  $('#search_form')[0].reset();

//    document.getElementById("#jobs_search_input").onkeydown= function() {
//       $.get($("#jobs_search").attr("action"), $("#jobs_search").serialize(), null, "script");
//       return false;
//    };
//    $("#jobs_search input").keyup(function() {
//
//    });

/*
      $(".jobs th a, .pagination a").live("click", function(e) {

         var v=this.href;

        $.ajax
        ({
            url: this.href,
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result){
               // alert(result);
//                var obj = $.parseJSON(result);
//                $.each(obj, function(idx, val) {
                    $('body').load(v, result);
//                });

//                 $("body").replaceWith(result);
            }
        });
          e.preventDefault()


      });*/


/*     $('.for_select_box_listing a').live ('click', function() {
        var params ={};
         var url = getUrlParams(this.href);

        params = $('#select_box').children(":selected").attr("value");
        $.getScript('/ajaxing/?' + params + '&' + url);
        return false;
//      location.reload();
    });*/

    /*    var pr = $("input.password_reset");

    pr.live ('click',  function() {
        pr.val("Merci");
        pr.attr("disabled", true);
    });*/


/*    var anc=$(a);
    anc.css({'color': '#D95E16', 'backgroundColor' : 'white'});

     $('div.menu a').hover(function ()
     {
        $(this).css(
        {
            'color' : '#FFFFFF',
            'background-color' : '#FF813C',
            'textDecoration' : 'underline'
        });
     });*/


    $("#select_box").val(0);

//    $("#search_form_submit").removeAttr("disabled");

//    var loc = window.location;
//    alert(loc);


    $(".sort_by a, .for_all_listing a").live("click", function(e) {
        var str = {};
        str = getUrlParams(this.href);
        var i = $('#select_box').children(":selected").attr("value");
        if(i>0) {
            $('#remove_category_anchor a').hide();
            $.getScript('/ajaxing/?' + i + '&' + str);
            return false;
        }

        $.getScript("jobs/search/?" + str);
//        url_parameters(str);
        return false;
  });

    function getUrlParams(href) {
        var params = (href.split('?')[1] || '');
        return params;
    }


    $('.for_all_listing').show();


     $('.for_autocomplete_listing a').live ('click', function() {
         var url = getUrlParams(this.href);
        $.getScript('jobs/search/?' + url);
        return false;
    });


    $('#main_list_link').live('click', function(){
       $.ajax(
       {
        url: '/jobs/search',
//        dataType: "html",
        beforeSend: function(){
          $(".spinner").showLoading();
          $("#main_list_link").hide();
        },
        success: function(){
          $(".spinner").hideLoading();
          $(".spinner #main_list_link").show();
        }
        });

        return false;
    });


    $('#search_form_text_field').val('');

    $('#search_form_text_field').on('input', function() {
        var params = {};
        params[this.name] = this.value;
        $.get('jobs/search_autocomplete', params);
    });


    $('#new_comment_link').click ( function() {
        $('#new_comment_link').hide();
    });

// for dynamically added content you must use live method for click event
// Internet den ogrendim.



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
    p.slideUp('slow').slideDown('slow');

   var nfn = $('.notify_friend_name');
   var nfe = $('.notify_friend_email');

    $("#show_link_to_email_friend").live('click', function() {
        nfn.val('');
        nfe.val('');

        $('#notify_friend_form').slideDown()
    });

    var batin = $("input:submit");
    batin.button();

    // batin.live yerine batin.on kullandiginda show page'deki
    // .notify_friend_submit button'a errorleri check ederken bir kere click ettikten sonra
    // bir daha calismiyor
    batin.live('click',  function() {
        batin.attr("disabled", true);
    });


   $('.notify_friend_submit').button('enable');

   var reg = new RegExp(/^([\w]+)(.[\w]+)*@([\w]+)(.[\w]{2,3}){1,2}$/);

//    alert(reg.test('guneybilen@yahoo.com'));

    var taym1 = new Date();
    taym1 = taym1.getTime();

    $('.notify_friend_submit').click( function(e) {

       var taym2 = new Date();
       taym2 = taym2.getTime();

       if (nfn.val().length == 0){

         if (locale == "tr"){
            alert("Lütfen isim giriniz"); }

         if (locale == "en"){
            alert("Please input name"); }

           return false;
       }

       if (nfe.val().length ==0 || !reg.test(nfe.val())) {

         if (locale == "tr"){
            alert("Lütfen geçerli bir email adresi giriniz"); }

         if (locale == "en"){
            alert("Please input a valid email address"); }

           return false;
       }
         var req = requirements(taym2);
         if (!req){return false;}

    });

//    $('.comment_submit').live('click', function(){
//        var taym3 = new Date();
//        taym3 = taym3.getTime();
//        var req = requirements(taym3);
//        if(!req){
//            $('.comment_submit').button('enable');
//            return false;
//        }
//    });


function requirements(taym){
       if($('.hidden_field_tag').val() !=''){
         alert("Code 999");
         nfn.val('');
         nfe.val('');
         return false;
       }


       if(taym1+10>taym){
         alert('Code 888');
         nfn.val('');
         nfe.val('');
         return false;
       }

       return true;
}

});




