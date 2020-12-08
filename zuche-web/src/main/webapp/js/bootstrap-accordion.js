
/**
 自定义手风琴控件数据加载
 解析格式参考  menuinfo实体类
 接收一个数组，第一层是标题分类，每一层的子元素是菜单元素
 */

/**
 * 初始化手风琴控件
 * @param obj  手风琴控件id
 * @param data  要绑定的数据
 */
function initaccordion(obj,data) {

    //每一个菜单定义
    var panelobj =$("<div class=\"panel panel-default\">\n" +
        "                <div class=\"panel-heading\">\n" +
        "                    <h4 class=\"panel-title\">\n" +
        "                        <a data-toggle=\"collapse\" data-parent=\"#accordion\"\n" +
        "                           href=\"#panel1\">\n" +
        "                            XXXXX\n" +
        "                        </a>\n" +
        "                    </h4>\n" +
        "                </div>\n" +
        "                <div id=\"panel1\" class=\"panel-collapse collapse\">\n" +
        "                    <div class=\"panel-body\">\n" +
        "                        <div class=\"list-group\" style=\"margin:0\">\n" +

        "                        </div>\n" +
        "                    </div>\n" +
        "                </div>\n" +
        "            </div>");



    //每一个子菜单定义
    var aobj =$("<a class=\"list-group-item\" href=\"#\" url=\"userlist.html\">\n" +
        "                                XXX管理\n" +
        "                            </a>");



    //循环所有菜单数据
    for(var i = 0;i<data.length;i++){
        //将外层菜单克隆一份
        var clonepanelobj = panelobj.clone();
        //设置外层菜单的显示标题
        clonepanelobj.find("div[class='panel-heading'] a").text(data[i].name);
        //设置外层菜单操作的body元素的id
        clonepanelobj.find("div[class='panel-heading'] a").attr("href","#panel"+i);
        //设置外层菜单对应的body元素的id
        clonepanelobj.find("div[class='panel-heading']").next("div").attr("id","panel"+i);
        //将外层菜单添加到菜单容器中
        $(obj).append(clonepanelobj);
        //循环外层菜单的子菜单
        for(var j=0;j<data[i].childMenu.length;j++){
            //克隆一份子菜单
            var cloneaobj =aobj.clone();
            //设置子菜单的显示标题
            cloneaobj.text(data[i].childMenu[j].name);
            //设置子菜单的跳转路径
            cloneaobj.attr("url",data[i].childMenu[j].linkUrl);
            //将子菜单追加到外层菜单
            clonepanelobj.find("div[class='list-group']").append(cloneaobj);
        }

    }

    //设置第一个外层菜单打开
    $(obj).find("div[class='panel-heading']").eq(0).next("div").addClass("in");
    //设置第一个外层菜单中的第一个子菜单选中
    $(obj).find("div[class='panel-heading']").eq(0).next("div").find("a").eq(0).addClass("active");

}