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
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xrpgate.trade.service.AccountDetailVO;
import xrpgate.trade.service.AccountVO;
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


	@Override
	public AccountVO selectAccountInfo(AccountVO accountVO) throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectAccountInfo(accountVO);
	}


	@Override
	public void insertTransactionInfo(AccountVO accountVO) throws Exception {
		// TODO Auto-generated method stub
		tradeMngDAO.insertTransactitionInfo(accountVO);
	}
	
	@Override
	public void deleteTransactionInfo(AccountVO accountVO) throws Exception {
		// TODO Auto-generated method stub
		tradeMngDAO.deleteTransactitionInfo(accountVO);
	}


	@Override
	public ArrayList<AccountVO> selectTransactionInfo(AccountVO accountVO) throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectTransactionInfo(accountVO);
	}


	@Override
	public ArrayList<TradeVO> selectXrpTradeList(TradeVO tradeVo)
			throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectXrpTradeList(tradeVo);
	}


	@Override
	public ArrayList<TradeVO> selectXrpBuyTradeList(TradeVO tradeVo)
			throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectXrpBuyTradeList(tradeVo);
	}


	@Override
	public ArrayList<TradeVO> selectXrpSellTradeList(TradeVO tradeVo)
			throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectXrpSellTradeList(tradeVo);
	}


	@Override
	public ArrayList<TradeVO> selectXrpCompleteTradeList() throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectXrpCompleteTradeList();
	}


	@Override
	public Map<String, Object> selectAdminAccountList(
			AccountDetailVO accountDeatailVo) throws Exception {
		List<AccountVO> list = tradeMngDAO.selectAdminAccountList(accountDeatailVo);
		
		int cnt = tradeMngDAO.selectAdminAccountListCnt(accountDeatailVo);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
	}


	@Override
	public AccountDetailVO selectadminAccountDetail(
			AccountDetailVO accountDeatailVo) throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectAdminAccountDetail(accountDeatailVo);
	}


	@Override
	public void updateMberAccount(AccountVO accountVo) throws Exception {
		
		tradeMngDAO.updateTransactionStatus(accountVo);
		
		if("S03".equals(accountVo.getStatus())){
			
			double requestMoney = accountVo.getTransactionsMoney();
			
			accountVo.setTransactionsMoney(requestMoney - accountVo.getFee());
			
			tradeMngDAO.updateMberAccount(accountVo);
			tradeMngDAO.updateAdminAccount(accountVo);
		}
		
	}
	
	public void insertAdminXrtTrade(TradeDetailVO tradeDetailVo) throws Exception{
		tradeMngDAO.insertAdminXrtTrade(tradeDetailVo);
	}

	@Override
	public Map<String, Object> selectAdminXrpTradeList(TradeDetailVO tradeDetailVo) throws Exception {
		List<TradeDetailVO> list = tradeMngDAO.selectAdminXrpTradeList(tradeDetailVo);
		
		int cnt = tradeMngDAO.selectAdminXrpTradeListCnt(tradeDetailVo);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
	}

	@Override
	public TradeDetailVO selectAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectAdminXrpTrade(tradeDetailVo);
	}

	@Override
	public void updateAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
		
		tradeMngDAO.updateAdminXrpTrade(tradeDetailVo);
	}
	
	@Override
	public void deleteAdminXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
		
		tradeMngDAO.deleteAdminXrpTrade(tradeDetailVo);
	}


	@Override
	public int selectAdminXrpTradeSumQty(TradeDetailVO tradeDetailVo) throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectAdminXrpTradeSumQty(tradeDetailVo);
	}


	@Override
	public HashMap<String, Object> selectXrpTradePrice() throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		TradeDetailVO tradeVo = new TradeDetailVO();
		try{
			// 매수
			tradeVo.setTradeType("B");
			map.put("purchasePrice", tradeMngDAO.selectXrpTradePrice(tradeVo));
			// 매도
			tradeVo.setTradeType("S");
			map.put("SellPrice", tradeMngDAO.selectXrpTradePrice(tradeVo));
			// 시세
			tradeVo.setTradeType("C");
			map.put("marketPrice", tradeMngDAO.selectXrpTradePrice(tradeVo));
			
		}catch (Exception e) {
			System.out.print(e.getMessage());
		}
		return map;
	}


	@Override
	public TradeDetailVO selectMberXrpTrade(TradeDetailVO tradeVo)
			throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectMberXrpTrade(tradeVo);
	}


	@Override
	public int selectMberXrpTradeListCnt(TradeDetailVO tradeVo)
			throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectMberXrpTradeListCnt(tradeVo);
	}


	@Override
	public  Map<String, Object> selectMberXrpTradeList(TradeDetailVO tradeVo)
			throws Exception {
		List<TradeDetailVO> list = tradeMngDAO.selectMberXrpTradeList(tradeVo);
		
		int cnt = tradeMngDAO.selectMberXrpTradeListCnt(tradeVo);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", list);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
	}

	@Override
	public void updateMberXrpTrade(TradeDetailVO tradeVo)
			throws Exception {
		
		try{
			tradeMngDAO.updateMberXrpTradeStatus(tradeVo);
			
			//처리 완료시에만 고객의 계좌 및 회사 계정에 수수료등 처리함.
			// 'P' 간편 거래 수수료 발생
			if("S03".equals(tradeVo.getStatus()) && "P".equals(tradeVo.getTradeType())){
				
				//tradeVo.setRequestMoney(tradeVo.getRequestMoney() + tradeVo.getFee());
				tradeMngDAO.updateMberBuyXrpAccount(tradeVo);
				tradeMngDAO.updateMberBuyXrpByadmin(tradeVo);
			} else {
				// 고객이 직접 xrp 구매및 판매시 수수료  발생하지 않음.
				if("B".equals(tradeVo.getTradeType())){
					tradeMngDAO.updateMberBuyXrpAccount(tradeVo);
				} else {
					tradeMngDAO.updateMberSellXrpAccount(tradeVo);
				}
			}
		} catch (Exception e){
			
		}
	}


	@Override
	public void updateMberBuyXrpAccount(TradeDetailVO tradeVo) throws Exception {
		// TODO Auto-generated method stub
		tradeMngDAO.updateMberBuyXrpAccount(tradeVo);
	}


	@Override
	public void updateMberSellXrpAccount(TradeDetailVO tradeVo)
			throws Exception {
		// TODO Auto-generated method stub
		tradeMngDAO.updateMberSellXrpAccount(tradeVo);
	}


	@Override
	public void updateMberBuyXrpByadmin(TradeDetailVO tradeVo) throws Exception {
		// TODO Auto-generated method stub
		tradeMngDAO.updateMberBuyXrpByadmin(tradeVo);
	}


	@Override
	public void deleteMberXrpTrade(TradeDetailVO tradeVo) throws Exception {
		// TODO Auto-generated method stub
		tradeMngDAO.deleteMberXrpTrade(tradeVo);
	}


	@Override
	public int selectMberXrpTradeSumQty(TradeDetailVO tradeVo) throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectMberXrpTradeSumQty(tradeVo);
	}


	@Override
	public ArrayList<AccountDetailVO> selectAccountTransactionByMber(AccountDetailVO acVo)
			throws Exception {
		// TODO Auto-generated method stub
		return tradeMngDAO.selectAccountTransactionByMber(acVo);
	}


	@Override
	public int selectChkTradeCntByMber(TradeVO tradeVo) throws Exception {
		// TODO Auto-generated method stub
		return  tradeMngDAO.selectChkTradeCntByMber(tradeVo);
	}
	
	
}
