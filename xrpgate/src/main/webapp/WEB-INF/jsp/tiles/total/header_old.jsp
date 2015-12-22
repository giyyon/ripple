<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>
<link href="/css/headerStyle.css" rel="stylesheet" type="text/css">

<script>
	if('${message}'  != null  &&'${message}' != '')
		alert('${message}');
</script>

<div id="header">
   <div id="header01">
   <img src="/img/m0.jpg" alt="로고" width="250" height="100" usemap="#Map" border="0" />
   <map name="Map" id="Map">
     <area shape="rect" coords="4,18,229,84" href="/" />
   </map>
   </div>
   <div id="header02">
   <security:authorize access="isAnonymous()">
	   <div id="hom"><a href="/" ><p id="p3">홈</p></a></div>
	   <div id="log"><a href="${contextPath}/login/loginUsr.do" ><p id="p3">로그인</p></a></div>
	   <div id="Member"><a href="${contextPath}/join/joinStep1.do" ><p id="p3">회원가입</p></a></div>
	   <div id="Customer"><a href="/customer/callPhoneCouncelModify.do" ><p id="p3">고객상담</p></a></div>
    </security:authorize>

	<security:authorize access="isAuthenticated()">
	   <div id="hom"><a href="/" ><p id="p3">홈</p></a></div>
	   <div id="log"><a href="${contextPath}/login/actionLogout.do" ><p id="p3">로그아웃</p></a></div>
	   <div id="Member"><a href="${contextPath}/myInfo//myInfoInqire.do" ><p id="p3">내정보</p></a></div>
	   
		<c:choose>
		<c:when test="${empty isAdminRole}">
			<div id="Customer"><a href="/customer/phoneQnAList.do" ><p id="p3">고객상담</p></a></div>
		</c:when>
		<c:otherwise>
			<div id="Customer"><a href="/admin/main.do" ><p id="p3">관리자</p></a></div>
		</c:otherwise>
		</c:choose>
	</security:authorize>
	   <img src="/img/m1.jpg" alt="상단메뉴" width="750" height="100" usemap="#Map2" border="0" />
	   <map name="Map2" id="Map2">
	     <area shape="rect" coords="3,56,57,86"    alt="회사소개"  onmouseover=""  class='handPnt'   href="/company/companyIntro.do" />
	     <area shape="rect" coords="72,57,132,84" alt="리플소개" href="/company/rippleIntro.do" />
	     <area shape="rect" coords="147,58,209,85"  alt="리플신청" href="/trade/callRippleTradeBuyModify.do" />
	     <area shape="rect" coords="225,58,293,86" alt="실시간시세" href="/customer/rippleTradeChart.do" />
	     <area shape="rect" coords="311,59,397,85" alt="리플트레이드" href="/customer/rippleTrade.do" />
	     <area shape="rect" coords="414,60,474,86" alt="리플뉴스" href="/customer/rippleNewsList.do" />
	     <area shape="rect" coords="488,59,547,87" alt="공지사항" href="/customer/rippleNoticeList.do" />
	     <area shape="rect" coords="562,58,647,88" alt="전화상담신청" href="/customer/callPhoneCouncelModify.do" />
	     <area shape="rect" coords="665,60,749,85" alt="신한덤포인트" href="#" />
	   </map>
	  </div>
</div>
<!--상단메뉴 끝-->


<!--     	<div id="gnb_wrap"> -->
<!--    			<div class="gnb area_ct"> -->
<!--             	<ul class="flr"> -->
<!--                 	<li><a href="/">홈</a></li> -->
<%-- 					<security:authorize access="isAnonymous()"> --%>
<%-- 							 <li><a href="${contextPath}/login/loginUsr.do">로그인</a></li> --%>
<%-- 							<li><a href="${contextPath}/join/UserSeChoose.do">회원가입</a></li> --%>
<%-- 					</security:authorize> --%>
<%-- 					<security:authorize access="isAuthenticated()"> --%>
<%-- 							<li><a href="${contextPath}/login/actionLogout.do">로그아웃</a></li> --%>
<%-- 							<li><a href="${contextPath}/myInfo/myInfoView.do">내정보</a></li> --%>
<%-- 					</security:authorize> --%>
<%--                     <li>글자크기 <a href="javascript:zoomOut();"><img src="${contextPath}/img/font_plus.png" alt="글씨크게"></a><a href="javascript:zoomIn();"><img src="${contextPath}/img/font_minus.png" alt="글씨작게"></a><a href="javascript:zoomReset();"><img src="${contextPath}/img/font_stop.png" alt="글씨크게"></a></li>        --%>
<!--             	</ul> -->
<!--             </div> -->
<!--    		</div> -->

		<!-- 관리자용 메뉴 구성-->
