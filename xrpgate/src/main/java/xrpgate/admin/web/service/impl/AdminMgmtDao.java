package xrpgate.admin.web.service.impl;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;










import xrpgate.admin.web.service.AdminAccountVO;
import xrpgate.admin.web.service.XrpChartVO;
import xrpgate.trade.service.AccountVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.uss.umt.service.MberManageVO;

@Repository("adminMgmtDao")
public class AdminMgmtDao extends EgovComAbstractDAO {

	public AdminAccountVO selectRippleAccountInfo() throws Exception{
		return (AdminAccountVO) select("AdminManageDAO.selectRippleAccountInfo");
	}
	
	public void updateRippleAccountInfo(AdminAccountVO accountVo)
			throws Exception {
		update("AdminManageDAO.updateRippleAccountInfo",accountVo);
	}
	
	/**
	 * 최저가
	 * @return
	 * @throws Exception
	 */
	public double selectXrpLowVolume() throws Exception {
		return  (Double) select("AdminManageDAO.selectXrpLowVolume");
	}
	
	/**
	 * 최고가
	 * @return
	 * @throws Exception
	 */
	public double selectXrpHighVolume() throws Exception {
		return (Double) select("AdminManageDAO.selectXrpHighVolume");
	}
	
	/**
	 * 매수호가
	 * @return
	 * @throws Exception
	 */
	public double selectXrpAsksVolume() throws Exception {
		return (Double) select("AdminManageDAO.selectXrpAsksVolume");
	}
	
	/**
	 * 매도호가
	 * @return
	 * @throws Exception
	 */
	public double selectXrpBidsVolume() throws Exception {
		return (Double) select("AdminManageDAO.selectXrpBidsVolume");
	}
	
	/**
	 * 스프레드
	 * @return
	 * @throws Exception
	 */
	public String selectXrpSpreadsVolume() throws Exception {
		String close = (String) select("AdminManageDAO.selectXrpSpreadsVolume");
		return close == null ? "0": close;
	}
	
	/**현재가
	 * @return
	 * @throws Exception
	 */
	public String selectXrpCloseVolume() throws Exception {
		String close = (String) select("AdminManageDAO.selectXrpCloseVolume");
		return close == null ? "0": close;
	}
	
	/**
	 * 전일 종가
	 * @return
	 * @throws Exception
	 */
	public String selectXrpYesterDatCloseVolume() throws Exception {
		String close = (String) select("AdminManageDAO.selectXrpYesterDatCloseVolume");
		return close == null ? "0": close;
	}
	
	/**
	 * 거래량
	 * @return
	 * @throws Exception
	 */
	public XrpChartVO selectXrpVolume() throws Exception {
		return (XrpChartVO) select("AdminManageDAO.selectXrpVolume");
	}
	
	/**
	 * 1주일간의 시세
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<XrpChartVO> selectXrpChartDataW (String chartType) throws Exception {
		
		return (ArrayList<XrpChartVO>) list("AdminManageDAO.selectXrpChartDataW", chartType);
	}
	
	/**
	 * 당일 시세 조회
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<XrpChartVO> selectXrpChartDataD () throws Exception {
		
		return (ArrayList<XrpChartVO>) list("AdminManageDAO.selectXrpChartDataD");
	}
	
	/**
	 * 회원의 첨부파일 정보 수정
	 * @param mberVo
	 * @throws Exception
	 */
	public void updateMberAtchFileInfo(MberManageVO mberVo) throws Exception {
		
		update("AdminManageDAO.updateMberAtchFileInfo", mberVo);
	}
	
	/** 회원 예탁/인출 정보 삭제
	 * @param accountVo
	 * @throws Exception
	 */
	public void deleteAccountTrade(AccountVO accountVo) throws Exception{
		delete("AdminManageDAO.deleteAccountTrade", accountVo);
	}
}
