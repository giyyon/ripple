package xrpgate.admin.web.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import xrpgate.admin.web.service.AdminAccountVO;
import xrpgate.admin.web.service.AdminMgmtService;
import xrpgate.admin.web.service.XrpChartVO;
import xrpgate.trade.service.AccountVO;
import xrpgate.trade.service.Impl.TradeManageDAO;

@Service("adminMgmtService")
public class AdminMgmtServiceImpl extends EgovAbstractServiceImpl implements AdminMgmtService {

	@Resource(name = "adminMgmtDao")
    private AdminMgmtDao adminMgmtDao;
	
	@Override
	public AdminAccountVO selectRippleAccountInfo() throws Exception {
		// TODO Auto-generated method stub
		return adminMgmtDao.selectRippleAccountInfo();
	}

	@Override
	public void insertRippleAccountInfo(AdminAccountVO accountVo)
			throws Exception {
		// TODO Auto-generated method stub
		adminMgmtDao.updateRippleAccountInfo(accountVo);
	}

	@Override
	public XrpChartVO selectXrpTradeInfo() throws Exception {
		// TODO Auto-generated method stub
		XrpChartVO xrpVo = new XrpChartVO();
		
		// 거래가
		xrpVo = adminMgmtDao.selectXrpVolume();
		// 매수호가
		xrpVo.setAsksVolume(adminMgmtDao.selectXrpAsksVolume());
		// 매도호가
		xrpVo.setBidsVolume(adminMgmtDao.selectXrpBidsVolume());
		
		//전일 종가
		xrpVo.setBeforeCloseVolume(Double.parseDouble( adminMgmtDao.selectXrpYesterDatCloseVolume()));
				
		// 현재가
		xrpVo.setCloseVolume(Double.parseDouble( adminMgmtDao.selectXrpCloseVolume()));
		// 최고가
		xrpVo.setHighVolume(adminMgmtDao.selectXrpHighVolume());
		//최저가
		xrpVo.setLowVolume(adminMgmtDao.selectXrpLowVolume());
		//스프레드
		//xrpVo.setSpreadsVolume(Double.parseDouble( adminMgmtDao.selectXrpSpreadsVolume()));
		return xrpVo;
	}

	@Override
	public HashMap<String, Object> selectXrpChartDat(String chartType) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("chartDataW", adminMgmtDao.selectXrpChartDataW(chartType));
		map.put("chartDataD", adminMgmtDao.selectXrpChartDataD());
		return map;
	}

	@Override
	public void updateMberAtchFileInfo(MberManageVO mberVo) throws Exception {
		// TODO Auto-generated method stub
		adminMgmtDao.updateMberAtchFileInfo(mberVo);
	}

	@Override
	public void deleteAccountTrade(AccountVO accountVo) throws Exception {
		// TODO Auto-generated method stub
		adminMgmtDao.deleteAccountTrade(accountVo);
	}


}
