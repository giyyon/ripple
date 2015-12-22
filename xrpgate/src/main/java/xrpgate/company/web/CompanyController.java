package xrpgate.company.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

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

import xrpgate.common.model.JsonObject;
import xrpgate.util.JSONResponseUtil;
import xrpgate.util.SupportUtil;

@Controller
@RequestMapping(value = "/company")
public class CompanyController {


	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(CompanyController.class);

	/**
	 * 회사 소개  화면으로 들어간다
	 * @param 
	 * @return 회사 소개  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/companyIntro.do")
	public String ci() throws Exception {
		return ".basic_company/companyIntro";
	}

	/**
	 * 설립 목적  화면
	 * @param 
	 * @return 회사 소개  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/about.do")
	public String establish() throws Exception {
		return ".basic_company/about";
	}
	
	/**
	 * 리플소개
	 * @param 
	 * @return 리플소개  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/rippleintro.do")
	public String rippleIntro() throws Exception {
		return ".basic_company/rippleIntro";
	}
	
	/**
	 * 리플지갑만들기
	 * @param 
	 * @return 리플지갑만들기
	 * @exception Exception
	 */
	@RequestMapping(value = "/walletripple.do")
	public String walletripple() throws Exception {
		return ".basic_company/walletripple";
	}
	
	/**
	 * 리플보내기
	 * @param 
	 * @return 리플보내기  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/sendripple.do")
	public String sendripple() throws Exception {
		return ".basic_company/sendripple";
	}
	
	/**
	 * 구매하기
	 * @param 
	 * @return 구매하기  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/ripplebuy.do")
	public String ripplebuy() throws Exception {
		return ".basic_company/ripplebuy";
	}
	
	/**
	 * 판매하기
	 * @param 
	 * @return 판매하기  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/ripplesell.do")
	public String ripplesell() throws Exception {
		return ".basic_company/ripplesell";
	}
	
	/**
	 * 게이트웨이 등록
	 * @param 
	 * @return 게이트웨이 등록  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/gateway.do")
	public String gateway() throws Exception {
		return ".basic_company/gateway";
	}
	
	/**
	 * 리플잔고
	 * @param 
	 * @return 리플잔고  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/ripplebalance.do")
	public String ripplebalance() throws Exception {
		return ".basic_company/ripplebalance";
	}
	
	/**
	 * 리플비밀번호 수정
	 * @param 
	 * @return 리플비밀번호 수정  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/ripplepw.do")
	public String ripplepw() throws Exception {
		return ".basic_company/ripplepw";
	}
	
	/**
	 * 리플 이중인증 설정
	 * @param 
	 * @return 리플 이중인증 설정  화면
	 * @exception Exception
	 */
	@RequestMapping(value = "/rippledouble.do")
	public String rippledouble() throws Exception {
		return ".basic_company/rippledouble";
	}
		
}