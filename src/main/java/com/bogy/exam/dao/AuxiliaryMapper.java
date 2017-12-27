package com.bogy.exam.dao;

import java.util.HashMap;
import java.util.List;


public interface AuxiliaryMapper {

	List<HashMap<String, Object>> getTableData(HashMap<String, Object> param);

	List<HashMap<String, Object>> getColumnList(HashMap<String, Object> param);

	void addInportData(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> getAreaData(HashMap<String, Object> param);

	List<HashMap<String, Object>> getTableDataBySql(HashMap<String, Object> param);


}
