package com.oracle.OMG.service.thService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.thDao.ThReplyDao;
import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.dto.Reply;
import com.oracle.OMG.dto.ReplyPage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class ThReplyServiceImpl implements ThReplyService {

	private final ThReplyDao rd;
	@Override
	public int register(Reply rep) {
		log.info("register..." + rep);
		return rd.insert(rep);
	}

	@Override
	public Reply get(int rep_id) {
		log.info("get..." + rep_id);
		return rd.read(rep_id);
	}

	@Override
	public int modify(Reply rep) {
		log.info("modify..." + rep);
		return rd.update(rep);
	}

	@Override
	public int remove(int rep_id) {
		log.info("remove..." + rep_id);
		return rd.delete(rep_id);
	}

	@Override
	public List<Reply> getList(Criteria cri, int brd_id) {
		log.info("get Reply List of a Board brd_id: " + brd_id);		
		return rd.GetListWithPaging(cri, brd_id);
	}

	@Override
	public ReplyPage getListPage(Criteria cri, int brd_id) {
		log.info("getListPage");
		return new ReplyPage(rd.getCountByBrd_id(brd_id), rd.GetListWithPaging(cri, brd_id));
	}
	
	




	
	
}
