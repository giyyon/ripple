<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>

<link href="/css/sub.css" rel="stylesheet" type="text/css" />
<link href="/css/common_xrp.css" rel="stylesheet" type="text/css">
<link href="/css/index.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
 $(document).ready(function(){  
   
  $(".topnav").hover(function() {                    //마우스를 topnav에 오버시
   $(this).parent().find(".subnav").slideDown('normal').show();                   //subnav가 내려옴.
   $(this).parent().hover(function() {  
   }, function(){  
    $(this).parent().find(".subnav").slideUp('fast');                 //subnav에서 마우스 벗어났을 시 원위치시킴  
   });  
  });  
   
 });  
</script>

<!--상단메뉴 시작-->
<div class="top">
    	<div class="top_wrap">
        	<div class="logo"><a href="${contextPath}/"><img src="/images/common/top_logo.png" /></a></div>
            <div class="nav">
            	<li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/company/companyIntro.do">
                       		<img src="/images/common/main_01_off.png" onmouseover="this.src='/images/common/main_01_on.png'"onmouseout="this.src='/images/common/main_01_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/company/companyIntro.do">인사말</a></li>  
                      
                      <!-- <li><a href="${contextPath}/company/about.do">회사소개</a></li> --> 
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/company/rippleintro.do">
                       		<img src="/images/common/main_02_off.png" onmouseover="this.src='/images/common/main_02_on.png'"onmouseout="this.src='/images/common/main_02_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/company/rippleintro.do">리플소개</a></li>  
                      <li><a href="${contextPath}/company/walletripple.do">리플지갑만들기</a></li> 
                      <li><a href="${contextPath}/company/sendripple.do">리플보내기</a></li> 
                      <!-- 20150201 고객 요청 감춤
                      <li><a href="${contextPath}/company/ripplebuy.do">구매하기</a></li> 
                      <li><a href="${contextPath}/company/ripplesell.do">판매하기</a></li> 
                       <li><a href="${contextPath}/company/gateway.do">게이트웨이 등록</a></li> --> 
                      <li><a href="${contextPath}/company/ripplePersonCert.do">리플 본인인증</a></li> 
                      <li><a href="${contextPath}/company/ripplePwChgCert.do">비밀번호 변경 & 이중인증</a></li> 
                      <li><a href="${contextPath}/company/ripplePwRestore.do">리플 비밀번호 복구</a></li> 
                      
                      <!--  <li><a href="${contextPath}/company/ripplebalance.do">리플잔고</a></li> 
                      <li><a href="${contextPath}/company/ripplepw.do">리플비밀번호 수정</a></li> 
                      <li><a href="${contextPath}/company/rippledouble.do">리플 이중인증 설정</a></li> 
                      -->
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/trade/callMarketPriece.do">
                       		<img src="/images/common/main_03_off.png" onmouseover="this.src='/images/common/main_03_on.png'"onmouseout="this.src='/images/common/main_03_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/tradeInfo/callMarketPriece.do">시세</a></li>  
                      <li><a href="${contextPath}/trade/callAccountTransactions.do">예탁</a></li> 
                      <li><a href="${contextPath}/trade/callAccountTransactions.do">인출</a></li>
                      <li><a href="${contextPath}/trade/callXrpTrade.do">거래하기</a></li>
                      <!-- 2010201 고객요청 감춤 
                      <li><a href="${contextPath}/trade/callExcutePurchase.do">리플구매대행</a></li>
                      <li><a href="${contextPath}/tradeInfo/callCommissionPolicy.do">수수료정책</a></li>
                      -->
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/customer/phoneQnAList.do">
                       		<img src="/images/common/main_04_off.png" onmouseover="this.src='/images/common/main_04_on.png'"onmouseout="this.src='/images/common/main_04_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/customer/phoneQnAList.do">FAQ</a></li>  
                      <li><a href="${contextPath}/customer/rippleNewsList.do">리플소식</a></li> 
                      <li><a href="${contextPath}/customer/rippleNoticeList.do">공지사항</a></li> 
                      <li><a href="${contextPath}/customer/referenceList.do">자료실</a></li> 
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/myInfo/memberChk.do">
                       		<img src="/images/common/main_05_off.png" onmouseover="this.src='/images/common/main_05_on.png'"onmouseout="this.src='/images/common/main_05_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/myInfo/memberChk.do">회원정보</a></li>  
                      <li><a href="${contextPath}/myInfo/myRippleTradeList.do">마이페이지</a></li> 
                      <li><a href="${contextPath}/join/joinStep1.do">회원가입</a></li> 
                   </ul>  
                </li>
            </div>
            
             <div class="top_small">
            <security:authorize access="isAnonymous()">
            	<li><a href="${contextPath}/login/loginUsr.do"><img src="/images/common/top_login.png" /></a></li>
            	<li><a href="${contextPath}/main/siteMap.do"><img src="/images/common/top_sitemap.png" /></a></li>
                <li><a href="${contextPath}/join/joinStep1.do"><img src="/images/common/top_join.png" /></a></li>
            </security:authorize>
            <security:authorize access="isAuthenticated()">
            	<li><a href="${contextPath}/login/actionLogout.do"><img src="/images/common/top_logout.png" /></a></li>
            	<li><a href="${contextPath}/main/siteMap.do"><img src="/images/common/top_sitemap.png" /></a></li>
                <li><a href="${contextPath}/join/joinStep1.do"><img src="/images/common/top_join.png" /></a></li>
                <c:if test="${not empty isAdminRole}">
				 <li><a href="${contextPath}/admin/main.do"><img src="/images/common/top_admin.png" /></a></li>
				</c:if>
            </security:authorize>
            </div>
        </div>
    </div>
