package xrpgate.admin.web.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import xrpgate.trade.service.AccountVO;
import egovframework.com.uss.umt.service.MberManageVO;


@Service("adminMgmtService")
public interface AdminMgmtService {
	
	public AdminAccountVO selectRippleAccountInfo() throws Exception;
	
	public void insertRippleAccountInfo(AdminAccountVO accountVo) throws Exception;
	
	public XrpChartVO selectXrpTradeInfo() throws Exception;
	
	public HashMap<String, Object> selectXrpChartDat(String chartType) throws Exception;
	
	/**
	 * 회원의 첨부파일 정보 수정
	 * @param mberVo
	 * @throws Exception
	 */
	public void updateMberAtchFileInfo(MberManageVO mberVo) throws Exception;
	
	/**
	 * 회원 예탁/ 인출 정보 삭제
	 * @param accountVo
	 * @throws Exception
	 */
	public void deleteAccountTrade(AccountVO accountVo) throws Exception;
}
