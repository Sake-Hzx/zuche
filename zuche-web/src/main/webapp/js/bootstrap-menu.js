function chu(param) {
    /**
     * checkbox boolean
     * url
     * type post/get
     * ulDoc
     * tabDoc
     *
     */
    let checkbox = true;
    // checkbox
    if (param.checkbox != true) checkbox = false;
    $(param.ulDoc).addClass("nav nav-pills nav-stacked")
    //
    $.ajax({
        url: param.url,
        type: param.type,
        success: function (data) {
            $(data).each(function (index, count) {
                if (count.parentId == 0) {
                    $(param.ulDoc).append("<li role='presentation' class='li" + count.id + "'>" +
                        "<a href='#child" + count.id + "' class='nav-header collapsed' " +
                        "data-toggle='collapse'>" + count.name + "" +
                        "<span style='margin-right: 5px;margin-top: 1px' class='pull-left " + count.icon + "'></span>" +
                        "</a>" +
                        "</li>");
                    let liCls = '.li' + count.id;
                    if (checkbox) $(liCls).append($('<input class="checkbox" type="checkbox" style="position: relative;left: -5px;top: -31px">'));
                } else {
                    let ulId = '#child' + count.parentId;
                    if ($(ulId).html() == undefined) {
                        let liCls = ".li" + count.parentId;
                        $(liCls).append("<ul id='child" + count.parentId + "' class='nav nav-stacked collapse'>" +
                            "<li class='li" + count.id + "' style='margin-left: 10px'><a class='addTabs aA" + count.id + "' href='#'>" + count.name + "" +
                            "<span style='margin-right: 5px;margin-top: 1px' class='pull-left " + count.icon + "'></span></a></li>" +
                            "</ul>");
                        let liCls1 = ".li" + count.id;
                        if (checkbox) $(liCls1).append($('<input class="checkbox" type="checkbox" style="position: relative;left: -5px;top: -31px">'));
                        let liCls2 = param.ulDoc + " li"
                        $(liCls2).each(function (index1, count1) {
                            let liCls = count1.attributes.class.nodeValue;
                            if (liCls == "li" + count.parentId) {
                                if (checkbox) {
                                    $(ulId).prev().prev().append("<span class='pull-right glyphicon glyphicon-chevron-down'></span>")
                                    $(ulId).prev().prev().attr('href', ulId);
                                    $(ulId).prev().prev().attr('data-toggle', "collapse");
                                } else {
                                    $(ulId).prev().append("<span class='pull-right glyphicon glyphicon-chevron-down'></span>")
                                    $(ulId).prev().attr('href', ulId);
                                    $(ulId).prev().attr('data-toggle', "collapse");
                                }
                            }
                            ;
                        });
                    } else {
                        $(ulId).append("<li class='li" + count.id + "' style='margin-left: 10px'><a class='addTabs aA" + count.id + "' href='#'>" + count.name + "" +
                            "<span style='margin-right: 5px;margin-top: 1px' class='pull-left " + count.icon + "'></span></a></li>");
                        let liCls = ".li" + count.id;
                        if (checkbox) $(liCls).append($('<input class="checkbox" type="checkbox" style="position: relative;left: -5px;top: -31px">'));
                        $('.addTabs').off();
                        $('.addTabs').click(function () {
                            let nameId = this.className.substr(10);
                            let href = this.attributes.href.textContent;
                            $(data).each(function (index1, count1) {
                                let liLu = 'lu' + count1.id
                                if (count1.id == nameId && href == '#' && $('.' + liLu).length <= 0) {
                                    let urlDiv = 'aB' + nameId;
                                    let tabUl = param.tabDoc + ">ul";
                                    $(tabUl).append('<li class="' + liLu + '"><a onclick="loadPage(\'#' + urlDiv + '\', \'' + count1.url + '\')" href="#' + urlDiv + '" data-toggle="pill">' +
                                        '<span class="' + count1.icon + '" style="top: 2px;left: -4px"></span>' + count1.name + '' +
                                        '<span class="glyphicon glyphicon-remove span" style="color:pink;position: relative;top: 2px;left: 5px;"></span>' +
                                        '</a></li>');
                                    $(".span").off();
                                    $(".span").hover(function () {
                                        $(this).css("color", "red");
                                    }, function () {
                                        $(this).css("color", "pink");
                                    });
                                    $('.span').click(function () {
                                        let idHref = $(this).parent()[0].attributes.href.textContent;
                                        $(idHref).remove();

                                        if ($(this).parent().parent().next().html() == undefined && $(this).parent().parent()[0].attributes.class.textContent.length > 5) {
                                            $(this).parent().parent().prev().children().tab('show');
                                        } else if ($(this).parent().parent()[0].attributes.class.textContent.length > 5) {
                                            $(this).parent().parent().next().children().tab('show');
                                        }
                                        $(this).parent().parent().remove();
                                    })
                                    let tabDiv = param.tabDoc + ">div";
                                    $(tabDiv).append('<div class="tab-pane fade" id="' + urlDiv + '"></div>');
                                    $('.' + liLu).tab('show');
                                    $(param.tabDoc + ' div[class="tab-pane fade active in"]').removeClass('active in')
                                    $('#' + urlDiv).addClass('active in');
                                    loadPage('#' + urlDiv, count1.url);
                                } else if ($('.' + liLu).length > 0 && count1.id == nameId) {
                                    let urlDiv = 'aB' + nameId;
                                    let tabDiv = param.tabDoc + ">div";
                                    $('.' + liLu).tab('show');
                                    $(param.tabDoc + ' div[class="tab-pane fade active in"]').removeClass('active in')
                                    $('#' + urlDiv).addClass('active in');
                                    loadPage('#' + urlDiv, count1.url);
                                }
                                rigClose(param.tabDoc);
                            });
                        });
                    }
                    $(param.ulDoc + ' a').css('color', 'rgb(87, 60, 113)');
                }
            });
        }
    });
}

function loadPage(e, href) {
    $(e).load(href);
}

function rigClose(tabDoc) {
    $('a[data-toggle="pill"]').off();
    $('a[data-toggle="pill"]').bind("contextmenu", function () {
        return false;
    });
    $('a[data-toggle="pill"]').mousedown(function (e) {
        //右键为3
        if (3 == e.which) {
            let top = $(this).offset().top + $(this).height() * 1.5;
            let left = $(this).offset().left + $(this).width() / 2;
            if ($('#rigBtn').length <= 0) {
                $('body').append('<button id="rigBtn" class="btn btn-danger" style="position: absolute;left: ' + left + 'px;' +
                    'top: ' + top + 'px">' +
                    '关闭全部' +
                    '</button>');
                $('#rigBtn').click(function () {
                    for (let i = 1; i < $('li').length; i++) {
                        $('li[class="lu' + i + '"]').remove();
                    }
                    $(tabDoc + ' div[class="tab-pane fade"]').remove();
                });
                $('body').click(function () {
                    if ($('#rigBtn').length >= 0) {
                        $('#rigBtn').remove();
                    }
                });
            }
        }
    });
}