package xrpgate.customer.web;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMaster;
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
@RequestMapping(value = "/customer")
public class CustomerController implements ApplicationContextAware, InitializingBean {
	
	//protected Logger log = Logger.getLogger(this.getClass());
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);
	//protected Logger logger = Logger.getLogger(this.getClass());

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;    // egovframework.com.cmm.service.EgovProperties.java
    
    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;
    
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
	
    /**
     * 전화신청 등록 화면 이동.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callPhoneCouncelModify.do")
    public String callPhoneCouncelModify(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	MberManageVO mberManageVO = null;
    	if (user == null){
    		//비로그인유저
    	}else{
    		//로그인유저
    		mberManageVO = mberManageService.selectMberById(user.getId());
			
        	boardVO.setFrstRegisterId(user.getId());
            boardVO.setFrstRegisterNm(user.getName());
            boardVO.setFrstRegisterPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
            boardVO.setLastUpdusrNm(user.getName());
            boardVO.setLastUpdusrPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
            boardVO.setMoblphonNo(mberManageVO.getMoblphonNo());
            boardVO.setNtcrId(user.getId());
            boardVO.setNtcrNm(user.getName());
    	}
		
		//,전화상담 게시판
		boardVO.setBbsId("BBSMSTR_000000000001");
    	model.addAttribute("boardVO", boardVO);
    	return ".basic_customer/phoneCouncelModify";
    }	
    
	
    /**
     * QnA 등록 화면 이동.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/callQnAModify.do")
    public String callQnAModify(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	MberManageVO mberManageVO = null;
    	if (user == null){
    		//비로그인유저
    	}else{
    		//로그인유저
    		mberManageVO = mberManageService.selectMberById(user.getId());
			
        	boardVO.setFrstRegisterId(user.getId());
            boardVO.setFrstRegisterNm(user.getName());
            boardVO.setFrstRegisterPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
            boardVO.setLastUpdusrNm(user.getName());
            boardVO.setLastUpdusrPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
            boardVO.setMoblphonNo(mberManageVO.getMoblphonNo());
            boardVO.setNtcrId(user.getId());
            boardVO.setNtcrNm(user.getName());
    	}
		
		//QnA 게시판
		boardVO.setBbsId("BBSMSTR_000000000002");
    	model.addAttribute("boardVO", boardVO);
    	return ".basic_customer/QnAModify";
    }	
	
    
    
    /**
     * 전화상담 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/insertPhoneCouncelArticle.do")
    public String insertPhoneCouncelArticle(
//    		                                                      final MultipartHttpServletRequest multiRequest, 
	                                                              @ModelAttribute("board") Board board,
	                                                              RedirectAttributes redirectAttributes,
	    ModelMap model) throws Exception {
		
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	if (user == null){
    		//비로그인유저
    		if(board.getNtcrNm() == null || board.getNtcrNm().equals("")){
    			board.setNtcrNm("익명사용자");
        		board.setNtcrId("익명사용자");
        		board.setFrstRegisterId("익명사용자");
    		}else{
        		board.setNtcrNm(board.getNtcrNm());
        		board.setNtcrId(board.getNtcrNm());
        		board.setFrstRegisterId(board.getNtcrNm());
    		}
    	}else{
    		//로그인유저
    		board.setNtcrNm(user.getName());
    		board.setNtcrId(user.getId());
    		board.setFrstRegisterId(user.getId());
    	}
	    //전화상담 게시판 아이디 : BBSMSTR_000000000001
		if("".equals(board.getBbsId()))
			board.setBbsId("BBSMSTR_000000000001");
	    	    
	    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
	    
	    board.setQnaProcessSttusCode("2"); // 접수
		board.setNttSj("전화상담 요청합니다.");
		//escape된 문자열을 다시 원래 형태로 복원하여 DB에 저장한다. ckEditor의 사용상 화명에 태그 형태 대로 적용하기 위한 처리 방식임.
	    board.setNttCn(StringEscapeUtils.unescapeHtml(board.getNttCn()));
	    
		bbsMngService.insertBoardArticle(board);	
		
		//model.addAttribute("message", "전화상담이 등록되었습니다. 상담 담당자가 등록하신 연락처로 연락드리겠습니다.");
		redirectAttributes.addFlashAttribute("message","전화상담이 등록되었습니다. 상담 담당자가 등록하신 연락처로 연락드리겠습니다.");
		
		return "redirect:/";
    }    
    

    /**
     * QnA게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/insertQnAArticle.do")
    public String insertQnAArticle(
	                                                              @ModelAttribute("board") Board board,
	                                                              RedirectAttributes redirectAttributes,
	    ModelMap model) throws Exception {
		
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	if (user == null){
    		//비로그인유저
    		if(board.getNtcrNm() == null || board.getNtcrNm().equals("")){
    			board.setNtcrNm("익명사용자");
        		board.setNtcrId("익명사용자");
        		board.setFrstRegisterId("익명사용자");
    		}else{
        		board.setNtcrNm(board.getNtcrNm());
        		board.setNtcrId(board.getNtcrNm());
        		board.setFrstRegisterId(board.getNtcrNm());
    		}
    	}else{
    		//로그인유저
    		board.setNtcrNm(user.getName());
    		board.setNtcrId(user.getId());
    		board.setFrstRegisterId(user.getId());
    	}

	    //QnA 게시판 아이디 : BBSMSTR_000000000002
		if("".equals(board.getBbsId()))
			board.setBbsId("BBSMSTR_000000000002");
	    	    
	    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
	    
	    board.setQnaProcessSttusCode("2"); // 접수
	    if("".equals(board.getNttSj()))
	    	board.setNttSj("리플관련 질문 요청합니다.");
		//escape된 문자열을 다시 원래 형태로 복원하여 DB에 저장한다. ckEditor의 사용상 화명에 태그 형태 대로 적용하기 위한 처리 방식임.
	    board.setNttCn(StringEscapeUtils.unescapeHtml(board.getNttCn()));
	    
		bbsMngService.insertBoardArticle(board);	
		
		redirectAttributes.addFlashAttribute("message","리플 Q&A 이 등록되었습니다. 상담 담당자가 빠른 시간내에 답변드리겠습니다.");
		
		return "redirect:/";
    }    
    
    
    /**
     * 전화상담/QnA게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/phoneQnAList.do")
    public String phoneQnAList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		//게시판 아이디 : BBSMSTR_000000000001 / BBSMSTR_000000000002

	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	//Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
	Map<String, Object> map = bbsMngService.selectPhoneQnAList(boardVO);//2011.09.07
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);


	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("paginationInfo", paginationInfo);

	return ".basic_customer/phoneQnAList";
    }

    /**
     * 리플뉴스 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleNewsList.do")
    public String rippleNewsList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	
	//게시판 아이디 : BBSMSTR_000000000003

	BoardMasterVO vo = new BoardMasterVO();
	
	if("".equals(boardVO.getBbsId()))
		boardVO.setBbsId("BBSMSTR_000000000003");
	
	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	//Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, ""); //
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);


	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("paginationInfo", paginationInfo);

	return ".basic_customer/rippleNewsList";
    }
    /**
     * 리플뉴스에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleNewsInqire.do")
    public String rippleNewsInqire(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
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

	//리플뉴스 게시판 아이디 : BBSMSTR_000000000003
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000003");
	
	// 신규 등록 화면에서 등록 후  redirect 된 경우 nttId를 model 객체에서 뽑아와야 한다.
	if(model.get("nttId") != null){
		long nttId = (Long.parseLong(model.get("nttId").toString()));
		if(nttId != 0){
			boardVO.setNttId(nttId);
		}	
	}
	
	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", vo);
	
	//CommandMap의 형태로 개선????

	return ".basic_customer/rippleNewsInqire";
    }   

    /**
     * 리플공지 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleNoticeList.do")
    public String rippleNoticeList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	
	//게시판 아이디 : BBSMSTR_000000000004

	BoardMasterVO vo = new BoardMasterVO();
	
	if("".equals(boardVO.getBbsId()))
		boardVO.setBbsId("BBSMSTR_000000000004");
	
	boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	paginationInfo.setPageSize(boardVO.getPageSize());

	boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	//Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, ""); //
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);


	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("paginationInfo", paginationInfo);

	return ".basic_customer/rippleNoticeList";
    }
    /**
     * 리플공지에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleNoticeInqire.do")
    public String rippleNoticeInqire(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
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

	//리플공지 게시판 아이디 : BBSMSTR_000000000004
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000004");
	
	// 신규 등록 화면에서 등록 후  redirect 된 경우 nttId를 model 객체에서 뽑아와야 한다.
	if(model.get("nttId") != null){
		long nttId = (Long.parseLong(model.get("nttId").toString()));
		if(nttId != 0){
			boardVO.setNttId(nttId);
		}	
	}
	
	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

	model.addAttribute("result", vo);
	
	//CommandMap의 형태로 개선????

	return ".basic_customer/rippleNoticeInqire";
    } 
    
    /**
     * 리플트레이드챠트 - 외부 링크
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleTradeChart.do")
    public String rippleTradeChart() throws Exception {
	return ".basic_customer/rippleTradeChart";
    }
    
    /**
     * 리플트레이드 - 외부 링크
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleTrade.do")
    public String rippleTrade() throws Exception {
	return ".basic_customer/rippleTrade";
    }

	

    
	/**
	 * 약관  화면
	 * @param 
	 * @return 회사 소개  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/terms.do")
	public String terms() throws Exception {
		return ".basic_customer/terms";
	}
	
	/**
	 * 개인정보 정책  화면
	 * @param 
	 * @return 회사 소개  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/privateInfoPolicy.do")
	public String privateInfoPolicy() throws Exception {
		return ".basic_customer/privateInfoPolicy";
	}
	
	/**
	 * 개인정보 정책  화면
	 * @param 
	 * @return 회사 소개  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/emailInfoPolicy.do")
	public String emailInfoPolicy() throws Exception {
		return ".basic_customer/emailInfoPolicy";
	}
}
