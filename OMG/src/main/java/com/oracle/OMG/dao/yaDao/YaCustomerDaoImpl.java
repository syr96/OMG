package com.oracle.OMG.dao.yaDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Customer;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YaCustomerDaoImpl implements YaCustomerDao {
	private final SqlSession session;

	@Override
	public List<Customer> customerList(Customer customer) {
		System.out.println("YaCustomerList dao start....");
		List<Customer>customerList = null;
		try {
			customerList = session.selectList("customerList", customer);
			System.out.println("YaCustomerDaoImpl customerList communityList.size()?"+customerList.size());
		} catch (Exception e) {
			System.out.println("YaCustomerDaoImpl  listCommunity e.getMessage()?"+e.getMessage());
		}
		
		return customerList;
	}
}
