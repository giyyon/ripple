<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%
    /* ============================================================================== */
    /* =   PAGE : ���� ��û PAGE                                                    = */
    /* = -------------------------------------------------------------------------- = */
    /* =   Copyright (c)  2012.02   KCP Inc.   All Rights Reserved.                 = */
    /* ============================================================================== */

    /* ============================================================================== */
    /* =   ȯ�� ���� ���� Include                                                   = */
    /* = -------------------------------------------------------------------------- = */
%>
<%@ page import="kr.co.kcp.CT_CLI"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%
    /* = -------------------------------------------------------------------------- = */
    /* =   ȯ�� ���� ���� Include END                                               = */
    /* ============================================================================== */

    /* ============================================================================== */
    /* =   Hash ������ ���� �ʿ� ������                                             = */
    /* = -------------------------------------------------------------------------- = */
    /* = ����Ʈ�ڵ� ( up_hash ������ �ʿ� )                                         = */
    /* = -------------------------------------------------------------------------- = */

    //  ��ݿ��ÿ��� �����Ʈ �ڵ� ����
    //String site_cd   = "V3704";
	// ���߽� ��� �ڵ�
	String site_cd   = "S6186";


    /* = -------------------------------------------------------------------------- = */
    /* = �ֹ���ȣ  ( up_hash ������ �ʿ� )                                           = */
    /* = -------------------------------------------------------------------------- = */

    String ordr_idxx = "TEST" + (new SimpleDateFormat("yyyyMMddHHmmssSSSSSSS").format(new Date())); // �ֹ���ȣ ���� ����

    /* = -------------------------------------------------------------------------- = */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
        
                            <!-- ��� ���̺� Start -->
                            <table width="551px" align="center" cellspacing="0" cellpadding="16">
                                <tr style="height:17px">
                                    <td style="background-image:url('/img/kcp/ttbg551.gif');border:0px " class="white">
                                        <span class="bold big">[������û]</span> �� �������� �޴��� ������û �������Դϴ�.
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-image:url('/img/kcp/boxbg551.gif') ;">
                                        <p class="align_left">�ҽ� ���� �� �������� ��Ȳ�� �°� ������ ���� �����Ͻñ� �ٶ��ϴ�.</p>
                                        <p class="align_left">������ �ʿ��� ������ ��Ȯ�ϰ� �Է��Ͻþ� ������ �����Ͻñ� �ٶ��ϴ�.</p>
                                    </td>
                                </tr>
                                <tr style="height:11px"><td style="background:url('/img/kcp/boxbtm551.gif') no-repeat;"></td></tr>
                            </table>
                            <!-- ��� ���̺� End -->
        
                            <!-- �ֹ� ���� ��� ���̺� Start -->
                            <table width="527" align="center" cellspacing="0" cellpadding="0" class="margin_top_20">
                                <tr><td colspan="2"  class="title">�� �� �� ��</td></tr>
                                <!-- �ֹ���ȣ(ordr_idxx) -->
                                <tr>
                                    <td class="sub_title1">�ֹ� ��ȣ</td>
                                    <td class="sub_input1">&nbsp&nbsp<input type="text" name="ordr_idxx" class="frminput" value="<%=ordr_idxx%>" size="40" readonly="readonly" maxlength="40"/></td>
                                </tr>
                                <!-- �����ڸ� -->
                                <tr>
                                    <td class="sub_title1">����</td>
                                    <td class="sub_content1"><input type="text" name="user_name" value="" size="20" maxlength="20" class="frminput" /></td>
                                </tr>
                                <!-- ������� -->
                                <tr>
                                    <td class="sub_title1">�������</td>
                                    <td class="sub_content1" id="year_month_day">
                                    </td>
                                </tr>
                                <!-- ��������
                                <tr>
                                    <td class="sub_title1">��������</td>
                                    <td class="sub_content1 bold">
                                        <input type="radio" name="sex_code" value="01" />����
                                        <input type="radio" name="sex_code" value="02" />����
                                         -->
                                        <!-- ��/�ܱ��α���
                                        <select name='local_code' class="frmselect">
                                            <option value='01'>������</option>
                                            <option value='02'>�ܱ���</option>
                                        </select>
                                    </td>
                                </tr>
         -->
                                <tr class="height_1px"><td colspan="2" bgcolor="#0f75ac"></td></tr>
                            </table>
                            <!-- �ֹ� ���� ��� ���̺� End -->
        
                            <!-- ���� ��ư ���̺� Start -->
                            <table width="527" align="center" cellspacing="0" cellpadding="0" class="margin_top_20">
                                <!-- ���� ��û/ó������ �̹��� ��ư -->
                                <tr id="show_pay_btn">
                                    <td colspan="2" align="center">
                                        <input type="image" src="/img/kcp/btn_certi.gif" onclick="return auth_type_check();" width="108" height="37" alt="������ ��û�մϴ�" />
                                    </td>
                                </tr>
                            </table>
                            <!-- ���� ��ư ���̺� End -->
                        </td>
                    </tr>
                    <tr><td></img src="/img/kcp/boxbtm589.gif" alt="Copyright(c) KCP Inc. All rights reserved."/></td></tr>
                </table>
        
                <!-- ��û���� -->
                <input name="sex_code" type="hidden" value="${certVO.sex_code }"/>
                <input name="local_code" type="hidden" value="${certVO.local_code }"/>
                <input name="year" type="hidden" value="${certVO.year }"/>
                <input name="month" type="hidden" value="${certVO.month }"/>
                <input name="day" type="hidden" value="${certVO.day }"/>
                <input type="hidden" name="req_tx"       value="cert"/>
                <!-- ��û���� -->
                <input type="hidden" name="cert_method"  value="01"/>
                <!-- ������Ʈ���̵� -->
                <input type="hidden" name="web_siteid"   value="J15070800859"/> 
                <!-- ���� ��Ż� default ó���� �Ʒ��� �ּ��� �����ϰ� ����Ͻʽÿ� 
                     SKT : SKT , KT : KTF , LGU+ : LGT
                <input type="hidden" name="fix_commid"      value="KTF"/>
                -->
                <!-- ����Ʈ�ڵ� -->
                <input type="hidden" name="site_cd"      value="<%= site_cd %>" />
                <!-- Ret_URL : ������� ���� ������ ( ������ URL �� ������ �ּž� �մϴ�. ) -->
				<input type="hidden" name="Ret_URL" value="http://219.254.215.233:8080/join/kcpCertProcRes.do" />      
                <!-- <input type="hidden" name="Ret_URL"      value="http://xrpgate.com/join/kcpCertProcRes.do" />  -->
                <!-- cert_otp_use �ʼ� ( �޴��� ����)
                     Y : �Ǹ� Ȯ�� + OTP ���� Ȯ�� , N : �Ǹ� Ȯ�� only
                -->
                <input type="hidden" name="cert_otp_use" value="Y"/>
                <!-- cert_enc_use �ʼ� (������ : �޴��� ����) -->
                <input type="hidden" name="cert_enc_use" value="Y"/>

                <input type="hidden" name="res_cd"       value=""/>
                <input type="hidden" name="res_msg"      value=""/>

                <!-- up_hash ���� �� ���� �ʵ� -->
                <input type="hidden" name="veri_up_hash" value=""/>

                <!-- ����Ȯ�� input ��Ȱ��ȭ -->
                <input type="hidden" name="cert_able_yn" value=""/>

                <!-- web_siteid ���� �� ���� �ʵ� -->
                <input type="hidden" name="web_siteid_hashYN" value=""/>

                <!-- ������ ��� �ʵ� (�����Ϸ�� ����)-->
                <input type="hidden" name="param_opt_1"  value="opt1"/> 
                <input type="hidden" name="param_opt_2"  value="opt2"/> 
                <input type="hidden" name="param_opt_3"  value="opt3"/> 
            </form>
        </div>
	 <script type="text/javascript">
		 $(document).ready(function(){ 
			 	
			 
		 });
            // ����â ������ ���������� ���� �Լ�
            function auth_data( frm )
            {
                var auth_form     = document.form_auth;
                var nField        = frm.elements.length;
                var response_data = "";
                var map = new Map();

                // up_hash ���� 
                if( frm.up_hash.value != auth_form.veri_up_hash.value )
                {
                    alert("up_hash ���� ��������");
                    // ���� ó�� ( dn_hash ���� ��������)
                }
                
               /* ���� �� ȸ������ �������� ����. */
//                 var form_value = "";

                for ( i = 0 ; i < frm.length ; i++ )
                {
//                     form_value += "["+frm.elements[i].name + "] = [" + frm.elements[i].value + "]\n";
//                     console.log(form_value);
                    map.put(frm.elements[i].name, frm.elements[i].value);
                }
                parent.fn_mappingAuthData(map);
                
            }
            
            // ����â ȣ�� �Լ�
            function auth_type_check()
            {
                var auth_form = document.form_auth;
    
                if( auth_form.ordr_idxx.value == "" )
                {
                    alert( "�ֹ���ȣ�� �ʼ� �Դϴ�." );
    
                    return false;
                }
                else
                {
                    if( ( navigator.userAgent.indexOf("Android") > - 1 || navigator.userAgent.indexOf("iPhone") > - 1 ) == false ) // ����Ʈ���� �ƴѰ��
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
                    
                    auth_form.target = "auth_popup"; // !!���� ������ ( ���Ϲ����� ���Ǵ� Ÿ�ٸ��Դϴ�.)
                    auth_form.action = "${contextPath}/join/kcpCertProcReq.do"; // ����â ȣ�� �� ����� ���� ������ �ּ�
                    auth_form.submit();
                    return true;
                }
            }
    
            /* ���� */
            window.onload=function()
            {
            	auth_type_check();
            	//setTimeout('auth_type_check()',100);
            	//��¥ ���� ����.
            	return;
                var today            = new Date();
                var year             = today.getFullYear();
                var month            = today.getMonth() + 1;
                var date             = today.getDate();
                var time             = today.getTime();
                var year_select_box  = "<option value=''>���� (��)</option>";
                var month_select_box = "<option value=''>���� (��)</option>";
                var day_select_box   = "<option value=''>���� (��)</option>";
                
                if(parseInt(month) < 10) {
                    month = "0" + month;
                }
    
                if(parseInt(date) < 10) {
                    date = "0" + date;
                }
    
                year_select_box = "<select name='year' class='frmselect' id='year_select'>";
                year_select_box += "<option value=''>���� (��)</option>";
       
                for(i=year;i>(year-100);i--)
                {
                    year_select_box += "<option value='" + i + "'>" + i + " ��</option>";
                }
                
                year_select_box  += "</select>";
                month_select_box  = "<select name=\"month\" class=\"frmselect\" id=\"month_select\">";
                month_select_box += "<option value=''>���� (��)</option>";
                
                for(i=1;i<13;i++)
                {
                    if(i < 10)
                    {
                        month_select_box += "<option value='0" + i + "'>" + i + " ��</option>";
                    }
                    else
                    {
                        month_select_box += "<option value='" + i + "'>" + i + " ��</option>";
                    }
                }
                
                month_select_box += "</select>";
                day_select_box    = "<select name=\"day\"   class=\"frmselect\" id=\"day_select\"  >";
                day_select_box   += "<option value=''>���� (��)</option>";
                for(i=1;i<32;i++)
                {
                    if(i < 10)
                    {
                        day_select_box += "<option value='0" + i + "'>" + i + " ��</option>";
                    }
                    else
                    {
                        day_select_box += "<option value='" + i + "'>" + i + " ��</option>";
                    }
                }
                
                day_select_box += "</select>";
                
                document.getElementById( "year_month_day"  ).innerHTML = year_select_box + month_select_box + day_select_box;
            }
            
           
        </script>
    </body>
</html>