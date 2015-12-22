package xrpgate.trade.service.Impl;

import java.util.Iterator;
import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardVO;

import org.springframework.stereotype.Repository;

import xrpgate.trade.service.TradeDetailVO;
import xrpgate.trade.service.TradeVO;

/**
 * 게시물 관리를 위한 데이터 접근 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2011.09.22 서준식          nttId IdGen 서비스로 변경
 * </pre>
 */
@Repository("tradeManageDAO")
public class TradeManageDAO extends EgovComAbstractDAO {

    /**
     * 리플트레이드 매매 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void deleteRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	insert("TradeManageDAO.deleteRippleTrade", tradeDetailVO);
    }
    /**
     * 리플트레이드 매매 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void insertRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	insert("TradeManageDAO.insertRippleTrade", tradeDetailVO);
    }
   
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public TradeVO selectRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	return (TradeVO)select("TradeManageDAO.selectRippleTrade", tradeDetailVO);
    }
    
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public TradeVO selectTotalBookingRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	return (TradeVO)select("TradeManageDAO.selectTotalBookingRippleTrade", tradeDetailVO);
    }

    /**
     *  게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<TradeVO> selectRippleTradeList(TradeDetailVO tradeDetailVO) throws Exception {
    	return (List<TradeVO>) list("TradeManageDAO.selectRippleTradeList", tradeDetailVO);
    }
    /**
     *  게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectRippleTradeListCnt(TradeDetailVO tradeDetailVO) throws Exception {
       	return (Integer)select("TradeManageDAO.selectRippleTradeListCnt", tradeDetailVO);
    }
    /**
     * 게시물에 대한 조회 건수를 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateRippleTrade(TradeDetailVO tradeDetailVO) throws Exception {
    	update("TradeManageDAO.updateRippleTrade", tradeDetailVO);
    }
}
