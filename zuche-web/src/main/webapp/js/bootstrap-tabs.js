/**
 * 初始化选项卡节点
 * @param tabNode div的节点
 */
function initTabbable(tabNode){
    $(tabNode).html("<ul class='nav nav-tabs'></ul><div class='tab-content'></div>");
}
//添加选项卡时后缀id
let _$tabbableId = 1;
/**
 * 添加选项卡
 * @param tabNode 选项卡节点
 * @param name 选项卡标题
 * @param icon 选项卡icon
 * @param url 选项内部卡打开的页面路径
 * @param data 传过去的参数
 * @param enableClose 是否启用关闭按钮
 */
function addTabbable(tabNode,name,icon,url,data,enableClose) {
    if (enableClose === undefined) enableClose = true;
    let tab = $(tabNode);
    //先判断该名称对应的选项卡是否存在,如果存在没就显示之前的
    if(activeTabbable(tabNode,name)) return;
    //选项卡头部
    let li = $("<li></li>");
    let a = $("<a></a>");
    let i = undefined;
    if (enableClose) {
        i = $("<i></i>");
        i.addClass("glyphicon glyphicon-remove button-close");
        //绑定移除事件
        i.click(function () {
            closeTabbable(tabNode, name);
        });
    }
    a.attr("data-toggle","tab");
    a.attr("data-name",name);
    a.attr("href","#panel-" + _$tabbableId);
    a.append("<i class=\"glyphicon " + icon + "\"></i>");
    a.append(" " + name + " ");
    if (enableClose) a.append(i);
    li.addClass("active");
    li.append(a);
    //选项卡身体
    let body = $("<div class='tab-pane active col-lg-12' id='panel-" + (_$tabbableId ++) + "'></div>");
    if (url !== undefined){
        if (data === null) body.load(url);
        else body.load(url,data);
    }
    //移除所有选项卡的active
    tab.children(".nav-tabs").children("li").removeClass("active");
    tab.children(".tab-content").children("div").removeClass("active");
    //加入选项卡
    tab.children(".nav-tabs").append(li);
    tab.children(".tab-content").append(body);
}

/**
 * 切换选项卡到选中状态
 * @param tabNode 选项卡节点
 * @param name 选项卡标题
 * @return boolean 是否关闭成功
 */
function activeTabbable(tabNode,name) {
    tabNode = $(tabNode);
    let temp = tabNode.children(".nav-tabs").children("li").children("a[data-name='" + name + "']");
    if(temp.length > 0){
        //移除所有选项卡的active
        tabNode.children(".nav-tabs").children("li").removeClass("active");
        tabNode.children(".tab-content").children("div").removeClass("active");
        //当前选项卡选中
        temp.parent().addClass("active");
        $(temp.attr("href")).addClass("active");
        return true;
    }
    return false;
}


/**
 * 关闭选项卡
 * @param tabNode 选项卡节点
 * @param name 选项卡标题
 * @return boolean 是否关闭成功
 */
function closeTabbable(tabNode,name){
    tabNode = $(tabNode);
    let temp = tabNode.children(".nav-tabs").children("li").children("a[data-name='" + name + "']");
    if(temp.length > 0){
        let liNav = tabNode.children(".nav-tabs");
        let divCon = tabNode.children(".tab-content");
        liNav.children("li").removeClass("active");
        divCon.children("div").removeClass("active");
        let id = temp.attr("href");
        temp.parent().remove();
        tabNode.find(id).remove();
        liNav.children("li").last().addClass("active");
        divCon.children("div").last().addClass("active");
        return true;
    }
    return false;
}

//加载样式
$(function () {
    let style = $("style");
    if (style.length === 0){
        style = $("<style></style>");
        $("head:eq(0)").append(style);
    }
    style.html(style.html() + ".nav-tabs li .button-close{display: none;cursor: pointer;}\n" +
        ".nav-tabs li:hover .button-close{display: inline;}\n" +
        ".nav-tabs li .button-close:hover {color: #2392C9}\n" +
        ".nav-tabs li.active .glyphicon{display: inline;}");
})