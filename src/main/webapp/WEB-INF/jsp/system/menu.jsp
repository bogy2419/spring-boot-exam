<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<title>菜单管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="layui/jquery.min.js"></script>
    <script src="layui/layui.js"></script>
    <script>
        layui.use('element', function(){
            var $ = layui.jquery
                ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
        });
    </script>
</head>
<body>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->         

<span class="layui-breadcrumb">
  <a href="/">首页</a>
  <a href="javascript:;">系统管理</a>
  <a><cite>菜单管理</cite></a>
</span>

 <div class="layui-row layui-col-space30">
 	<!-- 左边内容区域 -->
    <div class="layui-col-md3">
      <div class="grid-demo grid-demo-bg1">
		<fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
		  <legend>菜单树结构</legend>
		  <div>
		    <ul id="ztree" class="ztree"> </ul> 
		  </div>
		</fieldset>
	  </div>
    </div>
    <!-- 右边内容区域 -->
    <div class="layui-col-md9">
      <div class="grid-demo">
	  	2
	  </div>
    </div>
  </div> 
<script src="layui/jquery.ztree.all.min.js"></script>  
<script>
$(document).ready(function(){
	initMenu();
	
});

function initMenu(){
	$.ajax({
		url:"getMenuData.do",
		type:"post",
		data:"",
		dataType:"json",
		success:function(e){
			$.fn.zTree.init($("#ztree"), setting, e.menu);
			getMenuListByParam(0);
		}
		
	})
}
</script>

</body>
</html>