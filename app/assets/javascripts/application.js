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

//    $("#select_box").val(0);  // bu IE9'da calismiyor

    $("select#select_box").find("option#1").attr("selected", true);  // bu hem IE9'da hemde firefoxda calisiyor


    $(".sort_by_links_tr a, .for_all_listing a").live("click", function(e) {
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

    $('#search_form_text_field').live('input', function() {
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

//        var req = requirements(taym2);

//        if (!req){return false;}


//        if($('.notify_friend_captcha_answer').val() != $('.notify_friend_captcha_question').text()){
//            if (locale == "tr"){
//                alert("Lütfen kodu kutuya giriniz"); }
//
//            if (locale == "en"){
//                alert("Please enter the code in the textbox"); }
//
//            $('.notify_friend_captcha_question').animate({'backgroundColor' : "blue", "color" : "white"}, 5000);
//            $('.notify_friend_captcha_question').animate({'backgroundColor' : "white", "color" : "red"}, 5000);
//            return false;
//        }
    });


/*
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
*/

//    var captcha = randomString();
//    $('.notify_friend_captcha_question').text(captcha);
//    $('.notify_friend_captcha_question').css({'color': 'red'});
//    alert(randomString());

/*    function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 5;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }

        return randomstring;
    }*/

/*    $(".stripeMe tr").mouseover(function(){
        $(this).addClass('over');
    });

      $(".stripeMe tr").mouseout(function(){
        $(this).removeClass('over');
    });*/

    $(".stripeMe tr:even").addClass("alt");


});




