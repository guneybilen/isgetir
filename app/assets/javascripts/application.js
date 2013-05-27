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


//    $("#select_box").val(0);  // bu IE9'da calismiyor

//    $("select#select_box").find("option#1").attr("selected", true);  // bu hem IE9'da hemde firefoxda calisiyor

    $(".search_by_category_submit").live('click', function(e){
        e.preventDefault();
        var i = $('#select_box').children(":selected").attr("value");
        var u;
        if (i==0)
           u = '/ajaxing/?category_id=' + 0;
        if (i>0)
           u = '/ajaxing/?category_id=' + i;

            $.ajax
            ({
                url:u,
                beforeSend:function()
                {
                    $('.for_spinner').show();
                },

                complete: function()
                {
                  $('.for_spinner').hide();
                }
            });
    });

        $("#search_form_submit").live('click', function(e){

        e.preventDefault();

        var u = $("#search_form").serialize();

//            alert('guney');

            $.ajax
            ({
                url:'/jobs//search?' + u,
                beforeSend:function()
                {
                    $('.for_spinner').show();
                },

                complete: function()
                {
                  $('.for_spinner').hide();
                }
            });
    });

    if ($("select#select_box").val()>0){
        var i = $('#select_box').children(":selected").attr("value");

        $.ajax({
            url:'/ajaxing/?category_id=' + i,
            beforeSend:function(){
                $('.for_spinner').show();
            },
            complete: function(){
                  $('.for_spinner').hide();
            }});
    }


    $(".sort_by_links_tr a, .for_all_listing a").live("click", function() {
        window.scrollTo(0, 0);
        var str = {};
        str = getUrlParams(this.href);
        var i = $('#select_box').children(":selected").attr("value");
        if(i>0) {
           $('#remove_category_anchor a').hide();
           $.ajax({
            url:'/ajaxing/?category_id=' + i + '&' + str,
            beforeSend:function(){
                $('.for_spinner').show();
            },
            complete: function(){
                  $('.for_spinner').hide();
            }});
            return false;
        }

/*        $.ajaxSetuup ve $.ajax kullanip $.getScript("jobs/search/?" + str); kullanarak
        yukardaki $("body").live... kullanildiginda ilk page load ettiginde page 2 ye tikladiginda
        spinner gif yuklemiyor.*/
        $.ajax({
            url:"jobs/search/?" + str,
            beforeSend:function(){
                $('.for_spinner').show();
            },
            complete: function(){
                  $('.for_spinner').hide();
                }});
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
//        alert(params[this.name]);
        params[this.name] = this.value;
//        alert(this.value);
//        var repl = $.trim(this.value);
        var repl = this.value;
        var repl = $.trim(this.value);
//        repl = repl.replace(/^%20/, '');
//        alert(repl);
//        $.get('jobs/search_autocomplete?keyword=', repl);
        $.ajax({
            url:'jobs/search_autocomplete?keyword=' + repl
        })
    });


    $('#new_comment_link').click ( function() {
        $('#new_comment_link').hide();
    });


    $(".comment_submit").live("click", function(){
        $(".comment_form").slideUp();
        $('#new_comment_link').show();
    });

// for dynamically added content you must use live method for click event
// Internet den ogrendim.



    $("#forgot_my_password").click ( function () {
        $('#password_reset').slideDown();
    });

    $("#cancel_password_reset").click ( function () {
        $('#password_reset').slideUp();
    });


    var locale = $("div.set_locale").text();

    $('a.show').click(function() {
        var $link = $(this);

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
    batin.attr("disabled", false);
//    alert('guny') ;

    // batin.live yerine batin.on kullandiginda show page'deki
    // .notify_friend_submit button'a errorleri check ederken bir kere click ettikten sonra
    // bir daha calismiyor
    batin.live ('click',  function() {
        batin.attr("disabled", true);
         var title= $('#job_title').val() == '';
         var body = $('#job_body').val() == '';

//        js_build class jobs/_form.html.erb'deki submit button
         if (title || body){
             $('.js_build').attr('disabled', false)
         }
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


    $('input:checkbox').prop("checked", false);

//    $('.check_box').each( function(){
//        $(this).attr('checked', false)
//    });

    $('.confirm_button').click(function(){
        var attr = $('.delete_form_tag').serialize();
        if (locale == 'tr')
        {open1(attr);}
        if (locale == 'en')
        {open2(attr);}

        return false;
    });


    $('.manage').click(function(){

        window.location.href = '/users/admin_manage?admin=manage';
//        $.ajax({
//            url: '/users/admin_manage',
//            type: 'GET',
//            data: {admin:'manage'},
//            dataType: "script"
//          success: function(result) {}
//        });
//         $.getScript('/users/admin_manage/?' + 'admin=manage');
        return false;

    });

//    $('input:submit').val('save');

     $('.delete').click(function(){

        window.location.href = '/users/admin_manage?admin=delete';

        return false;
     });

    var user_parameter = $('.user_in_admin_updated_user').val();

    $('.back_link_in_admin_updated_user_interface').click( function(){
        window.location.href = '/users/admin_update_user_interface?user=' + user_parameter
    });

    $(".td_for_tooltip").tooltip({
    bodyHandler: function(){

//        alert($(this).next().attr('value'));
        var url = $(this).children().val();

        var tip;

        if (locale == "tr"){
            tip = $("<span/>").html("yüklüyor...");
        }

        if (locale == "en"){
            tip = $("<span/>").html("loading...");
        }

//        var sa;

        $.ajax({

            url: url,
            success: function(html){
             tip = tip.html(html);  //.replace(/(\r\n|\n|\r)/gm,"");

        }});

        return tip;
    },
    showURL: false,
    track: true,
    delay: 0,
    extraClass:"show_ajax matwork"     // right is a css class
});

/*

    $(".show").tooltip({
    bodyHandler: function(){

        var url = $(this).attr("href");

        var tip;

        if (locale == "tr"){
            tip = $("<span/>").html("yüklüyor...");
        }

        if (locale == "en"){
            tip = $("<span/>").html("loading...");
        }

//        var sa;

        $.ajax({

            url: url,
            success: function(html){
//                sa = $('.show_ajax').text();
//                alert(sa);
//                  $('.show').attr('text', );
//                alert(html);
//                html = $('show_ajax').toString().split(' ');
//                for(var key in html) {
//                    obj += obj + key;
//                }

//                html = jQuery.makeArray(html);
//                alert(typeof(html));
//
//                  alert(typeof(html));
//                p = $(html).length;
//                alert(p);
//                if (p > 5){
//                   html = html.splice(4,0,'\n');
//                   html.join(' ');
//                    alert(html);
//                }
                tip = tip.html(html);  //.replace(/(\r\n|\n|\r)/gm,"");
//                  sa =$(html).find($('.show_ajax').innerText);
//                alert(sa);
        }});

//        tip = jQuery.makeArray(tip)
//        tip = tip.toString();
//        alert(tip.text());
//        tip.toArray().each(function(i){
//          alert($(this[i]));
//         });

//        return $("<span/>").html(sa);
        return tip;
    },
    showURL: false,
    track: true,
    delay: 0,
    extraClass:"show_ajax matwork"     // right is a css class
});

*/

});





function open1(attr){
//     alert(attr)
  $( "#dialog-confirm" ).dialog({
            resizable: false,
            height: 250,
            modal: true,
            buttons: {
                "Sil": function() {
                    $.ajax({
                        url: '/users/destroy',
                        type: 'DELETE',
                        data: attr
//                        success: function(result) {}
                    });
                    $( this ).dialog( "close" );
                },
                "İptal": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

}

function open2(attr){
  $( "#dialog-confirm" ).dialog({
            resizable: false,
            height: 250,
            modal: true,
            buttons: {
                "Delete": function() {
                    $.ajax({
                        url: 'users/destroy',
                        type: 'DELETE',
                        data: attr //,
//                        success: function(result) {}
                    });
                    $( this ).dialog( "close" );
                },
                "Cancel": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

}


