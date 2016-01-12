<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

  
<div class="con_title">
  <li>
    <img src="/images/sub/faq_title.png" /><!--게시판 메뉴에 따라 제목이 바뀌면 됩니다.-->
  </li>
</div> 

<div class="content">
    <div class="content_in">
        <div class="con_info">
        	<div class="board_view">
            	<table cellpadding="0" cellspacing="0" border="0">
                	<thead>
                        <tr>
                            <td>
                            	<li class="view_title">제목</li>
                                <li class="view_bar"> | </li>
                                <li class="view_text"><c:out value="${result.nttSj}" /></li>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            	<div class="hit_box">
                                    <li class="view_title">조회</li>
                                    <li class="view_bar"> | </li>
                                    <li class="view_text"><c:out value="${result.inqireCo}"/></li>
                                </div>
                                <div class="who_box">
                                    <li class="view_title">작성자</li>
                                    <li class="view_bar"> | </li>
                                    <li class="view_text"><c:out value="${result.ntcrId}"/></li>
                                </div>
                                <div class="date_box">
                                    <li class="view_title">작성일</li>
                                    <li class="view_bar"> | </li>
                                    <li class="view_text"><c:out value="${result.frstRegisterPnttm}"/></li>
                                </div>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                        	<td >
                        		<div>
                        		<c:out value="${result.nttCn}" escapeXml="false" />
                        		</div>
                        	</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
        </div>
    </div>    
</div>  

<div class="view_btn"><!--페이지에 맞춰서 해당 목록으로 돌아가면 됩니다-->
            	<li><a href="javascript:linkListPage()">목록으로</a></li>            	
            </div>
<form:form commandName="result"  id="frm" action="${contextPath}/customer/rippleNewsList.do">    
	<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
	<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
	<input type="hidden" name="pageIndex" value="<c:out value='${result.pageIndex}'/>"/>
</form:form>  
  <script type="text/javaScript" language="javascript"> 
	
  $( window ).load(function() {
	  $tdheight = $("tbody td").css("height");
	  $tbody = $("tbody").css("height");
	  
	  if( $tbody < $tdheight ){
		  $("tbody").css("height", $tdheight);
	  }
	});
  
   function linkListPage(){
	   $('#frm').attr('action', '${contextPath}/customer/rippleNewsList.do'); 
	   $("#frm").submit();
   }
	
	$('[name=btnFileDownload]').click(function(e) {
		e.preventDefault();
		var category = $(this).attr('data_category');
		var $imgId = $(this).parent().find(':hidden');
		COM.openFileListPopup(category, $imgId.val());
	});
  </script> 

