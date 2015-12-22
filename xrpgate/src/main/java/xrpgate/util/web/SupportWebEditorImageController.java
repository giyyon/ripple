package xrpgate.util.web;

import java.io.File;
import java.util.List;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 웹에디터 이미지 upload 처리 Controller
 * @author 박세은
 * @since 2051.03.09
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2015.03.09 박세은          최초 생성
 *
 * </pre>
 */
@RequestMapping(value = "/files/ckEditor")
@Controller
public class SupportWebEditorImageController {

    /** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath")+File.separator+"ckEditorImage";

    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)


    /**
     * 이미지 Upload를 처리한다.
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/insertImage.do", method=RequestMethod.POST)
    public String imageUpload(HttpServletRequest request, Model model) throws Exception {

		// Spring multipartResolver 사용시
		List<EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFiles(request, uploadDir, maxFileSize);

		if (list.size() > 0) {
		    EgovFormBasedFileVo vo = list.get(0);	// 첫번째 이미지
	
		    String url = request.getContextPath()
		    + "/files/ckEditor/imageSrc.do?"
		    + "path=" + vo.getServerSubPath()
		    + "&physical=" + vo.getPhysicalName()
		    + "&contentType=" + vo.getContentType();
	
		    model.addAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		    model.addAttribute("url", url);
		}

	return ".popup_files/uploadForCkeditor";
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
}
