<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style12.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0019.jpg" width="400" height="35" />
<!-- </div> -->
<!--타이틀끝-->

<!--섹션시작-->
<div id="section"> 

         <!-- 목록리스트 -->
		<div class="list_box">
			<div class="list_head">
			<span class="Hnum">번호</span>
			<span class="Hnum">분류</span>
			<span class="Hsub2">제목</span>
			<span class="Hdate">등록일</span>
			<span class="Hhit">조회수</span>					
			</div>
		<form id="subForm" method="post" >
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input type="hidden" name="bbsId" value="" />
			<input type="hidden" name="nttId"  value="" />
		</form>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="bbs_lst handPnt" name="bbs_lst"  onclick="goDetail('${result.bbsId}', '${result.nttId}');">
				<span class="num"><c:out value="${result.nttNo}"/></span>
				<span class="num"><c:out value="${result.bbsNm}"/></span>
				<span class="bbs_sub2"><c:out value="${result.nttSj}"/></span>
				<span class="date"><c:out value="${result.frstRegisterPnttm}"/></span>
				<span class="num" ><c:out value="${result.inqireCo}"/></span>
				
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
				<input type="hidden" name="searchWrd"value="<c:out value='${searchVO.searchWrd}'/>"/>
				<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
				<input type="hidden" name="bbsNm" value="<c:out value='${result.bbsNm}'/>" />
				<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
				<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" />
				<input type="hidden" name="frstRegisterPnttm" value="<c:out value='${result.frstRegisterPnttm}'/>" />
				<input type="hidden" name="lastUpdusrId" value="<c:out value='${result.lastUpdusrId}'/>" />
				<input type="hidden" name="lastUpdusrPnttm" value="<c:out value='${result.lastUpdusrPnttm}'/>" />
				<input type="hidden" name="ntcrId" value='<c:out value="${result.ntcrId}" />'>
				<input type="hidden" name="nttCn" value='<c:out value="${result.nttCn}" escapeXml="false" />'>
		</div>
		</c:forEach>

			<!--pageing -->                    
			 <div class="paginate_complex">
			<ui:pagination paginationInfo="${paginationInfo}" type="supportImage" jsFunction="linkPage" />
			</div>
			<!--//pageing -->
            <!-- //목록리스트 -->
	
	<!--본문 끝-->
	</div>
	<!--우측메뉴 시작-->
	<%@ include file="../include/rightMenu.jsp" %></div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("subForm").attr({action:"${contextPath}/customer/rippleNewsList.do", target:""});
		
	});
	
	// 네비게시이션 이동
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		$('#subForm').attr('action', '${contextPath}/customer/rippleNewsList.do'); 
		$("#subForm").submit();
	}
	
	function goDetail(bbsId, nttId){
		$("#subForm input[name=bbsId]").val(bbsId);
		$("#subForm input[name=nttId]").val(nttId);
		$("#subForm").attr({action:"${contextPath}/customer/rippleNewsInqire.do", target:""});
		$("#subForm").submit();		
	}
</script>

