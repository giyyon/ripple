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
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import xrpgate.common.model.JsonObject;
import xrpgate.customer.web.CustomerController;
import xrpgate.util.JSONResponseUtil;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



@Controller
@RequestMapping(value = "/admin")
public class AdminCustomerController implements ApplicationContextAware, InitializingBean {
	
	//protected Logger log = Logger.getLogger(this.getClass());
	private static final Logger logger = LoggerFactory.getLogger(AdminCustomerController.class);
	//protected Logger logger = Logger.getLogger(this.getClass());

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;    // egovframework.com.cmm.service.EgovProperties.java
    
    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;
    
	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

    
	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(AdminCustomerController.class);
	
	@Override
	public void afterPropertiesSet() throws Exception {

		// TODO Auto-generated method stub
		
	}

	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {

		// TODO Auto-generated method stub
		
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

	return ".admin_admin/rippleNewsList";
    }
    
    /**
     * 리플 공지 목록을 조회한다.
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

	return ".admin_admin/rippleNoticeList";
    }

    /**
     * 게시물에 대한 수정 화면으로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleNewsCallInsertPage.do")
    public String rippleNewsCallInsertPage(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	boardVO.setFrstRegisterId(user.getId());
        boardVO.setFrstRegisterNm(user.getName());
        boardVO.setFrstRegisterPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setLastUpdusrNm(user.getName());
        boardVO.setLastUpdusrPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setNtcrId(user.getId());
        boardVO.setNtcrNm(user.getName());
		boardVO.setBbsId("BBSMSTR_000000000003");
    	model.addAttribute("result", boardVO);
    	return ".admin_admin/rippleNewsModify";
    }
    
    /**
     *  공지에 대한 수정 화면으로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/rippleNoticeCallInsertPage.do")
    public String rippleNoticeCallInsertPage(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	boardVO.setFrstRegisterId(user.getId());
        boardVO.setFrstRegisterNm(user.getName());
        boardVO.setFrstRegisterPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setLastUpdusrNm(user.getName());
        boardVO.setLastUpdusrPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setNtcrId(user.getId());
        boardVO.setNtcrNm(user.getName());
		boardVO.setBbsId("BBSMSTR_000000000004");
    	model.addAttribute("result", boardVO);
    	return ".admin_admin/rippleNoticeModify";
    }
    
    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/insertRippleNewsArticle.do")
    public String insertRippleNewsArticle(
//    		                                                      final MultipartHttpServletRequest multiRequest, 
    		                                                      @ModelAttribute("searchVO") BoardVO boardVO,
	                                                              @ModelAttribute("bdMstr") BoardMaster bdMstr, 
	                                                              @ModelAttribute("board") Board board, 
	                                                              RedirectAttributes redirectAttributes,
	    ModelMap model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		long nttId = 0;
		if (isAuthenticated) {
		    board.setFrstRegisterId(user.getId());
		    //리플뉴스 게시판 아이디 : BBSMSTR_000000000003
			if("".equals(boardVO.getBbsId()))
					boardVO.setBbsId("BBSMSTR_000000000003");
		    	    
		    //board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    //board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    
		    //board.setNttCn(board.getNttCn());	// XSS 방지
			//escape된 문자열을 다시 원래 형태로 복원하여 DB에 저장한다. ckEditor의 사용상 화명에 태그 형태 대로 적용하기 위한 처리 방식임.
		    board.setNttCn(StringEscapeUtils.unescapeHtml(board.getNttCn()));
		    
		    nttId = 0;
			if( board.getNttId() == 0 ){
				nttId = bbsMngService.insertBoardArticle(board);	
				board.setNttId(nttId);
			}else{
			    board.setLastUpdusrId(user.getId());
				bbsMngService.updateBoardArticle(board);
				nttId = board.getNttId();
			}	
		}
		model.addAttribute("result", board);
		
		redirectAttributes.addFlashAttribute("nttId",String.valueOf(nttId));
		
		//등록
		return "redirect:/admin/rippleNewsList.do";
    }    
    
    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/insertRippleNoticeArticle.do")
    public String insertRippleNoticeArticle(
//    		                                                      final MultipartHttpServletRequest multiRequest, 
    		                                                      @ModelAttribute("searchVO") BoardVO boardVO,
	                                                              @ModelAttribute("bdMstr") BoardMaster bdMstr, 
	                                                              @ModelAttribute("board") Board board, 
	                                                              RedirectAttributes redirectAttributes,
	    ModelMap model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		long nttId = 0;
		if (isAuthenticated) {
		    board.setFrstRegisterId(user.getId());
		    //리플 공지 게시판 아이디 : BBSMSTR_000000000003
			if("".equals(boardVO.getBbsId()))
					boardVO.setBbsId("BBSMSTR_000000000004");
		    	    
		    //board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    //board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    
		    //board.setNttCn(board.getNttCn());	// XSS 방지
			//escape된 문자열을 다시 원래 형태로 복원하여 DB에 저장한다. ckEditor의 사용상 화명에 태그 형태 대로 적용하기 위한 처리 방식임.
		    board.setNttCn(StringEscapeUtils.unescapeHtml(board.getNttCn()));
		    
		    nttId = 0;
			if( board.getNttId() == 0 ){
				nttId = bbsMngService.insertBoardArticle(board);	
				board.setNttId(nttId);
			}else{
			    board.setLastUpdusrId(user.getId());
				bbsMngService.updateBoardArticle(board);
				nttId = board.getNttId();
			}	
		}
		model.addAttribute("result", board);
		
		redirectAttributes.addFlashAttribute("nttId",String.valueOf(nttId));
		
		//등록
		return "redirect:/admin/rippleNoticeList.do";
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/rippleNewsInqire";
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
    @RequestMapping("/rippleNewsModify.do")
    public String rippleNewsModify(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/rippleNewsModify";
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

	//리플 공지 게시판 아이디 : BBSMSTR_000000000004
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/rippleNoticeInqire";
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
    @RequestMapping("/rippleNoticeModify.do")
    public String rippleNoticeModify(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
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

	//리플 공지 게시판 아이디 : BBSMSTR_000000000004
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/rippleNoticeModify";
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
	@RequestMapping("/jsonInsertPhoneQnAArticle.do")
	public JsonObject jsonInsertPhoneQnAArticle(
			  @ModelAttribute("board") Board board, 
            HttpServletRequest request,
            Model model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		//escape된 문자열을 다시 원래 형태로 복원하여 DB에 저장한다. ckEditor의 사용상 화명에 태그 형태 대로 적용하기 위한 처리 방식임.
//	    board.setAnswerCn(StringEscapeUtils.unescapeHtml(board.getAnswerCn()));
		board.setAnswerCn((board.getAnswerCn()).replaceAll("\r\n", "<br>"));
	    board.setLastUpdusrId(user.getId());
	    board.setQnaProcessSttusCode("3"); //완료처리
		bbsMngService.updatePhoneQnAArticle(board);
		
		JsonObject jo = new JsonObject();
		jo.IsSucceed = true;
		jo.Message = "완료처리 되었습니다.";
		return jo;
	}	
    
    /**
     * FAQ게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/FAQList.do")
    public String FAQList(BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

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

    	return ".admin_admin/FAQList";
    }
    
    /**
     * 게시물에 대한 수정 화면으로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/FAQCallInsertPage.do")
    public String FAQCallInsertPage(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	boardVO.setFrstRegisterId(user.getId());
        boardVO.setFrstRegisterNm(user.getName());
        boardVO.setFrstRegisterPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setLastUpdusrNm(user.getName());
        boardVO.setLastUpdusrPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setNtcrId(user.getId());
        boardVO.setNtcrNm(user.getName());
		boardVO.setBbsId("BBSMSTR_000000000001");
    	model.addAttribute("result", boardVO);
    	return ".admin_admin/FAQModify";
    }
    
    /**
     * FAQ에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/FAQInqire.do")
    public String FAQInqire(BoardVO boardVO, ModelMap model) throws Exception {
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

	//QnA 게시판 아이디 : BBSMSTR_000000000001
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000001");
	
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/FAQInqire";
    }
    
    /**
     * FAQ에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/FAQModify.do")
    public String FAQModify(BoardVO boardVO, ModelMap model) throws Exception {
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

	//QnA 게시판 아이디 : BBSMSTR_000000000001
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000001");
	
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/FAQModify";
    }
    
    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/insertFAQArticle.do")
    public String insertFAQArticle(
					//final MultipartHttpServletRequest multiRequest, 
                      @ModelAttribute("searchVO") BoardVO boardVO,
                      @ModelAttribute("bdMstr") BoardMaster bdMstr, 
                      @ModelAttribute("board") Board board, 
                      RedirectAttributes redirectAttributes,
	    ModelMap model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		long nttId = 0;
		if (isAuthenticated) {
		    board.setFrstRegisterId(user.getId());
		    //리플뉴스 게시판 아이디 : BBSMSTR_000000000003
			if("".equals(boardVO.getBbsId()))
					boardVO.setBbsId("BBSMSTR_000000000003");
		    	    
		    //board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    //board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    // 게시물의 진행상태코드 이전에는 답변도 달수 있었지만 현재는 사라진 상태라 고정으로 접수상태로 입력. 
		    board.setQnaProcessSttusCode("2"); // 게시물의 진행상태코드 
		    
		    //board.setNttCn(board.getNttCn());	// XSS 방지
			//escape된 문자열을 다시 원래 형태로 복원하여 DB에 저장한다. ckEditor의 사용상 화명에 태그 형태 대로 적용하기 위한 처리 방식임.
		    board.setNttCn(StringEscapeUtils.unescapeHtml(board.getNttCn()));
		    
		    nttId = 0;
			if( board.getNttId() == 0 ){
				nttId = bbsMngService.insertBoardArticle(board);	
				board.setNttId(nttId);
			}else{
			    board.setLastUpdusrId(user.getId());
				bbsMngService.updateBoardArticle(board);
				nttId = board.getNttId();
			}	
		}
		model.addAttribute("result", board);
		
		redirectAttributes.addFlashAttribute("nttId",String.valueOf(nttId));
		
		//등록
		return "redirect:/admin/FAQList.do";
    }    
	  
       /**
     * 게시물에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteBoardArticle.do")
    public String deleteBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, ModelMap model) throws Exception {
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		String returnUrl = "";
	    board.setLastUpdusrId(user.getUniqId());
	    
	    //공지사항 게시판 아이디 : BBSMSTR_000000000001
		if("".equals(board.getBbsId()))
			board.setBbsId("BBSMSTR_000000000001");
		
	    bbsMngService.deleteBoardArticle(board);

		if("BBSMSTR_000000000003".equals(board.getBbsId())){
			returnUrl = "redirect:/admin/rippleNewsList.do";
		}else if("BBSMSTR_000000000004".equals(board.getBbsId())){
			returnUrl = "redirect:/admin/rippleNoticeList.do";
		}else if("BBSMSTR_000000000001".equals(board.getBbsId())){
			returnUrl = "redirect:/admin/FAQList.do";
		} else {
			returnUrl = "redirect:/admin/referenceList.do";
		}
		return returnUrl;
    }
    
    /**
     * 게시물에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteCheckedNoticeList.do")
    public String deleteCheckedNoticeList(@ModelAttribute("searchVO") BoardVO boardVO,
    		                                                      @ModelAttribute("board") Board board,
    		                                                      @ModelAttribute("bdMstr") BoardMaster bdMstr, 
    		                                                      @RequestParam(value="delChk", required=true) List<String> delChk,
    		                                                      ModelMap model) throws Exception {
	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		if (isAuthenticated) {
		    board.setLastUpdusrId(user.getUniqId());
		    
		    //공지사항 게시판 아이디 : BBSMSTR_000000000001
			board.setBbsId("BBSMSTR_000000000001");
			
			//삭제
			if(delChk == null || delChk.size() == 0 ){

			}else{
				LOGGER.debug("삭제 갯수"+delChk.size());
				for(int i =  0 ;  i < delChk.size() ; i++){
					board.setNttId((Long.parseLong(delChk.get(i))));
					bbsMngService.deleteBoardArticle(board);
				}		
			}
		}
	
		return "redirect:/admin/noticeList.do";
    }
    
    /**
     * 자료실 게시물 리스트
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/referenceList.do")
    public String selectReferenceList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

    	//게시판 아이디 : BBSMSTR_000000000005

    	BoardMasterVO vo = new BoardMasterVO();
    	
    	if("".equals(boardVO.getBbsId()))
    		boardVO.setBbsId("BBSMSTR_000000000005");
    	
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

    	return ".admin_admin/referenceList";
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
    @RequestMapping("/referenceModify.do")
    public String referenceModify(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
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

	//리플 공지 게시판 아이디 : BBSMSTR_000000000004
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000005");
	
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/referenceModify";
    }
    
    /**
     * 게시물에 대한 수정 화면으로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/referenceCallInsertPage.do")
    public String referenceCallInsertPage(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	boardVO.setFrstRegisterId(user.getId());
        boardVO.setFrstRegisterNm(user.getName());
        boardVO.setFrstRegisterPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setLastUpdusrNm(user.getName());
        boardVO.setLastUpdusrPnttm(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));
        boardVO.setNtcrId(user.getId());
        boardVO.setNtcrNm(user.getName());
		boardVO.setBbsId("BBSMSTR_000000000005");
    	model.addAttribute("result", boardVO);
    	return ".admin_admin/referenceModify";
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
    @RequestMapping("/referenceInqire.do")
    public String referenceInqire(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
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
			boardVO.setBbsId("BBSMSTR_000000000005");
	
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

	model.addAttribute("sessionUniqId", user.getUniqId());
	return ".admin_admin/referenceInqire";
    }
    
    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/insertReferenceArticle.do")
    public String insertReferenceArticle(
//    		                                                      final MultipartHttpServletRequest multiRequest, 
    		                                                      @ModelAttribute("searchVO") BoardVO boardVO,
	                                                              @ModelAttribute("bdMstr") BoardMaster bdMstr, 
	                                                              @ModelAttribute("board") Board board, 
	                                                              RedirectAttributes redirectAttributes,
	    ModelMap model) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		long nttId = 0;
		if (isAuthenticated) {
		    board.setFrstRegisterId(user.getId());
		    //리플 공지 게시판 아이디 : BBSMSTR_000000000003
			if("".equals(boardVO.getBbsId()))
					boardVO.setBbsId("BBSMSTR_000000000005");
		    	    
		    //board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    //board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    
		    //board.setNttCn(board.getNttCn());	// XSS 방지
			//escape된 문자열을 다시 원래 형태로 복원하여 DB에 저장한다. ckEditor의 사용상 화명에 태그 형태 대로 적용하기 위한 처리 방식임.
		    board.setNttCn(StringEscapeUtils.unescapeHtml(board.getNttCn()));
		    
		    nttId = 0;
			if( board.getNttId() == 0 ){
				nttId = bbsMngService.insertBoardArticle(board);	
				board.setNttId(nttId);
			}else{
			    board.setLastUpdusrId(user.getId());
				bbsMngService.updateBoardArticle(board);
				nttId = board.getNttId();
			}	
		}
		model.addAttribute("result", board);
		
		redirectAttributes.addFlashAttribute("nttId",String.valueOf(nttId));
		
		//등록
		return "redirect:/admin/referenceList.do";
    }    
    
    /**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    protected String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

        return ret;
    }
}
