package xrpgate.util.web;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.util.StringUtil;
import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovProperties;
import xrpgate.common.model.JsonObject;
import egovframework.com.cmm.service.FileVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import xrpgate.util.file.FileUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
@RequestMapping(value = "/files")
public class RpnFileController {

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    @Resource(name = "egovFileIdGnrService")
	private EgovIdGnrService idgenService;

    
    /** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    

	/**
	 * @Method Name : uploadPage
	 * @Method 설명 : 파일을 업로드 하는 페이지
	 * @작성일 : 2014. 4. 17.오후 3:06:47
	 * @작성자 : 이방은
	 * @Modification Information
	 * 
	 * <pre>
		 *     수정일         수정자                   수정내용
		 *     -------          --------        ---------------------------
		 *   2014. 4. 17.      이방은                  최초 생성
		 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/uploadPage.do", method = RequestMethod.GET)
	public String uploadPage(ModelMap model) throws Exception{
		String atchFileId  = idgenService.getNextStringId();			
		model.addAttribute("serverAtchFileId", atchFileId);
		return ".popup_files/upload";
	}

	/**
	 * @Method Name : listPage
	 * @Method 설명 : 파일 목록 팝업
	 * @작성일 : 2014. 4. 22.오전 11:03:49
	 * @작성자 : 이방은
	 * @Modification Information
	 * 
	 * <pre>
		 *     수정일         수정자                   수정내용
		 *     -------          --------        ---------------------------
		 *   2014. 4. 22.      이방은                  최초 생성
		 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/listPage.do", method = RequestMethod.GET)
	public String listPage() {

		return ".popup_files/fileList";
	}

	/**
	 * @Method Name : upload
	 * @Method 설명 : 파일 업로드
	 * @작성일 : 2014. 4. 22.오전 10:37:22
	 * @작성자 : 이방은
	 * @Modification Information
	 * 
	 * <pre>
		 *     수정일         수정자                   수정내용
		 *     -------          --------        ---------------------------
		 *   2014. 4. 22.      이방은                  최초 생성
		 * </pre>
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/upload.do", method = RequestMethod.POST)
	public void upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		System.out.println("request.getParameter(Category) : " + request.getParameter("Category"));
		System.out.println("request.getParameter(AtchFileId) : " + request.getParameter("AtchFileId"));
		
		String atchFileId = request.getParameter("AtchFileId");
		if( EgovStringUtil.isEmpty(atchFileId) ) {
			atchFileId = idgenService.getNextStringId();
		}
		// upload to disk
		List<FileVO> list = FileUtil.uploadFiles(request, atchFileId);
		
		// add to DB
		atchFileId = this.fileMngService.insertFileInfsAdvence(list);
		
		//set.  신규로 디비에 저장된 fileSn 정보가를 조회하여 사용자 화면에 response로 보내준다.  
		List<FileVO> totalList = this.fileMngService.selectFileInfs((FileVO)list.get(0));
		
		//fileSn 정보를 갱신
		FileVO tempVo = null;
		FileVO tempTotalVo = null;
		for(int i =0 ; i < list.size() ; i++){
			tempVo = (FileVO)list.get(i);
			for(int j=0 ; j < totalList.size() ; j++){
				tempTotalVo = (FileVO)totalList.get(j);
				if(tempVo.getStreFileNm().equals(tempTotalVo.getStreFileNm()))
					tempVo.setFileSn(tempTotalVo.getFileSn());
			}
			//IE9에서  한글명이 깨지는 것을 막기 위한 조치.
			tempVo.setOrignlFileNm(URLEncoder.encode(tempVo.getOrignlFileNm(), "UTF-8").replaceAll("\\+", "%20"));
		}
		
		JsonObject jo = new JsonObject();
		jo.IsSucceed = true;
		jo.Data = list;

		// IE 9 이하 버전 호환성을 위해 plain으로 내려야 한다.
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		ObjectMapper objectMapper = new ObjectMapper();

		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
		String regex = "/Trident.*rv[ :]*11\\./";
		boolean isIE11 = userAgent.matches(regex);
		if (ie || isIE11) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setRealName(URLEncoder.encode(list.get(i).getRealName(), "UTF-8"));
			}
		}

		JsonGenerator generator = objectMapper.getJsonFactory().createJsonGenerator(byteArrayOutputStream, JsonEncoding.UTF8);

		objectMapper.writeValue(generator, jo);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(new String(byteArrayOutputStream.toByteArray(), "UTF-8"));
		
	}

	/**
	 * @Method Name : getFiles
	 * @Method 설명 : 파일 목록을 가져온다.
	 * @작성일 : 2014. 4. 22.오전 10:37:32
	 * @작성자 : 이방은
	 * @Modification Information
	 * 
	 * <pre>
		 *     수정일         수정자                   수정내용
		 *     -------          --------        ---------------------------
		 *   2014. 4. 22.      이방은                  최초 생성
		 * </pre>
	 * @param fileIds
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getFiles.do", method = RequestMethod.GET)
	public JsonObject getFiles(String fileIds) {
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(fileIds);
		
		List<FileVO> fileList;
				
		JsonObject jo = new JsonObject();
		jo.IsSucceed = true;
		try {
			fileList = this.fileMngService.selectFileInfs(fvo);
			jo.Data = fileList;
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jo;
	}

	/**
	 * @Method Name : download
	 * @Method 설명 : 파일 다운로드
	 * @작성일 : 2015.3. 11.오전 10:37:05
	 * @작성자 : 박세은
	 * @Modification Information
	 * 
	 * <pre>
		 *     수정일         수정자                   수정내용
		 *     -------          --------        ---------------------------
		 *   2015. 3. 11.     박세은                  최초 생성
		 * </pre>
	 * @param fileVO
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "/download.do", method = RequestMethod.GET)
	public void download(FileVO fileVO, HttpServletResponse response, HttpServletRequest request) throws Exception {

		boolean hasError = false;
		FileVO dbFile = this.fileMngService.selectFileInf(fileVO);

		try {
			FileUtil.downloadFile(dbFile, request, response);
		}
		catch (Exception ex) {
			hasError = true;
		}
			
		if (hasError) {
			response.setHeader("Content-Type", "text/html; charset=utf-8");

			throw new Exception();
		}
		else {
			
		}
	}
	
    /**
     * 첨부파일에 대한 목록을 조회한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfsAdvence.do")
    public String selectFileInfsAdvence(@ModelAttribute("searchVO") FileVO fileVO, 
    																	@RequestParam("param_atchFileId")  String atchFileId,
    		     	                                                     ModelMap model) throws Exception {

	fileVO.setAtchFileId(atchFileId);
	List<FileVO> result = fileMngService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);

	return ".popup_common/supportFileList";
    }

	@ResponseBody
	@RequestMapping(value = "/remove.do", method = RequestMethod.POST)
	public JsonObject remove(FileVO fileVO, HttpServletRequest request) throws Exception {

		JsonObject jo = new JsonObject();
		List<FileVO> fileList = this.fileMngService.selectFileInfs(fileVO);
		if (fileList.size() == 0) {
			jo.IsSucceed = false;
			jo.Message = "파일이 존재하지 않습니다.";
			return jo;
		}
		FileVO dbFile = fileList.get(0);

		try {
			// remove from db
			this.fileMngService.deleteFileInf(fileVO);
			// remove from disk
			FileUtil.removeFile(fileVO, request);
			jo.IsSucceed = true;
			jo.IsDeleted = true;
			jo.Message = "파일을 삭제하였습니다.";
			jo.Data = fileVO;
		}
		catch (Exception e) {
			jo.IsSucceed = false;
			jo.Message = e.getMessage();
		}
	/*			
	}
			else {
				jo.IsSucceed = false;
				jo.Message = "파일을 삭제하는데 실패 하였습니다.";
			}
		}
		*/

		return jo;
	}
	
    /**
     * 이미지 view를 제공한다.
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/imageSrc.do",method=RequestMethod.GET)
    public void imageSrc(HttpServletRequest request, HttpServletResponse response) throws Exception {

        
	String subPath = request.getParameter("path");
	String physical = request.getParameter("physical");
	String mimeType = request.getParameter("contentType");

	EgovFormBasedFileUtil.viewFile(response, uploadDir, subPath, physical, mimeType);
    }
    
    
    
    /**
     * 이미지 view를 제공한다.
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/imageThumnailSrcByFileId.do",method=RequestMethod.GET)
    public void imageThumnailSrcByFileId(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String fileId = request.getParameter("fileId");
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(fileId);
		
		List<FileVO> fileList;

		fileList = this.fileMngService.selectFileInfs(fvo);
		fvo =  fileList.get(0);

		EgovFormBasedFileUtil.viewFile(response, fvo.getFileStreCours(), "thumnails", fvo.getStreFileNm(), "");
    }
	
    	
}
