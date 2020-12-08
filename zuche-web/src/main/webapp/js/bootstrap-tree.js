/**
 * 初始化树节点
 * @param param
 */
$.fn.loadTree = function (param) {
    //先清空节点
    this.empty();
    this.addClass("tree");
    //保存param对象
    for (let i = 0; i < this.length; i++) this[i].loadParam = param;
    //提交方法
    let ajax = (async,type,url,data,func) => {
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
    let data = (param.data.url && ajax(false, param.data.type, param.data.url, (param.data.subFunc && param.data.subFunc() || undefined))) || param.data.variable || (param.data.func && param.data.func());
    //console.log(data);
    if (!data) return;
    let eachFunc = (obj, node, index, layer, parentParam) => {
        if (!obj) return;
        let tempNode = $("<li></li>");
        //子节点,用于递归调用
        let child = process.child && (typeof process.child === 'function' ? process.child(obj,index,layer) : obj[process.child]) || undefined;
        let span = $("<span></span>");
        //是否打开选项卡
        parentParam.open || tempNode.css("display", "none");
        //子级是否显示
        parentParam.open = !process.open ? false : (typeof process.open === "function" ? process.open(obj,index,layer) : process.open);
        child && child.length > 0 && span.append("<i class='tree-parent-icon glyphicon glyphicon-triangle-" + (!parentParam.open ? "right" : "bottom") + "'></i> ");
        //是否占满父节点
        let fill = !!param.fill;
        fill && span.css("width", "100%");
        //节点title
        span.attr("title", !process.title ? '' : (typeof process.title === "function" ? process.title(obj,index,layer) : obj[process.title]));
        //加载checkbox
        let checkbox = undefined;
        if (process.checkbox)
            if (typeof process.checkbox === "function")
                span.append(checkbox = $(process.checkbox(obj,index,layer)).addClass("tree-checkbox")).append(" ");
            else if (process.checkbox.enable === undefined || (typeof process.checkbox.enable === "function" ? process.checkbox.enable(obj,index,layer) : process.checkbox.enable)){
                checkbox = $("<input type='checkbox'/>").addClass("tree-checkbox");
                let name = !process.checkbox.name ? undefined : (typeof process.checkbox.name === "function" ? process.checkbox.name(obj,index,layer) : obj[process.checkbox.name]);
                name !== undefined && checkbox.attr("name", name);
                let value = !process.checkbox.value ? undefined : (typeof process.checkbox.value === "function" ? process.checkbox.value(obj,index,layer) : obj[process.checkbox.value]);
                value !== undefined && checkbox.val(value);
                //如果父节点选中,那么子节点全都选中
                parentParam.checked = parentParam.checked ? parentParam.checked : (!process.checkbox.checked ? undefined : (typeof process.checkbox.checked === "function" ? process.checkbox.checked(obj,index,layer) : process.checkbox.checked));
                parentParam.checked && checkbox.prop("checked",true);
                process.checkbox.onChecked && checkbox.ckBoxChangeEvent(e => {process.checkbox.onChecked(e,checkbox.get(0),(child && child.length > 0 ? "parent" : "child"))});
                span.append(checkbox).append(" ");
            }
        //节点图标
        let icon = !process.icon ? undefined : (typeof process.icon === "function" ? process.icon(obj,index,layer) : obj[process.icon]);
        icon && ((typeof icon === "string") && span.append("<i class='glyphicon " + icon + "'></i> ") || span.append(icon));
        //树节点显示内容
        span.append(!process.text ? '' : (typeof process.text === "function" ? process.text(obj,index,layer) : obj[process.text]));
        //after
        process.after && span.append(process.after(obj,index,layer));
        tempNode.append(span);
        //子节点
        let childUl = undefined;
        //递归子节点
        if (child && child.length > 0) {
            //子节点选中数量
            let childCheckedCount = 0;
            //子节点的checkbox数量
            let childCheckboxCount = 0;
            childUl = $("<ul></ul>");
            for (let i = 0; i < child.length; i++) {
                let temp= eachFunc(child[i], childUl,i,layer + 1, {open : parentParam.open, checked : parentParam.checked});
                temp.checked ? childCheckedCount ++ : 0;
                temp.hasCheckbox ? childCheckboxCount ++ : 0;
            }
            childCheckboxCount === childCheckedCount && checkbox && (parentParam.checked = true) && checkbox.prop("checked",true);
        }
        //添加子节点
        childUl && tempNode.append(childUl);
        //执行自定义操作
        process.custom && process.custom(tempNode,obj,index,layer);
        node.append(tempNode);

        return {hasCheckbox : (!!checkbox),checked : parentParam.checked};
    }
    let node = $("<ul></ul>");
    for (let i = 0; i < data.length; i++) eachFunc(data[i], node,i,1, {open : true, checked : false});
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
        e.stopPropagation();
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
        $(this).ckBoxChange(undefined,e);
    });
}

/**
 * 重新加载树节点,调用该方法前必须要调用过一次 loadTree() 方法
 */
$.fn.reloadTree = function () {
    for (let i = 0; i < this.length; i++) this.loadTree(this[i].loadParam);
}

/**
 * 查询树节点
 * @param name 节点内容
 */
$.fn.queryTree = function (name) {
    //图标改变
    this.find("li.parentLi > span > i.tree-parent-icon").addClass('glyphicon-triangle-right').removeClass('glyphicon-triangle-bottom');
    this.find("li span").css("color","");
    //先把所有的节点收起来
    this.find(" > ul > li").find("li").css("display", "none");
    if (!name || name === '') {
        this.find("li > span:contains('" + name + "')").css("color", "");
        return;
    }
    let select = this.find("li > span:contains('" + name + "')");
    if (name && name !== '') select.css("color","red");
    select.parents('li').parent().children().css("display", "");
    select.parent().parents('li').filter(".parentLi").find(" > span > i.tree-parent-icon").addClass('glyphicon-triangle-bottom').removeClass('glyphicon-triangle-right');
}

/**
 * 获取选中的项
 */
$.fn.getSelect = function () {
    return this.find("li span input.tree-checkbox:checked");
}


/**
 * checkbox改变状态后调用的绑定事件
 * @param func 事件函数
 * @param e event对象
 */
$.fn.ckBoxChangeEvent = function(func,e){
    if (func) for (let i = 0; i < this.length; i++) this[i].cbcef = func;
    else for (let i = 0; i < this.length; i++) this[i].cbcef && this[i].cbcef(e);
}

/**
 * 触发checkbox点击事件
 * @param type 递归调用递归类型
 * @param e event对象
 */
$.fn.ckBoxChange = function (type,e){
    let checked = this.is(":checked");
    !type || this.prop("checked",checked = !checked);
    this.ckBoxChangeEvent(undefined,e);
    let ul = this.closest("ul");
    if (!type || type === "up") {
        //父辈的checkbox
        let parentCheckbox = ul.parent().find(" > span input.tree-checkbox");
        if (parentCheckbox.length > 0) {
            //查看所有同辈checkbox全部选中
            let checkboxTemp = ul.find(" > li > span input.tree-checkbox");
            let count = checkboxTemp.length;
            let selectCount = checkboxTemp.filter(":checked").length;
            let parentCheckboxChecked = parentCheckbox.is(":checked");
            ((parentCheckboxChecked && selectCount < count) || (!parentCheckboxChecked && selectCount === count)) && parentCheckbox.ckBoxChange("up",e);
        }
    }
    if (!type || type === "down") {
        //子级的checkbox
        let childCheckbox = this.closest("li").find(" > ul > li > span input.tree-checkbox");
        if (childCheckbox.length > 0) {
            checked ? childCheckbox.not(":checked").ckBoxChange("down",e) : childCheckbox.filter(":checked").ckBoxChange("down",e);
        }
    }
}
