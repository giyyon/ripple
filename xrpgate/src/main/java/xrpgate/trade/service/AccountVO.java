package xrpgate.trade.service;

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
public class AccountVO  implements Serializable {

		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

		/**
		 *  회원 ID
		 */
		public String mberId;
		
		/**
		 *  예탁금
		 */
		public double deposit;
		
		/**
		 * XRP 예탁금
		 */
		public double xrpDeposit;
		
		/**
		 * 수수료율
		 */
		public double charge;
		
		/**
		 * 거래 ID
		 */
		public int tradeId;
		
		/**
		 * 거래 유형
		 */
		public String tradeType;
		
		/**
		 * 거래 금액
		 */
		public double transactionsMoney;
		
		/**
		 * 요청자 ID
		 */
		public String requestId;
		
		/**
		 * 거래 수수료율
		 */
		public double tradeCharge;
		
		/**
		 * 진행 상태
		 */ 
		public String status;
		
		/**
		 * 거래 날자
		 */
		public String requestDt;
		
		/**
		 * 수수료
		 */
		public double fee;
		
		/**
		 * 거래 완료 일자
		 */
		public String tradeCompleteDt;
		
		/**
		 * 비고
		 */
		public String remark;
		
		/**
		 * 리플 지갑 주소
		 */
		public String rippleTradeEmail;
		
		public String mberNm;
		
		public String rowNum;
		
		/**
		 * 진행상태 명
		 */
		private String statusNm;

		public String getMberId() {
			return mberId;
		}

		public void setMberId(String mberId) {
			this.mberId = mberId;
		}

		public double getDeposit() {
			return deposit;
		}

		public void setDeposit(double deposit) {
			this.deposit = deposit;
		}

		public double getXrpDeposit() {
			return xrpDeposit;
		}

		public void setXrpDeposit(double xrpDeposit) {
			this.xrpDeposit = xrpDeposit;
		}

		public int getTradeId() {
			return tradeId;
		}

		public void setTradeId(int tradeId) {
			this.tradeId = tradeId;
		}

		public String getTradeType() {
			return tradeType;
		}

		public void setTradeType(String tradeType) {
			this.tradeType = tradeType;
		}

		public String getRequestId() {
			return requestId;
		}

		public void setRequestId(String requestId) {
			this.requestId = requestId;
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

		public double getFee() {
			return fee;
		}

		public void setFee(double fee) {
			this.fee = fee;
		}

		public String getTradeCompleteDt() {
			return tradeCompleteDt;
		}

		public void setTradeCompleteDt(String tradeCompleteDt) {
			this.tradeCompleteDt = tradeCompleteDt;
		}

		public String getRemark() {
			return remark;
		}

		public void setRemark(String remark) {
			this.remark = remark;
		}

		public double getCharge() {
			return charge;
		}

		public void setCharge(double charge) {
			this.charge = charge;
		}

		public double getTransactionsMoney() {
			return transactionsMoney;
		}

		public void setTransactionsMoney(double transactionsMoney) {
			this.transactionsMoney = transactionsMoney;
		}

		public double getTradeCharge() {
			return tradeCharge;
		}

		public void setTradeCharge(double tradeCharge) {
			this.tradeCharge = tradeCharge;
		}

		public String getRippleTradeEmail() {
			return rippleTradeEmail;
		}

		public void setRippleTradeEmail(String rippleTradeEmail) {
			this.rippleTradeEmail = rippleTradeEmail;
		}

		public String getMberNm() {
			return mberNm;
		}

		public void setMberNm(String mberNm) {
			this.mberNm = mberNm;
		}

		public String getRowNum() {
			return rowNum;
		}

		public void setRowNum(String rowNum) {
			this.rowNum = rowNum;
		}

		public String getStatusNm() {
			return statusNm;
		}

		public void setStatusNm(String statusNm) {
			this.statusNm = statusNm;
		}

		
		
}
