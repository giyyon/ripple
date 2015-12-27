package xrpgate.join.web;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import xrpgate.join.model.KcpCertVO;
import xrpgate.login.web.LoginController;
import xrpgate.util.JSONResponseUtil;
import xrpgate.util.SupportUtil;
import xrpgate.common.model.JsonObject;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.ems.service.EgovSndngMailRegistService;
import egovframework.com.cop.ems.service.SndngMailVO;
import egovframework.com.sec.rgm.service.AuthorGroup;
import egovframework.com.sec.rgm.service.EgovAuthorGroupService;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.bind.annotation.CommandMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 일반회원관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *   2011.8.26	정진오			IncludedInfo annotation 추가
 *
 * </pre>
 */


@Controller
@RequestMapping(value = "/join")
//@SessionAttributes("mberManageVO")
public class JoinMberManageController {

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

    /** EgovSndngMailRegistService */
	@Resource(name = "sndngMailRegistService")
    private EgovSndngMailRegistService sndngMailRegistService;
	
	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;
	
    @Resource(name = "egovAuthorGroupService")
    private EgovAuthorGroupService egovAuthorGroupService;
    
	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	/**
	 * 일반회원, 기업회원 선정 화면으로 이동한다.
	 * @return joinStep1
	 * @throws Exception
	 */
	@RequestMapping("/joinStep1.do")
	public String userSeChoose()
			throws Exception {
		
		return ".basic_join/joinStep1";
	}
	
	/**
	 * 약관 동의 화면으로 이동한다.
	 * @return joinStep1
	 * @throws Exception
	 */
	@RequestMapping("/mem_join_chk.do")
	public String mem_join_chk()
			throws Exception {
		
		return ".basic_join/mem_join_chk";
	}
	
	/**
	 * 일반회원, 기업회원 선정 화면으로 이동한다.
	 * @param userSearchVO 검색조건정보
	 * @param mberManageVO 일반회원초기화정보
	 * @param model 화면모델
	 * @return uss/umt/EgovMberInsert
	 * @throws Exception
	 */
	@RequestMapping("/mem_join_p.do")
	public String mem_join_chk(@ModelAttribute("mberManageVO") MberManageVO mberManageVO,
										KcpCertVO certVO, Model model)
			throws Exception {
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		//년도목록
		vo.setCodeId("RIP901");
		List<?> year_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("year_result", year_result); 
		//월목록
		vo.setCodeId("RIP902");
		List<?> month_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("month_result", month_result); 
		//일목록
		vo.setCodeId("RIP903");
		List<?> day_result = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("day_result", day_result);

		return ".basic_join/mem_join_p";
	}
	
	/**
	 * 회원 가입 완료 화면으로 이동한다.
	 * @return joinStep1
	 * @throws Exception
	 */
	@RequestMapping("/memjoin_end.do")
	public String memjoin_end()
			throws Exception {
		
		return ".basic_join/memjoin_end";
	}
	
	
	/**
	 * 일반회원등록화면 - 실명확인으로 이동한다.
	 * @param userSearchVO 검색조건정보
	 * @param mberManageVO 일반회원초기화정보
	 * @param model 화면모델
	 * @return uss/umt/EgovMberInsert
	 * @throws Exception
	 */
	@RequestMapping("/gnrMberInsertView1.do")
	public String gnrMberInsertView1( @ModelAttribute("mberManageVO") MberManageVO mberManageVO, @ModelAttribute("loginVO") LoginVO  loginVO, Model model)
			throws Exception {
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//이메일 목록
		vo.setCodeId("SUP002");
		List<?> email_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("email_result", email_result); //이메일 목록
		return ".basic_join/grnMberInsert1";
	}

	
	/**
	 * 일반회원등록화면-최종 저장 .
	 * @param userSearchVO 검색조건정보
	 * @param mberManageVO 일반회원초기화정보
	 * @param model 화면모델
	 * @return F : .basic_join/grnMberInsert4, H : .basic_join/grnMberInsert3
	 * @throws Exception
	 */
	@RequestMapping("/gnrMberInsertMain.do")
	public String gnrMberInsertMain( @ModelAttribute("mberManageVO") MberManageVO mberManageVO, 
			KcpCertVO certVO, HttpServletRequest request,Model model)
			throws Exception {
			
			mberManageVO.setOldPassword(mberManageVO.getPassword());
			//가입상태 초기화 A:요청, P:승인 D:삭제
			mberManageVO.setMberSttus("P");
			// 성별, 지역, 생년월일 설정.
			mberManageVO.setSexdstnCode(certVO.getSex_code());
			mberManageVO.setLocalCode(certVO.getLocal_code());
			mberManageVO.setIhidnum(certVO.getBirth_day());
			mberManageVO.setMoblphonNo(certVO.getPhone_no());
			mberManageVO.setMberNm(certVO.getUser_name());
			//그룹정보 초기화
			//mberManageVO.setGroupId("1");
			//일반회원가입신청 등록시 일반회원등록기능을 사용하여 등록한다.
			mberManageService.insertMber(mberManageVO);
			
			//권한 부여
			MberManageVO afterMberManageVO = mberManageService.selectMberById(mberManageVO.getMberId());
			AuthorGroup authorGroup = new AuthorGroup();
			authorGroup.setUniqId(afterMberManageVO.getUniqId());
			authorGroup.setAuthorCode("ROLE_USER");
			authorGroup.setMberTyCode("USR01");
			
			egovAuthorGroupService.insertAuthorGroup(authorGroup);
        
			HttpSession sesseion = request.getSession();
			sesseion.setAttribute("mberManageVO", mberManageVO);
			
			sesseion.setAttribute("joinUserNm", mberManageVO.getMberNm());
			sesseion.setAttribute("joinUserId", mberManageVO.getMberId());
			sesseion.setAttribute("joinUserPw", mberManageVO.getOldPassword());
			
			model.addAttribute("mberManageVO", mberManageVO); // 회원정보
       	return  ".basic_join/joinComplete";
	}
	
	/**
	 * email 인증 발송1.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/SendVerifyEmailNumber1.do")
	public ResponseEntity<String>  sendVerifyEmailNumber(
		
		@ModelAttribute LoginVO  loginVO, HttpSession session, HttpServletRequest request, Model model) throws Exception {

		LOGGER.debug("loginVOgetName정보"+loginVO.getName());
		LOGGER.debug("loginVOgetEmail 정보"+loginVO.getEmail());
//		LOGGER.debug("loginVOgetMbTlNum 정보"+loginVO.getMbTlNum());
		LOGGER.debug("loginVOgetuserSe 정보"+loginVO.getUserSe());
			
		// 1. 유사 아이디 찾기	
		List<LoginVO> listVO = null;
		//List<LoginVO> listVO = loginService.searchIdForJoin(loginVO);
		boolean sendMailresult = false;
		boolean isSimilarUser = false;
		
		if(listVO.size() == 0){
			// 1. email 인증 번호 생성
			String verifyEmailNumber = new SupportUtil().gererateVerifyEmailNumber();		
			
	    	// 2. 임시 비밀번호를 이메일 발송한다.(메일연동솔루션 활용)
	    	SndngMailVO sndngMailVO = new SndngMailVO();
	    	sndngMailVO.setDsptchPerson("webmaster");
	    	sndngMailVO.setRecptnPerson(loginVO.getEmail());
	    	sndngMailVO.setSj("[공간정보융복합] 회원 가입 인증번호 발송");
	    	sndngMailVO.setEmailCn("고객님의 회원 가입 위한 인증번호는 " + verifyEmailNumber + " 입니다. 10분간만 유요한 인증번호입니다.");
	    	sndngMailVO.setAtchFileId("");
	    	
	    	sendMailresult = sndngMailRegistService.insertSndngMail(sndngMailVO);	
	    	
	    	//3. 유효 시간을 비교하기 위해 10분내 입력한 경우에 한해 인증 번호 유효성 부여
	        //  long diffSec = (toDay.getTimeInMillis() - yDay.getTimeInMillis()) / 1000;       //초
	    	Calendar toDay = Calendar.getInstance();
	    	long verifyStampTime = toDay.getTimeInMillis();
	    	
	    	session.setAttribute("sendVerifyStampTime",verifyStampTime);
	    	session.setAttribute("sendVerifyEmailNumber",verifyEmailNumber);
		}else{
			isSimilarUser = true;
		}

		JsonObject jo = new JsonObject();
		// 2. 결과 리턴
		//직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
		HashMap<String, Object> total  = new HashMap<String, Object>();
		HashMap<String, Object> data  = new HashMap<String, Object>();

		if(isSimilarUser){	
			total.put("IsSucceed", Boolean.FALSE);
			total.put("ErrorCode",  "ErrorSimilar");
			total.put("Data", listVO);	
		}else{
			if(sendMailresult){	
				total.put("IsSucceed", Boolean.TRUE);
				total.put("Message",  "회원 가입 인증번호를 발송했습니다. 해당 메일 계정으로 인증 번호 확인 후 인증번호 입력 바랍니다.");				
			}else{
				total.put("IsSucceed", Boolean.FALSE);
				total.put("ErrorCode",  "ErrorSendMail");
				total.put("Message",  "["+loginVO.getEmail() + "]메일 발송 생성에 실패했습니다. 관리자에게 문의 바랍니다.");	
			}
		}
//		return "jsonView";
//		return model;
		return JSONResponseUtil.getJSONResponse(total);
	}
	
	/**
	 * email 인증 발송1.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/SendVerifyEmailNumber2.do")
	public ResponseEntity<String>  sendVerifyEmailNumber2(
		@RequestParam String verifyEmailNumber, HttpSession session, HttpServletRequest request, Model model) throws Exception {

		LOGGER.debug("verifyEmailNumber정보"+verifyEmailNumber);
		//3. 유효 시간을 비교하기 위해 10분내 입력한 경우에 한해 인증 번호 유효성 부여
        //  long diffSec = (toDay.getTimeInMillis() - yDay.getTimeInMillis()) / 1000;       //초
    	Calendar toDay = Calendar.getInstance();
    	long stampTime = toDay.getTimeInMillis();
    	
    	long sendVerifyStampTime = ((Number) session.getAttribute("sendVerifyStampTime")).longValue();
    	long diffSec = (stampTime - sendVerifyStampTime) / 1000;
    	String sendVerifyEmailNumber = session.getAttribute("sendVerifyEmailNumber").toString();
    	
    	LOGGER.debug("현 시간 : "+stampTime);
    	LOGGER.debug("발송된 시간 : "+sendVerifyStampTime);
    	
    	LOGGER.debug("차이 시간 초 : "+diffSec);
    	
    	LOGGER.debug("현 verifyEmailNumber : "+verifyEmailNumber);
    	LOGGER.debug("발송된 sendVerifyEmailNumber : "+sendVerifyEmailNumber);
    	
		

		// 2. 결과 리턴
		//직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
		HashMap<String, Object> total  = new HashMap<String, Object>();
		HashMap<String, Object> data  = new HashMap<String, Object>();
		
    	if(sendVerifyEmailNumber.equals(verifyEmailNumber)){
    		if(diffSec < 600 ){
    			//성공
				total.put("IsSucceed", Boolean.TRUE);
    		}else{
    			//시간초과
    			total.put("IsSucceed", Boolean.FALSE);
				total.put("ErrorCode",  "ErrorTime");
				total.put("Message",  "시간이 초과 되어 인증 번호가 무효 되었습니다. 다시 진행하시기 바랍니다.");	
    		}
    	}else{
    		//인증키값 다름
			total.put("IsSucceed", Boolean.FALSE);
			total.put("ErrorCode",  "ErrorWrongNumber");
			total.put("Message",  "잘못된 인증 번호["+verifyEmailNumber+"]입니다. 다시 입력하시기 바랍니다.");	
   	}
		return JSONResponseUtil.getJSONResponse(total);
	}
	
	/**
	 * id 중복 검사
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/chkDuplicationGnrId.do", method = RequestMethod.POST)
	public ResponseEntity<String>  chkDuplicationGnrId(
			@ModelAttribute("mberManageVO") MberManageVO mberManageVO) throws Exception {

		LOGGER.debug("getMberId정보 : "+mberManageVO.getMberId());

//		MberManageVO oldMberManageVO = mberManageService.selectMber(mberManageVO.getMberId());
		MberManageVO oldMberManageVO = mberManageService.selectMberById(mberManageVO.getMberId());
		
    
		// 2. 결과 리턴
		//직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
		HashMap<String, Object> total  = new HashMap<String, Object>();
		HashMap<String, Object> data  = new HashMap<String, Object>();
		
    	if(oldMberManageVO != null ){
    		//중복된 사용자 있음
    			total.put("IsSucceed", Boolean.FALSE);
				total.put("Message",  "해당 ID로 존재합니다.");	
    	}else{
    		//중복된 사용자 있음
			total.put("IsSucceed", Boolean.TRUE);
			total.put("Message",  " 사용 가능한  ID입니다");	
    	
    	}
		return JSONResponseUtil.getJSONResponse(total);
	}

	/**
	 * 일반회원가입신청등록처리후로그인화면으로 이동한다.
	 * @param mberManageVO 일반회원가입신청정보
	 * @return forward:/uat/uia/egovLoginUsr.do
	 * @throws Exception
	 */
	@RequestMapping("/sbscrbMber.do")
	public String sbscrbMber(@ModelAttribute("mberManageVO") MberManageVO mberManageVO) throws Exception {

		//가입상태 초기화 A:요청, P:승인 D:삭제
		mberManageVO.setMberSttus("P");
		//그룹정보 초기화
		//mberManageVO.setGroupId("1");
		//일반회원가입신청 등록시 일반회원등록기능을 사용하여 등록한다.
		mberManageService.insertMber(mberManageVO);
		return "forward:/login/egovLoginUsr.do";
	}

	/**
	 * 일반회원 약관확인
	 * @param model 화면모델
	 * @return StplatCnfirmMber
	 * @throws Exception
	 */
	@RequestMapping("/SbscrbCnfirmMber.do")
	public String sbscrbCnfirmMber(@ModelAttribute("loginVO") LoginVO loginVO, Model model, HttpSession session, HttpServletRequest request) throws Exception {
//		//일반회원용 약관 아이디 설정
//		String stplatId = "STPLAT_0000000000001";
//		//회원가입유형 설정-일반회원
//		String sbscrbTy = "USR01";
//		//약관정보 조회
//		List<?> stplatList = mberManageService.selectStplat(stplatId);
//		model.addAttribute("stplatList", stplatList); //약관정보 포함
//		model.addAttribute("sbscrbTy", sbscrbTy); //회원가입유형 포함
		
		

		return ".basic_join/sbscrbCnfirm";
	}
	
	@RequestMapping("/kcpCertStart.do")
	public String kcpCertStart(@ModelAttribute("certVO") KcpCertVO certVO, HttpSession session, HttpServletRequest request, Model model) throws Exception{
		
		model.addAttribute("certVO", certVO);
		return ".popup_join/kcpcert_start";
	}
	
	@RequestMapping("/kcpCertProcReq.do")
	public String kcpCertProcReq(@ModelAttribute("certVO") KcpCertVO certVO, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception{
		
		return ".popup_join/kcpcert_proc_req";
	}
	
	@RequestMapping("/kcpCertProcRes.do")
	public String kcpCertProcRes(HttpSession session, HttpServletRequest request, Model model) throws Exception{
		
		return ".popup_join/kcpcert_proc_res";
	}
	
	/**
	 * 기존 회원인지 검사
	 * @param vo - 통신사에서 유일값을 가진 di
	 * @return result - di값이 존재시 userId 없으면 null
	 * @exception Exception
	 */

	@RequestMapping(value = "/chkDuplicationDi.do")
	public ResponseEntity<String>  chkDuplicationDi(
			@ModelAttribute("mberManageVO") MberManageVO mberManageVO) throws Exception {

		//mberManageVO.setDi(URLDecoder.decode(mberManageVO.getDi(), "UTF-8"));
		MberManageVO oldMberManageVO = mberManageService.selectChkJoinYn(mberManageVO.getDi());
		
    
		// 2. 결과 리턴
		//직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
		HashMap<String, Object> total  = new HashMap<String, Object>();
		HashMap<String, Object> data  = new HashMap<String, Object>();
		
    	if(oldMberManageVO != null ){
    		//중복된 사용자 있음
    			total.put("IsSucceed", Boolean.FALSE);
    			//total.put("mberId", oldMberManageVO.getMberId());
				total.put("Message",  "해당 "+ oldMberManageVO.getMberId() +"로 가입된 사용자 입니다..");	
    	}else{
    		//중복된 사용자 있음
			total.put("IsSucceed", Boolean.TRUE);
			total.put("Message",  "가입 가능한 사용자입니다.");	
    	
    	}
		return JSONResponseUtil.getJSONResponse(total);
	}
}