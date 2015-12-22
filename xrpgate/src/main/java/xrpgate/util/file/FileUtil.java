package xrpgate.util.file;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cmm.service.FileVO;

/**
 * @Class Name : FileUtil
 * @Description : 파일 업로드 및 다운로드에 대한 유틸리티 클래스입니다.
 * @author 방은
 * @Modification Information
 * 
 * <pre>
 *      수정일                                  수정자                                    수정내용
 *    -------          --------        ---------------------------
 *   2015. 1. 8.      방은                                       최초 생성
 * </pre>
 * @see
 */
public class FileUtil {

	private static final int BUFF_SIZE = 2048;

	private static final Logger logger = Logger.getLogger(FileUtil.class.getName());
	
	@Resource(name = "egovFileIdGnrService")
	private  EgovIdGnrService idgenService;

	/**
	 * @Method Name : downloadFile
	 * @Method 설명 : 파일을 다운로드 합니다.
	 * @작성일 : 2014. 12. 24.오전 10:51:29
	 * @작성자 : 방은
	 * @Modification Information
	 * 
	 * <pre>
	 *      수정일                                  수정자                                    수정내용
	 *    -------          --------        ---------------------------
	 *   2014. 12. 24.      방은                                       최초 생성
	 * </pre>
	 * @param fileVO
	 * @param request
	 * @param response
	 * @throws Exception
	 * @see
	 */
	public static void downloadFile(FileVO fileVO, HttpServletRequest request, HttpServletResponse response) throws Exception {

		//MessageSourceWrapper messageSourceWrapper = (MessageSourceWrapper) DynamicBeanProvider.getBean("messageSourceWrapper");
		String filePath = EgovProperties.getProperty("Globals.fileStorePath");

		String path = filePath + fileVO.getCategory();
		File file = new File(path + "/" + fileVO.getStreFileNm());

		if (!file.exists()) {
			throw new FileNotFoundException(fileVO.getOrignlFileNm());
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(fileVO.getOrignlFileNm());
		}

		String userAgent = request.getHeader("User-Agent");
		String fileName = "";
		boolean ie = userAgent.indexOf("MSIE") > -1;
		String regex = "/Trident.*rv[ :]*11\\./";
		boolean isIE11 = !userAgent.matches(regex);
//		if (ie || isIE11) {
//			fileName = URLEncoder.encode(fileVO.getOrignlFileNm(), "utf-8").replace("+", " ");
//		}
//		else {
//			fileName = new String(fileVO.getOrignlFileNm().getBytes("utf-8"));
//		}
		fileName = URLEncoder.encode(fileVO.getOrignlFileNm(), "UTF-8").replaceAll("\\+", "%20");

		byte[] b = new byte[BUFF_SIZE]; // buffer size 2K.

		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition:", "attachment; filename=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(new FileInputStream(file));
			outs = new BufferedOutputStream(response.getOutputStream());
			int read = 0;

			while ((read = fin.read(b)) != -1) {
				outs.write(b, 0, read);
			}
		}
		finally {
			if (outs != null) {
				try {
					outs.close();
				}
				catch (Exception ignore) {
					logger.debug("IGNORED: " + ignore.getMessage());
				}
			}
			if (fin != null) {
				try {
					fin.close();
				}
				catch (Exception ignore) {
					logger.debug("IGNORED: " + ignore.getMessage());
				}
			}
		}
	}

	/**
	 * @Method Name : uploadFiles
	 * @Method 설명 : 파일을 업로드 합니다.
	 * @작성일 : 2014. 12. 24.오전 10:54:17
	 * @작성자 : 방은
	 * @Modification Information
	 * 
	 * <pre>
	 *      수정일                                  수정자                                    수정내용
	 *    -------          --------        ---------------------------
	 *   2014. 12. 24.      방은                                       최초 생성
	 * </pre>
	 * @param request
	 * @return
	 * @throws Exception
	 * @see
	 */
	public static List<FileVO> uploadFiles(HttpServletRequest request, String atchFildID) throws Exception {

		//MessageSourceWrapper messageSourceWrapper = (MessageSourceWrapper) DynamicBeanProvider.getBean("messageSourceWrapper");
		
		//String filePath = messageSourceWrapper.getMessage("file.uploadPath");
		String filePath = EgovProperties.getProperty("Globals.fileStorePath");

		List<FileVO> list = new ArrayList<FileVO>();

		//String path = request.getSession().getServletContext().getRealPath(filePath);
		String path = filePath;
		File dir = new File(path);
		dir.mkdirs();

		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

//		String servletPath = mptRequest.getRealPath("webAttach");

		Iterator<String> fileIter = mptRequest.getFileNames();
		int fileSn = 0;
		while (fileIter.hasNext()) {
			MultipartFile file = mptRequest.getFile(fileIter.next());

			String fileName = file.getOriginalFilename();
			if (fileName.lastIndexOf("\\") >= 0) {
				fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
			}

			if (fileName.lastIndexOf(".") != -1) {
				FileVO vo = new FileVO();
				//파일 아이디 생성
				String VirtulName = java.util.UUID.randomUUID().toString().replace("-", "");
				vo.setFileId(atchFildID );
				vo.setRealName(file.getOriginalFilename());
				vo.setVirtualName(VirtulName);
				vo.setSize(file.getSize());
				vo.setContentType(file.getContentType());
				vo.setCategory(request.getParameter("Category"));
				//전자 정부프레임워크에 맞게 데이타 입력하게 임시로 생성
				vo.setFileExtsn(fileName.substring(fileName.lastIndexOf(".") + 1));
				vo.setFileStreCours(path +  vo.getCategory());
				vo.setFileMg(Long.toString(file.getSize()));
				vo.setOrignlFileNm(file.getOriginalFilename());
				vo.setStreFileNm(VirtulName);
				vo.setAtchFileId(atchFildID);
				vo.setFileSn(String.valueOf( fileSn));
				fileSn++;
				
				dir = new File(path + "/" + vo.getCategory());
				dir.mkdirs();

				if (file.getSize() > 0) {
//					uploadThumnail(file, vo, servletPath);
					uploadThumnail(file, vo, path + "/" + vo.getCategory() + "/");
					writeFile(file, vo.getVirtualName(), path + "/" + vo.getCategory() + "/");
					list.add(vo);
				}
			}
		}
		return list;
	}

	/**
	 * @Method Name : uploadThumnail
	 * @Method 설명 : 섬네일을 생성하여 업로드합니다.
	 * @작성일 : 2014. 12. 24.오전 10:47:21
	 * @작성자 : 방은
	 * @Modification Information
	 * 
	 * <pre>
	 *      수정일                                  수정자                                    수정내용
	 *    -------          --------        ---------------------------
	 *   2014. 12. 24.      방은                                       최초 생성
	 * </pre>
	 * @param file
	 * @param vo
	 * @param path
	 * @see
	 */
	private static void uploadThumnail(MultipartFile file, FileVO vo, String path) {
		
		if (file.getContentType().indexOf("image") >= 0) {
			BufferedImage bi;
			try {
				File dir = new File(path + "/thumnails/");
				dir.mkdirs();

				ImageIO.setUseCache(false);
				bi = ImageIO.read(file.getInputStream());
				if (bi.getWidth() < 95 && bi.getHeight() < 95) {
					BufferedImage img = new BufferedImage(bi.getWidth(), bi.getHeight(), BufferedImage.TYPE_INT_RGB);
					ImageIO.write(img, "jpg", new File(path + "/thumnails/" + vo.getVirtualName()));
				}
				else {
					double min = Math.min(95 / (double) bi.getWidth(), 115 / (double) bi.getHeight());
					BufferedImage img = new BufferedImage((int) (bi.getWidth() * min), (int) (bi.getHeight() * min), BufferedImage.TYPE_INT_RGB);
					img.createGraphics().drawImage(bi.getScaledInstance((int) (bi.getWidth() * min), (int) (bi.getHeight() * min), Image.SCALE_SMOOTH), 0, 0, null);
					ImageIO.write(img, "jpg", new File(path + "/thumnails/" + vo.getVirtualName()));
				}
				vo.setHasThumnail(true);
				vo.setWidth(String.valueOf(bi.getWidth()));
				vo.setHeight(String.valueOf(bi.getHeight()));
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private static void writeFile(MultipartFile file, String virtualName, String path) throws Exception {

		InputStream stream = null;
		OutputStream bos = null;

		try {
			stream = file.getInputStream();
			File cFile = new File(path);

			if (!cFile.isDirectory()) cFile.mkdirs();

			bos = new FileOutputStream(path + File.separator + virtualName);

			int bytesRead = 0;
			byte[] buffer = new byte[BUFF_SIZE];

			while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
				bos.write(buffer, 0, bytesRead);
			}
		}
		catch (Exception e) {
			logger.debug("IGNORED: " + e.getMessage());
		}
		finally {
			if (bos != null) {
				try {
					bos.close();
				}
				catch (Exception ignore) {
					logger.debug("IGNORED: " + ignore.getMessage());
				}
			}
			if (stream != null) {
				try {
					stream.close();
				}
				catch (Exception ignore) {
					logger.debug("IGNORED: " + ignore.getMessage());
				}
			}
		}
	}
	
	private static String filePathBlackList(String value) {

		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

		return returnValue;
	}

	/**
	 * @Method Name  : removeFile
	 * @Method 설명 : 물리적으로 파일을 삭제합니다.
	 * @작성일   : 2015. 1. 8.오전 10:01:49 
	 * @작성자   : 방은
	 * @Modification Information
	 * 
	 * <pre>
	 *      수정일      수정자                                    수정내용
	 *    -------          --------                                  ---------------------------
	 *   2015. 1. 8.      방은                                       최초 생성
	 * </pre>
	 * @param fileVO
	 * @param request
	 * @throws Exception
	 * @see
	 */
	public static void removeFile(FileVO fileVO, HttpServletRequest request) throws Exception {

		//MessageSourceWrapper messageSourceWrapper = (MessageSourceWrapper) DynamicBeanProvider.getBean("messageSourceWrapper");
		//String filePath = messageSourceWrapper.getMessage("file.uploadPath");
		
		String filePath = EgovProperties.getProperty("Globals.fileStorePath");

		String path = filePath + fileVO.getCategory();
		
		System.out.println(path);

		File file = new File(path + "/" + fileVO.getStreFileNm());
		File file1 = new File(fileVO.getFileStreCours() + "/" + fileVO.getStreFileNm());
		if (!file.exists()) {
			throw new FileNotFoundException(fileVO.getRealName());
		}
		if (!file.isFile()) {
			throw new FileNotFoundException(fileVO.getRealName());
		}
		file.delete();
	}
}
