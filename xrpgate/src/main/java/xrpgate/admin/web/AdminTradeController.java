package xrpgate.admin.web;

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

import xrpgate.common.model.JsonObject;
import xrpgate.customer.web.CustomerController;
import xrpgate.trade.service.TradeDetailVO;
import xrpgate.trade.service.TradeManageService;
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

    
	@Override
	public void afterPropertiesSet() throws Exception {

		// TODO Auto-generated method stub
		
	}

	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {

		// TODO Auto-generated method stub
		
	}
	
	@RequestMapping(value="/main.do", method = RequestMethod.GET)
	public String index(ModelMap model) {
		return "forward:/admin/tradeList.do";
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
     * 리플 판매 요청 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleSellReqList.do")
    public String rippleSellReqList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	return ".basic_customer/noticeList";
    }


    /**
     * 리플 구매 요청 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleBuyReqList.do")
    public String rippleBuyReqList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	return ".basic_customer/noticeList";
    }
    
	
    
}
