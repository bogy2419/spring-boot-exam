<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <title>后台管理系统</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">后台管理系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">消息任务中心</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a href="javascript:;">消息任务列表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">行政区划管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">区划备案</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">界线界桩标志管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">界线界桩可视化</a></dd>
                        <dd><a href="javascript:;">界桩管理</a></dd>
                        <dd><a href="javascript:;">地名标志管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">地名管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">行政审批</a></dd>
                        <dd><a href="javascript:;">行政备案</a></dd>
                        <dd><a href="javascript:;">档案管理</a></dd>
                        <dd><a href="javascript:;">巡查管理</a></dd>
                        <dd><a href="javascript:;">网上专栏管理</a></dd>
                        <dd><a href="javascript:;">专栏首页轮播图管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="javascript:;">标准地址库</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">系统管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="document.getElementById('main_frame').src='system.menu.do';">菜单管理</a></dd>
                        <dd><a href="javascript:;">用户管理</a></dd>
                        <dd><a href="javascript:;">角色管理</a></dd>
                        <dd><a href="javascript:;">组织机构管理</a></dd>
                        <dd><a href="javascript:;">接口管理</a></dd>
                        <dd><a href="javascript:;">预警规则管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="javascript:;" onclick="document.getElementById('main_frame').src='serviceData.do';">接口监测管理</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">辅助工具</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="document.getElementById('main_frame').src='auxiliary.boundary.do';">导入csv数据</a></dd>
                        <dd><a href="javascript:;" onclick="document.getElementById('main_frame').src='auxiliary.exportData.do';">导出数据</a></dd>
                        <dd><a href="javascript:;" onclick="document.getElementById('main_frame').src='auxiliary.areaData.do';">中国省市区数据</a></dd>
                    </dl>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;" class="layui-fluid">
            <iframe id="main_frame" style="border-width: 0;height: 800px" name="content_frame" width=100% marginwidth=0 marginheight=0 src="main.do" ></iframe>
        </div>

    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © jingyi.com - 东莞市民政局版权所有   技术支持：广东精一规划信息科技股份有限公司、东莞市智诚实业有限公司
    </div>
</div>
<script src="layui/jquery.min.js"></script>
<script src="layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    
   $("body").bind("keydown",function(event){  
        if (event.keyCode == 116) {  
                   event.preventDefault(); //阻止默认刷新  
             $("#main_frame").attr("src",window.frames["main_frame"].src);  
            
       }  
   })  
</script>
</body>
</html>