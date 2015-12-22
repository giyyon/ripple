package xrpgate.util;

import egovframework.com.utl.fcc.service.EgovNumberUtil;

public class SupportUtil {

	   /**
		 * 이메일 인증용 번호 생성.
		 * @param vo LoginVO
		 * @return boolean
		 * @exception Exception
		 */
 public String gererateVerifyEmailNumber() throws Exception {

 	// 1. 임시 인증번호를 생성한다.(숫=5자리)
 	String verifyEmailNumber = "";
 	for (int i = 1; i <= 5; i++) {
 		// 숫자
 		verifyEmailNumber += EgovNumberUtil.getRandomNum(0, 9);
 	}
 	return verifyEmailNumber;
 }
}
