package com.oracle.OMG.dao.chDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Purchase;

import lombok.Data;

@Repository
@Data
public class ChPurDaoImpl implements ChPurDao {
	
	private final SqlSession session;
	
	@Override
	public List<Purchase> purList() {
		System.out.println("ChPurDaoImpl purList start...");
		List<Purchase> purList = null;
		
		try {
			purList = session.selectList("chPurList");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl purList e.getMessage()" + e.getMessage());
		}
		
		return purList;
	}

}
