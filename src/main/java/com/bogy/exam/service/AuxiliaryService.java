package com.bogy.exam.service;

import java.util.HashMap;
import java.util.List;

import com.alibaba.fastjson.JSONObject;

public interface AuxiliaryService {

	HashMap<String, Object> getTableData(HashMap<String, Object> param);

	void addInportData(HashMap<String, Object> paramMap);

	JSONObject getAreaData(HashMap<String, Object> param);

	List<HashMap<String, Object>> getTableDataBySql(HashMap<String, Object> param);

}
