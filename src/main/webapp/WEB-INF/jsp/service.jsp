<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>接口监测</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="layui/jquery.min.js"></script>
    <script src="layui/layui.js"></script>
</head>
<body>
<span class="layui-breadcrumb" style="visibility: visible;">
  <a href="/">首页<span class="layui-box">&gt;</span></a>
  <a href="/demo/">系统管理<span class="layui-box">&gt;</span></a>
  <a><cite>接口管理</cite></a>
</span>

<div class="layui-row">
    <div class="layui-col-xs6" id="main" style="width: 50%;height: 400px;padding: 20px">
      
    </div>
    <div class="layui-col-xs6" id="main2" style="width: 50%;height: 400px;padding: 20px">
      
    </div>
</div>

<table id="demo"></table>
<div style="display: none;" id="serviceLitenListData">${serviceData}</div>
<script>
   	var data=JSON.parse($("#serviceLitenListData").text());
   	var serviceLitenList=data.serviceLitenList;

    layui.use('table', function(){
        var table = layui.table;

        //展示已知数据


        table.render({
            elem: '#demo'
            ,data: serviceLitenList
            ,cols: [[ //标题栏
                {field: 'ID', title: 'ID', width: 120, sort: true}
                ,{field: 'SERVICE_NAME', title: '接口名称', width: 200}
                ,{field: 'SERVICE_PARAM', title: '测试参数', width: 200}
                ,{field: 'RESPONSE_KEY', title: '返回值的key', width: 150}
                ,{field: 'SERVICE_ENABLE', title: '启用状态', width: 120,templet:'#enableValue'}
                ,{field: 'REMARK', title: '备注说明', width: 200}
                ,{field: 'CREATE_TIME', title: '创建时间', width: 200, sort: true}
                ,{field: 'LAST_UPDATE_TIME', title: '最后一次更新时间', width: 200, sort: true}
                ,{field: 'USE_COUNT', title: '调用次数', width: 100, sort: true}
            ]]
            ,skin: 'row' //表格风格
            ,even: true
            ,page: true //是否显示分页
            ,limits: [5, 7, 10]
            ,limit: 5 //每页默认显示的数量
        });
    });
</script>
<script type="text/html" id="enableValue">
  {{#  if(d.SERVICE_ENABLE == 1){ }}
    	启用
  {{#  } else { }}
   		停用
  {{#  } }}
</script>


<script src="layui/echarts.common.min.js"></script>
<script>
var chartsList=data.chartsList;
var chartsData=data.chartsData;

var myChart = echarts.init(document.getElementById('main'));
var option = {
    title : {
        text: '接口调用次数统计',
        subtext: '次数（占用总次数比例）',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        type: 'scroll',
        orient: 'vertical',
        right: 10,
        top: 20,
        bottom: 20,
        data: chartsList
    },
    series : [
        {
            name: '接口被调用次数',
            type: 'pie',
            radius : '60%',
            center: ['42%', '50%'],
            data: chartsData,
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
};
myChart.setOption(option);
</script>
<script>
var chartsList=data.chartsList;
var longgerList=data.longgerList;
var lastTimeList=data.lastTimeList;
var avgList=data.avgList;
var myChart2 = echarts.init(document.getElementById('main2'));
var option2 = {
    title: {
        text: '接口响应耗时统计',
        subtext: '耗时（ms）'
    },
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'shadow'
        }
    },
    legend: {
        data: ['最长耗时', '最近一次耗时','平均耗时']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis: {
        type: 'value',
        boundaryGap: [0, 0.01]
    },
    yAxis: {
        type: 'category',
        data: chartsList
    },
    series: [
        {
            name: '最长耗时',
            type: 'bar',
            data: longgerList
        },
        {
            name: '最近一次耗时',
            type: 'bar',
            data: lastTimeList
        }, {
            name: '平均耗时',
            type: 'bar',
            data: avgList
        }
    ]
};
myChart2.setOption(option2);


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