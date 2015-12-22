<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8">
<link href="../css/necgis.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#error_wrap { position:relative; width:70%; margin:0 auto; text-align:center; margin-top:70px}
#error_wrap img { padding-bottom:30px}
#error_wrap .ex { font-size:13px; line-height:24px; margin-top:40px; width:100%; float:left}
#error_wrap .btn { width:100%; float:left; margin-top:30px}
</style>
<title></title>
</head>

<body>

<div id="error_wrap">
    <div class="sect_tk fcBlue">
    <img src="/img/error.png" alt="error_img"/><br/>
    <span class="hi"><span class="fcBlue">HTTP 404 Error</span><br/>웹 페이지를 찾을 수 없습니다.
    <span class="ex">찾으시려는 페이지의 주소가 잘못 입력되었거나, 페이지 주소의 변경 혹은 삭제로 인해 현재 사용하실 수 없습니다. <br>입력하신 페이지의 주소가 정확한지 다시 한번 확인해 주시길 부탁드립니다.<br>
    아래 '홈으로 이동' 버튼을 클릭 후, 이동하여 이용해 주시기 바랍니다.<br>관련하여 문의가 있으시면 언제든지, 고객센터로 문의하여 주십시오.</span>
    
    <div class="btn"><a href="/"><img src="/img/btn_gohome.png" alt="홈으로 이동" /></a></div>
</span><br/>
    
    </div>
</div>
</body>
</html>
