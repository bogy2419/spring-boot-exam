package com.bogy.exam.controller;

import java.util.HashMap;

import javax.annotation.Resource;

import com.bogy.exam.service.BogyService;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;

@RestController
@EnableAutoConfiguration
public class indexController {
	@Resource
	private BogyService bogyService;

    @RequestMapping("/")
    String home() {
        return "Hello World!";
    }

    @RequestMapping("/hello/{myName}")
    String index(@PathVariable String myName) {
        return "Hello "+myName+"!!!";
    }
    
    @RequestMapping("/index.do")
    public ModelAndView indexPage() {
        return new ModelAndView("index");
    }
    @RequestMapping("main.do")
    public ModelAndView main() {
        return new ModelAndView("main");
    }

    @RequestMapping("serviceData.do")
    public ModelAndView serviceData(@RequestParam HashMap<String, Object> param,HashMap<String, Object> viewMap) {
    	JSONObject json= bogyService.getServiceData();
    	viewMap.put("serviceData", json);
    	return new ModelAndView("service");
    }
}