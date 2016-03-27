package egovframework.com.uss.umt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.ems.service.EgovSndngMailRegistService;
import egovframework.com.cop.ems.service.SndngMailVO;
import egovframework.com.uss.umt.service.EgovMberManageService;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

/**
 * 일반회원관리에 관한비지니스클래스를 정의한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *
 * </pre>
 */
@Service("mberManageService")
public class EgovMberManageServiceImpl extends EgovAbstractServiceImpl implements EgovMberManageService {
	
	/** userManageDAO */
	@Resource(name="userManageDAO")
	private UserManageDAO userManageDAO;
	
	/** mberManageDAO */
	@Resource(name="mberManageDAO")
	private MberManageDAO mberManageDAO;
	
	/** entrprsManageDAO */
	@Resource(name="entrprsManageDAO")
	private EntrprsManageDAO entrprsManageDAO;
	
	/** egovUsrCnfrmIdGnrService */
	@Resource(name="egovUsrCnfrmIdGnrService")
	private EgovIdGnrService idgenService;
	
	/**
	 * 사용자의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param mberManageVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public String insertMber(MberManageVO mberManageVO) throws Exception  {
		//고유아이디 셋팅-(예외 처리 : 관리자 모드 에서 비회원 가입을 하는 경우 선 얻어온 id를 활용하여 신규 등록 처리한다.)
		String uniqId = "";
		if (mberManageVO.getUniqId() == null || mberManageVO.getUniqId().equals("")){
			uniqId = idgenService.getNextStringId();
			mberManageVO.setUniqId(uniqId);
		}
		//패스워드 암호화
		String pass = EgovFileScrty.encryptPassword(mberManageVO.getPassword(), mberManageVO.getMberId());
		mberManageVO.setPassword(pass);
		
		String result = mberManageDAO.insertMber(mberManageVO);
		mberManageDAO.insertMberAccountInfo(mberManageVO);
		return result;
	}
	
	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param uniqId 상세조회대상 일반회원아이디
	 * @return mberManageVO 일반회원상세정보
	 * @throws Exception
	 */
	public MberManageVO selectMber(String uniqId) {
		MberManageVO mberManageVO = mberManageDAO.selectMber(uniqId);		
		return mberManageVO;
	}
	
	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param mberId 상세조회대상 일반회원아이디
	 * @return mberManageVO 일반회원상세정보
	 * @throws Exception
	 */
	public MberManageVO selectMberById(String mberId) {
		MberManageVO mberManageVO = mberManageDAO.selectMberById(mberId);		
		return mberManageVO;
	}

	
	
	/**
	 * 기 등록된 회원 중 검색조건에 맞는 회원들의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param userSearchVO 검색조건
	 * @return List<MberManageVO> 일반회원목록정보
	 */
	public List<MberManageVO> selectMberList(UserDefaultVO userSearchVO) {
		return mberManageDAO.selectMberList(userSearchVO);
	}

    /**
     * 일반회원 총 갯수를 조회한다.
     * @param userSearchVO 검색조건
     * @return 일반회원총갯수(int) 
     */
    public int selectMberListTotCnt(UserDefaultVO userSearchVO) {
    	return mberManageDAO.selectMberListTotCnt(userSearchVO);
    }

	/**
	 * 화면에 조회된 일반회원의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param mberManageVO 일반회원수정정보
	 * @throws Exception
	 */
	public void updateMber(MberManageVO mberManageVO) throws Exception {
		//관리자 + 기본 + 부가정보 기록
		mberManageDAO.updateMber(mberManageVO);
	}
	
	/**
	 * 신규:화면에 조회된 일반회원의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param mberManageVO 일반회원수정정보
	 * @throws Exception
	 */
	public void updateMberByAdmin(MberManageVO mberManageVO) throws Exception {
		//부가정보 기록
		mberManageDAO.updateMberByAdmin(mberManageVO);

	}
	

	/**
	 * 화면에 조회된 사용자의 정보를 데이터베이스에서 삭제
	 * @param checkedIdForDel 삭제대상 일반회원아이디
	 * @throws Exception
	 */
	public void deleteMber(String checkedIdForDel)  {
		String [] delId = checkedIdForDel.split(",");
		for (int i=0; i<delId.length ; i++){
			String [] id = delId[i].split(":");
			if (id[0].equals("USR03")){
		        //업무사용자(직원)삭제
				userManageDAO.deleteUser(id[1]);				
			}else if(id[0].equals("USR01")){
				//일반회원삭제
				mberManageDAO.deleteMber(id[1]);
			}else if(id[0].equals("USR02")){
				//기업회원삭제
				entrprsManageDAO.deleteEntrprsmber(id[1]);
			}
		}
	}

	/**
	 * 일반회원 약관확인
	 * @param stplatId 일반회원약관아이디
	 * @return 일반회원약관정보(List)
	 * @throws Exception
	 */
	public List selectStplat(String stplatId)  {
        return mberManageDAO.selectStplat(stplatId);
	}

	/**
	 * 일반회원암호수정
	 * @param mberManageVO 일반회원수정정보(비밀번호)
	 * @throws Exception
	 */
	public void updatePassword(MberManageVO mberManageVO) {
		mberManageDAO.updatePassword(mberManageVO);
	}

	/**
	 * 일반회원 비밀번호조회
	 * @param passVO 일반회원암호 조회조건정보
	 * @return mberManageVO 일반회원암호정보
	 * @throws Exception
	 */
	public MberManageVO selectPassword(MberManageVO passVO) {
		MberManageVO mberManageVO = mberManageDAO.selectPassword(passVO);
		return mberManageVO;
	}

	@Override
	public void updateWithdraw(String mberId) throws Exception {

		mberManageDAO.updateWithdraw(mberId);
		
	}
	
	/**
	 * 가입하려는 회원이 가입여부 조회
	 * @param di 통신사의 휴대폰넘고 고유식별키
	 * @return mberManageVO 일반회원상세정보
	 * @throws Exception
	 */
	public MberManageVO selectChkJoinYn(String di) {
		MberManageVO mberManageVO = mberManageDAO.selectChkJoinYn(di);		
		return mberManageVO;
	}
	
	private String makeMberTag(int mberCnt) {
		String mberTag = "A";
		
		char ch = 'A';
		char ch2 = 'A';
		if(mberCnt > 0 ) {
			int f1 = (mberCnt/26);
			int f2 = mberCnt%26;
			char[] array = new char[2];
			for (int i = 0; i < (f1 == 0 ? 1 : f1); i++) {
				array[0] = (char) (ch+i);
				for(int j = 0 ; j < f2; j++){
					array[1] = (char) (ch2+j);
					//System.out.println("두번째 :  " +array[1]);
				}
				//System.out.println("첫번째 :  " + array[0] + "  i ==" + i+f1);
			}
			mberTag = String.valueOf(array);
		}
		return mberTag;
	}

	@Override
	public String selectSameNameMberCnt(MberManageVO mberMnnageVo)
			throws Exception {
		// 회원의 정버 입력하기 전에 동명이인의 수 많큼 회원에게 태그를 생성.
				int mberCnt = mberManageDAO.selectSameNameMberCnt(mberMnnageVo);
				
		return makeMberTag(mberCnt);
	}

	@Override
	public String selectMberIdByMberNm(MberManageVO mberVo) throws Exception {
		// TODO Auto-generated method stub
		return mberManageDAO.selectMberIdByMberNm(mberVo);
	}

	@Override
	public Map<String, Object> selectMberPassByMberNm(MberManageVO mberVo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		MberManageVO mberInfo = new MberManageVO();
		
		int i = 0;
		i = mberManageDAO.selectMberPassByMberNm(mberVo);
		String tempPass = "";
		if(i > 0 ){
			tempPass = randomValue("C", 8);
			//패스워드 암호화
			String pass = EgovFileScrty.encryptPassword(tempPass, mberVo.getMberId());
			mberVo.setPassword(pass);
			mberManageDAO.updatePassword(mberVo);
			
			mberInfo = mberManageDAO.selectMberById(mberVo.getMberId());
			
			map.put("tempPass", tempPass);
			map.put("mberInfo", mberInfo);
			
		}
		return map;
	}
	
	public static String randomValue(String type, int cnt) {
		
		StringBuffer strPwd = new StringBuffer();
		char str[] = new char[1];
		// 특수기호 포함
		if (type.equals("P")) {
		for (int i = 0; i < cnt; i++) {
		str[0] = (char) ((Math.random() * 94) + 33);
		strPwd.append(str);
		}
		// 대문자로만
		} else if (type.equals("A")) {
		for (int i = 0; i < cnt; i++) {
		str[0] = (char) ((Math.random() * 26) + 65);
		strPwd.append(str);
		}
		// 소문자로만
		} else if (type.equals("S")) {
		for (int i = 0; i < cnt; i++) {
		str[0] = (char) ((Math.random() * 26) + 97);
		strPwd.append(str);
		}
		// 숫자형으로
		} else if (type.equals("I")) {
		int strs[] = new int[1];
		for (int i = 0; i < cnt; i++) {
		strs[0] = (int) (Math.random() * 9);
		strPwd.append(strs[0]);
		}
		// 소문자, 숫자형
		} else if (type.equals("C")) {
		Random rnd = new Random();
		for (int i = 0; i < cnt; i++) {
		if (rnd.nextBoolean()) {
		strPwd.append((char) ((int) (rnd.nextInt(26)) + 97));
		} else {
		strPwd.append((rnd.nextInt(10)));
		}
		}
		}
		return strPwd.toString();
		}    
}