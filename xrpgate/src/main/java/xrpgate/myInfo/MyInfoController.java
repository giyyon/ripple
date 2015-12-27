package xrpgate.myInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import xrpgate.login.web.LoginController;
import xrpgate.trade.service.TradeDetailVO;
import xrpgate.trade.service.TradeManageService;
import xrpgate.trade.service.TradeVO;
import xrpgate.util.JSONResponseUtil;
import xrpgate.common.model.JsonObject;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.cop.bbs.service.EgovBBSScrapService;
import egovframework.com.cop.bbs.service.ScrapVO;
import egovframework.com.cop.ems.service.EgovSndngMailRegistService;
import egovframework.com.sec.rgm.service.EgovAuthorGroupService;
import egovframework.com.uss.umt.service.EgovEntrprsManageService;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.EntrprsManageVO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 일반회원관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 박세은
 * @since 215.2
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2015.02.          최초 생성
 *
 * </pre>
 */


@Controller
@RequestMapping(value = "/myInfo")
@SessionAttributes(types=SessionVO.class)
public class MyInfoController {

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;
	
    /** entrprsManageService */
    @Resource(name = "entrprsManageService")
    private EgovEntrprsManageService entrprsManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;


    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;    // egovframework.com.cmm.service.EgovProperties.java
	

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

    /** EgovSndngMailRegistService */
	@Resource(name = "sndngMailRegistService")
    private EgovSndngMailRegistService sndngMailRegistService;
	
    @Resource(name = "egovAuthorGroupService")
    private EgovAuthorGroupService egovAuthorGroupService;
    
    
    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;
    
    @Resource(name = "tradeManageService")
    private TradeManageService tradeManageService;
    
	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	/**
	 * 일반회원 정보 화면으로 이동한다.
	 * @param userSearchVO 검색조건정보
	 * @param mberManageVO 일반회원초기화정보
	 * @param model 화면모델
	 * @return uss/umt/EgovMberInsert
	 * @throws Exception
	 */
	@RequestMapping("/myInfoInqire.do")
	public String myInfoInqire( 
			Model model)
			throws Exception {
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		LOGGER.debug("loginVOgetid정보"+loginVO.getId());
		LOGGER.debug("loginVOgetuserSe 정보"+loginVO.getUserSe());
		
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
		return ".basic_myInfo/myInfoInqire";
	}
	

    @SuppressWarnings("unchecked")
    @RequestMapping("/myRippleTradeList.do")
    public String myRippleTradeList(@ModelAttribute("searchVO") BoardVO boardVO,
                                                      @ModelAttribute("tradeDetailVO") TradeDetailVO tradeDetailVO,
                                                      RedirectAttributes redirectAttributes,
                                                      ModelMap model) throws Exception {

    	LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	tradeDetailVO.setRequestErId(loginVO.getId());	
    	
    	tradeDetailVO.setPageUnit(propertyService.getInt("pageUnit"));
    	tradeDetailVO.setPageSize(propertyService.getInt("pageSize"));
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
    	paginationInfo.setCurrentPageNo(tradeDetailVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(tradeDetailVO.getPageUnit());
    	paginationInfo.setPageSize(tradeDetailVO.getPageSize());

    	tradeDetailVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	tradeDetailVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	tradeDetailVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	
//		tradeDetailVO.setTradeType(""); // 모두 가져오기
		Map<String, Object> map = tradeManageService.selectRippleTradeList(tradeDetailVO);	
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("tradeDetailVO", tradeDetailVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//model.addAttribute("message", "전화상담이 등록되었습니다. 상담 담당자가 등록하신 연락처로 연락드리겠습니다.");
		return ".basic_myInfo/myRippleTradeList";
    }    
	
    /**
     * 마이페이지 이동전 비밀번호 체크 페이지 이동
	 * @param mberManageVO 
	 * @return ResponseEntity
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberChk.do")
	public String  gomemberChkPage ( @ModelAttribute("mberManageVO") MberManageVO mberManageVO) throws Exception {

    	return ".basic_myInfo/meminfo_chk";
	}
    
    /**
     * 마이페이지 이동전 비밀번호 체크
	 * @param mberManageVO 
	 * @return ResponseEntity
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberPasswordChk.do")
	public String  memberPasswordChk( @ModelAttribute("mberManageVO") MberManageVO mberManageVO) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		LOGGER.debug("getPassword정보 : "+mberManageVO.getPassword());
		LOGGER.debug("getOldPassword정보 : "+mberManageVO.getOldPassword());
		boolean isCorrectPassword = false;
		
		mberManageVO.setMberId(user.getId());
		// 기존 비밀번호 조회
		MberManageVO resultVO = mberManageService.selectPassword(mberManageVO);
		//패스워드 암호화
		String encryptPass = EgovFileScrty.encryptPassword(mberManageVO.getPassword(), mberManageVO.getMberId());
		
		// 조회된 비밀번호와 입력된 비밀번호 비교
		if (encryptPass.equals(resultVO.getPassword())) {
			isCorrectPassword = true;
		} else {
			//비밀번호 불일치
			isCorrectPassword = false;
		}

		String returnUrl = "";
    	if(isCorrectPassword  ){
			
    		returnUrl = "redirect:/myInfo/myInfoInqire.do";
    		
    	}else{
    		returnUrl = ".basic_myInfo/meminfo_chk";
    	
    	}
    	return returnUrl;
	}	
	
	/**
	 * @param mberManageVO 일반회원수정정보(비밀번호)
	 * @return ResponseEntity
	 * @throws Exception
	 */
	@RequestMapping(value = "/jsonGnrPasswordChange.do")
	public ResponseEntity<String>  jsonGnrPasswordChange(
			@ModelAttribute("mberManageVO") MberManageVO mberManageVO) throws Exception {

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		LOGGER.debug("getPassword정보 : "+mberManageVO.getPassword());
		LOGGER.debug("getOldPassword정보 : "+mberManageVO.getOldPassword());
		boolean isCorrectPassword = false;
	
		MberManageVO resultVO = mberManageService.selectPassword(mberManageVO);
		//패스워드 암호화
		String encryptPass = EgovFileScrty.encryptPassword(mberManageVO.getOldPassword());
		if (encryptPass.equals(resultVO.getPassword())) {
			isCorrectPassword = true;
		} else {
			//비밀번호 오류.
			isCorrectPassword = false;
		}

		// 2. 결과 리턴
		//직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
		HashMap<String, Object> total  = new HashMap<String, Object>();
		
    	if(isCorrectPassword  ){
			mberManageVO.setPassword(EgovFileScrty.encryptPassword(mberManageVO.getPassword()));
			mberManageService.updatePassword(mberManageVO);
    		
    		//비밀번호 일치
			total.put("IsSucceed", Boolean.TRUE);
			total.put("Message",  "비밀번호가 성공적으로 변경되었습니다.");	
    	}else{
    		//비밀번호 불일치
			total.put("IsSucceed", Boolean.FALSE);
			total.put("Message",  "저장된 비밀번호와 일치하지 않습니다.");	
    	
    	}
		return JSONResponseUtil.getJSONResponse(total);
	}	
	

	/**
	 * 일반회원정보 수정
	 * @param mberId 상세조회대상 일반회원아이디
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return uss/umt/EgovMberSelectUpdt
	 * @throws Exception
	 */
	@RequestMapping("/updateGnrMyInfo.do")
	public String updateGnrMyInfo(@ModelAttribute("mberManageVO") MberManageVO mberManageVO,
																 @RequestParam("progressStauts") String progressStauts,
																 Model model) throws Exception {
		
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		LOGGER.debug("loginVOgetid정보"+loginVO.getId());
		LOGGER.debug("loginVOgetuserSe 정보"+loginVO.getUserSe());
		
		mberManageService.updateMberMain(mberManageVO);
		//Exception 없이 진행시 수정성공메시지
		model.addAttribute("resultMsg", "success.common.update");
		
        if("F".equals(progressStauts)){
			return "forward:/myInfo/myInfoView.do";
   			
        }else{
    		//"H".equals(progressStauts)
        	return  ".basic_myInfo/grnMberMyInfoSub"; 
        }
	}

	
	// 탈퇴 처리 기능에 대한 예시
	@RequestMapping("/updateWithdraw.do")
	public String updateWithdraw(Model model) throws Exception {
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		String returnPage = "/"; // 탈퇴 처리 후 화면 지정

		if (!isAuthenticated) {
			model.addAttribute("resultMsg", "fail.common.delete");

			return "redirect:" + returnPage;
		}else{
			returnPage = "/login/actionLogout.do";
		}
		
		//일반 회원
		if(loginVO.getUserSe().equals("GNR")){			
			mberManageService.updateWithdraw(loginVO.getId());
		}
		
		//Exception 없이 진행시 삭제성공메시지
		model.addAttribute("resultMsg", "success.common.delete");

		return "redirect:" + returnPage;
	}	


    /**
     * 나의 리플 판매 요청 목록을 조회한다.
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

	//공지사항 게시판 아이디 : BBSMSTR_000000000001
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000001");

	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());

	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	if(user != null)
		vo.setUniqId(user.getUniqId());
	
	BoardMasterVO master  = null; 
//	new BoardMasterVO();

	//-------------------------------
	// 방명록이면 방명록 URL로 forward
	//-------------------------------
	if (master.getBbsTyCode().equals("BBST04")) {
	    return "forward:/cop/bbs/selectGuestList.do";
	}
	////-----------------------------

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
	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, master.getBbsAttrbCode());//2011.09.07
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	//-------------------------------
	// 기본 BBS template 지정 
	//-------------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/com/cop/tpl/egovBaseTemplate.css");
	}
	////-----------------------------

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);

	return ".basic_customer/noticeList";
    }


    /**
     * 나의 리플 구매 요청 목록을 조회한다.
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

	//공지사항 게시판 아이디 : BBSMSTR_000000000001
	if("".equals(boardVO.getBbsId()))
			boardVO.setBbsId("BBSMSTR_000000000001");

	boardVO.setBbsId(boardVO.getBbsId());
	boardVO.setBbsNm(boardVO.getBbsNm());

	BoardMasterVO vo = new BoardMasterVO();
	
	vo.setBbsId(boardVO.getBbsId());
	
	if(user != null)
		vo.setUniqId(user.getUniqId());
	
	BoardMasterVO master  = null; 
//	new BoardMasterVO();

	//-------------------------------
	// 방명록이면 방명록 URL로 forward
	//-------------------------------
	if (master.getBbsTyCode().equals("BBST04")) {
	    return "forward:/cop/bbs/selectGuestList.do";
	}
	////-----------------------------

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
	Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, master.getBbsAttrbCode());//2011.09.07
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	//-------------------------------
	// 기본 BBS template 지정 
	//-------------------------------
	if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
	    master.setTmplatCours("/css/egovframework/com/cop/tpl/egovBaseTemplate.css");
	}
	////-----------------------------

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("boardVO", boardVO);
	model.addAttribute("brdMstrVO", master);
	model.addAttribute("paginationInfo", paginationInfo);

	return ".basic_customer/noticeList";
    }
    
}