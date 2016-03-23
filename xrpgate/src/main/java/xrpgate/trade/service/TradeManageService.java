package xrpgate.trade.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import egovframework.com.uss.umt.service.MberManageVO;




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
    
    /**
     * 회원 계좌 예탁금 수수료율 조회
     * @param accountVO
     * @return
     * @throws Exception
     */
    public AccountVO selectAccountInfo(AccountVO accountVO) throws Exception;
    
    
    /**
     * 회원 계좌에 예탁/인출 거래 신청 정보 입력
     * @param accountVO
     * @throws Exception
     */
    public void insertTransactionInfo(AccountVO accountVO) throws Exception;
    
    /**
     * 회원 계좌에 예탁/인출 거래 신청 정보 삭제
     * @param accountVO
     * @throws Exception
     */
    public void deleteTransactionInfo(AccountVO accountVO) throws Exception;
    
    public ArrayList<AccountVO> selectTransactionInfo(AccountVO accountVO) throws Exception;
    
    /**
     * 회원의 xrp 거래 리스트를 가져온다.
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public ArrayList<TradeVO> selectXrpTradeList(TradeVO tradeVo) throws Exception;
    
    /**
     * 회원의 최근 xrp 매수 거래 리스트를 가져온다.
     * 회원id가 없는 경우 메인페이지에 표시될 리스트임.
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public ArrayList<TradeVO> selectXrpBuyTradeList(TradeVO tradeVo) throws Exception;
    
    /**
     * 회원의 최근 xrp 매도 거래 리스트를 가져온다.
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public ArrayList<TradeVO> selectXrpSellTradeList(TradeVO tradeVo) throws Exception;
    
    /**
     * 회원의 최근 xrp 거래 완료 리스트를 가져온다.
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public ArrayList<TradeVO> selectXrpCompleteTradeList() throws Exception;
    
   
    /**
     * 회원의 계좌 리스트 조회
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectAdminAccountList(AccountDetailVO accountDeatailVo) throws Exception;
    
    /**
     * 회원의 예탁 인출 상세 정보
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    public AccountDetailVO selectadminAccountDetail(AccountDetailVO accountDeatailVo) throws Exception;
    
    /**
     * 회원의 예탁/인출 요청에 대한 처리
     * @param accountVo
     * @throws Exception
     */
    public void updateMberAccount(AccountVO accountVo) throws Exception;
    
    /**
     * xrpGate xrp 거래 등록
     * @param tradeDetailVo
     * @throws Exception
     */
    public void insertAdminXrtTrade(TradeDetailVO tradeDetailVo) throws Exception ;
    /**
     * xrpGate xrp 리스트 조회
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectAdminXrpTradeList(TradeDetailVO tradeDetailVo) throws Exception;
    
    /**
     * xrpGate xrp 거래 정보
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    public TradeDetailVO selectAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception;
    
    /**
     * xrpGate xrp 누적 수량
     * @return
     * @throws Exception
     */
    public int selectAdminXrpTradeSumQty(TradeDetailVO tradeDetailVo) throws Exception;
    
    /**
     * xrpGate xrp 거래 정보 수정
     * @param tradeDetailVo
     * @throws Exception
     */
    public void updateAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception;
    
    /**
     * xrpGate xrp 거래 정보 삭제
     * @param tradeDetailVo
     * @throws Exception
     */
    public void deleteAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception;
    
    /**
     * 매수, 매도, 시세 가격 조회
     * @param tradeType
     * @return
     * @throws Exception
     */
    public HashMap<String, Object> selectXrpTradePrice() throws Exception;
    
    /**
     * 회원 xrp 거래 요청 정보
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public TradeDetailVO selectMberXrpTrade(TradeDetailVO tradeVo) throws Exception;
    
    /**
     * 회원 xrp 거래 리스트 수
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public int selectMberXrpTradeListCnt(TradeDetailVO tradeVo) throws Exception;
    
    /**
     * 회원 xrp 거래 리스트 조회
     * @param accountDeatailVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public Map<String, Object> selectMberXrpTradeList(TradeDetailVO tradeVo) throws Exception;
   	
    /**
     * 회원 xrp 거래 상태 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateMberXrpTrade(TradeDetailVO tradeVo) throws Exception;
    
    /**
     * 회원 xrp 매수 요청 승인에 따른 계좌 정보 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateMberBuyXrpAccount(TradeDetailVO tradeVo) throws Exception;
    
    /**
     * 회원 xrp 매도 요청 승인에 따른 계좌 정보 수정
     * @param accountVo
     * @throws Exception
     */
    public void updateMberSellXrpAccount(TradeDetailVO tradeVo) throws Exception;
    
    /**
     * 회원의 xrp 구매 대행에 대한 수수료 마스터 계정에 추가
     * @param accountVo
     * @throws Exception
     */
    public void updateMberBuyXrpByadmin(TradeDetailVO tradeVo) throws Exception;
    
    /**
     * 회원의 xrp 거래 정보 삭제
     * @param tradeVo
     * @throws Exception
     */
    public void deleteMberXrpTrade(TradeDetailVO tradeVo) throws Exception;
    
    /**
     * 회원의 전체 xrp 거래액
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public int selectMberXrpTradeSumQty(TradeDetailVO tradeVo) throws Exception ;
    
    /**
     * 회원의 계좌 거래내역 리스트
     * @param mberVo
     * @return
     * @throws Exception
     */
    public ArrayList<AccountDetailVO> selectAccountTransactionByMber(AccountDetailVO acVo) throws Exception;
    
    /**
     * 회원의 최근 xrp 구매신청중 처리완료가 안된 거래가 있는지 체크
     * @param tradeVo
     * @return
     * @throws Exception
     */
    public int selectChkTradeCntByMber(TradeVO tradeVo) throws Exception;
}
