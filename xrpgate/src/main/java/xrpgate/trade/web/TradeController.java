package xrpgate.trade.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.antlr.grammar.v3.ANTLRParser.exceptionGroup_return;
import org.apache.commons.lang.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import xrpgate.admin.web.service.AdminAccountVO;
import xrpgate.admin.web.service.AdminMgmtService;
import xrpgate.customer.web.CustomerController;
import xrpgate.trade.service.AccountVO;
import xrpgate.trade.service.TradeDetailVO;
import xrpgate.trade.service.TradeManageService;
import xrpgate.trade.service.TradeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSCommentService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.cop.bbs.service.EgovBBSSatisfactionService;
import egovframework.com.cop.bbs.service.EgovBBSScrapService;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



@Controller
@RequestMapping(value = "/trade")
public class TradeController implements ApplicationContextAware, InitializingBean {
	
	//protected Logger log = Logger.getLogger(this.getClass());
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);
	//protected Logger logger = Logger.getLogger(this.getClass());

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;    // egovframework.com.cmm.service.EgovProperties.java
    
    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;
    
    @Resource(name = "tradeManageService")
    private TradeManageService tradeManageService;
    
    @Resource(name = "adminMgmtService")
    private AdminMgmtService adminMgmtService;
    
    
	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

    //---------------------------------
    // 2009.06.29 : 2단계 기능 추가
    // 2011.07.01 : 댓글, 스크랩, 만족도 조사 기능의 종속성 제거
    //---------------------------------
    @Autowired(required=false)
    private EgovBBSCommentService bbsCommentService;
    
    @Autowired(required=false)
    private EgovBBSSatisfactionService bbsSatisfactionService;
    
    @Autowired(required=false)
    private EgovBBSScrapService bbsScrapService;
    
	@Override
	public void afterPropertiesSet() throws Exception {

		// TODO Auto-generated method stub
		
	}

	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {

		// TODO Auto-generated method stub
		
	}
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String index(ModelMap model) {
		return "basic_customer/noticeList";
	}
	
    /**
     * 리플 트레이드 판매 신청 화면 이동.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callRippleTradeSellModify.do")
    public String callRippleTradeSellModify(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	MberManageVO mberManageVO = null;
		//로그인유저
		mberManageVO = mberManageService.selectMberById(user.getId());
		
        boardVO.setMoblphonNo(mberManageVO.getMoblphonNo());
        boardVO.setNtcrNm(user.getName());
		
    	model.addAttribute("boardVO", boardVO);
    	return ".basic_trade/rippleTradeSell";
    }	
    
	
    /**
     * 리플 트레이드 예탁 화면 이동.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callAccountTransactions.do")
    public String callAccountTransactions( ModelMap model, HttpServletRequest request) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
    	AccountVO accountVO = new AccountVO();
    	ArrayList<AccountVO> listVo = new ArrayList<AccountVO>();
    	
    	LoginVO loginVo = (LoginVO) request.getSession().getAttribute("loginVO");
    	
		AdminAccountVO adminAccountVo = new AdminAccountVO();
		HashMap<String, Object> mapXrpPrice = new HashMap<String, Object>();
    	try {
    		accountVO.setMberId(user.getId());
        	
    		// 최근 3번째까지의 계좌 예탁/인출 정보
        	listVo = tradeManageService.selectTransactionInfo(accountVO);
        	
        	accountVO = tradeManageService.selectAccountInfo(accountVO);
        	
        	//xrpgate 계좌 정보 
    		adminAccountVo = adminMgmtService.selectRippleAccountInfo();
    		// 시세 정보 조회
    		mapXrpPrice = tradeManageService.selectXrpTradePrice();
    	} catch( Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	model.addAttribute("accountVO", accountVO);
    	model.addAttribute("listVo", listVo);
		model.addAttribute("user", loginVo);
		model.addAttribute("adminAccountVo", adminAccountVo);
		model.addAttribute("xrpPrice", mapXrpPrice);
    	return ".basic_trade/rippleAccountTrade";
    }	
    
    /**
     * 예탁 / 인출 거래 요청 정보를 저장한다.
     * @param accountVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value="insertTransactionInfo.do")
    @ResponseBody
    public HashMap<String, Object> insertTransactionInfo(AccountVO accountVO) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	
    	try{
    		accountVO.setMberId(user.getId());
    		
    		tradeManageService.insertTransactionInfo(accountVO);
    		
    		ArrayList<AccountVO> listVo = tradeManageService.selectTransactionInfo(accountVO);
    		
    		map.put("isSuccess", true);
    		map.put("listVo", listVo);
    	} catch(Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	
    	return map;
    }
    
    /**
     * 예탁 / 인출 거래 요청 정보를 저장한다.
     * @param accountVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value="deleteTransactionInfo.do")
    @ResponseBody
    public HashMap<String, Object> deleteTransactionInfo(AccountVO accountVO) throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	
    	try{
    		accountVO.setMberId(user.getId());
    		
    		tradeManageService.deleteTransactionInfo(accountVO);
    		
    		ArrayList<AccountVO> listVo = tradeManageService.selectTransactionInfo(accountVO);
    		
    		map.put("isSuccess", true);
    		map.put("listVo", listVo);
    	} catch(Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	
    	return map;
    }
	
    /**
     * 리플 트레이드 신청을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/insertXrpTrade.do")
    @ResponseBody
    public HashMap<String, Object> insertRippleTradeSell(
            @ModelAttribute("tradeDetailVO") TradeDetailVO tradeDetailVO,
            RedirectAttributes redirectAttributes,
            ModelMap model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		HashMap<String, Object> map = new HashMap<String, Object>();

		ArrayList<TradeVO> tradeList = new ArrayList<TradeVO>();
		
		String message = "";
		
		try {
			tradeDetailVO.setRequestErId(user.getId());
			tradeManageService.insertRippleTrade(tradeDetailVO);
			
			tradeList = tradeManageService.selectXrpTradeList(tradeDetailVO);
			
			if("S".equals(tradeDetailVO.getTradeType())){
				message = "리플 판매 신청이 등록되었습니다.\n처리완료되면 게이트허브 개인지갑이나 고객님 개인의 \n계좌내역을 확인해주세요";
			} else if("B".equals(tradeDetailVO.getTradeType())) {
				message = "리플 구매 신청이 등록되었습니다.\n처리완료되면 게이트허브 개인지갑이나 고객님 개인의 \n계좌내역을 확인해주세요";
			} else {
				message = "리플 구매 대행 신청이 등록되었습니다.\n처리완료되면 게이트허브 개인지갑이나 고객님 개인의 \n계좌내역을 확인해주세요";
			}
			
			map.put("isSuccess", true);
			map.put("tradeList", tradeList);
			map.put("message", message);
		} catch(Exception e){
			map.put("isSuccess", false);
		}
		return map;
	}    
    
    /**
     * 리플 트레이드 구매 신청을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/insertRippleTradeBuy.do")
    public String insertRippleTradeBuy(
          @ModelAttribute("tradeDetailVO") TradeDetailVO tradeDetailVO,
          RedirectAttributes redirectAttributes,
          ModelMap model) throws Exception {
		
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		//로그인유저
		tradeDetailVO.setTradeType("B");
		tradeDetailVO.setRequestErId(user.getId());
	    
		tradeManageService.insertRippleTrade(tradeDetailVO);	
		
		//model.addAttribute("message", "전화상담이 등록되었습니다. 상담 담당자가 등록하신 연락처로 연락드리겠습니다.");
		redirectAttributes.addFlashAttribute("message","리플 구매 신청이 등록되었습니다. 처리 결과는 마이페이지에서 확인 가능합니다.");
		
		return "redirect:/";
    }    
    
    
    /**
     * 게시물에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/Inqire.do")
    public String noticeInqire(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	// 조회수 증가 여부 지정
	boardVO.setPlusCount(true);

	//---------------------------------
	// 2009.06.29 : 2단계 기능 추가
	//---------------------------------
	if (!boardVO.getSubPageIndex().equals("")) {
	    boardVO.setPlusCount(false);
	}
	////-------------------------------

	//공지사항 게시판 아이디 : BBSMSTR_000000000001
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000001");
	
	// 이전 / 이후 게시물 id 조회
//	if("prev".equals(boardVO.getArticleDirection()) || ("next".equals(boardVO.getArticleDirection()))
//			boardVO.setNttId(nttId);BbsId("BBSMSTR_000000000001");
//		

	if(user != null)
		boardVO.setLastUpdusrId(user.getUniqId());
	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", vo);

	
	//CommandMap의 형태로 개선????

//	model.addAttribute("sessionUniqId", user.getUniqId());

	//----------------------------
	// template 처리 (기본 BBS template 지정  포함)
	//----------------------------
	BoardMasterVO master = new BoardMasterVO();
	
	master.setBbsId(boardVO.getBbsId());
//	master.setUniqId(user.getUniqId());
	
	BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);

	if (masterVo.getTmplatCours() == null || masterVo.getTmplatCours().equals("")) {
	    masterVo.setTmplatCours("/css/egovframework/com/cop/tpl/egovBaseTemplate.css");
	}

	model.addAttribute("brdMstrVO", masterVo);
	////-----------------------------
	
	//----------------------------
	// 2009.06.29 : 2단계 기능 추가
	// 2011.07.01 : 댓글, 스크랩, 만족도 조사 기능의 종속성 제거
	//----------------------------
	if (bbsCommentService != null){
		if (bbsCommentService.canUseComment(boardVO.getBbsId())) {
		    model.addAttribute("useComment", "true");
		}
	}
	if (bbsSatisfactionService != null) {
		if (bbsSatisfactionService.canUseSatisfaction(boardVO.getBbsId())) {
		    model.addAttribute("useSatisfaction", "true");
		}
	}
	if (bbsScrapService != null ) {
		if (bbsScrapService.canUseScrap()) {
		    model.addAttribute("useScrap", "true");
		}
	}
	////--------------------------
	return ".basic_customer/noticeInqire";
    }
	
    /**
     * 리플 트레이드 예탁 화면 이동.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callXrpTrade.do")
    public String callRippleXrpTrade( ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
    	AccountVO accountVO = new AccountVO();
    	TradeVO tradeVo = new TradeVO();
    	ArrayList<TradeVO> tradeList = new ArrayList<TradeVO>();
    	
    	// 최근 매수 목록 호출
		ArrayList<TradeVO> buyTrade = new ArrayList<TradeVO>();
		ArrayList<TradeVO> sellTrade = new ArrayList<TradeVO>();
		ArrayList<TradeVO> completeTrade = new ArrayList<TradeVO>();
		// 최근 매수, 매도, 시세 호출
		HashMap<String, Object> mapXrpPrice = new HashMap<String, Object>();
		
		AdminAccountVO adminAccountVo = new AdminAccountVO();
		
		int chkTrade = 0;
		
		try {
    		accountVO.setMberId(user.getId());
    		tradeVo.setRequestErId(user.getId());
    		
        	accountVO = tradeManageService.selectAccountInfo(accountVO);
        	tradeList = tradeManageService.selectXrpTradeList(tradeVo);
        	
        	buyTrade = tradeManageService.selectXrpBuyTradeList(tradeVo);
			// 최근 매도 목록 호출
			sellTrade = tradeManageService.selectXrpSellTradeList(tradeVo);
			// 최근 거래 완료 목록 호출
			completeTrade = tradeManageService.selectXrpCompleteTradeList();
			
			mapXrpPrice = tradeManageService.selectXrpTradePrice();
			//xrpgate 계좌 정보 
			adminAccountVo = adminMgmtService.selectRippleAccountInfo();
			
			// 사용자의 마지막 구매 상태 조회
			chkTrade = tradeManageService.selectChkTradeCntByMber(tradeVo);
        	
    	} catch( Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	model.addAttribute("accountVO", accountVO);
    	model.addAttribute("tradeList", tradeList);
    	model.addAttribute("buyTrade", buyTrade);
		model.addAttribute("sellTrade", sellTrade);
		model.addAttribute("completeTrade", completeTrade);
		model.addAttribute("xrpPrice", mapXrpPrice);
		model.addAttribute("adminAccountVo", adminAccountVo);
		model.addAttribute("chkStatus", chkTrade > 0 ? false:true);
    	
    	return ".basic_trade/rippleXrpTrade";
    }	
    
    @RequestMapping(value="/callMarketPriece.do")
    public String getMarketPrice(ModelMap model) throws Exception {
    	
    	return ".basic_trade/marketprice";
    }
    
    @RequestMapping(value="/callExcutePurchase.do")
    public String callExcutePurchase(ModelMap model) throws Exception {
    	AdminAccountVO adminAccountVo = new AdminAccountVO();
    	
    	//xrpgate 계좌 정보 
		adminAccountVo = adminMgmtService.selectRippleAccountInfo();
		model.addAttribute("adminAccountVo", adminAccountVo);
    	return ".basic_trade/executePurchase";
    }
    
    @RequestMapping(value="/callCommissionPolicy.do")
    public String callPommissionPolicy() throws Exception {
    	
    	return ".basic_trade/commissionPolicy";
    }
    
}
