
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>中国省市区数据</title>
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
<span class="layui-breadcrumb" style="visibility: visible;">
  <a href="javascript:;" onclick="window.parent.location.href='index.do';">首页<span class="layui-box">&gt;</span></a>
  <a><cite>辅助工具</cite><span class="layui-box">&gt;</span></a>
  <a><cite>中国省市区数据</cite></a>
</span>
<!-- <button onclick="downLoadFile()">下载文件demo</button>
<a href="auxiliary.downLoadFile.do">a标签下载文件</a> -->
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">全国</li>
        <li>省份</li>
        <li>城市</li>
        <li>辖区</li>
    </ul>

    <div class="layui-tab-content" style="height: 100px;">
        <div class="layui-tab-item layui-show">
        	<button class="layui-btn" onclick="getJsonData('all')">获取JSON格式数据</button>
            <table id="allArea"></table>
        </div>
        <div class="layui-tab-item">
        	 <button class="layui-btn" onclick="getJsonData('province')">获取JSON格式数据</button>
			 <table id="province"></table>
		</div>
        <div class="layui-tab-item">
        	<form class="layui-form" action="" style="width: 200px;float: left;margin-right: 10px">	
        		<select id="provinceSelect"  lay-filter="province" ></select>
        	</form>
        	<button class="layui-btn" onclick="getJsonData('city')">获取JSON格式数据</button>
			<table id="city"></table>
		</div>
        <div class="layui-tab-item">
        	<form class="layui-form" action="" style="width: 200px;float: left;margin-right: 10px">
        		<select id="citySelect"  lay-filter="city"></select>
        	</form>
        	<button class="layui-btn" onclick="getJsonData('area')">获取JSON格式数据</button>
			<table id="area"></table>
		</div>
    </div>

    </div>

	<div style="display: none;" id="bg-div">
		<div style="position: fixed; top: 0;left: 0;width: 100%;height: 100%;background: rgba(51, 51, 51, 0.5);z-index: 9" id="bg-div-child"></div>	
		<div style="position: fixed; top: 80px;left: 20%;width: 60%;height: 650px;background: white;z-index: 10">
			<div style="text-align: center;padding-top: 20px;font-size: 18px">JSON格式数据</div>
			<div style="padding: 20px">
				<form class="layui-form layui-form-pane" action="">
				  <div class="layui-form-item layui-form-text">
				    <label class="layui-form-label" id="jsonDataDiv-title">文本域</label>
				    <div class="layui-input-block">
				      <textarea placeholder="请输入内容" class="layui-textarea" id="jsonDataDiv" style="height: 500px"></textarea>
				    </div>
				  </div>
				</form>
			</div>
		</div>
	</div>
    
    <div style="display: none;" id="areaDataJson">${areaData}</div>
    <script>
    	var allData=JSON.parse($("#areaDataJson").text());
    	var provinceData,cityData,areaData;
        pushData("allArea","");
        pushData("province","100000");
        pushData("city","440000");
        pushData("area","441900");
        
        
	$("body").bind("keydown",function(event){  
	    if (event.keyCode == 116) {  
	              event.preventDefault(); //阻止默认刷新  
	              //location.reload();  
	              //采用location.reload()在火狐下可能会有问题，火狐会保留上一次链接  
	              location=location;  
	  }  
	}) 
	$("#bg-div-child").click(function(){
			hideBgDiv();
		})
	function hideBgDiv(){
		$("#bg-div").hide();
	}

layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
	form.on('select(province)', function(data){
	  pushData("city",data.value)
	});  
  
  form.on('select(city)', function(data){
	  pushData("area",data.value)
	}); 
})

function pushData(obj,pid){
	var thisData;
	if(pid ==null || pid =='' || pid == 'undefined'){
		thisData=allData.area;
	}else{
		thisData=new Array();
	    for(var p=0;p<allData.area.length;p++){
	    	if(allData.area[p].PARENT_ID == pid){
	    		thisData[thisData.length]=allData.area[p];
	    	}
	    }
	    if(obj.indexOf("province") >=0){
	    	provinceData=thisData;
    	}else if(obj.indexOf("city") >=0){
    		cityData=thisData;
    		var pHtml='';
    		for(var p=0;p<provinceData.length;p++){
    			if(provinceData[p].ID == pid){
    				pHtml += '<option selected value="'+provinceData[p].ID+'">'+provinceData[p].NAME+'</option>';
    			}else{
    				pHtml += '<option value="'+provinceData[p].ID+'">'+provinceData[p].NAME+'</option>';
    			}
    		}
    		$("#provinceSelect").html(pHtml);
    	}else if(obj.indexOf("area") >=0){
    		areaData=thisData;
    		var pHtml='';
    		for(var p=0;p<cityData.length;p++){
    			if(cityData[p].ID == pid){
    				pHtml += '<option selected value="'+cityData[p].ID+'">'+cityData[p].NAME+'</option>';
    			}else{
    				pHtml += '<option value="'+cityData[p].ID+'">'+cityData[p].NAME+'</option>';
    			}
    		}
    		$("#citySelect").html(pHtml);
    	}
	}
	
	layui.use('table', function(){
	    var table = layui.table;
		table.render({
	        elem: '#'+obj
	        ,data: thisData
	        ,cols: [[ //标题栏
	            {checkbox: true, LAY_CHECKED: true} //默认全选
	            ,{field: 'ID', title: 'ID', width: 80, sort: true}
	            ,{field: 'NAME', title: '全称', width: 200}
	            ,{field: 'PARENT_ID', title: '上级ID', width: 150}
	            ,{field: 'SIMPLE_NAME', title: '简称', width: 150}
	            ,{field: 'PINYIN', title: '简称拼音', width: 300}
	            ,{field: 'NAME_PATH', title: '名称路径', width: 500}
	        ]]
	        ,skin: 'row' //表格风格
	        ,even: true
	        ,page: true //是否显示分页
	        ,limits: [10, 20, 50]
	        ,limit: 10 //每页默认显示的数量
	    });
	
	});
}

function getJsonData(type){
	$("#bg-div").show();
	if(type == 'all'){
		$("#jsonDataDiv").val(JSON.stringify(allData));
		$("#jsonDataDiv-title").text("全国")
	}else if(type == 'province'){
		$("#jsonDataDiv").val(JSON.stringify(provinceData));
		$("#jsonDataDiv-title").text("省份")
	}else if(type == 'city'){
		$("#jsonDataDiv").val(JSON.stringify(cityData));
		$("#jsonDataDiv-title").text("城市")
	}else if(type == 'area'){
		$("#jsonDataDiv").val(JSON.stringify(areaData));
		$("#jsonDataDiv-title").text("辖区")
	}
}

/* function downLoadFile(){
	$.ajax({
		url : "auxiliary.downLoadFile.do",
		data:"",
		type:"get",
		success:function(e){
			
		}
		
	})
} */
    </script>

</body>
</html>