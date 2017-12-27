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
<span class="layui-breadcrumb" style="visibility: visible;">
  <a href="javascript:;" onclick="window.parent.location.href='index.do';">首页<span class="layui-box">&gt;</span></a>
  <a><cite>辅助工具</cite><span class="layui-box">&gt;</span></a>
  <a><cite>导入csv数据</cite></a>
</span>


<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <!-- <ul class="layui-tab-title">
        <li class="layui-this">导入界线数据</li>
        <li>导入界桩数据</li>
    </ul> -->

    <div class="layui-tab-content" style="height: 100px;">
        <div class="layui-tab-item layui-show">
            	<div class="layui-row">
				    <div class="layui-col-xs6">
				      <div class="grid-demo grid-demo-bg1" style="padding-right: 20px">
				      	<table id="demo"></table>
				      	
						<div class="layui-upload">
						 <button type="button" class="layui-btn layui-btn-normal" id="test8">选择文件</button> 
						  <!-- <input type="file" name="file" id="test8"> -->
						<!--   <button type="button" class="layui-btn" id="test9">开始上传</button> -->
						</div>
					  </div>
				    </div>
				    
				    <div class="layui-col-xs6">
				      <div class="grid-demo">
				      	 <div class="grid-demo grid-demo-bg1">
							<!-- <form class="layui-form" action="">
							  <div class="layui-form-item">
							    <div class="layui-input-inline">
							      <select name="quiz1" onchange="getTableData()" id="tableName">
							        <option value="">请选择</option>
							        <option value="t_point_info">t_point_info</option>
							        <option value="t_boundary_info">t_boundary_info</option>
							      </select>
							     </div>
							  </div>
							</form>
							 -->
						  <table id="demo2"></table>
						  
					      <div>
						      <!-- <select name="quiz1" onchange="getTableData()" id="tableName">
						        <option value="">请选择</option>
						        <option value="T_POINT_INFO">T_POINT_INFO</option>
						        <option value="T_BOUNDARY_INFO">T_BOUNDARY_INFO</option>
						      </select>
						       -->
						      <form class="layui-form" action="" style="width: 200px;float: left;margin-right: 10px">
				        		 <select id="tableName"  lay-filter="tableData">
				        		 	<option value="">请选择</option>
							        <option value="T_POINT_INFO">T_POINT_INFO</option>
							        <option value="T_BOUNDARY_INFO">T_BOUNDARY_INFO</option>
				        		 </select>
				        	  </form>
						  </div>
					      
					    </div>
				      </div>
				    </div>
			  </div>
			  
			  <hr class="layui-bg-blue">
			  
			  <div class="layui-col-xs6 layui-col-md12">
		         <div class="grid-demo grid-demo-bg2">
					
				 </div>
		      </div>
		      <div class="layui-row">
			    <div class="layui-col-xs6">
			        <div class="grid-demo grid-demo-bg1">
						<table id="demo3" class="layui-table"></table>
					</div>
			    </div>
			    <div class="layui-col-xs6">
			        <div class="grid-demo" style="margin:50px auto; width: min-content;">
						<button class="layui-btn layui-btn-normal" onclick="importData();">开始导入</button>
					</div>
			    </div>
			  </div>
        </div>
        <div class="layui-tab-item">内容2</div>
    </div>

    </div>
    
<script>
var inportData;
/* $("#test9").click(function(){
	var picFileList = $("#test8").get(0).files;
	var formData = new FormData();
	if(picFileList.length <= 0){
		return;
	}
    for(var i=0; i< picFileList.length; i++){
        formData.append("file" , picFileList[i] );
    }
	$.ajax({
		 url: "auxiliary.getCsvFileInfo.do",
		 type: "POST",
		 async: false,  
         cache: false,  
         contentType: false,  
         processData: false,  
		 data: formData,
		 success: function(res) {
			 console.log(res)
		      layui.use('table', function(){
		            var table = layui.table;
		            //展示已知数据
		            table.render({
		                elem: '#demo'
		                ,data: res.mainData
		                ,cols: tbl(res.titleList)
		                ,skin: 'row' //表格风格
		                ,even: true
		                ,page: true //是否显示分页
		                ,limits: [10,20, 50]
		                ,limit: 10 //每页默认显示的数量
		            });
		            
		            var html='<thead><tr><th>导入的文件列名</th><th>绑定的数据表列名</th></tr></thead>'
		            html+='<tbody>';
		            for(var i=0;i<res.titleList.length;i++){
		            	html+='<tr>';
		            	html+='<td>'+res.titleList[i]+'</td>';
		            	html+='<td id="'+res.titleList[i]+'"><input type="text" placeholder="请输入字段名" class="layui-input"></td>';
		            	html+='</tr>';
		            }
		            html+='</tbody>';
		            $("#demo3").html(html);
		        });
		 }
	})
}) */

layui.use('upload', function(){
	var $ = layui.jquery
	  ,upload = layui.upload;
	upload.render({
	    elem: '#test8'
	    ,url: 'auxiliary.getCsvFileInfo.do'
    	,accept: 'file' //普通文件
	    ,exts: 'csv' //只允许上传csv
	    ,done: function(res){
	      console.log(res)
	      inportData=res.mainData;
	      layui.use('table', function(){
	            var table = layui.table;
	            //展示已知数据
	            table.render({
	                elem: '#demo'
	                ,data: res.mainData
	                ,cols: tbl(res.titleList)
	                ,skin: 'row' //表格风格
	                ,even: true
	                ,page: true //是否显示分页
	                ,limits: [10,20, 50]
	                ,limit: 10 //每页默认显示的数量
	            });
	            
	            var html='<tr><th>导入的文件列名</th><th>绑定的数据表列名</th></tr>'
	            for(var i=0;i<res.titleList.length;i++){
	            	html+='<tr>';
	            	html+='<td>'+res.titleList[i]+'</td>';
	            	html+='<td id="'+res.titleList[i]+'"><input type="text" placeholder="请输入字段名" class="layui-input"></td>';
	            	html+='</tr>';
	            }
	            $("#demo3").html(html);
	        });
	      
	      
	      
	    
	    }
	  });
  
})   


function tbl(titleList){
	/* var a=[[ //标题栏
        {checkbox: true, LAY_CHECKED: true} //默认全选
        ,{field: 'id', title: 'ID', width: 80, sort: true}
        ,{field: 'username', title: '用户名', width: 120}
        ,{field: 'email', title: '邮箱', width: 150}
        ,{field: 'sign', title: '签名', width: 150}
        ,{field: 'sex', title: '性别', width: 80}
        ,{field: 'city', title: '城市', width: 100}
        ,{field: 'experience', title: '积分', width: 80, sort: true}
    ]] */
	var a1 = new Array();
	var a2 = new Array();
	for(var i=0;i<titleList.length;i++){
		a2[i] = {field: titleList[i], title: titleList[i], width: 150}
	}
	a1[0] = a2;
	return a1;
}

layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form;
	  form.on('select(tableData)', function(data){
		  getTableData(data.value)
		}); 
	})

function getTableData(tableName){
	//var tableName = $("#tableName").val();
	if(tableName == "" || tableName == null || tableName=="undefined"){
		return;
	}
	var data={"tableName":tableName};
	$.ajax({
		url:"auxiliary.getTableData.do",
		type:"get",
		data:data,
		dataType:"json",
		success:function(e){
			console.log(e);
			layui.use('table', function(){
			var table = layui.table;
			//展示已知数据
            table.render({
                elem: '#demo2'
                ,data: e.mainData
                ,cols: tbl(e.titleList)
                ,skin: 'row' //表格风格
                ,even: true
                ,page: true //是否显示分页
                ,limits: [10, 20, 50]
                ,limit: 10 //每页默认显示的数量
            });
			})
			
		}
	})
}

function importData(){
	/* var picFileList = $("#test8").get(0).files;
	var formData = new FormData();
	if(picFileList.length <= 0){
		return;
	}
    for(var i=0; i< picFileList.length; i++){
        formData.append("file" , picFileList[i] );
    } */
    var data={};
	$("#demo3 tbody tr").each(function(){
		//alert($(this).find("td").eq(0).text())
		//alert($(this).find("td").eq(1).find("input").val())
		var dataBaseTitle=$(this).find("td").eq(1).find("input").val();
		if(dataBaseTitle !=null && dataBaseTitle !='' && dataBaseTitle!='undefined'){
			var name=$(this).find("td").eq(0).text();
			data[name] = dataBaseTitle;
		}
	})
	data.tableName= $("#tableName").val();
	data.inportData=JSON.stringify(inportData);
	console.log(data);
	$.ajax({
		 url: "auxiliary.inportData.do",
		 type: "POST",
		 data: data,
		 success: function(res) {
			 if(res.result=="success"){
				 alert("导入数据成功")
			 }
			 console.log(res)
		 }
	})
	
	
}

$("body").bind("keydown",function(event){  
    if (event.keyCode == 116) {  
              event.preventDefault(); //阻止默认刷新  
              //location.reload();  
              //采用location.reload()在火狐下可能会有问题，火狐会保留上一次链接  
              location=location;  
  }  
}) 
</script>

<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  //日期
  laydate.render({
    elem: '#date'
  });
  laydate.render({
    elem: '#date1'
  });
  
  //创建一个编辑器
  var editIndex = layedit.build('LAY_demo_editor');
 
  //自定义验证规则
  form.verify({
    title: function(value){
      if(value.length < 5){
        return '标题至少得5个字符啊';
      }
    }
    ,pass: [/(.+){6,12}$/, '密码必须6到12位']
    ,content: function(value){
      layedit.sync(editIndex);
    }
  });
  
  //监听指定开关
  form.on('switch(switchTest)', function(data){
    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
      offset: '6px'
    });
    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
  });
  
  //监听提交
  form.on('submit(demo1)', function(data){
    layer.alert(JSON.stringify(data.field), {
      title: '最终的提交信息'
    })
    return false;
  });
  
});
</script>

</body>
</html>