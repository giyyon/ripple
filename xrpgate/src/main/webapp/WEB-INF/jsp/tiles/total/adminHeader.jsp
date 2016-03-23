<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>

<link href="/css/admin.css" rel="stylesheet" type="text/css" />



<div class="top">
    	<div class="top_wrap">
        	<div class="logo"><a href="${contextPath}/admin/main.do"><img src="${contextPath}/images/admin/admin_logo.png" /></a></div>
            <div class="nav">
            	<li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/admin/FAQList.do">
                       		<img src="${contextPath}/images/admin/admin_01_off.png" onmouseover="this.src='${contextPath}/images/admin/admin_01_on.png'"onmouseout="this.src='${contextPath}/images/admin/admin_01_off.png'" />
                        </a>
                   </div>
                    <ul class="subnav">  
                        <li><a href="${contextPath}/admin/FAQList.do">FAQ</a></li>    
                        <li><a href="${contextPath}/admin/rippleNewsList.do">리플소식</a></li>
                        <li><a href="${contextPath}/admin/rippleNoticeList.do">공지사항</a></li> 
                        <li><a href="${contextPath}/admin/referenceList.do">자료실</a></li>
                   </ul>  
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/admin/gnrMberList.do">
                       		<img src="${contextPath}/images/admin/admin_02_off.png" onmouseover="this.src='${contextPath}/images/admin/admin_02_on.png'"onmouseout="this.src='${contextPath}/images/admin/admin_02_off.png'" />
                        </a>
                   </div>
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/admin/accountMgmt.do">
                       		<img src="${contextPath}/images/admin/admin_03_off.png" onmouseover="this.src='${contextPath}/images/admin/admin_03_on.png'"onmouseout="this.src='${contextPath}/images/admin/admin_03_off.png'" />
                        </a>
                   </div>
                </li>
                
                <li class="navi_set" style="margin-left:20px;">  
                   <div class="topnav">
                       <a href="${contextPath}/admin/xrpgateTradeMgmt.do">
                       		<img src="${contextPath}/images/admin/admin_04_off.png" onmouseover="this.src='${contextPath}/images/admin/admin_04_on.png'"onmouseout="this.src='${contextPath}/images/admin/admin_04_off.png'" />
                        </a>
                   </div>
                </li>
                
                 <li class="navi_set" style="margin-left:30px;">  
                   <div class="topnav">
                       <a href="${contextPath}/admin/memberAttachFileMgmt.do">
                       		<img src="${contextPath}/images/admin/admin_05_off.png" onmouseover="this.src='${contextPath}/images/admin/admin_05_on.png'"onmouseout="this.src='${contextPath}/images/admin/admin_05_off.png'" />
                        </a>
                   </div>
                </li>
                
                <li class="navi_set">  
                   <div class="topnav">
                       <a href="${contextPath}/admin/mberXrpTradeMgmt.do">
                       		<img src="${contextPath}/images/admin/admin_06_off.png" onmouseover="this.src='${contextPath}/images/admin/admin_06_on.png'"onmouseout="this.src='${contextPath}/images/admin/admin_06_off.png'" />
                        </a>
                   </div>
                </li>
            </div>
        </div>
    </div>
    
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