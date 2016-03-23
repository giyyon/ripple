package xrpgate.admin.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import xrpgate.admin.web.service.AdminAccountVO;
import xrpgate.admin.web.service.AdminMgmtService;
import xrpgate.common.model.JsonObject;
import xrpgate.customer.web.CustomerController;
import xrpgate.trade.service.AccountDetailVO;
import xrpgate.trade.service.AccountVO;
import xrpgate.trade.service.TradeDetailVO;
import xrpgate.trade.service.TradeManageService;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
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



/**
 * @author park
 *
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminTradeController implements ApplicationContextAware, InitializingBean {
	
	//protected Logger log = Logger.getLogger(this.getClass());
	private static final Logger logger = LoggerFactory.getLogger(AdminTradeController.class);
	//protected Logger logger = Logger.getLogger(this.getClass());

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;    // egovframework.com.cmm.service.EgovProperties.java
    
    
	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

    
    @Resource(name = "tradeManageService")
    private TradeManageService tradeManageService;
    
    @Resource(name = "adminMgmtService")
    private AdminMgmtService adminMgmtService;

    /** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
	@Override
	public void afterPropertiesSet() throws Exception {

		// TODO Auto-generated method stub
		
	}

	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {

		// TODO Auto-generated method stub
		
	}
	
	@RequestMapping(value="/main.do", method = RequestMethod.GET)
	public String index(ModelMap model) throws Exception {
		//return "forward:/admin/tradeList.do";
		AdminAccountVO accountVo = adminMgmtService.selectRippleAccountInfo();
		
		model.put("accountVo", accountVo);
		return ".admin_admin/adminMain";
	}
	
	@RequestMapping(value="/callAccountInsertPage.do")
	public String callInsertPage(ModelMap model) throws Exception {
		
		AdminAccountVO accountVo = new AdminAccountVO();
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		accountVo = adminMgmtService.selectRippleAccountInfo();
		// 은행목록
		vo.setCodeId("RIP905");
		List<?> bank_result = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("bank_result", bank_result);
		model.put("accountVo", accountVo);
		return ".popup_admin/adminAccountModifyView";
	}
	
	@RequestMapping(value="/insertRippleAccount.do")
	@ResponseBody
	public HashMap<String, Object> insertRippleAccountInfo(AdminAccountVO accountVo) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		try{
			adminMgmtService.insertRippleAccountInfo(accountVo);
			
			map.put("isSuccess", true);
		}catch(Exception e){
			System.out.print(e.getMessage());
			map.put("isSuccess", false);
		}
		
		return map;
	}
	
    @SuppressWarnings("unchecked")
    @RequestMapping("/tradeList.do")
    public String tradeList(@ModelAttribute("searchVO") BoardVO boardVO,
                                                      @ModelAttribute("tradeDetailVO") TradeDetailVO tradeDetailVO,
                                                      RedirectAttributes redirectAttributes,
                                                      ModelMap model) throws Exception {

    	tradeDetailVO.setPageUnit(propertyService.getInt("pageUnit"));
    	tradeDetailVO.setPageSize(propertyService.getInt("pageSize"));
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
    	paginationInfo.setCurrentPageNo(tradeDetailVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(tradeDetailVO.getPageUnit());
    	paginationInfo.setPageSize(tradeDetailVO.getPageSize());

    	tradeDetailVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	tradeDetailVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	tradeDetailVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	
		tradeDetailVO.setTradeType(""); // 모두 가져오기
		Map<String, Object> map = tradeManageService.selectRippleTradeList(tradeDetailVO);	
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("tradeDetailVO", tradeDetailVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//model.addAttribute("message", "전화상담이 등록되었습니다. 상담 담당자가 등록하신 연락처로 연락드리겠습니다.");
		return ".basic_admin/tradeList";
    }    
	
    
	/**
	 * 답변 내용을 등록한다.
	 * @param mberId 상세조회대상 일반회원아이디
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return uss/umt/EgovMberSelectUpdt
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/jsonInsertRippleTrade.do")
	public JsonObject jsonInsertRippleTrade(
            @ModelAttribute("tradeDetailVO") TradeDetailVO tradeDetailVO,
            RedirectAttributes redirectAttributes,
            Model model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
	    tradeDetailVO.setStatus("Y");
	    tradeDetailVO.setUpdateErId(user.getId());
	    tradeManageService.updateRippleTrade(tradeDetailVO);
		
		JsonObject jo = new JsonObject();
		jo.IsSucceed = true;
		jo.Message = "완료처리 되었습니다.";
		return jo;
	}	
    
	/**
     * 회원 계좌 예탁/ 인출 리스트
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/accountMgmt.do")
    public String accountMgmt(TradeDetailVO tradeVo, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String url = "";
    	try{
    		
    		
    	}catch (Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	
	return ".admin_admin/adminAccountMgmt";
    }
    
    /**
     * 회원 계좌 예탁/ 인출 리스트
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/accountList.do")
    public String rippleSellReqList(AccountDetailVO accountDeatailVo, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String url = "";
    	try{
    		
    		accountDeatailVo.setPageUnit(propertyService.getInt("pageUnit"));
        	accountDeatailVo.setPageSize(propertyService.getInt("pageSize"));
        	
        	PaginationInfo paginationInfo = new PaginationInfo();
        	
        	paginationInfo.setCurrentPageNo(accountDeatailVo.getPageIndex());
        	paginationInfo.setRecordCountPerPage(accountDeatailVo.getPageUnit());
        	paginationInfo.setPageSize(accountDeatailVo.getPageSize());

        	accountDeatailVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        	accountDeatailVo.setLastIndex(paginationInfo.getLastRecordIndex());
        	accountDeatailVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    		Map<String, Object> map = tradeManageService.selectAdminAccountList(accountDeatailVo);	
    		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    		
    		paginationInfo.setTotalRecordCount(totCnt);
    		
    		model.addAttribute("resultList", map.get("resultList"));
    		model.addAttribute("resultCnt", map.get("resultCnt"));
    		model.addAttribute("accountDeatailVo", accountDeatailVo);
    		model.addAttribute("paginationInfo", paginationInfo);
    		
    		if("D".equals(accountDeatailVo.getTradeType())){
    			url = ".contents_admin/accountDepositView";
    		} else {
    			url = ".contents_admin/accountDrawView";
    		}
    	}catch (Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	
	return url;
    }


    /**
     * 예탁 /인출 수정 화면 호출
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callModifyAccountView.do")
    public String rippleBuyReqList(AccountDetailVO accountDeatailVo, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	AccountDetailVO accountVo = new AccountDetailVO();
    	try{
    		accountVo = tradeManageService.selectadminAccountDetail(accountDeatailVo); 
    	}catch(Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	model.addAttribute("accountVo", accountVo);
    	
	return ".popup_admin/accountModifyView";
    }
    
    @RequestMapping(value="ModifyMberAccount")
    @ResponseBody
	public HashMap<String, Object> updateMemberAccount(AccountVO accountVo) throws Exception {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	
    	try{
    		tradeManageService.updateMberAccount(accountVo);
    		
    		map.put("isSuccess", true);
    		
    	} catch (Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	
    	return map;
	}
    
    /**
     * XRPGATE 예탁/인출 정보 삭제
     * @param accountVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/deleteTransactionInfo.do")
    @ResponseBody
	public HashMap<String, Object> deleteTransactionInfo(AccountVO accountVo) throws Exception {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		tradeManageService.deleteTransactionInfo(accountVo);
    		map.put("isSuccess", true);
    		
    	} catch (Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	return map;
	}
    
    /**
     * XRPGATE XRP 거래 관리 화면 호출
     * @param tradeVo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/xrpgateTradeMgmt.do")
    public String xrpgateTradeMgmt(TradeDetailVO tradeVo, ModelMap model) throws Exception {
	return ".admin_admin/trade/xrpgateTradeMgmt";
    }
    
    /**
     * XRPGATE XRP 거래 리스트
     * @param tradeDetailVo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/xrpgateTradeList.do")
    public String selectAdminXrpTradeList(TradeDetailVO tradeDetailVo, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String url = "";
    	try{
    		
    		tradeDetailVo.setPageUnit(propertyService.getInt("pageUnit"));
    		tradeDetailVo.setPageSize(propertyService.getInt("pageSize"));
        	
        	PaginationInfo paginationInfo = new PaginationInfo();
        	
        	paginationInfo.setCurrentPageNo(tradeDetailVo.getPageIndex());
        	paginationInfo.setRecordCountPerPage(tradeDetailVo.getPageUnit());
        	paginationInfo.setPageSize(tradeDetailVo.getPageSize());

        	tradeDetailVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        	tradeDetailVo.setLastIndex(paginationInfo.getLastRecordIndex());
        	tradeDetailVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    		Map<String, Object> map = tradeManageService.selectAdminXrpTradeList(tradeDetailVo);
    		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    		
    		paginationInfo.setTotalRecordCount(totCnt);
    		
    		model.addAttribute("resultList", map.get("resultList"));
    		model.addAttribute("resultCnt", map.get("resultCnt"));
    		model.addAttribute("tradeDetailVo", tradeDetailVo);
    		model.addAttribute("paginationInfo", paginationInfo);
    		
    		if("B".equals(tradeDetailVo.getTradeType())){
    			url = ".contents_admin/trade/xrpBuyTradeView";
    		} else if("S".equals(tradeDetailVo.getTradeType())){
    			url = ".contents_admin/trade/xrpSellTradeView";
    		} else {
    			url = ".contents_admin/trade/xrpCurrentPriceView";
    		}
    	}catch (Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	
	return url;
    }


    
    /**
     * XRPGATE XRP 거래 수정 및 인서트 화면 호출
     * @param tradeDetailVo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callXrpTradeView.do")
    public String callXrpTradeView(TradeDetailVO tradeDetailVo, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	TradeDetailVO tradeVo = new TradeDetailVO();
    	
    	int totalSum = 0;
    	try{
    		tradeVo = tradeManageService.selectAdminXrpTrade(tradeDetailVo);
    		totalSum = tradeManageService.selectAdminXrpTradeSumQty(tradeDetailVo);
    		
    		tradeVo.setMberNm(user.getName());
    	}catch(Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	model.addAttribute("tradeVo", tradeVo);
    	model.addAttribute("tradeType", tradeDetailVo.getTradeType());
    	model.addAttribute("totalSum", totalSum);
    	
	return ".popup_admin/xrpTradeModifyView";
    }
    
    /**
     * XRPGATE XRP 거래 등록
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/insertXrpTrade.do")
    @ResponseBody
	public HashMap<String, Object> insertXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	try{
    		tradeDetailVo.setRequestId(user.getId());
    		tradeManageService.insertAdminXrtTrade(tradeDetailVo);
    		
    		map.put("isSuccess", true);
    		
    	} catch (Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	
    	return map;
	}
    
    /**
     * XRPGATE XRP 거래 수정
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/modifyXrpTrade.do")
    @ResponseBody
	public HashMap<String, Object> updateXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	
    	try{
    		tradeManageService.updateAdminXrpTrade(tradeDetailVo);
    		
    		map.put("isSuccess", true);
    		
    	} catch (Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	
    	return map;
	}
    
    /**
     * XRPGATE XRP 거래 삭제
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/deleteXrpTrade.do")
    @ResponseBody
	public HashMap<String, Object> deleteXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		tradeManageService.deleteAdminXrpTrade(tradeDetailVo);
    		map.put("isSuccess", true);
    		
    	} catch (Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	return map;
	}
    
    
    /**
     * XRPGATE 회원 XRP 거래 관리 화면 호출
     * @param tradeVo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mberXrpTradeMgmt.do")
    public String mberXrpTradeMgmt(TradeDetailVO tradeVo, ModelMap model) throws Exception {
	return ".admin_admin/trade/mberXrpTradeMgmt";
    }
    
    /**
     * XRPGATE 회원 XRP 거래 리스트
     * @param tradeDetailVo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mberXrpTradeList.do")
    public String selectMberXrpTradeList(TradeDetailVO tradeDetailVo, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	String url = "";
    	try{
    		
    		tradeDetailVo.setPageUnit(propertyService.getInt("pageUnit"));
    		tradeDetailVo.setPageSize(propertyService.getInt("pageSize"));
        	
        	PaginationInfo paginationInfo = new PaginationInfo();
        	
        	paginationInfo.setCurrentPageNo(tradeDetailVo.getPageIndex());
        	paginationInfo.setRecordCountPerPage(tradeDetailVo.getPageUnit());
        	paginationInfo.setPageSize(tradeDetailVo.getPageSize());

        	tradeDetailVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        	tradeDetailVo.setLastIndex(paginationInfo.getLastRecordIndex());
        	tradeDetailVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    		Map<String, Object> map = tradeManageService.selectMberXrpTradeList(tradeDetailVo);
    		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    		
    		paginationInfo.setTotalRecordCount(totCnt);
    		
    		model.addAttribute("resultList", map.get("resultList"));
    		model.addAttribute("resultCnt", map.get("resultCnt"));
    		model.addAttribute("tradeDetailVo", tradeDetailVo);
    		model.addAttribute("paginationInfo", paginationInfo);
    		
    		if("B".equals(tradeDetailVo.getTradeType())){
    			url = ".contents_admin/trade/mberXrpBuyTradeView";
    		} else {
    			url = ".contents_admin/trade/mberXrpSellTradeView";
    		}
    	}catch (Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	
	return url;
    }


    
    /**
     * XRPGATE 회원 XRP 거래 수정 및 인서트 화면 호출
     * @param tradeDetailVo
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callMberXrpTradeView.do")
    public String callMberXrpTradeView(TradeDetailVO tradeDetailVo, ModelMap model
    		, @ModelAttribute("tradeVo") TradeDetailVO tradeVo) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	int totalSum = 0;
    	try{
    		tradeVo = tradeManageService.selectMberXrpTrade(tradeDetailVo);
    		totalSum = tradeManageService.selectMberXrpTradeSumQty(tradeVo);
    		
    		// 인서트일경우 tradeVo null로 에러 발생 null이 아닌 상태로 만듬.
    		tradeVo.setMberNm(user.getName());
    	}catch(Exception e){
    		System.out.print(e.getMessage());
    	}
    	
    	model.addAttribute("tradeVo", tradeVo);
    	model.addAttribute("tradeType", tradeDetailVo.getTradeType());
    	model.addAttribute("totalSum", totalSum);
    	
	return ".popup_admin/xrpMberTradeModifyView";
    }
    
    /**
     * XRPGATE 회원 XRP 거래 등록
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/updateMberXrpTrade.do")
    @ResponseBody
	public HashMap<String, Object> updateMberXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	try{
    		tradeManageService.updateMberXrpTrade(tradeDetailVo);
    		
    		map.put("isSuccess", true);
    		
    	} catch (Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	
    	return map;
	}
    
    
    /**
     * XRPGATE 회원 XRP 거래 삭제
     * @param tradeDetailVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/deleteMberXrpTrade.do")
    @ResponseBody
	public HashMap<String, Object> deleteMberXrpTrade(TradeDetailVO tradeDetailVo) throws Exception {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		tradeManageService.deleteMberXrpTrade(tradeDetailVo);
    		map.put("isSuccess", true);
    		
    	} catch (Exception e){
    		System.out.print(e.getMessage());
    		map.put("isSuccess", false);
    	}
    	return map;
	}
    

}
