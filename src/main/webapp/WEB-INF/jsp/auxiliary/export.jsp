
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>导出数据</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="layui/jquery.min.js"></script>
    <script src="layui/layui.js"></script>
</head>
<body>
<span class="layui-breadcrumb" style="visibility: visible;">
  <a href="javascript:;" onclick="window.parent.location.href='index.do';">首页<span class="layui-box">&gt;</span></a>
  <a><cite>辅助工具</cite><span class="layui-box">&gt;</span></a>
  <a><cite>导出数据</cite></a>
</span>

<div class="layui-row">
    <div class="layui-col-xs3">
      <div class="grid-demo grid-demo-bg1">
			<fieldset class="layui-elem-field site-demo-button" style="margin-top: 50px;">
			  <legend>查询数据SQL</legend>
			  <form class="layui-form layui-form-pane" action="">    
			    <div class="layui-form-item layui-form-text" style="margin-bottom: 0;">
				    <div class="layui-input-block">
				      <textarea class="layui-textarea" style="border: 0;height: 464px;resize: none;" id="sqlText"> select * from t_member </textarea>
				    </div>
				</div>
			  </form> 
			</fieldset>
	  </div>
    </div>
    <div class="layui-col-xs9">
      <div class="grid-demo">
      	<table id="dataTest" style="margin-top: 53px"></table>
      </div>
    </div>
  </div>
  	<div>
		<button class="layui-btn" onclick="getData();">执行SQL</button>
	</div>
  <div class="layui-row">
    <div class="layui-col-xs12">
      <div class="grid-demo grid-demo-bg1">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			  <legend>已选择导出的字段</legend>
			</fieldset>
			<form class="layui-form layui-form-pane" action="">    
			    <div class="layui-form-item layui-form-text" style="margin-bottom: 0;">
				    <div class="layui-input-block">
				      <table id="expColumn" class="layui-table">
				      	
				      </table>
				    </div>
				</div>
		  	</form> 
	  </div>
    </div>
  </div>

<div>
	
	<div class="layui-inline">
      <label class="layui-form-label">文件名称</label>
      <div class="layui-input-inline">
       	<input class="layui-input" style="width: auto; display: initial;margin-right: 10px" type="text" id="fileName" value="fileName">
       	<button class="layui-btn" onclick="expData();">开始导出</button>	
      </div>
    </div>
</div>
<div>
<table id="columnTable" style="margin-top: 53px"></table>
<input type="hidden" id="columnData">
</div>
<script>
layui.use(['form'], function(){
	  var form = layui.form
	  ,layer = layui.layer;
	  
	  //监听指定开关
	  form.on('switch(switchTest)', function(data){
	    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
	      offset: '6px'
	    });
	    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
	  });
	  
});

var expColumnList=[];
function getData(){
	var sqlText=$("#sqlText").val();
	$("#expColumn").html('');
	$.ajax({
		url:"auxiliary.exportSql.do",
		data:{"sqlText":sqlText},
		type:"post",
		dataType:"json",
		success:function(e){
			layui.use('table', function(){
			    var table = layui.table;
			    //展示已知数据
			    table.render({
			        elem: '#dataTest'
			        ,data: e.mainData
			        ,cols: tbl(e.titleList)
			        ,skin: 'row' //表格风格
			        ,even: true
			        ,page: true //是否显示分页
			        ,limits: [10,20, 50]
			        ,limit: 10 //每页默认显示的数量
			    });
			    
			    $("table thead tr th").click(function(){
			    	//alert($(this).attr("data-field"))
			    	var itemIndex=$.inArray($(this).attr("data-field"), expColumnList);
			    	if(itemIndex >=0){
			    		expColumnList.splice(itemIndex,1);
			    		$(this).css("color","#000");
			    	}else{
				    	expColumnList.push($(this).attr("data-field"));
				    	$.unique(expColumnList); 
				    	$(this).css("color","#5fb878");
			     	}
			    	var html='<thead><tr>';
			    	for(var i=0;i<expColumnList.length;i++){
			    		html+='<td>'+expColumnList[i]+'</td>';
			    	}
			    	html+='</tr></thead>';
			    	$("#expColumn").html(html);
			    	var inputHtml='<tr>';
			    	$("#expColumn thead tr td").each(function(e){
			    		inputHtml+='<td><input class="layui-input" style="border:none;" type="text" value="'+$(this).text()+'"></td>';
			    	})
			    	inputHtml+='</tr>';
			    	$("#expColumn").append(inputHtml);
			    	
			    })
			});
			
			
		}
	})
	
}
function tbl(titleList){
	var a1 = new Array();
	var a2 = new Array();
	a2[0]={checkbox: true, LAY_CHECKED: true,fixed: true};
	for(var i=0;i<titleList.length;i++){
		a2[a2.length] = {field: titleList[i], title: titleList[i], width: 150};
	}
	a1[0] = a2;
	return a1;
}

function expData(){
	var jsonParam='',input='';
	$("#expColumn thead tr td").each(function(e){
		//jsonParam[$(this).text()] = $("#expColumn tbody tr td").eq(e).find("input").val();
		jsonParam+='&'+$(this).text()+'='+$("#expColumn tbody tr td").eq(e).find("input").val();
		input+='<input type="hidden" name="'+$(this).text()+'" value="'+$("#expColumn tbody tr td").eq(e).find("input").val()+'">';
	})
	//jsonParam['sqlText'] = $("#sqlText").val();
	jsonParam+='&sqlText='+$("#sqlText").val();
	input+='<input type="hidden" name="sqlText" value="'+$("#sqlText").val()+'">';
	input+='<input type="hidden" name="fileName" value="'+$("#fileName").val()+'">';
	
	 var iframe = $('<iframe name="exp_hide_" />');
	 var form = $('<form method="post" style="display:none;" target="exp_hide_" action="auxiliary.exportFile.do"  name="exp_hide_" enctype="multipart/form-data" />');
	 form.append(input)
	 $(document.body).append(iframe).append(form);
     form.submit();//表单提交   
	
	/* $.ajax({
		url:'auxiliary.exportFile.do',
		type:'post',
		data:jsonParam,
		dataType:'json',
		success:function(e){
			alert(2)
			console.log(e);
		}
	}) */
	
}

</script>
</body>
</html>