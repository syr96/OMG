package com.oracle.OMG.service.shService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.shDao.ShMemberDao;
import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShMemberServiceImpl implements ShMemberService {

	private final ShMemberDao md;
	
	@Override
	public Member mainMember(int memId) {
		System.out.println("memberService mainMember() Start");
		Member member = md.mainMember(memId);
		return member;
	}
	
	@Override
	public String monthTotalSale() {
		System.out.println("memberService monthTotalSale() Start");
		String monthTotalSale = md.monthTotalSale();
		return monthTotalSale;
	}
	
	@Override
	public String monthTotalPurchase() {
		System.out.println("memberService monthTotalPurchase() Start");
		String monthTotalPurchase = md.monthTotalPurchase();
		return monthTotalPurchase;
	}
	
	@Override
	public List<Member> mainTeamList(int memId) {
		System.out.println("memberService mainTeamList() Start");
		List<Member> teamMember = md.mainTeamList(memId);
		return teamMember;
	}
	
	@Override
	public int createMember(Member member) {
		System.out.println("memberService createMember() Start");
		int result = md.createMember(member);
		return result;
	}

	@Override
	public List<Member> memberList(Member member) {
		System.out.println("memberService memberList() Start");
		List<Member> memberList = md.memberList(member);
		return memberList;
	}

	@Override
	public List<Member> selectStatus() {
		System.out.println("memberService selectStatus() Start");
		List<Member> statusList = md.selectStatus();
		return statusList;
	}
	
	@Override
	public int memberTotal() {
		System.out.println("memberService memberTotal() Start");
		int total = md.memberTotal();
		return total;
	}

	@Override
	public List<Member> memberSearchList(Member member) {
		System.out.println("memberService memberSearchList() Start");
		List<Member> memberList = md.memberSearchList(member);
		return memberList;
	}

	@Override
	public int searchMemberTotal(Member member) {
		System.out.println("memberService searchMemberTotal() Start");
		int total = md.searchMemberTotal(member);
		return total;
	}

	@Override
	public Member searchMemberDetail(int mem_id) {
		System.out.println("memberService searchMemberDetail() Start");
		Member member = md.searchMemberDetail(mem_id);
		return member;
	}

	@Override
	public int updateLeaveMember(Member member) {
		System.out.println("memberService updateLeaveMember() Start");
		int result = md.updateLeaveMember(member);
		return result;
	}

	@Override
	public int updateReinMember(Member member) {
		System.out.println("memberService updateReinMember() Start");
		int result = md.updateReinMember(member);
		return result;
	}

	@Override
	public int updateResiMember(Member member) {
		System.out.println("memberService updateResiMember() Start");
		int result = md.updateResiMember(member);
		return result;
	}

	@Override
	public int updateMember(Member member) {
		System.out.println("memberService updateMember() Start");
		int result = md.updateMember(member);
		return result;
	}

	@Override
	public int detailMember(Member member) {
		System.out.println("memberService detailMember() Start");
		int result = md.detailMember(member);
		return result;
	}


}
