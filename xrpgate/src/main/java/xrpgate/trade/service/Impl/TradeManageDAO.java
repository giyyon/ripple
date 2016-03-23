package xrpgate.trade.service.Impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.uss.umt.service.MberManageVO;

import org.antlr.grammar.v3.ANTLRParser.exceptionGroup_return;
import org.springframework.stereotype.Repository;

import xrpgate.trade.service.AccountDetailVO;
import xrpgate.trade.service.AccountVO;
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
    
    
    /** 회원 계좌의 예탁금 및 수수료율 조회
     * @param accountVO
     * @return
     * @throws Exception
     */
    public AccountVO selectAccountInfo(AccountVO accountVO) throws Exception {
    	
    	return (AccountVO) select("TradeManageDAO.selectAccountInfo", accountVO);
    }
    
    /**
     * 회원 계좌 예탁/ 인출 신청 저장
     * @param accountVO
     * @throws Exception
     */
    public void insertTransactitionInfo(AccountVO accountVO) throws Exception{
    	
    	insert("TradeManageDAO.insertTransactionInfo", accountVO);
    }
    
    /**
     * 회원 계좌 예탁/ 인출 신청 삭제
     * @param accountVO
     * @throws Exception
     */
    public void deleteTransactitionInfo(AccountVO accountVO) throws Exception{
    	
    	delete("TradeManageDAO.deleteTransactionInfo", accountVO);
    }
    
    @SuppressWarnings("unchecked")
	public ArrayList<AccountVO> selectTransactionInfo(AccountVO accountVO) throws Exception {
    	return (ArrayList<AccountVO>) list("TradeManageDAO.selectTransactionInfo", accountVO);
    }
    
    @SuppressWarnings("unchecked")
	public ArrayList<TradeVO> selectXrpTradeList(TradeVO tradeVo) throws Exception {
    	return (ArrayList<TradeVO>) list("TradeManageDAO.selectXrpTradeList", tradeVo);
    }
    
    @SuppressWarnings("unchecked")
	public ArrayList<TradeVO> selectXrpBuyTradeList(TradeVO tradeVo) throws Exception {
    	return (ArrayList<TradeVO>) list("TradeManageDAO.selectXrpBuyTrade", tradeVo);
    }
    
    @SuppressWarnings("unchecked")
	public ArrayList<TradeVO> selectXrpSellTradeList(TradeVO tradeVo) throws Exception {
    	return (ArrayList<TradeVO>) list("TradeManageDAO.selectXrpSellTrade", tradeVo);
    }
    
    @SuppressWarnings("unchecked")
	public ArrayList<TradeVO> selectXrpCompleteTradeList() throws Exception {
    	return (ArrayList<TradeVO>) list("TradeManageDAO.selectXrpCompleteTrade");
    }
    
    /**
     * 예탁/인출 리스트 수
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public int selectAdminAccountListCnt(AccountDetailVO accountDeatailVo) throws Exception {
    	return (Integer) select("TradeManageDAO.selectAdminAccountListCnt", accountDeatailVo);
    }
    
    /**
     * 예탁/인출 리스트 조회
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public ArrayList<AccountVO> selectAdminAccountList(AccountDetailVO accountDeatailVo) throws Exception {
       	return (ArrayList<AccountVO>) list("TradeManageDAO.selectAdminAccountList", accountDeatailVo);
       }
    
    /**
     * 예탁/인출 상세 정보
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    public AccountDetailVO selectAdminAccountDetail(AccountDetailVO accountDeatailVo) throws Exception {
    	return (AccountDetailVO) select("TradeManageDAO.selectAdminAccountDetail",accountDeatailVo);
    }
    
    /**
     * 예탁/인출 요청에 대한 상태 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateTransactionStatus(AccountVO accountVo) throws Exception {
    	update("TradeManageDAO.updateMberTransaction", accountVo);
    }
    
    /**
     * 예탁/인출 요청에 대한 회원의 계좌 정보 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateMberAccount(AccountVO accountVo) throws Exception {
    	update("TradeManageDAO.updateMberAccount", accountVo);
    }
    
    /**
     * 회원의 예탁/인출 요청에 대한 수수료 마스터 계정에 추가
     * @param accountVo
     * @throws Exception
     */
    public void updateAdminAccount(AccountVO accountVo) throws Exception {
    	update("TradeManageDAO.updateAdminAccount", accountVo);
    }
    
    /**
     * xrpGate xrp 거래 등록
     * @param tradeDetailVo
     * @throws Exception
     */
    public void insertAdminXrtTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	insert("TradeManageDAO.insertAdminXrpTrade",tradeDetailVo);
    }
    /**
     * xrpGate xrp 거래수
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public int selectAdminXrpTradeListCnt(TradeDetailVO tradeDetailVo) throws Exception {
    	return (Integer) select("TradeManageDAO.selectAdminXrpTradeListCnt", tradeDetailVo);
    }
    
    /**
     * xrpGate xrp 누적 수량
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public int selectAdminXrpTradeSumQty(TradeDetailVO tradeDetailVo) throws Exception {
    	return (Integer) select("TradeManageDAO.selectAdminXrpTradeSumQty", tradeDetailVo);
    }
    
    /**
     * xrpGate xrp 리스트 조회
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public ArrayList<TradeDetailVO> selectAdminXrpTradeList(TradeDetailVO tradeDetailVo) throws Exception {
       	return (ArrayList<TradeDetailVO>) list("TradeManageDAO.selectAdminXrpTradeList", tradeDetailVo);
       }
    
    /**
     * xrpGate xrp 거래 정보
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    public TradeDetailVO selectAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	return (TradeDetailVO) select("TradeManageDAO.selectAdminXrpTrade",tradeDetailVo);
    }
    
    /**
     * xrpGate xrp 거래 정보 수정
     * @param tradeDetailVo
     * @throws Exception
     */
    public void updateAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	update("TradeManageDAO.updateAdminXrpTrade", tradeDetailVo);
    }
    
    /**
     * xrpGate xrp 거래 정보 삭제
     * @param tradeDetailVo
     * @throws Exception
     */
    public void deleteAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	update("TradeManageDAO.deleteAdminXrpTrade", tradeDetailVo);
    }
    
    /**
     * 매수, 매도, 시세 조회
     * @param tradeType
     * @return
     * @throws Exception
     */
    public String selectXrpTradePrice(TradeDetailVO tradeVo) throws Exception {
    	
    	return (String) select("TradeManageDAO.selectXrpTradePrice", tradeVo);
    }
    
    /**
     * 회원 xrp 거래 요청 정보
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public TradeDetailVO selectMberXrpTrade(TradeDetailVO tradeVo) throws Exception {
    	return  (TradeDetailVO) select("TradeManageDAO.selectMberXrpTrade", tradeVo);
    }
    
    /**
     * 회원 xrp 거래 리스트 수
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public int selectMberXrpTradeListCnt(TradeDetailVO tradeVo) throws Exception {
    	return (Integer) select("TradeManageDAO.selectMberXrpTradeListCnt", tradeVo);
    }
    
    /**
     * 회원 xrp 거래 리스트 조회
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public ArrayList<TradeDetailVO> selectMberXrpTradeList(TradeDetailVO tradeVo) throws Exception {
       	return (ArrayList<TradeDetailVO>) list("TradeManageDAO.selectMberXrpTradeList", tradeVo);
       }
    
    
    /**
     * 회원 xrp 거래 상태 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateMberXrpTradeStatus(TradeDetailVO tradeVo) throws Exception {
    	update("TradeManageDAO.updateMberXrpTrade", tradeVo);
    }
    
    /**
     * 회원 xrp 매수 요청 승인에 따른 계좌 정보 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateMberBuyXrpAccount(TradeDetailVO tradeVo) throws Exception {
    	//update("TradeManageDAO.updateMberBuyXrpAccount", tradeVo);
    	//고객의 임시 요구로 거래 완료 승인후 계좌 정보 초기화
    	// 정상으로 백업시 위 쿼리문 호출함.
    	update("TradeManageDAO.updateMberBuyXrpAccountTemp", tradeVo);
    }
    
    
    /**
     * 회원 xrp 매도 요청 승인에 따른 계좌 정보 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateMberSellXrpAccount(TradeDetailVO tradeVo) throws Exception {
    	//update("TradeManageDAO.updateMberSellXrpAccount", tradeVo);
    	//고객의 임시 요구로 거래 완료 승인후 계좌 정보 초기화
    	// 정상으로 백업시 위 쿼리문 호출함.
    	update("TradeManageDAO.updateMberSellXrpAccountTemp", tradeVo);
    }
    
    /**
     * 회원의 xrp 구매 대행에 대한 수수료 마스터 계정에 추가
     * @param accountVo
     * @throws Exception
     */
    public void updateMberBuyXrpByadmin(TradeDetailVO tradeVo) throws Exception {
    	update("TradeManageDAO.updateMberBuyXrpByadmin", tradeVo);
    }
    
    /**
     * 회원의 xrp 거래 정보 삭제
     * @param tradeVo
     * @throws Exception
     */
    public void deleteMberXrpTrade(TradeDetailVO tradeVo) throws Exception {
    	delete("TradeManageDAO.deleteMberXrpTrade",tradeVo);
    }
    
    /**
     * 회원의 전체 xrp 거래액
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public int selectMberXrpTradeSumQty(TradeDetailVO tradeVo) throws Exception {
    	return (Integer) select("TradeManageDAO.selectMberXrpTradeSumQty",tradeVo);
    }
    
    /**
     * 회원의 계좌 거래 내역 리스트
     * @param mberVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public ArrayList<AccountDetailVO> selectAccountTransactionByMber(AccountDetailVO acVo) throws Exception{
    	return (ArrayList<AccountDetailVO>) list("TradeManageDAO.selectAccountTransactionByMber", acVo);
    }
    
    /**
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public int selectChkTradeCntByMber(TradeVO tradeVo) throws Exception{
    	return (Integer) select("TradeManageDAO.selectChkTradeCntByMber",tradeVo);
    }
}
