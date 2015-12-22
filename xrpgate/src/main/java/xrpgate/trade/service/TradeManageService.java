package xrpgate.trade.service;

import java.util.Map;


/**
 * 게시물 관리를 위한 서비스 인터페이스  클래스
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
 *
 * </pre>
 */
public interface TradeManageService {

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void deleteRippleTrade(TradeDetailVO tradeDetailVO) throws Exception;

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void insertRippleTrade(TradeDetailVO tradeDetailVO) throws Exception;

    /**
     * 게시물 대하여 상세 내용을   갱신 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public void updateRippleTrade(TradeDetailVO tradeDetailVO) throws Exception;
    
    
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public TradeVO selectTotalBookingRippleTrade(TradeDetailVO tradeDetailVO) throws Exception;
    
    /**
     * 게시물 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public TradeVO selectRippleTrade(TradeDetailVO tradeDetailVO) throws Exception;
    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectRippleTradeList(TradeDetailVO tradeDetailVO) throws Exception;
}
