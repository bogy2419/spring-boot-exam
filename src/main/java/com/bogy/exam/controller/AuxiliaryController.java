package com.bogy.exam.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bogy.exam.service.AuxiliaryService;
import com.bogy.exam.util.ExportUtil;
import org.apache.catalina.core.ApplicationPart;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItem;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.support.StandardMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import oracle.net.aso.e;

@RestController
@EnableAutoConfiguration
public class AuxiliaryController {
    @Resource
    private AuxiliaryService auxiliaryService;

    @RequestMapping("auxiliary.boundary.do")
    public ModelAndView auxiliaryBoundary(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap) {
        //JSONObject json= bogyService.getServiceData();
        //viewMap.put("serviceData", json);
        return new ModelAndView("auxiliary/boundary");
    }

    @RequestMapping("auxiliary.getCsvFileInfo.do")
    public String getCsvFileInfo(@RequestParam("file") MultipartFile files,@RequestParam HashMap<String , Object> param,HttpServletRequest request) throws IllegalStateException, IOException
    {
        JSONObject json=new JSONObject();
        List<HashMap<String, Object>> dataList=new ArrayList<HashMap<String, Object>>();
        List<String> titleList=new ArrayList<String>();
        //得到字节流
        InputStream in = files.getInputStream();
        //将字节流转化成字符流，并指定字符集
        InputStreamReader isr = new InputStreamReader(in,"UTF-8");
        BufferedReader br=null;
        HashMap<String, Object> dataMap;
        try {
            br = new BufferedReader(isr);
            String line = "";
            String firstLine = null;
            while ((line = br.readLine()) != null) {
                dataMap=new HashMap<String, Object>();
                if (firstLine == null) {
                    String titles[]=line.split(",");
                    for(int a=0;a<titles.length;a++) {
                        titleList.add(titles[a]);
                    }
                    firstLine=line;
                }else {
                    String mainData[]=line.split(",");
                    for(int i=0;i<titleList.size();i++) {
                        dataMap.put(titleList.get(i), mainData[i]);
                    }
                    //dataMap.put("1", value)
                    dataList.add(dataMap);
                }
            }

        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            if(br!=null){
                try {
                    br.close();
                    br=null;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        json.put("mainData", dataList);
        json.put("titleList", titleList);
        return json.toJSONString();
    }

    @RequestMapping("auxiliary.getTableData.do")
    public JSONObject getTableData(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap) {
        JSONObject json=new JSONObject();
        List<String> titleList=new ArrayList<String>();
        HashMap<String, Object> info=auxiliaryService.getTableData(param);
        List<HashMap<String, Object>> list=(List<HashMap<String, Object>>) info.get("list");
        List<HashMap<String, Object>> columnList= (List<HashMap<String, Object>>) info.get("columnList");
        for(int i=0;i<columnList.size();i++) {
            titleList.add(columnList.get(i).get("TITLE").toString());
        }
        json.put("mainData", list);
        json.put("titleList", titleList);
        return json;
    }

    @RequestMapping("auxiliary.inportData.do")
    public JSONObject inportData(@RequestParam HashMap<String , Object> param) throws IllegalStateException, IOException
    {
        JSONObject json=new JSONObject();
        String tableName=param.get("tableName").toString();
        String inportData=param.get("inportData").toString();
        JSONArray array=JSONArray.parseArray(inportData);
        System.out.println(array.size());
        List<String> titleList=new ArrayList<String>();
        for(String key:param.keySet()) {
            titleList.add(key);
        }
        for(int i=0;i<array.size();i++) {
            JSONObject data=JSONObject.parseObject(array.get(i).toString());
            HashMap<String, Object> paramMap=new HashMap<String, Object>();
            paramMap.put("tableName", tableName);
            String columnNames="";
            String paramStr="";
            for(String column:param.keySet()) {
                if(data.get(column) !=null) {
                    columnNames += param.get(column)+",";
                    paramStr += "'"+data.get(column)+"'"+",";
                }
            }
            paramMap.put("columnNames", columnNames.substring(0, columnNames.length()-1)); //a,b,c
            paramMap.put("param", paramStr.substring(0, paramStr.length()-1));		//1,2,3
            auxiliaryService.addInportData(paramMap);
        }
    		/*JSONObject json=new JSONObject();
	        List<HashMap<String, Object>> dataList=new ArrayList<HashMap<String, Object>>();
	        List<String> titleList=new ArrayList<String>();
	       
	        HashMap<String, Object> dataMap;
	    
	            String line = ""; 
	            String firstLine = null; 
	           for(int k=0;k<19;k++) {
	            	dataMap=new HashMap<String, Object>();
	            	if (firstLine == null) {
	            		String titles[]=line.split(",");
	            		for(int a=0;a<titles.length;a++) {
	            			titleList.add(titles[a]);
	            		}
	            		firstLine=line;
	            	}else {
		            	String mainData[]=line.split(",");
		            	for(int i=0;i<titleList.size();i++) {
		            		if(param.get(titleList.get(i)) !=null) {
		            			dataMap.put(param.get(titleList.get(i)).toString(), mainData[i]);
		            		}
		            	}
		                dataList.add(dataMap);
		                
		                //拼接参数
		                HashMap<String, Object> paramMap=new HashMap<String, Object>();
		                paramMap.put("tableName", tableName);
		                String columnNames="";
		                String paramStr="";
		                for(String column:dataMap.keySet()) {
		                	columnNames += column+",";
		                	paramStr += "'"+dataMap.get(column)+"'"+",";
		                }
		                paramMap.put("columnNames", columnNames.substring(0, columnNames.length()-1));
		                paramMap.put("param", paramStr.substring(0, paramStr.length()-1));
		                auxiliaryService.addInportData(paramMap);
		                
	            	}
	           }
	 
	        json.put("mainData", dataList);*/
        //json.put("titleList", titleList);
        json.put("result", "success");
        return json;
    }
    //auxiliary.areaData.do
    @RequestMapping("auxiliary.areaData.do")
    public ModelAndView auxiliaryAreaData(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap) {
        JSONObject json= auxiliaryService.getAreaData(param);
        viewMap.put("areaData", json);
        return new ModelAndView("auxiliary/area");
    }

    //base64字符串转成字节实现文件下载
    @RequestMapping("auxiliary.downLoadFile.do")
    public String downLoadFile(HttpServletRequest request,HttpServletResponse response) throws IOException {
        final String userAgent = request.getHeader("USER-AGENT");
        String fileName="这是文件名.png";
        byte[] buffer = Base64.decodeBase64("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");
        String finalFileName = null;
        if(userAgent.equals("MSIE")){//IE浏览器
            finalFileName = URLEncoder.encode(fileName,"UTF8");
        }else if(userAgent.equals("Mozilla")){//google,火狐浏览器
            finalFileName = new String(fileName.getBytes(), "ISO8859-1");
        }else{
            finalFileName = URLEncoder.encode(fileName,"UTF8");//其他浏览器
        }
        response.reset();
        // 先去掉文件名称中的空格,然后转换编码格式为utf-8,保证不出现乱码,这个文件名称用于浏览器的下载框中自动显示的文件名
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=" + finalFileName);
        response.addHeader("Content-Length", "" + buffer.length);
        OutputStream os = new BufferedOutputStream(response.getOutputStream());
        response.setContentType("application/octet-stream");
        os.write(buffer);// 输出文件
        os.flush();
        os.close();
        return null;
    }


    @RequestMapping("auxiliary.exportData.do")
    public ModelAndView exportData(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap) {
        return new ModelAndView("auxiliary/export");
    }

    @RequestMapping("auxiliary.exportSql.do")
    public JSONObject exportSql(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap) {
        JSONObject json=new JSONObject();
        try {
            List<String> titleList=new ArrayList<String>();
            List<HashMap<String, Object>> list=auxiliaryService.getTableDataBySql(param);

            for(String key:list.get(0).keySet()) {
                titleList.add(key);
            }
            json.put("mainData", list);
            json.put("titleList", titleList);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @RequestMapping("auxiliary.exportFile.do")
    public void exportFile(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap,HttpServletResponse response) {
        String fName = param.get("fileName").toString();

        try (final OutputStream os = response.getOutputStream()) {
            List<HashMap<String, Object>> dataList = auxiliaryService.getTableDataBySql(param);
            String sTitle="";
            String mapKey="";
            for(String key : param.keySet()) {
                if(!key.equals("sqlText") && !key.equals("fileName")) {
                    sTitle += param.get(key)+",";
                    mapKey += key+",";
                }
            }
            ExportUtil.responseSetProperties(fName, response);
            ExportUtil.doExport(dataList, sTitle, mapKey, os);

        } catch (Exception e) {
            System.out.println("导出CSV失败");
            e.printStackTrace();
        }
    }
}