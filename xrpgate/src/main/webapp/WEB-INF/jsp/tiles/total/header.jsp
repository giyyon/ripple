<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>

<script type="text/javascript">
 	$(function() {
		$('#main_bn').ulslide({          
			statusbar: true,
			height: 500,        // 슬라이드 배너의 세로크기 조절
			affect: 'slide',      // fade로 변경시 서서히 사라지고 나타나는 형태로 바뀜
			axis: 'y',              // y로 변경시 세로슬라이드로 바뀜
			navigator: '#main_bn_bt a',
			duration: 400,        // 배너 바뀌는 속도
			autoslide: 3000       // 배너 바뀌는 딜레이 조절
		});
	});
</script>
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
        	<div class="logo"><a href="${contextPath}/company/companyIntro.do"><img src="/images/common/top_logo.png" /></a></div>
            <div class="nav">
            	<li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/company/companyIntro.do">
                       		<img src="/images/common/main_01_off.png" onmouseover="this.src='/images/common/main_01_on.png'"onmouseout="this.src='/images/common/main_01_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/company/companyIntro.do">인사말</a></li>  
                      
                      <li><a href="${contextPath}/company/about.do">회사소개</a></li> 
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
                      <li><a href="${contextPath}/company/ripplebuy.do">구매하기</a></li> 
                      <li><a href="${contextPath}/company/ripplesell.do">판매하기</a></li> 
                      <li><a href="${contextPath}/company/gateway.do">게이트웨이 등록</a></li> 
                      <li><a href="${contextPath}/company/ripplebalance.do">리플잔고</a></li> 
                      <li><a href="${contextPath}/company/ripplepw.do">리플비밀번호 수정</a></li> 
                      <li><a href="${contextPath}/company/rippledouble.do">리플 이중인증 설정</a></li> 
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="html/marketprice.html">
                       		<img src="/images/common/main_03_off.png" onmouseover="this.src='/images/common/main_03_on.png'"onmouseout="this.src='/images/common/main_03_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/trade/callAccountTransactions.do">예탁</a></li>  
                      <li><a href="${contextPath}/trade/callAccountTransactions.do">예탁</a></li> 
                      <li><a href="${contextPath}/trade/callAccountTransactions.do">인출</a></li>
                      <li><a href="${contextPath}/trade/callXrpTrade.do">거래하기</a></li>
                      <li><a href="html/proxy.html">리플구매대행</a></li>
                      <li><a href="html/fees.html">수수료정책</a></li>
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="html/FAQ.html">
                       		<img src="/images/common/main_04_off.png" onmouseover="this.src='/images/common/main_04_on.png'"onmouseout="this.src='/images/common/main_04_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/customer/phoneQnAList.do">FAQ</a></li>  
                      <li><a href="${contextPath}/customer/rippleNewsList.do">리플소식</a></li> 
                      <li><a href="${contextPath}/customer/rippleNoticeList.do">공지사항</a></li> 
                      <li><a href="${contextPath}/company/about.do">자료실</a></li> 
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="html/member/meminfo_chk.html">
                       		<img src="/images/common/main_05_off.png" onmouseover="this.src='/images/common/main_05_on.png'"onmouseout="this.src='/images/common/main_05_off.png'" />
                        </a>
                   </div>
                   <ul class="subnav">  
                      <li><a href="${contextPath}/myInfo/memberChk.do">회원정보</a></li>  
                      <li><a href="${contextPath}/myInfo/myRippleTradeList.do">리플거래내역</a></li> 
                      <li><a href="${contextPath}/join/joinStep1.do">회원가입</a></li> 
                   </ul>  
                </li>
            </div>
          	<div class="top_small">
            	<li><a href="${contextPath}/login/loginUsr.do"><img src="/images/common/top_login.png" /></a></li>
                <li><a href="html/sitemap.html"><img src="/images/common/top_sitemap.png" /></a></li>
                <li><a href="${contextPath}/join/joinStep1.do"><img src="/images/common/top_join.png" /></a></li>
            </div>
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
