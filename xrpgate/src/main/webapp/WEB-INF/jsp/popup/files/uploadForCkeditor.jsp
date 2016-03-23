<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>upload</title>
</head>
<body>

<script type='text/javascript'>
	top.CKEDITOR.tools.callFunction('${CKEditorFuncNum}', '${url}', '완료');
</script>

<%
// 	boolean isMultipart = ServletFileUpload.isMultipartContent(request);  //multipart로 전송되었는가 체크
// 	if (isMultipart) {
// 		// 설정단계
//  		File temporaryDir = new File("c:\\tmp\\");  //업로드된 파일의 임시 저장 폴더
//  		String realDir = config.getServletContext().getRealPath(request.getParameter("realDir"));  //실제 저장될 파일경로
//  		String sFunc = request.getParameter("CKEditorFuncNum");
//  		String realUrl = request.getParameter("realUrl");

//  		// 디스크 기반의 파일 아이템 팩토리 생성
// 		DiskFileItemFactory factory = new DiskFileItemFactory();
// 		factory.setSizeThreshold(1 * 1024 * 1024);  //최대 메모리 크기
// 		factory.setRepository(temporaryDir);  // 임시저장폴더 연결

// 		// 구현단계
// 		ServletFileUpload upload = new ServletFileUpload(factory);
// 		upload.setSizeMax(10 * 1024 * 1024);  //최대 업로드 크기
// 		List<FileItem> items = upload.parseRequest(request); //이 부분에서 파일이 생성
// 		Iterator iter = items.iterator();
 
// 		while (iter.hasNext()) {
// 			FileItem fileItem = (FileItem) iter.next();
// 			if (fileItem.isFormField()) {  // File 컴포넌트가 아닌 일반 컴포넌트일 경우
// 				out.println(fileItem.getFieldName() + "=" + fileItem.getString("euc-kr") + "<br/>");
// 			}else{
// 				if (fileItem.getSize() > 0) {  //파일이 업로드 되었나 안되었나 체크
// 					String fieldName = fileItem.getFieldName();
// 					String fileName = fileItem.getName();
// 					String contentType = fileItem.getContentType();
// 					boolean isInMemory = fileItem.isInMemory();
// 					long sizeInBytes = fileItem.getSize();
					
// 					/* 
// 			 		out.println("[realDir] : "+ realDir +"<br/>");
// 			     	out.println("[fieldName] : "+ fieldName +"<br/>");
// 			        out.println("[fileName] : "+ fileName +"<br/>");
// 			        out.println("[contentType] : "+ contentType +"<br/>");
// 			        out.println("[isInMemory] : "+ isInMemory +"<br/>");
// 			        out.println("[sizeInBytes] : "+ sizeInBytes +"<br/>");
// 			 		*/
			 		
// 			 		out.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + sFunc + ", '"+ realUrl + fileName + "', '완료');</script>");

// 			 		try {
// 			 			File uploadedFile = new File(realDir, fileName);
// 			 			fileItem.write(uploadedFile);  //실제 디렉토리에 카피
// 			 			fileItem.delete();   //temp폴더의 파일 제거
// 			 		} catch(IOException ex) {
// 			 			out.println("error : "+ ex +"<br/>");
// 			 		}
// 				}
// 			}
// 		}
// 	} else {
// // 		out.println("인코딩 타입이 multipart/form-data 가 아님.");
// 	}
%>
</body>
</html>