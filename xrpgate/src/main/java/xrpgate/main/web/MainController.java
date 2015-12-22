package xrpgate.main.web;

import java.util.Map;

import javax.annotation.Resource;

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

import xrpgate.common.model.JsonObject;
import xrpgate.login.web.LoginController;
import xrpgate.trade.service.TradeDetailVO;
import xrpgate.trade.service.TradeManageService;
import xrpgate.trade.service.TradeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSCommentService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.cop.bbs.service.EgovBBSSatisfactionService;
import egovframework.com.cop.bbs.service.EgovBBSScrapService;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



@Controller
@RequestMapping(value = "/main")
public class MainController implements ApplicationContextAware, InitializingBean {
	
	//protected Logger log = Logger.getLogger(this.getClass());
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	//protected Logger logger = Logger.getLogger(this.getClass());

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;
	
    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;    // egovframework.com.cmm.service.EgovProperties.java
    
    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

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
	
	@RequestMapping(value="/index.do", method = RequestMethod.GET)
	public String index(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model)  throws Exception{
		if(EgovUserDetailsHelper.isAuthenticated()){
			LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
			logger.debug("loginVOgetid정보"+loginVO.getId());
			logger.debug("loginVOgetuserSe 정보"+loginVO.getUserSe());
			
			//일반 회원
			if(loginVO.getUserSe().equals("GNR")){			
				TradeDetailVO tradeDetailVO = new TradeDetailVO();
				TradeVO tradeVO = new TradeVO();
				tradeDetailVO.setRequestErId(loginVO.getId());
				
				MberManageVO mberManageVO = mberManageService.selectMberById(loginVO.getId());
				tradeVO = tradeManageService.selectTotalBookingRippleTrade(tradeDetailVO);
				
				model.addAttribute("mberManageVO", mberManageVO);		
				model.addAttribute("tradeVO", tradeVO);
			}
		}
		return ".basic_main/potal";
		
//		return "main/potal";
	}
	

    /**
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
	@ResponseBody
    @RequestMapping("/jsonRippleNewList.do")
    public JsonObject jsonRippleNewList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
		//리플뉴스 게시판 아이디 : BBSMSTR_000000000003
		boardVO.setBbsId("BBSMSTR_000000000003");
	
		//공지사항 게시판 정렬 순서 
		logger.debug("공지게시판 boardVO.getSortType() 빈공백");
		boardVO.setBbsNm(boardVO.getBbsNm());
	
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		
		if(user != null)
			vo.setUniqId(user.getUniqId());
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		JsonObject jo = new JsonObject();
		jo.IsSucceed = true;
		try {
			Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "");//
			jo.Data = map.get("resultList");
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jo;
    }
	

    /**
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
	@ResponseBody
    @RequestMapping("/jsonRippleNoticeList.do")
    public JsonObject jsonRippleNoticeList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
		//리플공지사항 게시판 아이디 : BBSMSTR_000000000004
		boardVO.setBbsId("BBSMSTR_000000000004");
	
		//공지사항 게시판 정렬 순서 
		logger.debug("공지게시판 boardVO.getSortType() 빈공백");
		boardVO.setBbsNm(boardVO.getBbsNm());
	
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		
		if(user != null)
			vo.setUniqId(user.getUniqId());
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		JsonObject jo = new JsonObject();
		jo.IsSucceed = true;
		try {
			Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "");//
			jo.Data = map.get("resultList");
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jo;
    }
}
