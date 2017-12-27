package com.bogy.exam.service.impl;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import com.bogy.exam.dao.BogyMapper;
import com.bogy.exam.service.BogyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@Service("bogyService")
public class BogyServiceImpl implements BogyService {
	@Autowired
	private BogyMapper bogyMapper;

	@Override
	public JSONObject getServiceData() {
		JSONObject info = new JSONObject();
		List<HashMap<String, Object>> serviceList=bogyMapper.getServiceLitenData();
		List<HashMap<String, Object>> serviceLitenList=bogyMapper.serviceLitenList();
		List<String> longgerList=new LinkedList<>();
		List<String> lastTimeList=new LinkedList<>();
		List<String> avgList=new LinkedList<>();
		if(serviceList !=null && serviceList.size()>0) {
			JSONArray jaArray=new JSONArray();
			JSONArray snameList=new JSONArray();
			for (int i = 0; i < serviceList.size(); i++) {
				JSONObject jo=new JSONObject();
				jo.put("name", serviceList.get(i).get("SERVICE_NAME"));
				jo.put("value", serviceList.get(i).get("USE_COUNT"));
				jaArray.add(jo);
				snameList.add(serviceList.get(i).get("SERVICE_NAME"));
				
				longgerList.add(serviceList.get(i).get("MAX_TIME").toString());
				lastTimeList.add(serviceList.get(i).get("LAST_ONCE_USE_TIME").toString());
				avgList.add(serviceList.get(i).get("AVG_TIME").toString());
			}
			info.put("chartsList", snameList);
			info.put("chartsData", jaArray);
			

			info.put("longgerList", longgerList);
			info.put("lastTimeList", lastTimeList);
			info.put("avgList", avgList);
		}
		info.put("serviceLitenList", serviceLitenList);
		return info;
	}

}
