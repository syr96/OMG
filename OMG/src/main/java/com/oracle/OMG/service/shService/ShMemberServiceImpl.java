package com.oracle.OMG.service.shService;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.shDao.ShMemberDao;
import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShMemberServiceImpl implements ShMemberService {

	private final ShMemberDao md;
	
	@Override
	public int createMember(Member member) {
		System.out.println("memberService createMember() Start");
		int result = md.createMember(member);
		return result;
	}


}
