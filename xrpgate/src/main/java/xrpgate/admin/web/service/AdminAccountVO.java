package xrpgate.admin.web.service;

import java.io.Serializable;

/**
 * 회원 계좌 정보 및 예탁/인출 관리 VO 클랙스
 * @author  박세은
 * @since 2016.01.08
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *
 * </pre>
 */
public class AdminAccountVO  implements Serializable {

		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 은행 코드
	 */
	private String bankId;
	
	/**
	 * 은행명
	 */
	private String bankNm;
	
	/**
	 * 계좌번호
	 */
	private String account;
	
	/**
	 * 리플 지갑
	 */
	private String rippleTrade;

	public String getBankId() {
		return bankId;
	}

	public void setBankId(String bankId) {
		this.bankId = bankId;
	}

	public String getBankNm() {
		return bankNm;
	}

	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getRippleTrade() {
		return rippleTrade;
	}

	public void setRippleTrade(String rippleTrade) {
		this.rippleTrade = rippleTrade;
	}
		
		
}
