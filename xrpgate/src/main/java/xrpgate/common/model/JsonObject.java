package xrpgate.common.model;

/**
 * @Class Name : JsonObject
 * @Description : 모든 서버 json 호출에 대한 응답 클래스
 * @author 이방은
 * @Modification Information
 * 
 * <pre>
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2014. 4. 10.      이방은                  최초 생성
 *   2015. 1. 20.		 김종민					double submit 적용
 * </pre>
 * @see
 */
public class JsonObject {

	/**
	 * 오류가 없다면 true
	 */
	public boolean IsSucceed;
	/**
	 * madal 에 보여 줄 메시지
	 */
	public String Message;
	/**
	 * 모달의 제목
	 */
	public String Title;
	/**
	 * 모달의 확인 버튼을 클릭 후 이동할 url
	 */
	public String RedirectUrl;
	/**
	 * client에 내려줄 데이터
	 */
	public Object Data;
	/**
	 * client에 내려줄 DoubleSubmit 데이터
	 */
	public Object DoubleSubmitData;
	/**
	 * Data의 총 record 수
	 */
	public int totalRecordCount;
	/**
	 * 파일의 삭제 여부 성공시 true
	 */
	public boolean IsDeleted;
}
