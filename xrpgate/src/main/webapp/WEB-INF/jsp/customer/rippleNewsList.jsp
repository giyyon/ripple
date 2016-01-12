<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>



<div class="con_title">
	  <li>
      	<img src="/images/sub/news_title.png" />
      </li>
  </div> 

<div class="content">
    <div class="content_in">
        <div class="con_info">
            <div class="faq_search">
            	<li><input type="text" /></li>
                <li class="search_btn"><a href="#">검색</a></li>
            </div>
            <div class="board_write_btn"><!--관리자에게만 보이는 버튼 입니다.-->
            	<a href="/html/board_write.html">글쓰기</a>            
            </div>
			<div cass="faq_table">
            	<table class="sub_news" border="1" cellpadding="0" cellspacing="0">
	                <colgroup>
                    	<col />
                        <col width="110" />
                        <col width="100" />
                        <col width="80" />
                    </colgroup>
                    <thead>
                    	<tr>
                        	<th scope="col">제목</th>
                            <th scope="col">글쓴이</th>
                            <th scope="col">날짜</th>
                            <th scope="col">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr style="cursor:hand" onclick="goDetail('${result.bbsId}', '${result.nttId}');">
							<td class="title">
                            	<span  onclick="layer_open('layer2',  ${status.index}); return false;">
								<c:out value="${result.nttSj}"/>
							</span>
                            </td>
                            <td class="name"><c:out value="${result.ntcrId}"/></td>
                            <td class="date"><c:out value="${result.frstRegisterPnttm}"/></td>
                            <td class="hit"></td>
                            <!-- 
							<span class="num"><c:out value="${result.nttId}"/></span>
							<span class="num"><c:out value="${result.bbsNm}"/></span>
							<span class="bbs_sub"><c:out value="${result.nttSj}"/></span>
							<span class="date"><c:out value="${result.frstRegisterPnttm}"/></span>
							<span class="picinf"><c:out value="${result.ntcrId}"/></span>
							<span class="num handPnt" onclick="layer_open('layer2',  ${status.index}); return false;">
							<c:out value="${result.qnaProcessSttusCode}"/>
							</span>
							 -->
							<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
							<input type="hidden" name="searchWrd"value="<c:out value='${searchVO.searchWrd}'/>"/>
							<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
							<input type="hidden" name="bbsNm" value="<c:out value='${result.bbsNm}'/>" />
							<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
							<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" />
							<input type="hidden" name="frstRegisterPnttm" value="<c:out value='${resultfrstRegisterPnttm}'/>"/>
							<input type="hidden" name="lastUpdusrId" value="<c:out value='${result.lastUpdusrId}'/>" />
							<input type="hidden" name="lastUpdusrPnttm" value="<c:out value='${result.lastUpdusrPnttm}'/>" />
							<input type="hidden" name="ntcrId" value='<c:out value="${result.ntcrId}" />'>
							<input type="hidden" name="nttCn" value='<c:out value="${result.nttCn}" escapeXml="false" />'>
							<input type="hidden" name="moblphonNo" value='<c:out value="${result.moblphonNo}" />'>
							<input type="hidden" name="answerCn" value='<c:out value="${result.answerCn}" />'>
							<input type="hidden" name="qnaProcessSttusCode" value='<c:out value="${result.qnaProcessSttusCode}" escapeXml="false" />'>
						</td>
						</c:forEach>
                    </tbody>
                </table>
               
                <div class="paging">
					<ui:pagination paginationInfo="${paginationInfo}" type="supportImage" jsFunction="linkPage" />
				</div>
            </div>
        </div>
    </div>    
</div>

 <form id="subForm"  method="post" >
	<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	<input type="hidden" name="bbsId" value="" />
	<input type="hidden" name="nttId"  value="" />
</form>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("subForm").attr({action:"${contextPath}/customer/insertPhoneCouncelArticle.do", target:""});
		
	});
	
	// 네비게시이션 이동
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		//$('#subForm').attr('action', '${contextPath}/customer/phoneQnAList.do'); 
		$("#subForm").attr({action:"${contextPath}/customer/rippleNewsList.do", target:""});
		$("#subForm").submit();
	}
	
	function goDetail(bbsId, nttId){
		$("#subForm input[name=bbsId]").val(bbsId);
		$("#subForm input[name=nttId]").val(nttId);
		$("#subForm").attr({action:"${contextPath}/customer/rippleNewsInqire.do", target:""});
		$("#subForm").submit();		
	}
</script>
