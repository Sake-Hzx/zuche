
$(window).load(function () {

    //加载菜单tree数据
    $("#tree").tree({
        url:'querymenu.action',
        onClick: function(node){
            //alert(node.text);  // 在用户点击的时候提示

            //带地址的节点点击  才会往下运行
            var url =node.attributes.url;
            if(url==undefined || url==""){
                return;
            }

            if($("#tt").tabs('exists',node.text)){
                //select
                $("#tt").tabs('select',node.text);
            }else{
                //add

                $("#tt").tabs('add',
                    {title:node.text,
                        selected:true,
                        href:node.attributes.url,
                        iconCls:'icon-reload',
                        closable:true});
            }
        }

    });


});