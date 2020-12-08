/**
 * @name bootstrap-extend
 *
 * bootstrap扩展插件
 * 使用时请引入:"bootstrap-extend.css"
 *
 * 包含 :
 * tree控件扩展
 * 选项卡控件
 * 模态框组件扩展
 * 提示框组件
 * 表单事件扩展
 *
 * @version 1.0
 * @data 2020-10-13
 * @author 小李
 */

(function ($) {

    //************************ tree控件 *************************

    /**
     * checkbox改变状态后调用的绑定事件
     * @param obj 触发者对象
     * @param func 事件函数
     * @param e event对象
     */
    let treeCkBoxChangeEvent = function (obj,func, e) {
        if (func) for (let i = 0; i < obj.length; i++) obj[i].cbcef = func;
        else for (let i = 0; i < obj.length; i++) obj[i].cbcef && obj[i].cbcef(e);
    }

    /**
     * 触发checkbox点击事件
     * @param obj 触发者对象
     * @param type 递归调用递归类型
     * @param e event对象
     * @param ck 选中状态
     * @param indeterminate 是否为半选中状态
     */
    let treeCkBoxChange = function (obj,type, e,ck, indeterminate) {
        let checked = obj.is(":checked");
        if (indeterminate === undefined) {
            obj.removeClass("indeterminate");
            for (let i = 0; i < obj.length; i++)
                obj[i].indeterminate = false;
            !type || obj.prop("checked", checked = (ck !== undefined ? ck : !checked));
            treeCkBoxChangeEvent(obj,undefined, e);
        } else {
            let temp = checked;
            obj.prop("checked", checked = false);
            if (temp) treeCkBoxChangeEvent(obj,undefined, e);
            if (indeterminate) obj.addClass("indeterminate");
            else obj.removeClass("indeterminate");
            for (let i = 0; i < obj.length; i++)
                obj[i].indeterminate = indeterminate;
        }
        let ul = obj.closest("ul");
        //向上遍历
        if (!type || type === "up") {
            //父辈的checkbox
            let parentCheckbox = ul.parent().find(" > span input.tree-checkbox");
            if (parentCheckbox.length > 0) {
                //查看所有同辈checkbox全部选中
                let checkboxTemp = ul.find(" > li > span input.tree-checkbox");
                //同辈半选数量
                let indeterminateCount = checkboxTemp.filter(".indeterminate").length;
                //同辈checkbox数量
                let count = checkboxTemp.length;
                //选中数量
                let selectCount = checkboxTemp.filter(":checked").length;
                //父辈是否选中
                let parentCheckboxChecked = parentCheckbox.is(":checked");

                if (indeterminate !== undefined) {
                    if (!indeterminate && selectCount === 0)
                        treeCkBoxChange(parentCheckbox, "up", e, undefined, indeterminate);
                    else if (indeterminate && indeterminateCount !== 0)
                        treeCkBoxChange(parentCheckbox, "up", e, undefined, indeterminate);
                } else if (selectCount === count) {//满选
                    !parentCheckboxChecked && treeCkBoxChange(parentCheckbox, "up", e, true);
                } else if (parentCheckboxChecked && selectCount < count && selectCount > 0) { //从满选过渡到非满选
                    if (selectCount === 0) treeCkBoxChange(parentCheckbox, "up", e, false);
                    else treeCkBoxChange(parentCheckbox, "up", e, undefined, true);
                } else if (selectCount > 0 && selectCount < count) { //半选
                    treeCkBoxChange(parentCheckbox, "up", e, undefined, true);
                } else if (selectCount === 0 && indeterminateCount === 0) { //一个都没选
                    treeCkBoxChange(parentCheckbox, "up", e,undefined, false);
                }
            }
        }
        //向下遍历
        if (!type || type === "down") {
            //子级的checkbox
            let childCheckbox = obj.closest("li").find(" > ul > li > span input.tree-checkbox");
            if (childCheckbox.length > 0) {
                checked ? treeCkBoxChange(childCheckbox.not(":checked"),"down", e) : treeCkBoxChange(childCheckbox.filter(":checked"),"down", e);
            }
        }
        return this;
    }


    /**
     * 初始化树节点
     * 参考用法:<br>
     ```javascript
     let param = {
        data : {
            // 获取数据有一下参数,选填一个类别即可
            // ************** 从url获取数据 ******************
            //从url获取数据
            url : "test",
            //请求类型
            type : 'get',
            //url请求时执行函数,函数返回值为请求参数,function(){return data},
            subFunc : undefined,
            //************** 从变量获取数据 ******************
            //从变量获取数据
            variable : treeData,
            //************** 从自定义方法获取数据 ******************
            //自定义方法获取数据,function(){return data},
            func : undefined
        },
        process : {
            //是否打开树节点,默认false,可以为boolean值值或function(item,index,layer){return boolean},
            open : true,
            //显示的图标,bootstrap的图标样式,字段名或者function(item,index,layer){return str | jqueryObj},
            icon : 'icon',
            //checkbox,如果为undefined将不显示checkbox,
            //你可以直接写 checkbox : function(item,index,layer){return checkboxObj} ,函数返回一个checkbox对象
            //当然也可以像下面这样
            checkbox : {
                //是否启用checkbox,默认true,可以为boolean值或function(item,index,layer){return boolean},
                enable : undefined,
                //checkbox名称,字段名或者function(item,index,layer){return str},
                name : 'name',
                //checkbox值属性,字段名或者function(item,index,layer){return str},
                value : 'id',
                //checkbox是否选中,默认false,如果选中,那么该节点的所有子节点都将选中,字段名或者function(item,index,layer){return boolean},
                checked : false,
                //checkbox点击触发事件,被子级或者父级被动改变状态也会触发该事件,function(e,checkbox,type){return void}
                onChecked : function(e,checkbox,type){  }
            },
            //标题(鼠标悬停时显示),字段或者function(item,index,layer){return str},
            title : undefined,
            //树节点显示内容,字段或者function(item,index,layer){return str},
            text : 'name',
            //后面的自定义内容,function(item,index,layer){return JQueryObj},
            after : undefined,
            //子级(list集合),字段名或者function(item,index,layer){return list}
            child : 'list',
            //节点点击事件
            //可以直接 onChick : function(e,node,type){return void} ,node为当前节点(span)的jquery对象
            //当然也可以像下面这样
            onChick : {
                //是否启用,默认true,可以为boolean值或function(item,index,layer){return boolean},
                enable : undefined,
                //点击执行方法,function(e,checkbox,type){return void} ,node为当前节点(span)的jquery对象
                func : function (e,node,type) {  }
            }
            //当以上操作全部完成后,执行自定义操作,function (liObj,item,index,layer) {return void},liObj为当前列表的jquery对象
            custom : undefined
        },
        //节点树是否占满父级节点
        fill : true,
        //字体大小
        fontSize : 15
     }
     ```
     * @param param 参数对象,参考上面的用法
     */
    $.fn.loadTree = function (param) {
        //先清空节点
        this.empty();
        this.addClass("tree");
        //保存param对象
        for (let i = 0; i < this.length; i++) this[i].loadParam = param;

        //提交方法
        let getData = (async,type,url,data,func) => {
            let retData = undefined;
            $.ajax({
                async: async ,
                type: type,
                url: url,
                data: data,
                dataType: 'json',
                success : data => {
                    retData = !async && data || undefined;
                    func && func(data);
                }
            });
            return retData;
        }
        let process = param.process;
        //状态大小
        param.fontSize && this.css("font-size", param.fontSize);
        //获取tree数据
        let data = (param.data.url && getData(false, param.data.type, param.data.url, (param.data.subFunc && param.data.subFunc() || undefined))) || param.data.variable || (param.data.func && param.data.func());
        //console.log(data);
        if (!data) return;
        let eachFunc = (obj, node, index, layer, parentParam) => {
            if (!obj) return;
            let tempNode = $("<li></li>");
            //子节点,用于递归调用
            let child = process.child && (typeof process.child === 'function' ? process.child(obj, index, layer) : obj[process.child]) || undefined;
            let span = $("<span></span>");
            //是否打开选项卡
            parentParam.open || tempNode.css("display", "none");
            //子级是否显示
            parentParam.open = !process.open ? false : (typeof process.open === "function" ? process.open(obj, index, layer) : process.open);
            child && child.length > 0 && span.append("<i class='tree-parent-icon glyphicon glyphicon-triangle-" + (!parentParam.open ? "right" : "bottom") + "'></i> ");
            //是否占满父节点
            let fill = !!param.fill;
            fill && span.css("width", "100%");
            //节点title
            span.attr("title", !process.title ? '' : (typeof process.title === "function" ? process.title(obj, index, layer) : obj[process.title]));
            //加载checkbox
            let checkbox = undefined;
            if (process.checkbox)
                if (typeof process.checkbox === "function")
                    span.append(checkbox = $(process.checkbox(obj, index, layer)).addClass("tree-checkbox")).append(" ");
                else if (process.checkbox.enable === undefined || (typeof process.checkbox.enable === "function" ? process.checkbox.enable(obj, index, layer) : process.checkbox.enable)) {
                    checkbox = $("<input type='checkbox'/>").addClass("tree-checkbox");
                    let name = !process.checkbox.name ? undefined : (typeof process.checkbox.name === "function" ? process.checkbox.name(obj, index, layer) : obj[process.checkbox.name]);
                    name !== undefined && checkbox.attr("name", name);
                    let value = !process.checkbox.value ? undefined : (typeof process.checkbox.value === "function" ? process.checkbox.value(obj, index, layer) : obj[process.checkbox.value]);
                    value !== undefined && checkbox.val(value);
                    //如果父节点选中,那么子节点全都选中
                    parentParam.checked = parentParam.checked ? parentParam.checked : (!process.checkbox.checked ? undefined : (typeof process.checkbox.checked === "function" ? process.checkbox.checked(obj, index, layer) : process.checkbox.checked));
                    parentParam.checked && checkbox.prop("checked", true);
                    process.checkbox.onChecked && treeCkBoxChangeEvent(checkbox,e => {
                        process.checkbox.onChecked(e, checkbox.get(0), (child && child.length > 0 ? "parent" : "child"))
                    });
                    span.append(checkbox).append(" ");
                }
            //节点图标
            let icon = !process.icon ? undefined : (typeof process.icon === "function" ? process.icon(obj, index, layer) : obj[process.icon]);
            icon && ((typeof icon === "string") && span.append("<i class='glyphicon " + icon + "'></i> ") || span.append(icon));
            //树节点显示内容
            span.append(!process.text ? '' : (typeof process.text === "function" ? process.text(obj, index, layer) : obj[process.text]));
            //after
            process.after && span.append(process.after(obj, index, layer));
            tempNode.append(span);
            //子节点
            let childUl = undefined;
            //递归子节点
            if (child && child.length > 0) {
                //子节点选中数量
                let childCheckedCount = 0;
                //子节点半选数量
                let childIndeterminateCount = 0;
                //子节点的checkbox数量
                let childCheckboxCount = 0;
                childUl = $("<ul></ul>");
                for (let i = 0; i < child.length; i++) {
                    let temp = eachFunc(child[i], childUl, i, layer + 1, {
                        open: parentParam.open,
                        checked: parentParam.checked,
                        indeterminate: parentParam.indeterminate
                    });
                    temp.checked ? childCheckedCount++ : 0;
                    temp.hasCheckbox ? childCheckboxCount++ : 0;
                    temp.indeterminate ? childIndeterminateCount++ : 0;
                }
                if (checkbox && childCheckboxCount > 0 && childCheckedCount > 0){
                    if (childCheckboxCount === childCheckedCount){ //如果子级全选
                        parentParam.checked = true;
                        checkbox.prop("checked", true);
                    } else if (childCheckedCount < childCheckboxCount) { //非全选
                        parentParam.indeterminate = true;
                        checkbox.addClass("indeterminate");
                        for (let i = 0; i < checkbox.length; i++)
                            checkbox[i].indeterminate = true;
                    }
                } else if (checkbox && childIndeterminateCount > 0) {
                    parentParam.indeterminate = true;
                    checkbox.addClass("indeterminate");
                    for (let i = 0; i < checkbox.length; i++)
                        checkbox[i].indeterminate = true;
                }
            }
            //添加子节点
            childUl && tempNode.append(childUl);
            //点击事件
            if (process.onChick)
                if (typeof process.onChick === 'function')
                    span.addClass("hsaClick") && span.click(e => {
                        process.onChick(e,span,child && child.length > 0 ? "parent" : "child");
                    });
                else if (process.onChick.enable === undefined || (typeof process.onChick.enable === "function" ? process.onChick.enable(obj, index, layer) : process.onChick.enable))
                    span.addClass("hsaClick") && span.click(e => {
                        process.onChick.func(e,span,child && child.length > 0 ? "parent" : "child");
                    });

            //执行自定义操作
            process.custom && process.custom(tempNode, obj, index, layer);
            node.append(tempNode);

            return {hasCheckbox: (!!checkbox), checked: parentParam.checked,indeterminate: parentParam.indeterminate};
        }
        let node = $("<ul></ul>");
        for (let i = 0; i < data.length; i++) eachFunc(data[i], node, i, 1, {open: true, checked: false,indeterminate: false});
        this.append(node);

        this.find('li:has(ul)').addClass('parentLi');
        this.find('li.parentLi > span').on('click', function (e) {
            let parent = $(this).parent('li.parentLi');
            let children = parent.find(' > ul > li');
            if (children.is(":visible")) {
                children.hide('fast');
                $(this).children('i.tree-parent-icon').addClass('glyphicon-triangle-right').removeClass('glyphicon-triangle-bottom');
            } else {
                children.show('fast');
                $(this).children('i.tree-parent-icon').addClass('glyphicon-triangle-bottom').removeClass('glyphicon-triangle-right');
            }
            //e.stopPropagation();
        });
        let childCheckbox = this.find("li:has('span')").not(".parentLi").find(' > span > input.tree-checkbox');

        //给含有checkbox的span绑定点击事件
        let childSpan = childCheckbox.parent();
        childSpan.click(function (e) {
            $(this).find(" > input.tree-checkbox").click();
        })
        childSpan.addClass("hasCheckbox");
        this.find("li span input").click(function (e) {
            e.stopPropagation();
            treeCkBoxChange($(this),undefined, e);
        });
        return this;
    }

    /**
     * 重新加载树节点,调用该方法前必须要调用过一次 loadTree() 方法
     */
    $.fn.reloadTree = function () {
        for (let i = 0; i < this.length; i++) this.loadTree(this[i].loadParam);
        return this;
    }

    /**
     * 查询树节点
     * @param name 节点内容
     */
    $.fn.queryTree = function (name) {
        //图标改变
        this.find("li.parentLi > span > i.tree-parent-icon").addClass('glyphicon-triangle-right').removeClass('glyphicon-triangle-bottom');
        this.find("li span").css("color", "");
        //先把所有的节点收起来
        this.find(" > ul > li").find("li").css("display", "none");
        if (!name || name === '') {
            this.find("li > span:contains('" + name + "')").css("color", "");
            return;
        }
        let select = this.find("li > span:contains('" + name + "')");
        if (name && name !== '') select.css("color", "red");
        select.parents('li').parent().children().css("display", "");
        select.parent().parents('li').filter(".parentLi").find(" > span > i.tree-parent-icon").addClass('glyphicon-triangle-bottom').removeClass('glyphicon-triangle-right');
        return this;
    }

    /**
     * 获取选中的项,也就是选中的checkbox
     * @param indeterminate 是否获取半选中状态的checkbox,默认false
     */
    $.fn.getSelectTree = function (indeterminate) {
        if (indeterminate) {
            let temp = this.find("li span input.tree-checkbox");
            return temp.filter(":checked").add(temp.filter(".indeterminate"));
        }
        return this.find("li span input.tree-checkbox:checked");
    }

    //************************ 选项卡控件 *************************

    //添加选项卡时后缀id
    let _$tabbableId = 1;

    /**
     * 初始化选项卡节点
     */
    $.fn.initTabs = function () {
        this.html("<ul class='nav nav-tabs'></ul><div class='tab-content'></div>");
        return this;
    }

    /**
     * 添加选项卡
     * @param name 选项卡标题
     * @param icon 选项卡icon
     * @param url 选项内部卡打开的页面路径
     * @param data 传过去的参数
     * @param enableClose 是否启用关闭按钮
     */
    $.fn.addTabs = function (name, icon, url, data, enableClose) {
        if (enableClose === undefined) enableClose = true;
        //先判断该名称对应的选项卡是否存在,如果存在没就显示之前的
        if (this.activeTabs(name)) return;
        //选项卡头部
        let li = $("<li></li>");
        let a = $("<a></a>");
        let i = undefined;
        if (enableClose) {
            i = $("<i></i>");
            i.addClass("glyphicon glyphicon-remove button-close");
            //绑定移除事件
            i.click(() => {
                this.closeTabs(name);
            });
        }
        a.attr("data-toggle", "tab");
        a.attr("data-name", name);
        a.attr("href", "#panel-" + _$tabbableId);
        a.append("<i class=\"glyphicon " + icon + "\"></i>");
        a.append(" " + name + " ");
        if (enableClose) a.append(i);
        li.addClass("active");
        li.append(a);
        //选项卡身体
        let body = $("<div class='tab-pane active col-lg-12' id='panel-" + (_$tabbableId++) + "'></div>");
        if (url !== undefined) {
            if (data === null) body.load(url);
            else body.load(url, data);
        }
        //移除所有选项卡的active
        this.children(".nav-tabs").children("li").removeClass("active");
        this.children(".tab-content").children("div").removeClass("active");
        //加入选项卡
        this.children(".nav-tabs").append(li);
        this.children(".tab-content").append(body);
        return this;
    }

    /**
     * 切换选项卡到选中状态
     * @param name 选项卡标题
     * @return boolean 是否关闭成功
     */
    $.fn.activeTabs = function (name) {
        let temp = this.children(".nav-tabs").children("li").children("a[data-name='" + name + "']");
        if (temp.length > 0) {
            //移除所有选项卡的active
            this.children(".nav-tabs").children("li").removeClass("active");
            this.children(".tab-content").children("div").removeClass("active");
            //当前选项卡选中
            temp.parent().addClass("active");
            $(temp.attr("href")).addClass("active");
            return true;
        }
        return false;
    }

    /**
     * 关闭选项卡
     * @param name 选项卡标题
     * @return boolean 是否关闭成功
     */
    $.fn.closeTabs = function (name) {
        let temp = this.children(".nav-tabs").children("li").children("a[data-name='" + name + "']");
        if (temp.length > 0) {
            let liNav = this.children(".nav-tabs");
            let divCon = this.children(".tab-content");
            liNav.children("li").removeClass("active");
            divCon.children("div").removeClass("active");
            let id = temp.attr("href");
            temp.parent().remove();
            this.find(id).remove();
            liNav.children("li").last().addClass("active");
            divCon.children("div").last().addClass("active");
            return true;
        }
        return false;
    }


    //************************ 模态框组件 *************************

    /**
     * 是否打开了模态框
     * @type {boolean}
     */
    let isOpenModal = false;

    /**
     * 模态框组件
     */
    let modal = $(`<div id='dialog-box' class='col-md-12 column'>
                        <div data-backdrop="static" class='modal fade' id='dialog-box-modal-container' role='dialog' aria-labelledby='dialog-box-title' aria-hidden='true'>
                            <div class='modal-dialog'>
                                <div class='modal-content'>
                                    <div class='modal-header'>
                                        <button id='dialog-box-close' type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>
                                        <h4 class='modal-title' id='dialog-box-title'></h4>
                                    </div>
                                    <div class='modal-body' id='dialog-box-body'></div>
                                    <div class='modal-footer'>
                                        <button id='dialog-box-cancelling' type='button' class='btn btn-default' data-dismiss='modal'>取消</button>
                                        <button id='dialog-box-true' type='button' class='btn btn-primary' data-dismiss='modal'>确定</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                   </div>`
    ).on('hidden.bs.modal', function () {
        isOpenModal = false;
        $("#dialog-box-title").empty();
        $("#dialog-box-body").empty();
        $("#dialog-box-true").off("click");
        $("#dialog-box-cancelling").off("click");
        $("#dialog-box-close").off("click");
    });


    /**
     * 弹出一个消息框,并包含3个按钮
     * @param title 消息框标题
     * @param body 消息框身体
     * @param func 关闭执行方法,参数为点击的按钮类型:(-1,0,1)
     * @param size 尺寸,模态框显示的大小,参数为: 'lg','md','sm' ,默认'md'
     */
    $.showDialogBox = function (title, body, func, size) {
        if (isOpenModal)
            throw new Error("禁止嵌套打开模态框!");
        isOpenModal = true;
        let boxModal = modal.children("#dialog-box-modal-container");
        let dialog = boxModal.children(".modal-dialog");
        if (size === 'lg')
            dialog.removeClass("modal-sm").addClass("modal-lg");
        else if (size === 'sm')
            dialog.removeClass("modal-lg").addClass("modal-sm");
        else
            dialog.removeClass("modal-sm modal-lg");
        let titleNode = modal.find("#dialog-box-title");
        let bodyNode = modal.find("#dialog-box-body");
        titleNode.html(title);
        bodyNode.html(body);
        let trueBtn = modal.find("#dialog-box-true");
        let cancellingBtn = modal.find("#dialog-box-cancelling");
        let closeBtn = modal.find("#dialog-box-close");
        let temp = function (type) {
            boxModal.modal('hide');
            if (func !== undefined && func !== null) func(type);
            isOpenModal = false;
        }
        trueBtn.click(function () {
            temp(1);
        });
        cancellingBtn.click(function () {
            temp(0);
        });
        closeBtn.click(function () {
            temp(-1);
        });
        boxModal.modal('show');
        return this;
    }

    /**
     * 根据一个url打开一个遮罩窗体
     * @param title 遮罩窗体标题
     * @param url 打开路径
     * @param data 传入数据
     * @param func 关闭执行方法,参数为点击的按钮类型:(-1,0,1)
     * @param size 尺寸,模态框显示的大小,参数为: 'lg','md','sm' ,默认'md'
     */
    $.showDialogBoxByUrl = function (title,url,data,func,size) {
        let div = $("<div class='container-fluid'></div>");
        div.load(url, data);
        $.showDialogBox(title, div, func, size);
        return this;
    }

    //************************ 提示框组件 *************************

    /**
     * 显示一个自定义的提示信息框
     * @param body 提示信息内容
     * @param time? 显示时间,默认2500毫秒
     * @param finishFunc? 显示完成后执行函数
     * @param bgc? 背景颜色,默认白色
     * @param top? 离顶部距离,默认40%
     * @param left? 离底左边距离,默认50%
     */
    $.showPrompt = function (body,time,finishFunc,bgc,top,left) {
        let prompt = $(`<div class="prompt"></div>`);
        body !== undefined && prompt.html(body);
        bgc && prompt.css("background-color",bgc);
        top !== undefined && prompt.css("top",top);
        left !== undefined && prompt.css("left",left);
        $("body").first().append(prompt);
        prompt.slideToggle("fast", () => {
            setTimeout( () => {
                prompt.fadeOut("fast", () => {
                    prompt.remove();
                    finishFunc && finishFunc();
                })
            },time || 2500);
        });
        return prompt;
    }

    /**
     * 显示一个成功的提示框
     * @param body 提示信息内容
     * @param time? 显示时间,默认2500毫秒
     * @param finishFunc? 显示完成后执行函数
     * @param top? 离顶部距离,默认40%
     * @param left? 离底左边距离,默认50%
     */
    $.showPromptSuccess = function (body,time,finishFunc,top,left) {
        let icon = $(`<i class="glyphicon glyphicon-ok"/> `);
        let prompt = $.showPrompt(undefined,time,finishFunc,undefined,top,left);
        prompt.addClass("alert alert-success");
        prompt.append(icon).append(body);
    }

    /**
     * 显示一个提醒的提示框
     * @param body 提示信息内容
     * @param time? 显示时间,默认2500毫秒
     * @param finishFunc? 显示完成后执行函数
     * @param top? 离顶部距离,默认40%
     * @param left? 离底左边距离,默认50%
     */
    $.showPromptInfo = function (body,time,finishFunc,top,left) {
        let icon = $(`<i class="glyphicon glyphicon-info-sign"/> `);
        let prompt = $.showPrompt(undefined,time,finishFunc,undefined,top,left);
        prompt.addClass("alert alert-info");
        prompt.append(icon).append(body);
    }

    /**
     * 显示一个警告的提示框
     * @param body 提示信息内容
     * @param time? 显示时间,默认2500毫秒
     * @param finishFunc? 显示完成后执行函数
     * @param top? 离顶部距离,默认40%
     * @param left? 离底左边距离,默认50%
     */
    $.showPromptWarning = function (body,time,finishFunc,top,left) {
        let icon = $(`<i class="glyphicon glyphicon-warning-sign"/> `);
        let prompt = $.showPrompt(undefined,time,finishFunc,undefined,top,left);
        prompt.addClass("alert alert-warning");
        prompt.append(icon).append(body);
    }

    /**
     * 显示一个警告的提示框
     * @param body 提示信息内容
     * @param time? 显示时间,默认2500毫秒
     * @param finishFunc? 显示完成后执行函数
     * @param top? 离顶部距离,默认40%
     * @param left? 离底左边距离,默认50%
     */
    $.showPromptDanger = function (body,time,finishFunc,top,left) {
        let icon = $(`<i class="glyphicon glyphicon-remove"/> `);
        let prompt = $.showPrompt(undefined,time,finishFunc,undefined,top,left);
        prompt.addClass("alert alert-danger");
        prompt.append(icon).append(body);
    }

    //************************ 表单事件扩展 *************************

    /**
     * ajax提交数据
     * @param async 是否异步提交
     * @param type 提交类型
     * @param url url
     * @param data 提交数据
     * @param func 成功是回调函数
     * @param error 错误时调用函数
     */
    $.ajaxData = function (async, type, url, data, func, error) {
        $.ajax({
            async: async,
            type: type,
            url: url,
            data: data,
            dataType: 'json',
            success: func,
            error: error
        });
    }

    /**
     * form表单序列化对象,根据表单name属性
     * @returns json对象
     */
    $.fn.serializeObject = function () {
        let o = {};
        let a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name] !== undefined) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    }

    /**
     * ajax方法提交表单
     * @param async 是否异步提交
     * @param type 提交类型
     * @param url url
     * @param data 提交数据
     * @param func 成功是回调函数
     * @param error 错误时调用函数
     */
    /*$.fn.ajaxSubmit = function (async, type, url, data, func, error) {
        $.ajaxData(async, type, url, data ? Object.assign({}, this.serializeObject(), data) : this.serializeObject(), func, error);
        return this;
    }*/

    //初始化模态框
    $(function () {
        //添加遮罩窗体
        $("body").first().append(modal);
    })

}(jQuery))

