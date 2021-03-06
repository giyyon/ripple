package egovframework.com.uss.umt.service;

import java.util.List;
import java.util.Map;

/**
 * 일반회원관리에 관한 인터페이스클래스를 정의한다.
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
public interface EgovMberManageService {
	
	/**
	 * 사용자의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param mberManageVO 일반회원 등록정보
	 * @return 등록결과
	 * @throws Exception
	 */
	public String insertMber(MberManageVO mberManageVO) throws Exception;
	
	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param mberId 상세조회대상 일반회원아이디
	 * @return mberManageVO 일반회원상세정보
	 * @throws Exception
	 */
	public MberManageVO selectMber(String uniqId) throws Exception;
	
	
	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param mberId 상세조회대상 일반회원아이디
	 * @return mberManageVO 일반회원상세정보
	 * @throws Exception
	 */
	public MberManageVO selectMberById(String mberId) throws Exception;
	
	/**
	 * 기 등록된 회원 중 검색조건에 맞는 회원들의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param userSearchVO 검색조건
	 * @return List<MberManageVO> 일반회원목록정보
	 * @throws Exception
	 */
	public List<MberManageVO> selectMberList(UserDefaultVO userSearchVO) throws Exception;
	
    /**
     * 일반회원 총 갯수를 조회한다.
     * @param userSearchVO 검색조건
     * @return 일반회원총갯수(int) 
     * @throws Exception
     */
    public int selectMberListTotCnt(UserDefaultVO userSearchVO) throws Exception;

	/**
	 * 화면에 조회된 일반회원의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param mberManageVO 일반회원수정정보
	 * @throws Exception
	 */
	public void updateMber(MberManageVO mberManageVO) throws Exception;
	
	
	/**
	 * 신규 : 화면에 조회된 일반회원의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param mberManageVO 일반회원수정정보
	 * @throws Exception
	 */
	public void updateMberByAdmin(MberManageVO mberManageVO) throws Exception;
	
	/**
	 * 화면에 조회된 사용자의 정보를 데이터베이스에서 삭제
	 * @param checkedIdForDel 삭제대상 일반회원아이디
	 * @throws Exception
	 */
	public void deleteMber(String checkedIdForDel) throws Exception;
	
	/**
	 * 일반회원 약관확인
	 * @param stplatId 일반회원약관아이디
	 * @return 일반회원약관정보(List)
	 * @throws Exception
	 */
	public List selectStplat(String stplatId)  throws Exception;
	
	/**
	 * 일반회원암호수정
	 * @param mberManageVO 일반회원수정정보(비밀번호)
	 * @throws Exception
	 */
	public void updatePassword(MberManageVO mberManageVO) throws Exception;
	
	/**
	 * 일반회원탈퇴
	 * @param entrprsmberId 일반회원ID
	 * @throws Exception
	 */
	public void updateWithdraw(String mberId) throws Exception;	
	
	/**
	 * 일반회원 비밀번호 변경시 비밀번호 일치여부 확인위해 이전 비밀번호 조회
	 * @param passVO 일반회원암호 조회조건정보
	 * @return mberManageVO 일반회원암호정보
	 * @throws Exception
	 */
	public MberManageVO selectPassword(MberManageVO passVO) throws Exception;
	
	/**
	 * 가입하려는 회원이 가입여부 조회
	 * @param di 통신사의 휴대폰넘고 고유식별키
	 * @return mberManageVO 일반회원상세정보
	 * @throws Exception
	 */
	public MberManageVO selectChkJoinYn(String di) throws Exception;
	
	 /**
	  * 회원의 동명이인의 숫자를 파악 개별 태그 생성
	 * @param mberMnnageVo
	 * @return
	 * @throws Exception
	 */
	public String selectSameNameMberCnt(MberManageVO mberMnnageVo) throws Exception;
	
	/**
	 * 회원 id찾기
	 * @param mberVo
	 * @return
	 * @throws Exception
	 */
	public String selectMberIdByMberNm(MberManageVO mberVo) throws Exception;
	
	/**
	 * 회원의 임시 비밀번호 발급
	 * @param mberVo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMberPassByMberNm(MberManageVO mberVo) throws Exception;
		
}