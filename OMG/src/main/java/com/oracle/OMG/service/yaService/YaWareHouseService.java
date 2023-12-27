package com.oracle.OMG.service.yaService;

import java.util.List;

import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Warehouse;

public interface YaWareHouseService {
	List<Warehouse> inventoryList(Warehouse warehouse);
	List<Item> 		itemListSelect(Item item);
	List<Warehouse> 	SearchAll(int code, String month);
	List<Warehouse>		SearchAllInventory(String month);
	List<Warehouse> 	SearchForAllMonths(int code);
	List<Warehouse> 	inventorySearch(int code, String month);
}
