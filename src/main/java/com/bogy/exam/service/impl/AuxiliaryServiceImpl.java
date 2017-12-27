package com.bogy.exam.service.impl;

import java.util.HashMap;
import java.util.List;

import com.bogy.exam.dao.AuxiliaryMapper;
import com.bogy.exam.service.AuxiliaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;

@Service("auxiliaryService")
public class AuxiliaryServiceImpl implements AuxiliaryService {
	@Autowired
	private AuxiliaryMapper auxiliaryMapper;

	@Override
	public HashMap<String, Object> getTableData(HashMap<String, Object> param) {
		HashMap<String, Object> info=new HashMap<>();
		List<HashMap<String, Object>> list= auxiliaryMapper.getTableData(param);
		List<HashMap<String, Object>> columnList= auxiliaryMapper.getColumnList(param);
		info.put("list", list);
		info.put("columnList", columnList);
		return info;
	}

	@Override
	public void addInportData(HashMap<String, Object> paramMap) {
		auxiliaryMapper.addInportData(paramMap);
	}

	@Override
	public JSONObject getAreaData(HashMap<String, Object> param) {
		if(param.get("parentId") == null) {
			param.put("parentId", 100000);
		}
		JSONObject json=new JSONObject();
		List<HashMap<String, Object>> list=auxiliaryMapper.getAreaData(param);
		json.put("area", list);
		return json;
	}

	@Override
	public List<HashMap<String, Object>> getTableDataBySql(HashMap<String, Object> param) {
		return auxiliaryMapper.getTableDataBySql(param);
	}

	

}
