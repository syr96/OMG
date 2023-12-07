package com.oracle.OMG.service.yaService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.yaDao.YaCustomerDao;
import com.oracle.OMG.dto.Customer;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YaCustomerServiceImpl implements YaCustomerService {
	private final YaCustomerDao ycd;

	@Override
	public List<Customer> customerList(Customer customer) {
		System.out.println("YaCustomerService CustomerList List<Customer> customerList start....");
		
		List<Customer> customerList = ycd.customerList(customer);
		System.out.println("YaCommunityServiceImpl YaCustomerList.size()?"+customerList.size());
		return customerList;
	}
		
		
}
