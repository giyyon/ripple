<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style12.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0028.jpg" width="400" height="35" id="titleImage"/>
<!-- </div> -->
<!--타이틀끝-->

<!--섹션시작-->
<div id="section"> 

	<!--본문시작-->
            <!-- 목록리스트 -->
            <div class="list_box">
            	<div class="list_head">
					<span class="Hnum">번호</span>
					<span class="Hnum">분류</span>
					<span class="Hsub">제목</span>
					<span class="Hdate">등록일</span>
					<span class="Hpicinf">회원명</span>
					<span class="Hhit">처리현황</span>					
	             </div>
		<form id="subForm" method="post"  action="${contextPath}/admin/noticeInqire.do" >
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="bbs_lst" name="bbs_lst">
				<span class="num"><c:out value="${result.nttId}"/></span>
				<span class="num"><c:out value="${result.bbsNm}"/></span>
				<span class="bbs_sub"><c:out value="${result.nttSj}"/></span>
				<span class="date"><c:out value="${result.frstRegisterPnttm}"/></span>
				<span class="picinf"><c:out value="${result.ntcrId}"/></span>
				<span class="num handPnt" onclick="layer_open('layer2',  ${status.index}); return false;"><c:out value="${result.qnaProcessSttusCode}"/></span>
				
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
				<input type="hidden" name="moblphonNo" value='<c:out value="${result.moblphonNo}" />'>
				<input type="hidden" name="answerCn" value='<c:out value="${result.answerCn}" />'>
				<input type="hidden" name="qnaProcessSttusCode" value='<c:out value="${result.qnaProcessSttusCode}" escapeXml="false" />'>
			</div>
		</c:forEach>

			<!--//팝업 레이어 -->
			<div class="pop-layer-cover">
				<div class="bg"></div>
				<div id="layer2" class="pop-layer">
					<div class="pop-container">
						<div class="pop-conts">
							<!--//content -->
							<p class="ctxt mb20"><strong><span>처리 결과 조회</span></strong><br>
							</p>
							<div class="layerContent">
								<form name = "popupForm" >
									<input type="hidden" name="bbsId">
									<input type="hidden"  name="nttId">
									<input type="hidden" name="isUpdated" value="N"/>
									
									<div class="bview_box">
										<ul>
											<li class="full"><strong><span>제목</span></strong><span id="targetSubjectText"></span></li>
				                            <li class="full"><strong><span>등록자(연락처)</span></strong><span id="targetErText"></span></li>
				                            <li class="full"><strong><span>등록일시</span></strong><span id="targetDateText"></span></li>
				                        </ul>
				                        <div class="cont">
				                        	<div id="targetCnText"></div>
				                        </div>	
				                    </div>
				                    
				                    <div class="bview_box">
										<ul>
											<li class="full"><strong><span>처리자</span></strong><span id="targetLastErText"></span></li>
				                            <li class="full"><strong><span>처리일시</span></strong><span id="targetLastDateText"></span></li>
											<div id ="statusYes">
												<li class="full"><strong><span>답변 내용</span></strong><span id="targetAnswerText" name="targetAnswerText"></span></li>
											</div>
											<c:choose>
												<c:when test="${empty isAdminRole}">
												</c:when>
												<c:otherwise>
												<div id ="statusNo">
													<li class="full"><strong><span>답변 내용</span></strong>
														<textarea style="height:100px;width:380px;"  id="answerCn"  name="answerCn"></textarea>
														<input type="button" id="popupBtn" class="btn-style"  value="처리 완료"></li>
												</div>
											</c:otherwise>
											</c:choose>
				                        </ul>
				                    </div>
								</form>
							</div>
							<div class="layerContent_result">
							</div>
							<div class="btn-r">
								<div  class="cbtn">Close</div>
							</div>
							<!--//content -->
						</div>
					</div>
				</div>
			</div>
			<!--//팝업 레이어 -->			
			<!--pageing -->                    
			 <div class="paginate_complex">
			<ui:pagination paginationInfo="${paginationInfo}" type="supportImage" jsFunction="linkPage" />
			</div>
			<!--//pageing -->
		</div>		
            <!-- //목록리스트 -->
	
	<!--본문 끝-->

	<!--우측메뉴 시작-->
	<%@ include file="../include/rightMenuForAdmin.jsp" %></div>

<script type="text/javaScript" language="javascript">
	$(function(){
		$("subForm").attr({action:"${contextPath}/admin/insertPhoneCouncelArticle.do", target:""});

		var $search = $(location).attr('search');
 		var isPhone = $search.indexOf("BBSMSTR_000000000001");
 		if(isPhone != -1){
 			$("#titleImage").attr("src", "/img/title0026.jpg" );
 		}else{
 			$("#titleImage").attr("src", "/img/title0028.jpg" );
 		}
	});
	
	// 네비게시이션 이동
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		$('#subForm').attr('action', '${contextPath}/admin/phoneQnAList.do'); 
		$("#subForm").submit();
	}
</script>

<script type="text/javascript">
	function layer_open(el, seq){

		$(".layerContent_result").hide();
		$(".layerContent").show();
		
		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

		if(bg){
			$('.pop-layer-cover').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		}else{
			temp.fadeIn();
		}

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		var boardBBSID =  $("div[name=bbs_lst]:eq("+seq+") input[name=bbsId]").val();;
		var boardNttId =  $("div[name=bbs_lst]:eq("+seq+") input[name=nttId]").val();;
		var boardDate =  $("div[name=bbs_lst]:eq("+seq+") input[name=frstRegisterPnttm]").val();;
		var boardLastDate =  $("div[name=bbs_lst]:eq("+seq+") input[name=lastUpdusrPnttm]").val();;
		var boardSubject =  $("div[name=bbs_lst]:eq("+seq+") input[name=nttSj]").val();;
		var boardNttCn = $("div[name=bbs_lst]:eq("+seq+") input[name=nttCn]").val();
		var boardMoblphonNo = $("div[name=bbs_lst]:eq("+seq+") input[name=moblphonNo]").val();
		var boardAnswerCn = $("div[name=bbs_lst]:eq("+seq+") input[name=answerCn]").val();
		var boardQnAStatus = $("div[name=bbs_lst]:eq("+seq+") input[name=qnaProcessSttusCode]").val();
		var boardEr = $("div[name=bbs_lst]:eq("+seq+") input[name=ntcrId]").val();
		var boardLastEr =  $("div[name=bbs_lst]:eq("+seq+") input[name=lastUpdusrId]").val();;
		
		$("#targetSubjectText").html(boardSubject);
		$("#targetErText").html(boardEr + ' ( '+boardMoblphonNo+' ) ');
		$("#targetDateText").html(boardDate);
		$("#targetCnText").html(boardNttCn);
		$("#targetLastErText").html(boardLastEr);
		$("#targetLastDateText").html(boardLastDate);
		$("#targetAnswerText").html(boardAnswerCn);

		if(boardQnAStatus == "접수"){
// 			if( boardBBSID == "BBSMSTR_000000000001"){
// 				$("#targetActionText").html("<br>본 전화상담 게시글에 상담 완료 처리 하시겠습니까?");	
// 			}else{
// 				$("#targetActionText").html("<br>본 Q&A 문의글에 답변 완료 처리 하시겠습니까?");
// 			}
			$("#statusYes").hide();              //조회 Area
			$("#statusNo").show();              //등록 Area
			$("#popupBtn").show();            //답변등록버튼
		}else{
			// 답변완료
			$("#statusYes").show();              //조회 Area
			$("#statusNo").hide();               //등록 Area
			$("#popupBtn").hide();             //답변등록버튼
		}
		
		$("form[name=popupForm] input[name=bbsId]").val(boardBBSID);
		$("form[name=popupForm] input[name=nttId]").val(boardNttId);
//////////////////////////////////////////////////////////////////////////////////////////////////
		temp.find('#popupBtn').bind('click', function() {
			doSubmit();  
		  });

			 
		var doSubmit = function(){
			temp.find('#popupBtn').unbind('click');
			var infoData = $("form[name=popupForm]").serialize();
	 		$.ajax({
			    url : "${contextPath}/admin/jsonInsertPhoneQnAArticle.do",
			    dataType : "json",
			    type : "post",  // post 또는 get
			    data :infoData,   // 호출할 url 에 있는 페이지로 넘길 파라메터
			    success : function(result){
			        $(".layerContent_result").html(result.Message);
			        $(".layerContent").hide();
			        $(".layerContent_result").show();
			        $("form[name=popupForm] input[name=isUpdated]").val('Y');
			    }
			});
			
		};	
			
		temp.find('div.cbtn').click(function(e){
			if(bg){
				$('.pop-layer-cover').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
			if($("form[name=popupForm] input[name=isUpdated]").val() =='Y'){
				location.reload();	
			};			
		});
		
		//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
		$('.pop-layer-cover .bg').click(function(e){	
			$('.pop-layer-cover').fadeOut();
			e.preventDefault();
		});
	}
</script>
