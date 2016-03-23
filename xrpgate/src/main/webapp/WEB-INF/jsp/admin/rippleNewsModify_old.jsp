<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style12.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0019.jpg" width="400" height="35" />
<!-- </div> -->
<!--타이틀끝-->
     	<div id="sub_container">
        	<div id="content-group">
            	<div id="contents" class="bg_cs">
            	<form:form commandName="result"  id="frm">    
            		<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
					<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input name="searchCnd" type="hidden" value="<c:out value='${searchVO.searchCnd}'/>"/>
					<input name="searchWrd" type="hidden" value="<c:out value='${searchVO.searchWrd}'/>"/>
<!--             		<div class="con_tit">리플뉴스 관리 <span>Ripple News Administration</span> -->
<!--                     	<span class="ex">더리플에서 전하는 공지사항 관리입니다.</span> -->
<!--                     </div> -->
	                
					<div class="bview_box mt15">
                    	<ul>
                            <li class="full"><strong><span>작성자</span></strong><c:out value="${result.frstRegisterNm}" /></li>
                            <li class="full"><strong>최초등록일 </span></strong><c:out value="${result.frstRegisterPnttm}" /></li>
                			<li class="full"><strong><span>편집자 </span></strong><c:out value="${result.lastUpdusrNm}" /></li>
                            <li class="full"><strong>최종수정일 </span></strong><c:out value="${result.lastUpdusrPnttm}" /></li>
                            <li class="full"><strong><span>게시물등록</span></strong><span><a href="javascript:goPost();"><img src="${contextPath}/img/btn_wregist.png" alt="등록"></a><a href="javascript:linkListPage()"><img src="${contextPath}/img/btn_wcancle.png" alt="취소"></a></span></li>
                        </ul>
                    </div>
                    
						<div class="mem_info_sect">
                        <div class="mem_box fl100">
                            <ul class="info_put fl100">
                                <li><strong>*제목 </strong><span class="con"><form:input path="nttSj"   class="w400" /></span> </li>
                                <li><strong>첨부파일</strong>
                                    <span class="con">
									<form:hidden path="atchFileId" />
									<input name="file1_text" type="text" class="w400">
									<img name="btnFileUpload" src="${contextPath}/img/btn_find.png" data_fileMax="5" data_category="news"  data_type="file"  alt="찾아보기"   >
                                   	<img name="btnFileDownload" src="${contextPath}/img/btn_down2.png"    data_type="file"   alt="다운로드"> 
                                    <span class="con_inf txt11 fl100 fcYg">* 10M 미만의 파일만 허용됩니다.</span>
                                    <br>
                                     <c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
									 </c:import>	 
                                    </span>
                                </li>
                                <li><strong>내용</strong>
                                        <span class="con">
                                    <form:textarea path="nttCn"  htmlEscape="false" ></form:textarea>
                                    <script>
                                    CKEDITOR.replace(
                                 	'nttCn',
                                 	{
                                 		contenteditable:"false",
                                 		filebrowserImageUploadUrl : '/files/ckEditor/insertImage.do',
                                 		width : '100%', //넓이값
                                 		height : '200'      //높이값
                                 	}
                                    );
                                    </script>  </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    </form:form>
                        
                    <div class="mbtn_wrap">
                    	<a href="javascript:goPost();"><img src="${contextPath}/img/btn_regist.png" alt="등록"></a><a href="javascript:linkListPage()"><img src="${contextPath}/img/btn_cancle.png" alt="취소"></a>
                    </div>
            	</div>
            	<!--//contents -->
        	</div>
        	<!--//content-group -->
		</div><!--//sub_container -->
 
  <script> 
   function linkListPage(){
	   $('#frm').attr('action', '${contextPath}/admin/rippleNewsList.do'); 
	   $("#frm").submit();
   }
   
   function goPost(){
	   $('#frm').attr('action', '${contextPath}/admin/insertRippleNewsArticle.do'); 
	   $("#frm").submit();  
	}
   
 	$(document).ready(function(){
		$('[name=btnFileUpload]').click(function(e) {
			
			var offset = $(this).offset();
			var currPlace = $('body').scrollTop();
			var thisType = $(this).attr('data_type');
			var category = $(this).attr('data_category');
			var fileMax = $(this).attr('data_fileMax');
			
			var $imgId = $(this).parent().find(':hidden');
			var $fileNmme = $(this).parent('').find('[name=file1_text]');
			var $imgDiv = $(this).closest('dl').find('dt');
			
			var params = fn_dataParamSetting(category, fileMax, thisType, $imgId.val());
			e.preventDefault();
					
			var options = {
				url : '<c:url value="/files/uploadPage.do" />',
				width : 650,
				height : 350,
				closeCallback : closeCallback,
				title : '[파일 올리기]',
				data : params,
				buttonType : 0
			};
			var $dialog = BIT.modalDialog(options);
			
			function closeCallback(returnValue) {
				if (returnValue != null && returnValue.length > 0) {
					var files = returnValue;
					var fileIds = '';
					var fileNames = '';
					//단일 이미지 처리시에만 적용 올려진 썸네일 이미지를 리턴받아 화면상에 이미지 영역에 뿌려줌
					var imgUrl = "";
					
					for (var i = 0; i < files.length; i++) {
						if (fileIds) {
							fileIds = files[i].atchFileId;
							fileNames += ',' + files[i].orignlFileNm;
						} else {
							fileIds = files[i].atchFileId;
							fileNames = files[i].orignlFileNm;
							imgUrl =   '<c:url value="/files/imageSrc.do?path=" />'+files[i].category  +'/thumnails&physical=' + files[i].streFileNm;    
	// 						imgUrl =  '<c:url value="/webAttach/thumnails/" />' + files[i].streFileNm;
						}
					}
					var options = {"background":"url("+imgUrl+")", 'background-repeat' : 'no-repeat', 'background-position':'center'};
					$imgId.val(fileIds);
					$fileNmme.val(fileNames);
					if(thisType == 'img'){
						$imgDiv.css(options);
					}
					
				} else {
					$imgId.val('');
					$fileNmme.val('');
					if(thisType == 'img'){
						$imgDiv.css('background', 'url(/img/noimg.png)');
					}
					
				}
			}
		});

		$('[name=btnFileDownload]').click(function(e) {
			e.preventDefault();
			var category = $(this).attr('data_category');
			var $imgId = $(this).parent().find(':hidden');
			COM.openFileListPopup(category, $imgId.val());
		});
	
		$('[name=btnImgDelete]').click(function(e){
			$(this).parent().find(':hidden').val('');
			$(this).parent('').find('[name=file1_text]').val('');
		});
		
		$('[name=btnFileDelete]').click(function(e){
			var $imgId = $(this).parent().find(':hidden');
			var $fileNmme = $(this).parent('').find('[name=file1_text]');
			var $imgDiv = $(this).closest('dl').find('dt');
			
			$imgId.val('');
			$fileNmme.val('')
			var basicImg = '<c:url value="/webAttach/thumnails/" />'
			$imgDiv.css
		});

	});

	function replaceModalwindow(offset, currPlace) {
		$('.ui-dialog').css('top', offset.top +'px');
		$( 'html, body' ).animate( { scrollTop : currPlace }, 0);
	}

	function fn_dataParamSetting(category, fileMax, type, filesIds){
		var fileExtn = '';
		
		if(type == "img"){
			fileExtn = 'jpg|jpeg|png|bmp|gif';
		} else {
			fileExtn = '';
		}
		
		var params = {
				Category : category,
				Accept : fileExtn,
				Max : Number(fileMax),
				Type : type,
				FileIds : filesIds
			}
		
		return params;
	}
	
   	function doSync(){
//		 goJsonSave();
 //  		goPost('01');
	}

// 	function goJsonSave(){      	
// 	var formData = $("form").serialize ();
// 	var params = $("form").serialize();
// 	BIT.callAjax('${contextPath}/myInfo/jsonUpdateGnrSubMyInfo.do'
// 			, 'post'
// 			, params
// 			, function(responseText){
// 				return false;
// 			});
// 	}

  </script>
    

