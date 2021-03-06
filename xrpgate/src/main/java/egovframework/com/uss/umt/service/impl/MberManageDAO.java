package egovframework.com.uss.umt.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.uss.umt.service.MberManageVO;
import egovframework.com.uss.umt.service.UserDefaultVO;

import org.springframework.stereotype.Repository;

/**
 * 일반회원관리에 관한 데이터 접근 클래스를 정의한다.
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
@Repository("mberManageDAO")
public class MberManageDAO extends EgovComAbstractDAO{

    /**
     * 기 등록된 특정 일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
     * @param userSearchVO 검색조건
     * @return List<MberManageVO> 기업회원 목록정보
     */
    public List<MberManageVO> selectMberList(UserDefaultVO userSearchVO){
        return (List<MberManageVO>) list("mberManageDAO.selectMberList", userSearchVO);
    }

    /**
     * 일반회원 총 갯수를 조회한다.
     * @param userSearchVO 검색조건
     * @return int 일반회원총갯수
     */
    public int selectMberListTotCnt(UserDefaultVO userSearchVO) {
        return (Integer)select("mberManageDAO.selectMberListTotCnt", userSearchVO);
    }

    /**
     * 화면에 조회된 일반회원의 정보를 데이터베이스에서 삭제
     * @param delId 삭제 대상 일반회원아이디
     */
    public void deleteMber(String delId){
        delete("mberManageDAO.deleteMber_S", delId);
    }

    /**
     * 일반회원의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
     * @param mberManageVO 일반회원 등록정보
     * @return String 등록결과
     */
    public String insertMber(MberManageVO mberManageVO){
        return (String)insert("mberManageDAO.insertMber_S", mberManageVO);
    }

    /**
     * 기 등록된 사용자 중 검색조건에 맞는일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
     * @param mberId 상세조회대상 일반회원아이디
     * @return MberManageVO 일반회원 상세정보
     */
    public MberManageVO selectMber(String uniqId){
        return (MberManageVO) select("mberManageDAO.selectMber_S", uniqId);
    }
    
    /**
     * 기 등록된 사용자 중 검색조건에 맞는일반회원의 정보를 데이터베이스에서 읽어와 화면에 출력
     * @param mberId 상세조회대상 일반회원아이디
     * @return MberManageVO 일반회원 상세정보
     */
    public MberManageVO selectMberById(String mberId){
        return (MberManageVO) select("mberManageDAO.selectMberById", mberId);
    }
    /**
     * 화면에 조회된일반회원의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
     * @param mberManageVO 일반회원수정정보
     */
    public void updateMber(MberManageVO mberManageVO){
        update("mberManageDAO.updateMber_S",mberManageVO);
    }

    /**
     * 화면에 조회된일반회원의 기본정보를 관리자가 수정
     * @param mberManageVO 일반회원수정정보
     */
    public void updateMberByAdmin(MberManageVO mberManageVO){
        update("mberManageDAO.updateMberByAdmin",mberManageVO);
    }
    
    /**
     * 일반회원 약관확인
     * @param stplatId 일반회원약관아이디
     * @return List 일반회원약관정보
     */
    public List selectStplat(String stplatId){
    	return list("mberManageDAO.selectStplat_S", stplatId);
    }

    /**
     * 일반회원 암호수정
     * @param passVO 기업회원수정정보(비밀번호)
     */
    public void updatePassword(MberManageVO passVO) {
        update("mberManageDAO.updatePassword_S", passVO);
    }

    /**
     * 일반회원 탈퇴처리
     * @param mberId 일반회원ID
     */
    public void updateWithdraw(String mberId) {
        update("mberManageDAO.updateWithdraw", mberId);
    }

    /**
     * 일반회원 비밀번호 조회
     * @param mberManageVO 일반회원암호 조회조건정보
     * @return MberManageVO 일반회원 암호정보
     */
    public MberManageVO selectPassword(MberManageVO mberManageVO){
    	return (MberManageVO) select("mberManageDAO.selectPassword_S", mberManageVO);
    }
    
    /**
     * 회원 가입시 가입되있는지 여부 파악
     * @param mberManageVO 회원 di
     * @return MberManageVO 일반회원 가입여부 및 mberId
     */
    public MberManageVO selectChkJoinYn(String di){
    	return (MberManageVO) select("mberManageDAO.selectMberIdByDi", di);
    }
    
    /**
     * 회원 가입시 회원의 계좌 상태 정보 등록
     * @param mberManageVo
     * @throws Exception
     */
    public void insertMberAccountInfo(MberManageVO mberManageVo) throws Exception {
    	insert("mberManageDAO.insertMberAccountInfo", mberManageVo);
    }
    
    /**
     * 같은 이름을 가진 회원의 수 파악
     * @param mberMnnageVo
     * @return
     * @throws Exception
     */
    public int selectSameNameMberCnt(MberManageVO mberMnnageVo) throws Exception {
    	return (Integer) select("mberManageDAO.selectSameNameMberCnt", mberMnnageVo);
    }
    
    /**
     * 회원 id 찾기
     * @param mberVo
     * @return
     * @throws Exception
     */
    public String selectMberIdByMberNm(MberManageVO mberVo) throws Exception{
    	return (String) select("mberManageDAO.selectMberIdByMberNm", mberVo);
    }
    
    /**
     * 회원 존재여부
     * @param mberVo
     * @return
     * @throws Exception
     */
    public Integer selectMberPassByMberNm(MberManageVO mberVo) throws Exception {
    	
    	return (Integer) select("mberManageDAO.selectMberPassByMberNm", mberVo);
    }
    
    

}