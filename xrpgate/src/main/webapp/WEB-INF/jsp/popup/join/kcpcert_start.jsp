<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* ============================================================================== */
    /* =   PAGE : 인증 요청 PAGE                                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2012.02   KCP Inc.   All Rights Reserved.                 = */
    /* ============================================================================== */

    /* ============================================================================== */
    /* =   환경 설정 파일 Include                                                   = */
    /* = -------------------------------------------------------------------------- = */
%>
<%@ page import="kr.co.kcp.CT_CLI"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   환경 설정 파일 Include END                                               = */
    /* ============================================================================== */

    /* ============================================================================== */
    /* =   Hash 데이터 생성 필요 데이터                                             = */
    /* = -------------------------------------------------------------------------- = */
    /* = 사이트코드 ( up_hash 생성시 필요 )                                         = */
    /* = -------------------------------------------------------------------------- = */

    //  운영반영시에만 운영사이트 코드 적용
    String site_cd   = "V3704";
	// 개발시 사용 코드
	//String site_cd   = "S6186";


    /* = -------------------------------------------------------------------------- = */
    /* = 주문번호  ( up_hash 생성시 필요 )                                           = */
    /* = -------------------------------------------------------------------------- = */

    String ordr_idxx = "TEST" + (new SimpleDateFormat("yyyyMMddHHmmssSSSSSSS").format(new Date())); // 주문번호 생성 예제

    /* = -------------------------------------------------------------------------- = */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>*** KCP Online Payment System [JSP Version] ***</title>
        <link href="/css/kcp/sample.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${contextPath}/js/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" src="${contextPath}/js/scripts/Common.js"></script>
       
    </head>
    <body oncontextmenu="return false;" ondragstart="return false;" onselectstart="return false;">
        <div align="center">
            <form name="form_auth">
                <table width="589" cellpadding="0" cellspacing="0">
                    <tr style="height:14px"><td style="background-image:url('/img/kcp/boxtop589.gif');"></td></tr>
                    <tr>
                        <td style="background-image:url('/img/kcp/boxbg589.gif')">
        
                            <!-- 상단 테이블 Start -->
                            <table width="551px" align="center" cellspacing="0" cellpadding="16">
                                <tr style="height:17px">
                                    <td style="background-image:url('/img/kcp/ttbg551.gif');border:0px " class="white">
                                        <span class="bold big">[인증요청]</span> 이 페이지는 휴대폰 인증요청 페이지입니다.
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-image:url('/img/kcp/boxbg551.gif') ;">
                                        <p class="align_left">소스 수정 시 가맹점의 상황에 맞게 적절히 수정 적용하시길 바랍니다.</p>
                                        <p class="align_left">결제에 필요한 정보를 정확하게 입력하시어 인증를 진행하시기 바랍니다.</p>
                                    </td>
                                </tr>
                                <tr style="height:11px"><td style="background:url('/img/kcp/boxbtm551.gif') no-repeat;"></td></tr>
                            </table>
                            <!-- 상단 테이블 End -->
        
                            <!-- 주문 정보 출력 테이블 Start -->
                            <table width="527" align="center" cellspacing="0" cellpadding="0" class="margin_top_20">
                                <tr><td colspan="2"  class="title">인 증 정 보</td></tr>
                                <!-- 주문번호(ordr_idxx) -->
                                <tr>
                                    <td class="sub_title1">주문 번호</td>
                                    <td class="sub_input1">&nbsp&nbsp<input type="text" name="ordr_idxx" class="frminput" value="<%=ordr_idxx%>" size="40" readonly="readonly" maxlength="40"/></td>
                                </tr>
                                <!-- 명의자명 -->
                                <tr>
                                    <td class="sub_title1">성명</td>
                                    <td class="sub_content1"><input type="text" name="user_name" value="${certVO.user_name }" size="20" maxlength="20" class="frminput" /></td>
                                </tr>
                                <!-- 생년월일 -->
                                <tr>
                                    <td class="sub_title1">생년월일</td>
                                    <td class="sub_content1" id="year_month_day">
                                    </td>
                                </tr>
                                <!-- 성별구분
                                <tr>
                                    <td class="sub_title1">성별구분</td>
                                    <td class="sub_content1 bold">
                                        <input type="radio" name="sex_code" value="01" />남성
                                        <input type="radio" name="sex_code" value="02" />여성
                                         -->
                                        <!-- 내/외국인구분
                                        <select name='local_code' class="frmselect">
                                            <option value='01'>내국인</option>
                                            <option value='02'>외국인</option>
                                        </select>
                                    </td>
                                </tr>
         -->
                                <tr class="height_1px"><td colspan="2" bgcolor="#0f75ac"></td></tr>
                            </table>
                            <!-- 주문 정보 출력 테이블 End -->
        
                            <!-- 결제 버튼 테이블 Start -->
                            <table width="527" align="center" cellspacing="0" cellpadding="0" class="margin_top_20">
                                <!-- 결제 요청/처음으로 이미지 버튼 -->
                                <tr id="show_pay_btn">
                                    <td colspan="2" align="center">
                                        <input type="image" src="/img/kcp/btn_certi.gif" onclick="return auth_type_check();" width="108" height="37" alt="결제를 요청합니다" />
                                    </td>
                                </tr>
                            </table>
                            <!-- 결제 버튼 테이블 End -->
                        </td>
                    </tr>
                    <tr><td></img src="/img/kcp/boxbtm589.gif" alt="Copyright(c) KCP Inc. All rights reserved."/></td></tr>
                </table>
        
                <!-- 요청종류 -->
                <input name="sex_code" type="hidden" value="${certVO.sex_code }"/>
                <input name="local_code" type="hidden" value="${certVO.local_code }"/>
                <input name="year" type="hidden" value="${certVO.year }"/>
                <input name="month" type="hidden" value="${certVO.month }"/>
                <input name="day" type="hidden" value="${certVO.day }"/>
                <input type="hidden" name="req_tx"       value="cert"/>
                <!-- 요청구분 -->
                <input type="hidden" name="cert_method"  value="01"/>
                <!-- 웹사이트아이디 -->
                <input type="hidden" name="web_siteid"   value="J15070800859"/> 
                <!-- 노출 통신사 default 처리시 아래의 주석을 해제하고 사용하십시요 
                     SKT : SKT , KT : KTF , LGU+ : LGT
                <input type="hidden" name="fix_commid"      value="KTF"/>
                -->
                <!-- 사이트코드 -->
                <input type="hidden" name="site_cd"      value="<%= site_cd %>" />
                <!-- Ret_URL : 인증결과 리턴 페이지 ( 가맹점 URL 로 설정해 주셔야 합니다. ) -->
				<!--<input type="hidden" name="Ret_URL" value="http://219.254.215.233:8081/join/kcpCertProcRes.do" />    --> 
                 <input type="hidden" name="Ret_URL"      value="http://xrpgate.com/join/kcpCertProcRes.do" />   
                <!-- cert_otp_use 필수 ( 메뉴얼 참고)
                     Y : 실명 확인 + OTP 점유 확인 , N : 실명 확인 only
                -->
                <input type="hidden" name="cert_otp_use" value="Y"/>
                <!-- cert_enc_use 필수 (고정값 : 메뉴얼 참고) -->
                <input type="hidden" name="cert_enc_use" value="Y"/>

                <input type="hidden" name="res_cd"       value=""/>
                <input type="hidden" name="res_msg"      value=""/>

                <!-- up_hash 검증 을 위한 필드 -->
                <input type="hidden" name="veri_up_hash" value=""/>

                <!-- 본인확인 input 비활성화 -->
                <input type="hidden" name="cert_able_yn" value=""/>

                <!-- web_siteid 검증 을 위한 필드 -->
                <input type="hidden" name="web_siteid_hashYN" value=""/>

                <!-- 가맹점 사용 필드 (인증완료시 리턴)-->
                <input type="hidden" name="param_opt_1"  value="opt1"/> 
                <input type="hidden" name="param_opt_2"  value="opt2"/> 
                <input type="hidden" name="param_opt_3"  value="opt3"/> 
            </form>
        </div>
	 <script type="text/javascript">
		 $(document).ready(function(){
			 
			 	
		 });
            // 결제창 종료후 인증데이터 리턴 함수
            function auth_data( frm )
            {
                var auth_form     = document.form_auth;
                var nField        = frm.elements.length;
                var response_data = "";
                var map = new Map();

                // up_hash 검증 
                if( frm.up_hash.value != auth_form.veri_up_hash.value )
                {
                    alert("up_hash 변조 위험있음");
                    // 오류 처리 ( dn_hash 변조 위험있음)
                }
                
               /* 리턴 값 회원가입 페이지로 전달. */
//                 var form_value = "";

                for ( i = 0 ; i < frm.length ; i++ )
                {
//                     form_value += "["+frm.elements[i].name + "] = [" + frm.elements[i].value + "]\n";
//                     console.log(form_value);
                    map.put(frm.elements[i].name, frm.elements[i].value);
                }
                top.fn_mappingAuthData(map);
                
            }
            
            // 인증창 호출 함수
            function auth_type_check()
            {
                var auth_form = document.form_auth;
    
                if( auth_form.ordr_idxx.value == "" )
                {
                    alert( "주문번호는 필수 입니다." );
    
                    return false;
                }
                else
                {
                    if( ( navigator.userAgent.indexOf("Android") > - 1 || navigator.userAgent.indexOf("iPhone") > - 1 ) == false ) // 스마트폰이 아닌경우
                    {
	                    var return_gubun;
	                    var width  = 410;
	                    var height = 500;
	
	                    var leftpos = screen.width  / 2 - ( width  / 2 );
	                    var toppos  = screen.height / 2 - ( height / 2 );
	
	                    var winopts  = "width=" + width   + ", height=" + height + ", toolbar=no,status=no,statusbar=no,menubar=no,scrollbars=no,resizable=no";
	                    var position = ",left=" + leftpos + ", top="    + toppos;
	                    var AUTH_POP = window.open('','auth_popup', winopts + position);
                    }
                    console.log($("[name=user_name]").val());
                    auth_form.target = "auth_popup"; // !!주의 고정값 ( 리턴받을때 사용되는 타겟명입니다.)
                    auth_form.action = "${contextPath}/join/kcpCertProcReq.do"; // 인증창 호출 및 결과값 리턴 페이지 주소
                    auth_form.submit();
                    return true;
                }
            }
    
            /* 예제 */
            window.onload=function()
            {

            	auth_type_check();
            	//setTimeout('auth_type_check()',100);
            	//날짜 선택 못함.
            	return;
                var today            = new Date();
                var year             = today.getFullYear();
                var month            = today.getMonth() + 1;
                var date             = today.getDate();
                var time             = today.getTime();
                var year_select_box  = "<option value=''>선택 (년)</option>";
                var month_select_box = "<option value=''>선택 (월)</option>";
                var day_select_box   = "<option value=''>선택 (일)</option>";
                
                if(parseInt(month) < 10) {
                    month = "0" + month;
                }
    
                if(parseInt(date) < 10) {
                    date = "0" + date;
                }
    
                year_select_box = "<select name='year' class='frmselect' id='year_select'>";
                year_select_box += "<option value=''>선택 (년)</option>";
       
                for(i=year;i>(year-100);i--)
                {
                    year_select_box += "<option value='" + i + "'>" + i + " 년</option>";
                }
                
                year_select_box  += "</select>";
                month_select_box  = "<select name=\"month\" class=\"frmselect\" id=\"month_select\">";
                month_select_box += "<option value=''>선택 (월)</option>";
                
                for(i=1;i<13;i++)
                {
                    if(i < 10)
                    {
                        month_select_box += "<option value='0" + i + "'>" + i + " 월</option>";
                    }
                    else
                    {
                        month_select_box += "<option value='" + i + "'>" + i + " 월</option>";
                    }
                }
                
                month_select_box += "</select>";
                day_select_box    = "<select name=\"day\"   class=\"frmselect\" id=\"day_select\"  >";
                day_select_box   += "<option value=''>선택 (일)</option>";
                for(i=1;i<32;i++)
                {
                    if(i < 10)
                    {
                        day_select_box += "<option value='0" + i + "'>" + i + " 일</option>";
                    }
                    else
                    {
                        day_select_box += "<option value='" + i + "'>" + i + " 일</option>";
                    }
                }
                
                day_select_box += "</select>";
                
                document.getElementById( "year_month_day"  ).innerHTML = year_select_box + month_select_box + day_select_box;
            }
            
           
        </script>
    </body>
</html>