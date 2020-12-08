package com.guigu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class TreeController {

    @RequestMapping("/tree.action")
    public void method01(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();

        writer.write("[\n" +
                "    {\n" +
                "        \"id\" : 1,\n" +
                "        \"name\" : \"系统管理\",\n" +
                "        \"icon\" : \"glyphicon-education\",\n" +
                "        \"list\" : [\n" +
                "            {\n" +
                "                \"id\" : 2,\n" +
                "                \"name\" : \"员工管理\",\n" +
                "                \"icon\" : \"glyphicon-education\",\n" +
                "                \"list\" : [\n" +
                "                    {\n" +
                "                        \"id\" : 3,\n" +
                "                        \"name\" : \"添加员工\",\n" +
                "                        \"icon\" : \"glyphicon-ok\",\n" +
                "                        \"list\" : []\n" +
                "                    },\n" +
                "                    {\n" +
                "                        \"id\" : 4,\n" +
                "                        \"name\" : \"修改员工\",\n" +
                "                        \"icon\" : \"glyphicon-education\",\n" +
                "                        \"list\" : [\n" +
                "                            {\n" +
                "                                \"id\" : 5,\n" +
                "                                \"name\" : \"添加员工xxx\",\n" +
                "                                \"icon\" : \"glyphicon-th\",\n" +
                "                                \"list\" : []\n" +
                "                            },\n" +
                "                            {\n" +
                "                                \"id\" : 6,\n" +
                "                                \"name\" : \"删除员工xxx\",\n" +
                "                                \"icon\" : \"glyphicon-text-background\",\n" +
                "                                \"list\" : []\n" +
                "                            }\n" +
                "                        ]\n" +
                "                    },\n" +
                "                    {\n" +
                "                        \"id\" : 7,\n" +
                "                        \"name\" : \"删除员工\",\n" +
                "                        \"icon\" : \"glyphicon-text-background\",\n" +
                "                        \"list\" : []\n" +
                "                    }\n" +
                "                ]\n" +
                "            },\n" +
                "            {\n" +
                "                \"id\" : 8,\n" +
                "                \"name\" : \"权限管理\",\n" +
                "                \"icon\" : \"glyphicon-text-background\",\n" +
                "                \"list\" : []\n" +
                "            }\n" +
                "        ]\n" +
                "    },\n" +
                "    {\n" +
                "        \"id\" : 9,\n" +
                "        \"name\" : \"商品管理\",\n" +
                "        \"icon\" : \"glyphicon-education\",\n" +
                "        \"list\" : [\n" +
                "            {\n" +
                "                \"id\" : 10,\n" +
                "                \"name\" : \"商品查询\",\n" +
                "                \"icon\" : \"glyphicon-education\",\n" +
                "                \"list\" : []\n" +
                "            },\n" +
                "            {\n" +
                "                \"id\" : 11,\n" +
                "                \"name\" : \"添加商品\",\n" +
                "                \"icon\" : \"glyphicon-refresh\",\n" +
                "                \"list\" : []\n" +
                "            }\n" +
                "        ]\n" +
                "    },\n" +
                "    {\n" +
                "        \"id\" : 12,\n" +
                "        \"name\" : \"销售管理\",\n" +
                "        \"icon\" : \"glyphicon-education\",\n" +
                "        \"list\" : [\n" +
                "            {\n" +
                "                \"id\" : 13,\n" +
                "                \"name\" : \"销售查询\",\n" +
                "                \"icon\" : \"glyphicon-education\",\n" +
                "                \"list\" : [\n" +
                "                    {\n" +
                "                        \"id\" : 14,\n" +
                "                        \"name\" : \"历史记录\",\n" +
                "                        \"icon\" : \"glyphicon-align-center\",\n" +
                "                        \"list\" : []\n" +
                "                    }\n" +
                "                ]\n" +
                "            }\n" +
                "        ]\n" +
                "    },\n" +
                "    {\n" +
                "        \"id\" : 15,\n" +
                "        \"name\" : \"门店管理\",\n" +
                "        \"icon\" : \"glyphicon-bookmark\",\n" +
                "        \"list\" : []\n" +
                "    }\n" +
                "]");
        writer.flush();
        writer.close();
    }
}
