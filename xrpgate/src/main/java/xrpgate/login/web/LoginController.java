package xrpgate.login.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.ems.service.SndngMailVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import xrpgate.util.JSONResponseUtil;
import xrpgate.util.SupportUtil;
import xrpgate.common.model.JsonObject;

/*
import com.gpki.gpkiapi.cert.X509Certificate;
import com.gpki.servlet.GPKIHttpServletRequest;
import com.gpki.servlet.GPKIHttpServletResponse;
*/

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.8.26	정진오			IncludedInfo annotation 추가
 *  2011.09.07  서준식          스프링 시큐리티 로그인 및 SSO 인증 로직을 필터로 분리
 *  2011.09.25  서준식          사용자 관리 컴포넌트 미포함에 대한 점검 로직 추가
 *  2011.09.27  서준식          인증서 로그인시 스프링 시큐리티 사용에 대한 체크 로직 추가
 *  2011.10.27  서준식          아이디 찾기 기능에서 사용자 리름 공백 제거 기능 추가
 *  </pre>
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {

	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	/** EgovCmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@IncludedInfo(name = "support로그인", listUrl = "/login/loginUsr.do", order = 15, gid = 10)
	@RequestMapping(value = "/loginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		if (EgovComponentChecker.hasComponent("mberManageService")) {
			model.addAttribute("useMemberManage", "true");
		}

		/*
		GPKIHttpServletResponse gpkiresponse = null;
		GPKIHttpServletRequest gpkirequest = null;

		try{

			gpkiresponse=new GPKIHttpServletResponse(response);
		    gpkirequest= new GPKIHttpServletRequest(request);
		    gpkiresponse.setRequest(gpkirequest);
		    model.addAttribute("challenge", gpkiresponse.getChallenge());
		    return "egovframework/com/uat/uia/EgovLoginUsr";

		}catch(Exception e){
		    return "egovframework/com/cmm/egovError";
		}
		*/
//		return ".contents_login/loginUsr";
		return ".basic_login/loginUsr";
	}

	/**
	 * 아이디 찾기  화면으로 들어간다
	 * @param 
	 * @return 아이디 찾기
	 * @exception Exception
	 */
	@RequestMapping(value = "/findId.do")
	public String findId(@ModelAttribute("mberManageVO") MberManageVO mberManageVO,
			                              Model model) throws Exception {
		
		//이메일 목록
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("SUP002");
		List<?> email_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("email_result", email_result); //이메일 목록
		
		return ".basic_login/findId";
	}
	
	/**
	 * 아이디 검색 결과 리턴
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/jsonFindId.do")
	public ResponseEntity<String>  jsonFindId(
		
		@ModelAttribute LoginVO  loginVO, HttpSession session, HttpServletRequest request, Model model) throws Exception {

		LOGGER.debug("loginVOgetName정보"+loginVO.getName());
		LOGGER.debug("loginVOgetEmail 정보"+loginVO.getEmail());
//		LOGGER.debug("loginVOgetMbTlNum 정보"+loginVO.getMbTlNum());
		LOGGER.debug("loginVOgetuserSe 정보"+loginVO.getUserSe());
			
		// 1. 유사 아이디 찾기
		Map<String, Object> map  = null;
//		Map<String, Object> map  = loginService.searchAllMatchId(loginVO);
		
		@SuppressWarnings("unchecked")
		List<LoginVO> listVO = (List<LoginVO>)map.get("similarList");
		
		boolean mailResult  = false;
//		boolean mailResult  = (boolean)map.get("mailResult");
		
		boolean isSimilarUser = false;
		
		if(listVO.size() == 0){
	
		}else{
			isSimilarUser = true;
		}

		// 2. 결과 리턴
		//직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
		HashMap<String, Object> total  = new HashMap<String, Object>();

		if(isSimilarUser){	
			total.put("IsSucceedSimilar", Boolean.TRUE);
			total.put("Data", listVO);	
		}else{
			total.put("IsSucceedSimilar", Boolean.FALSE);
			total.put("Message", "NoUser");
		}
		
		if(mailResult){	
			total.put("IsSucceedMail", Boolean.TRUE);
			total.put("Data", listVO);	
		}else{
			total.put("IsSucceedMail", Boolean.FALSE);
			total.put("Message", "메일 발송 내역이 없습니다. 이름,핸드폰번호,이메일 정보를 정확히 기입했는지 확입 바랍니다.");
		}
		
		return JSONResponseUtil.getJSONResponse(total);
	}
		
	/**
	 * 패스워드 찾기  화면으로 들어간다
	 * @param 
	 * @return 아이디 찾기
	 * @exception Exception
	 */
	@RequestMapping(value = "/findPassword.do")
	public String findPassword(@ModelAttribute("mberManageVO") MberManageVO mberManageVO,
			                              Model model) throws Exception {
		
		//이메일 목록
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("SUP002");
		List<?> email_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("email_result", email_result); //이메일 목록
		
		return ".basic_login/findPassword";
	}	
	
	/**
	 * 패스워드 검색 결과 리턴
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/jsonFindPassword.do")
	public ResponseEntity<String>  jsonFindPassword(
		
		@ModelAttribute LoginVO  loginVO, HttpSession session, HttpServletRequest request, Model model) throws Exception {

		LOGGER.debug("loginVOgetId정보"+loginVO.getId());
		LOGGER.debug("loginVOgetName정보"+loginVO.getName());
		LOGGER.debug("loginVOgetEmail 정보"+loginVO.getEmail());
//		LOGGER.debug("loginVOgetMbTlNum 정보"+loginVO.getMbTlNum());
		LOGGER.debug("loginVOgetuserSe 정보"+loginVO.getUserSe());
			
		// 1. 비밀번호 찾기
		boolean result = loginService.searchPassword(loginVO);

		// 2. 결과 리턴
		//직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
		HashMap<String, Object> total  = new HashMap<String, Object>();
		if (result) {
			total.put("IsSucceed", Boolean.TRUE);
			total.put("Message", "- 아이디 : "+loginVO.getId());
		} else {
			total.put("IsSucceed", Boolean.FALSE);
		}

		return JSONResponseUtil.getJSONResponse(total);
	}	
	
	/**
	 * 일반(세션) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "/successLogin.do")
	public String successLogin(@ModelAttribute("loginVO") LoginVO loginVO, 
			                                            HttpServletRequest request, 
			                                            
			                                            ModelMap model) throws Exception {

		//사용자 로그인 처리는 이미 login-filter에서 처리 하여 넘어온 이후이기 때문에 별도로 로그인 할 필요가 없음.
		
		// 1. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return ".contents_login/loginUsr";
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		LOGGER.debug("User Id : {}", user.getId());
		String requestAttrRedirectUrl  = "";
		String  sessionAttrRedirectUrl  = "";
		
		if(request.getAttribute("reDirectUrl") ==null )
				requestAttrRedirectUrl = "";
		else
			    requestAttrRedirectUrl  = request.getAttribute("reDirectUrl").toString();
		
		if(request.getSession().getAttribute("reDirectUrl") ==null )
			sessionAttrRedirectUrl = "";
		else
			sessionAttrRedirectUrl  = request.getSession().getAttribute("reDirectUrl").toString();
		
		LOGGER.debug("request.getAttribute(reDirectUrl) : {}", ""+requestAttrRedirectUrl);
		LOGGER.debug("Session.getAttribute(reDirectUrl) : {}", ""+sessionAttrRedirectUrl);

		
		String reDirectUrl = request.getParameter("reDirectUrl");
		
		try{
			
			if(reDirectUrl == null || "".equals(reDirectUrl)){
				
//				if(request.getAttribute("reDirectUrl") ==  null || "".equals(request.getAttribute("reDirectUrl").toString())){
				if(  "".equals(requestAttrRedirectUrl) && "".equals(sessionAttrRedirectUrl)){
					
					SavedRequest savedRequest = (SavedRequest) request.getSession().getAttribute("SPRING_SECURITY_SAVED_REQUEST");
					
					if(savedRequest == null){
							reDirectUrl = EgovProperties.getProperty("Globals.MainPage");       // /customer/noticeList.do				
							LOGGER.debug("명시적 리턴 url이 없는 경우 서버 환경 설정에서 가져옴 :  " + reDirectUrl);	
					}else{
						reDirectUrl = savedRequest.getRedirectUrl();
						LOGGER.debug("명시적 리턴 url이 없는 경우 이전 request에서 추출 " + reDirectUrl);	
					}
					
				}else{
					reDirectUrl = requestAttrRedirectUrl;
					if(reDirectUrl.equals("")){
						reDirectUrl = sessionAttrRedirectUrl;
						request.getSession().removeAttribute("reDirectUrl");
					}
				}

			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		
		LOGGER.debug("리턴 Url : {}", reDirectUrl);
		

		return "redirect:"+reDirectUrl;
		
//		// 1. 일반 로그인 처리
//		LoginVO resultVO = loginService.actionLogin(loginVO);
//
//		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
//
//			// 2-1. 로그인 정보를 세션에 저장
//			request.getSession().setAttribute("loginVO", resultVO);
//
//			return "redirect:/main/actionMain.do";
//
//		} else {
//			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
//			return "egovframework/com/uat/uia/EgovLoginUsr";
//		}
	}


	/**
	 * 로그인 후 메인화면으로 들어간다
	 * @param
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/main/actionMain.do")
	public String actionMain(ModelMap model) throws Exception {

		// 1. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		LOGGER.debug("User Id : {}", user.getId());

		/*
		// 2. 메뉴조회
		MenuManageVO menuManageVO = new MenuManageVO();
		menuManageVO.setTmp_Id(user.getId());
		menuManageVO.setTmp_UserSe(user.getUserSe());
		menuManageVO.setTmp_Name(user.getName());
		menuManageVO.setTmp_Email(user.getEmail());
		menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
		menuManageVO.setTmp_UniqId(user.getUniqId());
		List list_headmenu = menuManageService.selectMainMenuHead(menuManageVO);
		model.addAttribute("list_headmenu", list_headmenu);
		*/

		// 3. 메인 페이지 이동
		String main_page = Globals.MAIN_PAGE;

		LOGGER.debug("Globals.MAIN_PAGE > " + Globals.MAIN_PAGE);
		LOGGER.debug("main_page > {}", main_page);

		if (main_page.startsWith("/")) {
			return "forward:" + main_page;
		} else {
			return main_page;
		}

		/*
		if (main_page != null && !main_page.equals("")) {

			// 3-1. 설정된 메인화면이 있는 경우
			return main_page;

		} else {

			// 3-2. 설정된 메인화면이 없는 경우
			if (user.getUserSe().equals("USR")) {
				return "egovframework/com/EgovMainView";
			} else {
				return "egovframework/com/EgovMainViewG";
			}
		}
		*/
	}

	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {

		/*String userIp = EgovClntInfo.getClntIP(request);

		// 1. Security 연동
		return "redirect:/j_spring_security_logout";*/

		request.getSession().setAttribute("loginVO", null);
		String main_page = Globals.MAIN_PAGE;
		
		//return "redirect:/egovDevIndex.jsp";
		return "redirect:/main/index.do";
	}

	/**
	 * 아이디/비밀번호 찾기 화면으로 들어간다
	 * @param
	 * @return 아이디/비밀번호 찾기 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/egovIdPasswordSearch.do")
	public String idPasswordSearchView(ModelMap model) throws Exception {

		// 1. 비밀번호 힌트 공통코드 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM022");
		List<?> code = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("pwhtCdList", code);

		return "egovframework/com/uat/uia/EgovIdPasswordSearch";
	}

	/**
	 * 인증서안내 화면으로 들어간다
	 * @return 인증서안내 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/egovGpkiIssu.do")
	public String gpkiIssuView(ModelMap model) throws Exception {
		return "egovframework/com/uat/uia/EgovGpkiIssu";
	}

	/**
	 * 아이디를 찾는다.
	 * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
	 * @return result - 아이디
	 * @exception Exception
	 */
	@RequestMapping(value = "/SearchId.do")
	public String searchId(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

		if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("") && loginVO.getEmail() == null || loginVO.getEmail().equals("")
				&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")) {
			return "egovframework/com/cmm/egovError";
		}

		// 1. 아이디 찾기
		loginVO.setName(loginVO.getName().replaceAll(" ", ""));
		List<LoginVO> listVO = null;
//		List<LoginVO> listVO = loginService.searchIdForForget(loginVO);

		if (listVO.size() != 0 ) {
			//model.addAttribute("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		} else {
			model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.idsearch"));
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		}
	}
	

	/**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/searchPassword.do")
	public String searchPassword(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

		if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("") && loginVO.getName() == null || loginVO.getName().equals("") && loginVO.getEmail() == null
				|| loginVO.getEmail().equals("") && loginVO.getPasswordHint() == null || loginVO.getPasswordHint().equals("") && loginVO.getPasswordCnsr() == null
				|| loginVO.getPasswordCnsr().equals("") && loginVO.getUserSe() == null || loginVO.getUserSe().equals("")) {
			return "egovframework/com/cmm/egovError";
		}

		// 1. 비밀번호 찾기
		boolean result = loginService.searchPassword(loginVO);

		// 2. 결과 리턴
		if (result) {
			model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		} else {
			model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.pwsearch"));
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		}
	}

	/**
	 * 개발 시스템 구축 시 발급된 GPKI 서버용인증서에 대한 암호화데이터를 구한다.
	 * 최초 한번만 실행하여, 암호화데이터를 EgovGpkiVariables.js의 ServerCert에 넣는다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/getEncodingData.do")
	public void getEncodingData() throws Exception {

		/*
		X509Certificate x509Cert = null;
		byte[] cert = null;
		String base64cert = null;
		try {
			x509Cert = Disk.readCert("/product/jeus/egovProps/gpkisecureweb/certs/SVR1311000011_env.cer");
			cert = x509Cert.getCert();
			Base64 base64 = new Base64();
			base64cert = base64.encode(cert);
			log.info("+++ Base64로 변환된 인증서는 : " + base64cert);

		} catch (GpkiApiException e) {
			e.printStackTrace();
		}
		*/
	}

	/**
	 * 인증서 DN추출 팝업을 호출한다.
	 * @return 인증서 등록 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/EgovGpkiRegist.do")
	public String gpkiRegistView(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		/** GPKI 인증 부분 */
		// OS에 따라 (local NT(로컬) / server Unix(서버)) 구분
		String os = System.getProperty("os.arch");
		LOGGER.debug("OS : {}", os);
		
		//String virusReturn = null;

		/*
		// 브라우저 이름을 받기위한 처리
		String webKind = EgovClntInfo.getClntWebKind(request);
		String[] ss = webKind.split(" ");
		String browser = ss[1];
		model.addAttribute("browser",browser);
		// -- 여기까지
		if (os.equalsIgnoreCase("x86")) {
		    //Local Host TEST 진행중
		} else {
		    if (browser.equalsIgnoreCase("Explorer")) {
		GPKIHttpServletResponse gpkiresponse = null;
		GPKIHttpServletRequest gpkirequest = null;

		try {
		    gpkiresponse = new GPKIHttpServletResponse(response);
		    gpkirequest = new GPKIHttpServletRequest(request);

		    gpkiresponse.setRequest(gpkirequest);
		    model.addAttribute("challenge", gpkiresponse.getChallenge());

		    return "egovframework/com/uat/uia/EgovGpkiRegist";

		} catch (Exception e) {
		    return "egovframework/com/cmm/egovError";
		}
		}
		}
		*/
		return "egovframework/com/uat/uia/EgovGpkiRegist";
	}

	/**
	 * 인증서 DN값을 추출한다
	 * @return result - dn값
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionGpkiRegist.do")
	public String actionGpkiRegist(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		/** GPKI 인증 부분 */
		// OS에 따라 (local NT(로컬) / server Unix(서버)) 구분
		String os = System.getProperty("os.arch");
		LOGGER.debug("OS : {}", os);
		
		// String virusReturn = null;
		@SuppressWarnings("unused")
		String dn = "";

		// 브라우저 이름을 받기위한 처리
		String webKind = EgovClntInfo.getClntWebKind(request);
		String[] ss = webKind.split(" ");
		String browser = ss[1];
		model.addAttribute("browser", browser);
		/*
		// -- 여기까지
		if (os.equalsIgnoreCase("x86")) {
			// Local Host TEST 진행중
		} else {
			if (browser.equalsIgnoreCase("Explorer")) {
				GPKIHttpServletResponse gpkiresponse = null;
				GPKIHttpServletRequest gpkirequest = null;
				try {
					gpkiresponse = new GPKIHttpServletResponse(response);
					gpkirequest = new GPKIHttpServletRequest(request);
					gpkiresponse.setRequest(gpkirequest);
					X509Certificate cert = null;

					// byte[] signData = null;
					// byte[] privatekey_random = null;
					// String signType = "";
					// String queryString = "";

					cert = gpkirequest.getSignerCert();
					dn = cert.getSubjectDN();

					model.addAttribute("dn", dn);
					model.addAttribute("challenge", gpkiresponse.getChallenge());

					return "egovframework/com/uat/uia/EgovGpkiRegist";
				} catch (Exception e) {
					return "egovframework/com/cmm/egovError";
				}
			}
		}
		*/
		return "egovframework/com/uat/uia/EgovGpkiRegist";
	}
	
	@RequestMapping(value="/findIdByMber.do")
	@ResponseBody
	public HashMap<String, Object> findIdByMber(MberManageVO mberVo) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String mberId = mberManageService.selectMberIdByMberNm(mberVo);
		
		if("".equals(mberId) || mberId == null){
			map.put("message", "등록된 ID가 존재하지 않습니다.");
			map.put("isSuccess", false);
		} else {
			map.put("isSuccess", true);
			map.put("mberId", mberId);
		}
		
		return map;
	}
	
	@RequestMapping(value="/findPassByMber.do")
	@ResponseBody
	public HashMap<String, Object> findPassByMber(MberManageVO mberVo) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String tempPass = mberManageService.selectMberPassByMberNm(mberVo);
		
		if("".equals(tempPass) || tempPass == null){
			map.put("message", "임시 비밀번호 발급에 실패하였습니다.");
			map.put("isSuccess", false);
		} else {
			map.put("isSuccess", true);
			map.put("tempPass", tempPass);
		}
		
		return map;
	}
}