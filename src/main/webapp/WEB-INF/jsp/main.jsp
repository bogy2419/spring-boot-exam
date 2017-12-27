<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>首页</title>
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
<!--<span class="layui-breadcrumb" style="visibility: visible;">
  <a href="/">首页<span class="layui-box">&gt;</span></a>
  <a href="/demo/">演示<span class="layui-box">&gt;</span></a>
  <a><cite>导航元素</cite></a>
</span>-->
<span class="layui-breadcrumb" style="visibility: visible;">
  <a><cite>首页</cite></a>
</span>

<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">全部（40）</li>
        <li>代办事项（10）</li>
        <li>预警任务（5）</li>
        <li>超期任务（0）</li>
        <li>已办事项（25）</li>
    </ul>

    <div class="layui-tab-content" style="height: 100px;">
        <div class="layui-tab-item layui-show">
        	<div class="demoTable">
			  搜索ID：
			  <div class="layui-inline">
			    <input class="layui-input" name="id" id="demoReload" autocomplete="off">
			  </div>
			  <button class="layui-btn" data-type="reload">搜索</button>
			</div>
            <table id="demo"></table>
        </div>
        <div class="layui-tab-item">内容2</div>
        <div class="layui-tab-item">内容3</div>
        <div class="layui-tab-item">内容4</div>
        <div class="layui-tab-item">内容5</div>
    </div>

    </div>
    <script>
        layui.use('table', function(){
            var table = layui.table;

            //展示已知数据
            table.render({
                elem: '#demo'
                ,data: [{
                    "id": "10001"
                    ,"username": "杜甫"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "116"
                    ,"ip": "192.168.0.8"
                    ,"logins": "108"
                    ,"joinTime": "2016-10-14"
                }, {
                    "id": "10002"
                    ,"username": "李白"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "12"
                    ,"ip": "192.168.0.8"
                    ,"logins": "106"
                    ,"joinTime": "2016-10-14"
                    ,"LAY_CHECKED": true
                }, {
                    "id": "10003"
                    ,"username": "王勃"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "65"
                    ,"ip": "192.168.0.8"
                    ,"logins": "106"
                    ,"joinTime": "2016-10-14"
                }, {
                    "id": "10004"
                    ,"username": "贤心"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "666"
                    ,"ip": "192.168.0.8"
                    ,"logins": "106"
                    ,"joinTime": "2016-10-14"
                }, {
                    "id": "10005"
                    ,"username": "贤心"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "86"
                    ,"ip": "192.168.0.8"
                    ,"logins": "106"
                    ,"joinTime": "2016-10-14"
                }, {
                    "id": "10006"
                    ,"username": "贤心"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "12"
                    ,"ip": "192.168.0.8"
                    ,"logins": "106"
                    ,"joinTime": "2016-10-14"
                }, {
                    "id": "10007"
                    ,"username": "贤心"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "16"
                    ,"ip": "192.168.0.8"
                    ,"logins": "106"
                    ,"joinTime": "2016-10-14"
                }, {
                    "id": "10008"
                    ,"username": "贤心"
                    ,"email": "xianxin@layui.com"
                    ,"sex": "男"
                    ,"city": "浙江杭州"
                    ,"sign": "人生恰似一场修行"
                    ,"experience": "106"
                    ,"ip": "192.168.0.8"
                    ,"logins": "106"
                    ,"joinTime": "2016-10-14"
                }]
                ,cols: [[ //标题栏
                    {checkbox: true, LAY_CHECKED: true,fixed: true} //默认全选
                    ,{field: 'id', title: 'ID', width: 80, sort: true,fixed: true}
                    ,{field: 'username', title: '用户名', width: 120}
                    ,{field: 'email', title: '邮箱', width: 150}
                    ,{field: 'sign', title: '签名', width: 150}
                    ,{field: 'sex', title: '性别', width: 80}
                    ,{field: 'city', title: '城市', width: 100}
                    ,{field: 'experience', title: '积分', width: 80, sort: true}
                ]]
                ,id: 'testReload'
                ,page: true //是否显示分页
            });
            
            var $ = layui.$, active = {
            	    reload: function(){
            	      var demoReload = $('#demoReload');
            	      console.log(demoReload.val())
            	      table.reload('testReload', {
            	        where: {
            	          key: {
            	            id: demoReload.val()
            	          }
            	        }
            	      });
            	    }
            	  };
            	  
            	  $('.demoTable .layui-btn').on('click', function(){
            	    var type = $(this).data('type');
            	    console.log(type)
            	    active[type] ? active[type].call(this) : '';
            	  });
            
            
        });
        
        
        
$("body").bind("keydown",function(event){  
    if (event.keyCode == 116) {  
              event.preventDefault(); //阻止默认刷新  
              //location.reload();  
              //采用location.reload()在火狐下可能会有问题，火狐会保留上一次链接  
              location=location;  
  }  
}) 
    </script>

</body>
</html>