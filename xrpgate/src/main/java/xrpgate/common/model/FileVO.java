package xrpgate.common.model;

/**
 * @Class Name : FileVO
 * @Description : 파일의 정보를 가지고 있는 VO 입니다. 이미지의 경우 섬네일을 생성하며 width, height의 값을 가지고 있어야 합니다.
 * @author 방은
 * @Modification Information
 * 
 * <pre>
 *      수정일          수정자                   수정내용
 *    -------          --------        ---------------------------
 *   2014. 12. 24.      방은                     최초 생성
 * </pre>
 * @see
 */
public class FileVO {

	private String fileId;
	private String createdDate;
	private String contentType;
	private long size;
	private String category;
	private String realName;
	private String virtualName;
	private String height;
	private String width;
	private boolean hasThumnail;
	
	/**
     * 첨부파일 아이디
     */
    public String atchFileId = "";
    /**
     * 생성일자
     */
    public String creatDt = "";
    /**
     * 파일내용
     */
    public String fileCn = "";
    /**
     * 파일확장자
     */
    public String fileExtsn = "";
    /**
     * 파일크기
     */
    public String fileMg = "";
    /**
     * 파일연번
     */
    public String fileSn = "";
    /**
     * 파일저장경로
     */
    public String fileStreCours = "";
    /**
     * 원파일명
     */
    public String orignlFileNm = "";
    /**
     * 저장파일명
     */
    public String streFileNm = "";


	/**
	 * @return the atchFileId
	 */
	public String getAtchFileId() {
	
		return atchFileId;
	}

	/**
	 * @param atchFileId the atchFileId to set
	 */
	public void setAtchFileId(String atchFileId) {
	
		this.atchFileId = atchFileId;
	}

	/**
	 * @return the creatDt
	 */
	public String getCreatDt() {
	
		return creatDt;
	}

	/**
	 * @param creatDt the creatDt to set
	 */
	public void setCreatDt(String creatDt) {
	
		this.creatDt = creatDt;
	}

	/**
	 * @return the fileCn
	 */
	public String getFileCn() {
	
		return fileCn;
	}

	/**
	 * @param fileCn the fileCn to set
	 */
	public void setFileCn(String fileCn) {
	
		this.fileCn = fileCn;
	}

	/**
	 * @return the fileExtsn
	 */
	public String getFileExtsn() {
	
		return fileExtsn;
	}

	/**
	 * @param fileExtsn the fileExtsn to set
	 */
	public void setFileExtsn(String fileExtsn) {
	
		this.fileExtsn = fileExtsn;
	}

	/**
	 * @return the fileMg
	 */
	public String getFileMg() {
	
		return fileMg;
	}

	/**
	 * @param fileMg the fileMg to set
	 */
	public void setFileMg(String fileMg) {
	
		this.fileMg = fileMg;
	}

	/**
	 * @return the fileSn
	 */
	public String getFileSn() {
	
		return fileSn;
	}

	/**
	 * @param fileSn the fileSn to set
	 */
	public void setFileSn(String fileSn) {
	
		this.fileSn = fileSn;
	}

	/**
	 * @return the fileStreCours
	 */
	public String getFileStreCours() {
	
		return fileStreCours;
	}

	/**
	 * @param fileStreCours the fileStreCours to set
	 */
	public void setFileStreCours(String fileStreCours) {
	
		this.fileStreCours = fileStreCours;
	}

	/**
	 * @return the orignlFileNm
	 */
	public String getOrignlFileNm() {
	
		return orignlFileNm;
	}

	/**
	 * @param orignlFileNm the orignlFileNm to set
	 */
	public void setOrignlFileNm(String orignlFileNm) {
	
		this.orignlFileNm = orignlFileNm;
	}

	/**
	 * @return the streFileNm
	 */
	public String getStreFileNm() {
	
		return streFileNm;
	}

	/**
	 * @param streFileNm the streFileNm to set
	 */
	public void setStreFileNm(String streFileNm) {
	
		this.streFileNm = streFileNm;
	}

	public String getFileId() {

		return fileId;
	}

	public void setFileId(String fileId) {

		this.fileId = fileId;
	}

	public String getCreatedDate() {

		return createdDate;
	}

	public void setCreatedDate(String createdDate) {

		this.createdDate = createdDate;
	}

	public String getContentType() {

		return contentType;
	}

	public void setContentType(String contentType) {

		this.contentType = contentType;
	}

	public long getSize() {

		return size;
	}

	public void setSize(long size) {

		this.size = size;
	}

	public String getCategory() {

		return category;
	}

	public void setCategory(String category) {

		this.category = category;
	}

	public String getRealName() {

		return realName;
	}

	public void setRealName(String realName) {

		this.realName = realName;
	}

	public String getVirtualName() {

		return virtualName;
	}

	public void setVirtualName(String virtualName) {

		this.virtualName = virtualName;
	}

	public String getHeight() {

		return height;
	}

	public void setHeight(String height) {

		this.height = height;
	}

	public String getWidth() {

		return width;
	}

	public void setWidth(String width) {

		this.width = width;
	}

	public boolean isHasThumnail() {

		return hasThumnail;
	}

	public void setHasThumnail(boolean hasThumnail) {

		this.hasThumnail = hasThumnail;
	}

	@Override
	public String toString() {

		return "FileVO [fileId=" + fileId + ", createdDate=" + createdDate + ", contentType=" + contentType + ", size=" + size + ", category=" + category + ", realName=" + realName + ", virtualName=" + virtualName + ", height=" + height + ", width=" + width + ", hasThumnail=" + hasThumnail + "]";
	}

}
