package com.oracle.OMG.dao.shDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ShMemberDaoImpl implements ShMemberDao {
	
	private final SqlSession session;

	@Override
	public int createMember(Member member) {
		System.out.println("memberDao createMemeber() Start");
		int result = 0;
		try {
			result = session.insert("shCreateMember",member);
		} catch (Exception e) {
			System.out.println("memberDao createMember() Exception ->" + e.getMessage());
		}
		return result;
	}

}
