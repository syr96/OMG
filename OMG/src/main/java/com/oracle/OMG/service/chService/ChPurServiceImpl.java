package com.oracle.OMG.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.chDao.ChPurDao;
import com.oracle.OMG.dto.Purchase;

import lombok.Data;

@Service
@Data
public class ChPurServiceImpl implements ChPurService {
	
	private final ChPurDao cpd;

	@Override
	public List<Purchase> purList() {
		System.out.println("ChPurServiceImpl purList Start...");
		
		List<Purchase> purList = cpd.purList();
		
		return purList;
	}

}
