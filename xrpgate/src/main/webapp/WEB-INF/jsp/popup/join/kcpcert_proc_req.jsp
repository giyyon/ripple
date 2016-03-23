<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Enumeration" %>
<%@ page import="kr.co.kcp.CT_CLI"%>
<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.lang.StringBuilder"%>



<%
    /* ============================================================================== */
    /* =   인증창 호출 및 수신 페이지                                               = */
    /* = -------------------------------------------------------------------------- = */
    /* =   해당 페이지는 반드시 가맹점 서버에 업로드 되어야 하며                    = */ 
    /* =   가급적 수정없이 사용하시기 바랍니다.                                     = */
    /* ============================================================================== */
%>
<%!
    /* ============================================================================== */
    /* =   null 값을 처리하는 메소드                                                = */
    /* = -------------------------------------------------------------------------- = */
    public String f_get_parm_str( String val )
    {
        if ( val == null ) val = "";
        return  val;
    }

    //!!중요 해당 함수는 year, month, day 변수가 null 일 경우 00 으로 치환합니다
    public String f_get_parm_int( String val )
    {
        String ret_val = "";
        
        if ( val == null      ) val = "00";
        if ( val.equals( "" ) ) val = "00";
      
        ret_val = val.length() == 1? ("0" + val) : val;
      
        return  ret_val;
    }
    /* ============================================================================== */
%>
<%
    request.setCharacterEncoding ( "euc-kr" ) ;

    String req_tx        = "";

    String site_cd       = "";
    String ordr_idxx     = "";

    String year          = "";
    String month         = "";
    String day           = "";
    String user_name     = "";
    String sex_code      = "";
    String local_code    = "";

    String web_siteid    = "";
    String web_siteid_hashYN = "";
    String cert_able_yn  = "";

    String up_hash       = "";
    // 한글 성명 인코딩용.
    StringBuilder sb = new StringBuilder();
	/*------------------------------------------------------------------------*/
    /*  :: 전체 파라미터 남기기                                               */
    /*------------------------------------------------------------------------*/
    StringBuffer sbParam = new StringBuffer();
    CT_CLI       cc      = new CT_CLI();
    
    // request 로 넘어온 값 처리
    Enumeration params = request.getParameterNames();
    while(params.hasMoreElements())
    {
         String nmParam = (String) params.nextElement();
         String valParam[] = request.getParameterValues(nmParam);

        for(int i = 0; i < valParam.length;i++)
        {
            if( nmParam.equals( "site_cd"   ) )
            {
                site_cd = f_get_parm_str( valParam[i] );
            }

            if( nmParam.equals( "req_tx"    ) )
            {
                req_tx = f_get_parm_str( valParam[i] );
            }

            if( nmParam.equals( "ordr_idxx" ) )
            {
                ordr_idxx = f_get_parm_str( valParam[i] );
            }

            if( nmParam.equals( "user_name" ) )
            {
            	ByteArrayOutputStream requestOutputStream = new ByteArrayOutputStream();
      		  	requestOutputStream.write(f_get_parm_str( valParam[i]).getBytes("EUC-KR"));
      			String userNm =   requestOutputStream.toString("EUC-KR");
                //user_name = f_get_parm_str( valParam[i] );
                
                 byte[] key_source = f_get_parm_str( valParam[i]).getBytes("EUC-KR");
		            for(byte b : key_source) {
		                String hex = String.format("%02x", b).toUpperCase();
		                sb.append("%");
		                sb.append(hex);
		            }
                //user_name = new String(userNm.getBytes("EUC-KR"),"EUC-KR");
                user_name = sb.toString();
                System.out.println(user_name);
            }

            if( nmParam.equals( "year"      ) )
            {
                year = f_get_parm_int( valParam[i] );
            }

            if( nmParam.equals( "month"     ) )
            {
                month = f_get_parm_int( valParam[i] );
            }

            if( nmParam.equals( "day"       ) )
            {
                day = f_get_parm_int( valParam[i] );
            }

            if( nmParam.equals( "sex_code"  ) )
            {
                sex_code = f_get_parm_str( valParam[i] );
            }

            if( nmParam.equals( "local_code" ) )
            {
                local_code = f_get_parm_str( valParam[i] );
            }

            if( nmParam.equals( "web_siteid_hashYN" ) )
            {
                web_siteid_hashYN = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "web_siteid" ) )
            {
                web_siteid = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "cert_able_yn" ) )
            {
                cert_able_yn = f_get_parm_str( valParam[i] );
            }

           // 인증창으로 넘기는 form 데이터 생성 필드
            sbParam.append( "<input type=\"hidden\" name=\"" + nmParam + "\" value=\"" + f_get_parm_str( valParam[i] ) + "\"/>" );
        }
    }

    if ( req_tx.equals( "cert" ) )
    {
        // !!up_hash 데이터 생성시 주의 사항
        // year , month , day 가 비어 있는 경우 "00" , "00" , "00" 으로 설정이 됩니다
        // 그외의 값은 없을 경우 ""(null) 로 세팅하시면 됩니다.
        // up_hash 데이터 생성시 site_cd 와 ordr_idxx 는 필수 값입니다.
        if( cert_able_yn.equals( "Y" ) )
        {
            up_hash = cc.makeHashData( site_cd   +
                                       ordr_idxx +
                                       ( web_siteid_hashYN.equals( "Y" )? web_siteid:"" ) +
                                       ""   +
                                       "00" +
                                       "00" +
                                       "00" +
                                       ""   +
                                       ""
                                      );
        }
        else
        {
            up_hash = cc.makeHashData( site_cd   +
                                       ordr_idxx +
                                       ( web_siteid_hashYN.equals( "Y" )? web_siteid:"" ) +
                                       user_name +
                                       year      +
                                       month     +
                                       day       +
                                       sex_code  +
                                       local_code 
                                      );
        }
        cc = null; // 객체 해제

        // 인증창으로 넘기는 form 데이터 생성 필드 ( up_hash )
        sbParam.append( "<input type=\"hidden\" name=\"up_hash\" value=\"" + up_hash + "\"/>" );
    }
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
        <title>*** KCP Online Payment System [Jsp Version] ***</title>
        <script type="text/javascript">
            window.onload=function()
            {
                var frm = document.form_auth;

                // 인증 요청 시 호출 함수
                if ( frm.req_tx.value == "cert" )
                {
                	window.opener.document.forms[0].veri_up_hash.value = frm.up_hash.value; // up_hash 데이터 검증을 위한 필드
                 	// 테스트 사이트
                	 //frm.action="https://testcert.kcp.co.kr/kcp_cert/cert_view.jsp";
                	// 운영 사이트
                	frm.action= "https://cert.kcp.co.kr/kcp_cert/cert_view.jsp";
                    
                    frm.submit();
                }

                // 인증 결과 데이터 리턴 페이지 호출 함수
                else if ( ( frm.req_tx.value == "auth" || frm.req_tx.value == "otp_auth" ) )
                {
                    //개발시
                	//frm.action= "http://219.254.215.233:8091/join/kcpCertProcRes.do";
                    //운영시
                    frm.action= "http://xrpgate.com/join/kcpCertProcRes.do";
                    frm.submit();
                }
                else
                {
                    //alert ("req_tx 값을 확인해 주세요");
                }
            }
        </script>
    </head>
    <body oncontextmenu="return false;" ondragstart="return false;" onselectstart="return false;">
        <form name="form_auth" method="post">
            <%= sbParam.toString() %>
        </form>
    </body>
</html>
