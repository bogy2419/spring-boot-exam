package com.bogy.exam.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.bogy.exam.service.SystemService;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;


@RestController
@EnableAutoConfiguration
public class SystemController {
	@Resource
	private SystemService systemService;

    @RequestMapping("system.menu.do")
    public ModelAndView menu(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap) {
    	return new ModelAndView("system/menu");
    }
    
    @RequestMapping("getMenuData.do")
	@ResponseBody
	public JSONObject getMenuData(@RequestParam HashMap<String, Object> param, HttpServletRequest request) {
		//List<HashMap<String,Object>> menuList= systemService.getMenuData(param);
		JSONObject json = JSONObject.parseObject("");
		return json;
	}
}