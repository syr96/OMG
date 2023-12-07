package com.oracle.OMG.dao.yaDao;

import java.util.List;

import com.oracle.OMG.dto.Customer;

public interface YaCustomerDao {

	List<Customer> customerList(Customer customer);

}
