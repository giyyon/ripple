<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style12.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0020.jpg" width="400" height="35" />
<!-- </div> -->
<!--타이틀끝-->

     	<div id="sub_container">
        	<div id="content-group">
            	<!--//lnb-group -->
            	
            	<div id="contents" class="bg_cs">
            		<form:form commandName="result"  id="frm" action="${contextPath}/customer/noticeInqire.do">    
	            		<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
						<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

					<div class="etc_info">
					  No.<c:out value="${result.nttNo}"/><em>|</em>Hits.<c:out value="${result.inqireCo}"/><em>|</em><c:out value="${result.frstRegisterPnttm}"/>
                    </div>
                    <!------------ //20150209추가/변경--------- -->
                    
                    <div class="bview_box">
                    	<ul>
                            <li class="full"><strong><span>제목</span></strong><span class="fcR_B"><c:out value="${result.nttSj}" /></span></li>
                            <li class="full"><strong><span>등록자</span></strong><span>관리자</span></li>
                            <li class="full"><strong><span>첨부파일</span></strong>
                           		 <div class="file_bx">
                           		 	<c:choose>
                           		 		<c:when test='${empty result.atchFileId}'>
											<span>첨부파일 없음</span>
                           		 		</c:when>
                           		 		<c:otherwise>
		                          		    <form:hidden path="atchFileId" />
		                                  	<img name="btnFileDownload" src="${contextPath}/img/btn_down2.png"    data_type="file"   alt="다운로드"> 
		                                   <br>
		                                    <c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atchFileId}" />
										 </c:import>	  
                           		 		</c:otherwise>
                           		 	</c:choose>
                            	</div>                    	
                            </li>  
                        </ul>
                        <div class="cont">
                           <c:out value="${result.nttCn}" escapeXml="false" />
                        </div>	
                    </div>

                    <!-- //뷰 -->
 
                    
                    <!-- 뷰 -->
            	     <div class="btn_wrap">
                    	<a href="javascript:linkListPage()"><img id="showNotice" src="${contextPath}/img/btn_list.png" alt="목록"></a>
                    </div>
					</form:form>
            	</div>
            	<!--//contents -->
        	</div>
        	<!--//content-group -->
		</div><!--//sub_container -->
  <script> 

   function linkListPage(){
	   $('#frm').attr('action', '${contextPath}/customer/rippleNoticeList.do'); 
	   $("#frm").submit();
   }
	
	$('[name=btnFileDownload]').click(function(e) {
		e.preventDefault();
		var category = $(this).attr('data_category');
		var $imgId = $(this).parent().find(':hidden');
		COM.openFileListPopup(category, $imgId.val());
	});
  </script> 

