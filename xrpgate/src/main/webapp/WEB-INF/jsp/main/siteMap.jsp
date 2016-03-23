<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
  <li>
    <img src="/images/sub/sitemap_title.png" />
  </li>
</div> 
<div class="content">
    <div class="content_in">
        <div class="con_info">
        	<div class="sitemap_box" style="margin-left:50px;">
            	<div class="sitemap_title">회사소개</div>
                <div class="sitemap_info">
                	<li><a href="${contextPath}/company/companyIntro.do">인사말</a></li>
                    <!-- <li><a href="${contextPath}/company/about.do">회사소개</a></li> -->                
                </div>
            </div>
            
            <div class="sitemap_box">
            	<div class="sitemap_title">리플이란?</div>
                <div class="sitemap_info">
                	<li><a href="${contextPath}/company/rippleintro.do">Ripple 소개</a></li>
                    <li><a href="${contextPath}/company/walletripple.do">리플 지갑만들기</a></li>   
                    <li><a href="${contextPath}/company/sendripple.do">리플 보내기</a></li> 
                    <!--
                    <li><a href="${contextPath}/company/ripplebuy.do">구매하기</a></li> 
                    <li><a href="${contextPath}/company/ripplesell.do">판매하기</a></li> 
                    <li><a href="gateway.html">게이트웨이 등록방법 </a></li> --> 
                    <li><a href="${contextPath}/company/ripplePersonCert.do">리플 본인인증 </a></li> 
                    <li><a href="${contextPath}/company/ripplePwChgCert.do">비밀번호 변경 & 이중인증</a></li> 
                      <li><a href="${contextPath}/company/ripplePwRestore.do">리플 비밀번호 복구</a></li>           
                </div>
            </div>
            
            <div class="sitemap_box">
            	<div class="sitemap_title">예탁/인출</div>
                <div class="sitemap_info">
                	<li><a href="${contextPath}/tradeInfo/callMarketPriece.do">시세</a></li>  
                      <li><a href="${contextPath}/trade/callAccountTransactions.do">예탁</a></li> 
                      <li><a href="${contextPath}/trade/callAccountTransactions.do">인출</a></li>
                      <li><a href="${contextPath}/trade/callXrpTrade.do">거래하기</a></li>
                      <!-- 2010201 고객요청 감춤 
                      <li><a href="${contextPath}/trade/callExcutePurchase.do">리플구매대행</a></li>
                      <li><a href="${contextPath}/tradeInfo/callCommissionPolicy.do">수수료정책</a></li>   
                      -->       
                </div>
            </div>
            
            <div class="sitemap_box">
            	<div class="sitemap_title">고객센터</div>
                <div class="sitemap_info">
                	<li><a href="${contextPath}/customer/phoneQnAList.do">FAQ</a></li>  
                      <li><a href="${contextPath}/customer/rippleNewsList.do">리플소식</a></li> 
                      <li><a href="${contextPath}/customer/rippleNoticeList.do">공지사항</a></li> 
                      <li><a href="${contextPath}/customer/referenceList.do">자료실</a></li>              
                </div>
            </div>
            
            <div class="sitemap_box">
            	<div class="sitemap_title">마이페이지</div>
                <div class="sitemap_info">
                	<li><a href="${contextPath}/myInfo/memberChk.do">회원정보</a></li>  
                	<li><a href="${contextPath}/myInfo/myRippleTradeList.do">마이페이지</a></li> 
                    <li><a href="${contextPath}/join/joinStep1.do">회원가입</a></li>             
                </div>
            </div>
        </div>
    </div>    
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		
	});

</script>
        