<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>

<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />

<form:form commandName="mberVo"  id="frm">
 <div class="chn_pop_box">
 	<div class="pop_title">회원정보 수정</div> 
    <div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="150px" class="pop_table_title">이름</td>
                <td width="300px"><input type="text" name="mberNm" value="${mberVo.mberNm }" style="width:200px"/></td>
                <td width="150px" class="pop_table_title">휴대폰번호</td>
                <td width="300px" class="phone_number">
                	<li><input type="text" id="mbtlnumHead" name="mbtlnumHead" value="${fn:substring(mberVo.moblphonNo,0,3)}" style="width:50px"/></li>
                    <li>-</li>
                    <li><input type="text" id="mbtlnumMiddle" name="mbtlnumMiddle"value="${fn:substring(mberVo.moblphonNo,3,7)}" style="width:60px"/></li>
                    <li>-</li>
                    <li><input type="text" id="mbtlnumMTail" name="mbtlnumMTail" value="${fn:substring(mberVo.moblphonNo,7,13)}" style="width:60px"/></li>
                </td>
            </tr>
            <tr>
            	<td width="150px" class="pop_table_title">회원등급</td>
                <td width="300px">
                	<form:select path="memberGrade" style="width:100px; ">
						<form:option value="Silver" label="Silver"/>
						<form:option value="Gold" label="Gold"/>
						<form:option value="VVIP"  label="VVIP"/>
					</form:select>
                </td>
                <td width="150px" class="pop_table_title">리플지갑계정</td>
                <td width="300px" >${mberVo.rippleTradeEmail }</td>
            </tr>
            <tr>
            	<td class="pop_table_title">국가</td>
                <td>
                	<form:select path="state" style="width:200px; ">
						<form:option value="ko"  label="대한민국"/>
						<!-- 
						<form:option value="Afghanistan" label="Afghanistan"/>
						<form:option value="Albania" label="Albania"/>
						<form:option value="Algeria" label="Algeria"/>
						 -->
					</form:select>
                </td>
                <td class="pop_table_title">생년월일</td>
                <td>
                	<form:input path="ihidnum" style="width:200px"/>
                </td>
            </tr>
             <tr>
            	<td class="pop_table_title">계좌번호</td>
                <td class="bank_no">
                	<li>
                		<form:select path="bankId" style="width:110px; ">
							<c:forEach var="result" items="${bank_result}" varStatus="status">
                        	<form:option value="${result.code}"  label='${result.codeNm}'/>
                        	</c:forEach>
						</form:select>
                    </li>
                    <li><input type="text" name="account" value="${mberVo.account }" style="width:170px"/></li>
                	
                </td>
                <td class="pop_table_title">아이디</td>
                <td>${mberVo.mberId }</td>
            </tr>
        </table>
    </div>
    <div class="pop_btn">
    	<li><a href="#" name="btnSave"><img src="${contextPath}/images/admin/admin_submit_btn.png" /></a></li>
        <li style="margin-left:20px;"><a href="#" name="btnCancle"><img src="${contextPath}/images/admin/admin_cancle_btn.png" /></a></li>
    </div>
 </div>
 <input type="hidden" name="mberId" value="${mberVo.mberId }">
  <input type="hidden" id="moblphonNo" name="moblphonNo" value="${mberVo.moblphonNo }">
</form:form>
 
 <div class="pop_cc">
	<div class="pop_cc_in">Copyrightⓒ2015 By XRPGATE. All right reserved.</div>
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		// 핸드폰 번호 
		$( "#mbtlnumHead, #mbtlnumMiddle,  #mbtlnumMTail" ) .change(function () {
			$("#moblphonNo").val(  $( "#mbtlnumHead" ).val() + $( "#mbtlnumMiddle" ).val() + $( "#mbtlnumMTail" ).val() );
			
		});
		
		$("[name=btnCancle]").click(function(e){
			window.close();window.close();
		});
		
		$("[name=btnSave]").click(function(e){
			e.preventDefault;
			
			var url = "${contextPath}/admin/updateGnrMberInfo.do?";
			var bankId = $("[name=bankId]").val();
			var moblphonNo = $("[name=moblphonNo]").val();
			var account = $("[name=account]").val();
			var ihidnum = $("[name=ihidnum]").val();
			var state = $("[name=state]").val();
			var memberGrade = $("[name=memberGrade]").val();
			var mberId = $("[name=mberId]").val();
			var mberNm = $("[name=mberNm]").val();
			var param = {
					mberId : mberId
					, bankId : bankId
					, moblphonNo : moblphonNo
					, account : account
					, ihidnum :ihidnum
					, memberGrade : memberGrade
					, state : state
					, mberNm : mberNm
			}
			
			sendPost(url, param, "fn_updateMberInfo");
		});
		
		
	});
	
	function fn_updateMberInfo(data){
		if(data.isSuccess){
			alert("수정되었습니다.");
			opener.location.reload();
			window.open('', '_self').close();
		} else {
			alert("수정되지 않았습니다.");
		}
	}
</script>
