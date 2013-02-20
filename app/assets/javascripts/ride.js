$(document).ready(function() {

    $("#reset_checkboxes").click(function() {
        $("#accordion").find("input[type=checkbox]").each(function() {
            $(this).attr("checked", false);
        });
        $("#min_price, #max_price").val("");
        $("#submit_filters").click();
    });

    $(".ellipsis, #slideshow div.descr").dotdotdot({
        height: 140
    });

    $('#gallery').imagegallery();


    $('#slideshow').bjqs({
        'height' : 480,
        'width' : 640,
        'responsive' : true,
        'animspeed' : 4000
    });

    $('.redactor').redactor({
        buttons: ['|', 'formatting', '|', 'bold', 'italic', 'deleted', '|',
            'unorderedlist', 'orderedlist', 'outdent', 'indent', '|',
            'image', 'video', 'file', 'table', 'link', '|',
            'fontcolor', 'backcolor', '|', 'alignment', '|', 'horizontalrule']
    });

    $("#accordion").multiAccordion({active: [0,1,2,3,4,5,6,7,8,9,10]});

    $("span.selectable").click(function() {
        $(this).prev().click();
    })

    $("#submit_filters").click(function() {
        filterParts();
    });

    $(".datetimepicker").datetimepicker({
        stepHour: 1,
        stepMinute: 10
    });

    $('#back-top').fadeOut();
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            $('#back-top').fadeIn();
        } else {
            $('#back-top').fadeOut();
        }
    });

    // scroll body to 0px on click
    $('#back-top a').click(function () {
        $('body,html').animate({
            scrollTop: 0
        }, 800);
        return false;
    });

    VK.init({apiId: 3225011});

    VK.Widgets.Auth("vk_auth", {width: "200px", onAuth: function(data) {
        login_with_vk(data);
    } });
});

function filterParts() {
    var queryString = decodeURI($('#filters_form').formSerialize());
    window.location = formFiltersUrl(queryString);
}

function formFiltersUrl(queryString) {
    var objURL = new Object();

    queryString.replace(new RegExp("([^?=&]+)(=([^&]*))?", "g"),
            function($0, $1, $2, $3) {
                if ($1.indexOf("filters") == 0) {
                    var key = getFilterParamName($1);
                    if (objURL[key] != undefined)
                        objURL[key] += "," + $3;
                    else if ($3 != "")
                        objURL[key] = $3;
                }
            });
    var path = "http://" + window.location.host + window.location.pathname + "?";

    for (var strKey in objURL) {
        path += strKey + "=" + objURL[ strKey ] + "&";
    }
    path = path.substr(0, path.length - 1);
    return path;
}

function getFilterParamName(value) {
    var m = value.toString().match(/filters((?:\[[^\]]+\])+)/);
    var substr = m[1].substring(1, m[1].length - 1);
    var array = substr.split("][");
    return array[0];
}

function login_with_vk(vk_response) {
    $.ajax({ type: 'POST',
        url: "pages/login_with_vk",
        data: vk_response}).success(function(data){
            window.location = data.redirect_path;
    });
}