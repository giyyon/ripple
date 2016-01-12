<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
  <li>
    <img src="../images/sub/faq_title.png" /><!--게시판 메뉴에 따라 제목이 바뀌면 됩니다.-->
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
                                <li class="view_text">테스트입니당</li>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            	<div class="hit_box">
                                    <li class="view_title">조회</li>
                                    <li class="view_bar"> | </li>
                                    <li class="view_text">100</li>
                                </div>
                                <div class="who_box">
                                    <li class="view_title">작성자</li>
                                    <li class="view_bar"> | </li>
                                    <li class="view_text">관리자</li>
                                </div>
                                <div class="date_box">
                                    <li class="view_title">작성일</li>
                                    <li class="view_bar"> | </li>
                                    <li class="view_text">2015-11-06</li>
                                </div>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                        	<td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="view_btn"><!--페이지에 맞춰서 해당 목록으로 돌아가면 됩니다-->
            	<li><a href="../html/faq.html">목록으로</a></li>            	
            </div>
        </div>
    </div>    
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("subForm").attr({action:"${contextPath}/customer/insertPhoneCouncelArticle.do", target:""});
		
	});
	
	// 네비게시이션 이동
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		$('#subForm').attr('action', '${contextPath}/customer/phoneQnAList.do'); 
		$("#subForm").submit();
	}
</script>


