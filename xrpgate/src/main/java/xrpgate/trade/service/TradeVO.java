package xrpgate.trade.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * Trade 관리를 위한 VO 클래스
 * @author  박세은
 * @since 2015.07.29
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
@SuppressWarnings("serial")
public class TradeVO  implements Serializable {

	private long tradeId ;

	private String tradeType = "";
		
	private double requestBuyMoney = 0L;

	private double requestSellQty =0L;

	private double resultUnitPrice = 0L;

	private long resultQty = 0L;

	private double resultTotMoney = 0L;

	private double fee = 0L;

	private String status = "";

	private String requestDt = "";

	private String requestErId = "";

	private String updateDt = "";

	private String updateErId = "";

	private String mberNm = "";
	
	private String moblphonNo = "";	
	
	private String rippleTradeId = "";
	
	private String rippleTradeEmail = "";
	
	private String dumPointCardNo = "";
	
	private String requestId;
	
	private String requestTime;
	
	/**
	 * 누적 수량
	 */
	private String accumulateQty;

	/**
	 * 요청 수량
	 */
	private double requestQty = 0L;
	
	/**
	 * 요청 금액
	 */
	private double requestMoney = 0L;
	
	/**
	 * 거래 상품 유형
	 */
	private String productType;
	
	/**
	 * 고객 은행
	 */
	private String bankNm;
	
	/**
	 * 고객 계좌 번호
	 */
	private String account;
	
	/**
	 * 결재 통화 유형
	 */
	private String paymentCurrency;
	
	private double rowSum = 0;
	
	public String getMoblphonNo() {
		return moblphonNo;
	}

	public void setMoblphonNo(String moblphonNo) {
		this.moblphonNo = moblphonNo;
	}

	public long getTradeId() {
		return tradeId;
	}

	public void setTradeId(long tradeId) {
		this.tradeId = tradeId;
	}

	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}

	public String getTradeTypeNm() {
		if (this.tradeType.equals("B")){
			return "구입";
		}else{
			return "판매";
		}
	}

	public double getRequestBuyMoneyOrSellQty() {
		if (this.tradeType.equals("B")){
			return getRequestBuyMoney();
		}else{
			return getRequestSellQty();
		}
	}
	
	public double getRequestBuyMoney() {
		return requestBuyMoney;
	}

	public void setRequestBuyMoney(long requestBuyMoney) {
		this.requestBuyMoney = requestBuyMoney;
	}

	public double getRequestSellQty() {
		return requestSellQty;
	}

	public void setRequestSellQty(double requestSellQty) {
		this.requestSellQty = requestSellQty;
	}

	public double getResultUnitPrice() {
		return resultUnitPrice;
	}

	public void setResultUnitPrice(double resultUnitPrice) {
		this.resultUnitPrice = resultUnitPrice;
	}

	public double getResultQty() {
		return resultQty;
	}

	public void setResultQty(long resultQty) {
		this.resultQty = resultQty;
	}

	public double getResultTotMoney() {
		return resultTotMoney;
	}

	public void setResultTotMoney(double resultTotMoney) {
		this.resultTotMoney = resultTotMoney;
	}

	public double getFee() {
		return fee;
	}

	public void setFee(double fee) {
		this.fee = fee;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRequestDt() {
		return requestDt;
	}

	public void setRequestDt(String requestDt) {
		this.requestDt = requestDt;
	}

	public String getRequestErId() {
		return requestErId;
	}

	public void setRequestErId(String requestErId) {
		this.requestErId = requestErId;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}

	public String getUpdateErId() {
		return updateErId;
	}

	public void setUpdateErId(String updateErId) {
		this.updateErId = updateErId;
	}

	public String getMberNm() {
		return mberNm;
	}

	public void setMberNm(String mberNm) {
		this.mberNm = mberNm;
	}

	public String getRippleTradeId() {
		return rippleTradeId;
	}

	public void setRippleTradeId(String rippleTradeId) {
		this.rippleTradeId = rippleTradeId;
	}

	public String getRippleTradeEmail() {
		return rippleTradeEmail;
	}

	public void setRippleTradeEmail(String rippleTradeEmail) {
		this.rippleTradeEmail = rippleTradeEmail;
	}

	public String getDumPointCardNo() {
		return dumPointCardNo;
	}

	public void setDumPointCardNo(String dumPointCardNo) {
		this.dumPointCardNo = dumPointCardNo;
	}

	public double getRequestQty() {
		return requestQty;
	}

	public void setRequestQty(double requestQty) {
		this.requestQty = requestQty;
	}

	public double getRequestMoney() {
		return requestMoney;
	}

	public void setRequestMoney(double requestMoney) {
		this.requestMoney = requestMoney;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getPaymentCurrency() {
		return paymentCurrency;
	}

	public void setPaymentCurrency(String paymentCurrency) {
		this.paymentCurrency = paymentCurrency;
	}

	public void setRequestBuyMoney(double requestBuyMoney) {
		this.requestBuyMoney = requestBuyMoney;
	}

	public double getRowSum() {
		return rowSum;
	}

	public void setRowSum(double rowSum) {
		this.rowSum = rowSum;
	}

	public String getRequestId() {
		return requestId;
	}

	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}

	public String getRequestTime() {
		return requestTime;
	}

	public void setRequestTime(String requestTime) {
		this.requestTime = requestTime;
	}

	public String getAccumulateQty() {
		return accumulateQty;
	}

	public void setAccumulateQty(String accumulateQty) {
		this.accumulateQty = accumulateQty;
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
	
	
}
