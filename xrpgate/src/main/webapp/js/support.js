	   var nowZoom = 100;
		function zoomIn() {
			nowZoom = nowZoom - 5;
			if(nowZoom <= 70) nowZoom = 70;
			zooms();
		}


		function zoomOut() {
				nowZoom = nowZoom + 5;
				if(nowZoom >= 500) nowZoom = 500;
				zooms();
		}
		
		function zoomReset(){
			nowZoom = 100; 
			zooms();
		}
		
		function zooms(){
			document.body.style.zoom = nowZoom + '%';
		
			if(nowZoom==70){
				alert ("30%축소 되었습니다. 더 이상 축소할 수 없습니다.");
			}
			
			if(nowZoom==500){
				alert ("500%확대 되었습니다. 더 이상 확대할 수 없습니다.");
			}
		}
		
//		$(document).ready(function(){
//			//----------------------------------------------------------------------------------------------------------------------------------------
//			//첨부파일 등록하는 전용 스크립트
//			$('[name=btnFileUpload]').click(function(e) {
//	    		
//	    		var offset = $(this).offset();
//	    		var currPlace = $('body').scrollTop();
//	    		var thisType = $(this).attr('data_type');
//	    		var category = $(this).attr('data_category');
//	    		var fileMax = $(this).attr('data_fileMax');
//	    		
//	    		var $imgId = $(this).parent().find(':hidden');
//	    		var $fileNmme = $(this).parent('').find('[name=file1_text]');
//	    		var $imgDiv = $(this).closest('dl').find('dt');
//	    		
//	    		var params = fn_dataParamSetting(category, fileMax, thisType, $imgId.val());
//	    		e.preventDefault();
//	    				
//	    		var options = {
//	    			url : '<c:url value="/files/uploadPage.do" />',
//	    			width : 550,
//	    			height : 400,
//	    			closeCallback : closeCallback,
//	    			title : '[File upload center]',
//	    			data : params,
//	    			buttonType : 0
//	    		};
//	    		var $dialog = BIT.modalDialog(options);
//	    		
//	    		function closeCallback(returnValue) {
//	    			if (returnValue != null && returnValue.length > 0) {
//	    				debugger;
//	    				var files = returnValue;
//	    				var fileIds = '';
//	    				var fileNames = '';
//	    				//단일 이미지 처리시에만 적용 올려진 썸네일 이미지를 리턴받아 화면상에 이미지 영역에 뿌려줌
//	    				var imgUrl = "";
//	    				
//	    				for (var i = 0; i < files.length; i++) {
//	    					if (fileIds) {
//	    						fileIds = files[i].atchFileId;
//	    						fileNames += ',' + files[i].orignlFileNm;
//	    					} else {
//	    						fileIds = files[i].atchFileId;
//	    						fileNames = files[i].orignlFileNm;
//	    						imgUrl =   '<c:url value="/files/imageSrc.do?path=" />'+files[i].category  +'/thumnails&physical=' + files[i].streFileNm;    
////		    						imgUrl =  '<c:url value="/webAttach/thumnails/" />' + files[i].streFileNm;
//	    					}
//	    				}
//	    				var options = {"background":"url("+imgUrl+")", 'background-repeat' : 'no-repeat', 'background-position':'center left'};
//	    				$imgId.val(fileIds);
//	    				$fileNmme.val(fileNames);
//	    				if(thisType == 'img'){
//	    					$imgDiv.css(options);
//	    				}
//	    				
//	    			} else {
//	    				$imgId.val('');
//	    				$fileNmme.val('');
//	    				if(thisType == 'img'){
//	    					$imgDiv.css('background', 'url(/img/noimg.png)');
//	    				}
//	    				
//	    			}
//	    		}
//	    	});
//
//	    	$('[name=btnFileDownload]').click(function(e) {
//	    		e.preventDefault();
//	    		var category = $(this).attr('data_category');
//	    		var $imgId = $(this).parent().find(':hidden');
//	    		COM.openFileListPopup(category, $imgId.val());
//	    	});
//
//			$('[name=btnImgDelete]').click(function(e){
//				$(this).parent().find(':hidden').val('');
//	    		$(this).parent('').find('[name=file1_text]').val('');
//			});
//			
//			$('[name=btnFileDelete]').click(function(e){
//				var $imgId = $(this).parent().find(':hidden');
//	    		var $fileNmme = $(this).parent('').find('[name=file1_text]');
//	    		var $imgDiv = $(this).closest('dl').find('dt');
//				
//	    		$imgId.val('');
//	    		$fileNmme.val('');
//	    		var basicImg = '<c:url value="/webAttach/thumnails/" />';
//	    		$imgDiv.css;
//			});
//					
//			
//		});
//		
//		function fn_dataParamSetting(category, fileMax, type, filesIds){
//	   		var fileExtn = '';
//	   		
//	   		if(type == "img"){
//	   			fileExtn = 'jpg|jpeg|png|bmp|gif';
//	   		} else {
//	   			fileExtn = '';
//	   		}
//	   		
//	   		var params = {
//	   				Category : category,
//						Accept : fileExtn,
//	   				Max : Number(fileMax),
//	   				Type : type,
//	   				FileIds : filesIds
//	   			}
//	   		
//	   		return params;
//	   	}
//
//	    function replaceModalwindow(offset, currPlace) {
//	    	$('.ui-dialog').css('top', offset.top +'px');
//	    	$( 'html, body' ).animate( { scrollTop : currPlace }, 0);
//	    }
		