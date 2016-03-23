<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

  
<div class="con_title">
  <li>
    <img src="/images/sub/news_title.png" /><!--게시판 메뉴에 따라 제목이 바뀌면 됩니다.-->
  </li>
</div> 
<form:form commandName="result"  id="frm" action="${contextPath}/customer/rippleNewsList.do"> 
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
                                    <li class="view_text"><c:out value="${result.ntcrNm}"/></li>
                                </div>
                                <div class="date_box">
                                    <li class="view_title">작성일</li>
                                    <li class="view_bar"> | </li>
                                    <li class="view_text"><c:out value="${result.frstRegisterPnttm}"/></li>
                                </div>
                            </td>
                        </tr>
                        <c:if test='${not empty result.atchFileId}'>
						<tr>
							<td >
								<div class="hit_box" style="width:10%">
									<li class="view_title">첨부파일 목록</li>
								</div>
								<div class="who_box" style="width:10%">
                                    <li class="view_bar"> | </li>
                                    <li class="view_text">
                                    	<form:hidden path="atchFileId" />
										<img name="btnFileDownload" src="${contextPath}/img/btn_down2.png"  data_fileMax="5" data_category="news"  data_type="img" data_fieldId="atchFileId"    alt="다운로드">
									</li>
                                </div>
				            	<div class="date_box" style="width:60%">
				            	<li class="view_text" >
					            	 
									<c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import>	
								</li>
								</div>
							</td> 
						</tr>
						</c:if>
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
		var fieldId = $(this).attr('data_fieldId');
		var thisType = $(this).attr('data_type');
		var category = $(this).attr('data_category');
		var fileMax = $(this).attr('data_fileMax');
		var fileMode = "";
		
		var $imgId = $(this).parent().find(':hidden');
		
		e.preventDefault();
				
		var url = "${contextPath}/files/uploadPage.do?";
		var atchFileId = $(this).parent().find(':hidden').val();
		var param = {
				atchFileId : atchFileId
				, contentType : thisType
				, category : category
				, size : fileMax
				, fieldId : fieldId
				, fileMode : fileMode
		}
		
		window.open(url+ $.param(param), 'popUpWindow','height=300, width=650, left=300, top=100, resizable=no, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');
	});
  </script> 

