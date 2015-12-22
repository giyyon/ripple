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

	private long tradeId = 0L;

	private String tradeType = "";
		
	private long requestBuyMoney = 0L;

	private long requestSellQty =0L;

	private long resultUnitPrice = 0L;

	private long resultQty = 0L;

	private long resultTotMoney = 0L;

	private long fee = 0L;

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

	public long getRequestBuyMoneyOrSellQty() {
		if (this.tradeType.equals("B")){
			return getRequestBuyMoney();
		}else{
			return getRequestSellQty();
		}
	}
	
	public long getRequestBuyMoney() {
		return requestBuyMoney;
	}

	public void setRequestBuyMoney(long requestBuyMoney) {
		this.requestBuyMoney = requestBuyMoney;
	}

	public long getRequestSellQty() {
		return requestSellQty;
	}

	public void setRequestSellQty(long requestSellQty) {
		this.requestSellQty = requestSellQty;
	}

	public long getResultUnitPrice() {
		return resultUnitPrice;
	}

	public void setResultUnitPrice(long resultUnitPrice) {
		this.resultUnitPrice = resultUnitPrice;
	}

	public long getResultQty() {
		return resultQty;
	}

	public void setResultQty(long resultQty) {
		this.resultQty = resultQty;
	}

	public long getResultTotMoney() {
		return resultTotMoney;
	}

	public void setResultTotMoney(long resultTotMoney) {
		this.resultTotMoney = resultTotMoney;
	}

	public long getFee() {
		return fee;
	}

	public void setFee(long fee) {
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
	
}
