package xrpgate.trade.service.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import xrpgate.trade.service.TradeDetailVO;
import xrpgate.trade.service.TradeManageService;
import xrpgate.trade.service.TradeVO;

/**
 * 게시물 관리를 위한 서비스 구현 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일     	수정자           수정내용
 *  -----------    --------    ---------------------------
 *   2009.03.19  	이삼섭          최초 생성
 *	 2011.09.22 	서준식          nttId IdGen 서비스로 변경
 *	 2014.02.21		이기하          답글에 대한 nttId 생성
 * </pre>
 */
@Service("tradeManageService")
public class TradeManageServiceImpl extends EgovAbstractServiceImpl implements TradeManageService {

    @Resource(name = "tradeManageDAO")
    private TradeManageDAO tradeMngDAO;

    @Resource(name = "egovNttIdGnrService")
    private EgovIdGnrService nttIdgenService;

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     *
     * @see egovframework.com.cop.bbs.TradeManageService.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
     */
    public void insertRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	tradeMngDAO.insertRippleTrade(tradeDetailVO);
    }

    
    /**
     * 게시판에 게시물 또는 답변 게시물을  삭제  한다.
     *
     * @see egovframework.com.cop.bbs.TradeManageService.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
     */
    public void deleteRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	tradeMngDAO.deleteRippleTrade(tradeDetailVO);
    }
    
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public TradeVO selectTotalBookingRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	return tradeMngDAO.selectTotalBookingRippleTrade(tradeDetailVO);
    }
	/**
     * 게시물 대하여 상세 내용을 조회 한다.
     *
     * @see egovframework.com.cop.bbs.TradeManageService.service.EgovBBSManageService#selectBoardArticle(egovframework.com.cop.bbs.brd.service.BoardVO)
     */
    public TradeVO selectRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	return tradeMngDAO.selectRippleTrade(tradeDetailVO);
    }

	/**
     * 조건에 맞는 게시물 목록을 조회 한다.
     *
     * @see egovframework.com.cop.bbs.TradeManageService.service.EgovBBSManageService#selectBoardArticles(egovframework.com.cop.bbs.brd.service.BoardVO)
     */
    public Map<String, Object> selectRippleTradeList(TradeDetailVO tradeDetailVO) throws Exception {
		List<TradeVO> list = tradeMngDAO.selectRippleTradeList(tradeDetailVO);
	
		int cnt = tradeMngDAO.selectRippleTradeListCnt(tradeDetailVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }


	@Override
	public void updateRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	tradeMngDAO.updateRippleTrade(tradeDetailVO);
	}
}
