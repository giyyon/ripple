<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.util.Enumeration" %>
<%@ page import="kr.co.kcp.CT_CLI"%>
<%@ page import="java.net.URLDecoder"%>
<%
    /* ============================================================================== */
    /* =   인증데이터 수신 및 복호화 페이지                                         = */
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
    /* ============================================================================== */
%>
<%
    request.setCharacterEncoding ( "euc-kr" ) ;

    String site_cd       = "";
    String ordr_idxx     = "";
    
    String cert_no       = "";
    String cert_enc_use  = "";
    String enc_cert_data = "";
    String enc_info      = "";
    String enc_data      = "";
    String req_tx        = "";
    
    String tran_cd       = "";
    String res_cd        = "";
    String res_msg       = "";

    String dn_hash       = "";
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
        	System.out.println(" nmParam === " + nmParam +" valParam[i] ==== " + valParam[i]);
            if( nmParam.equals( "site_cd"      ) )
            {
                site_cd = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "ordr_idxx"    ) )
            {
                ordr_idxx = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "res_cd"       ) )
            {
                res_cd = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "cert_enc_use" ) )
            {
                cert_enc_use = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "req_tx"       ) )
            {
                req_tx = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "cert_no"      ) )
            {
                cert_no = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "enc_cert_data" ) )
            {
                enc_cert_data = f_get_parm_str( valParam[i] );
            }
            
            if( nmParam.equals( "dn_hash"       ) )
            {
                dn_hash = f_get_parm_str( valParam[i] );
            }
            // 결과 메시지가 한글 데이터 URL decoding 해줘야합니다.
            // 부모창으로 넘기는 form 데이터 생성 필드
            if( nmParam.equals( "res_msg"       ) )
            {
                sbParam.append( "<input type=\"hidden\" name=\"" + nmParam + "\" value=\"" + URLDecoder.decode( valParam[i], "UTF-8" ) + "\"/>" );
            }
            else
            {
                sbParam.append( "<input type=\"hidden\" name=\"" + nmParam + "\" value=\"" + f_get_parm_str( valParam[i] ) + "\"/>" );
            }

        }
    }
    
    // 결과 처리
    if( cert_enc_use.equals( "Y" ) )
    {
        if( res_cd.equals( "0000" ) )
        {
            // dn_hash 검증
            // KCP 가 리턴해 드리는 dn_hash 와 사이트 코드, 주문번호 , 인증번호를 검증하여
            // 해당 데이터의 위변조를 방지합니다
            if ( !cc.checkValidHash( dn_hash, ( site_cd + ordr_idxx + cert_no ) ) )
            {
                // 검증 실패시 처리 영역

                System.out.println("dn_hash 변조 위험있음");
                //cc = null; // 객체 반납 ( 루틴 탈출시에만 호출 )
            }

            // 가맹점 DB 처리 페이지 영역

            System.out.println(site_cd);
            System.out.println(cert_no);
            System.out.println(enc_cert_data);
            
            // 인증데이터 복호화 함수
            // 해당 함수는 암호화된 enc_cert_data 를
            // site_cd 와 cert_no 를 가지고 복화화 하는 함수 입니다.
            // 정상적으로 복호화 된경우에만 인증데이터를 가져올수 있습니다.
            cc.decryptEncCert( site_cd, cert_no, enc_cert_data );
            //cc.setCharSetUtf8(); // 복호와 결과값 인코딩 변경 메서드 ( UTF-8 인코딩 사용시 주석을 해제하시기 바랍니다.)
            sbParam.append( "<input type=\"hidden\" name=\"comm_id\" value=\"" + cc.getKeyValue("comm_id"     ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"phone_no\" value=\"" + cc.getKeyValue("phone_no"    ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"user_name\" value=\"" +cc.getKeyValue("user_name"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"birth_day\" value=\"" +cc.getKeyValue("birth_day"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"sex_code\" value=\"" +cc.getKeyValue("sex_code"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"local_code\" value=\"" +cc.getKeyValue("local_code"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"ci\" value=\"" +cc.getKeyValue("ci"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"di\" value=\"" +cc.getKeyValue("di"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"ci_url\" value=\"" +cc.getKeyValue("ci_url"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"di_url\" value=\"" +cc.getKeyValue("di_url"   ) + "\"/>" );
            sbParam.append( "<input type=\"hidden\" name=\"web_siteid\" value=\"" +cc.getKeyValue("web_siteid"   ) + "\"/>" );
            System.out.println( "이동통신사 코드"    + cc.getKeyValue("comm_id"     ) ); // 이동통신사 코드   
            System.out.println( "전화번호"           + cc.getKeyValue("phone_no"    ) ); // 전화번호          
            System.out.println( "이름"               + cc.getKeyValue("user_name"   ) ); // 이름              
            System.out.println( "생년월일"           + cc.getKeyValue("birth_day"   ) ); // 생년월일          
            System.out.println( "성별코드"           + cc.getKeyValue("sex_code"    ) ); // 성별코드          
            System.out.println( "내/외국인 정보 "    + cc.getKeyValue("local_code"  ) ); // 내/외국인 정보    
            System.out.println( "CI"                 + cc.getKeyValue("ci"          ) ); // CI                
            System.out.println( "DI 중복가입 확인값" + cc.getKeyValue("di"          ) ); // DI 중복가입 확인값
            System.out.println( "CI_URL"             + URLDecoder.decode( cc.getKeyValue("ci_url"      ) ) ); // CI URL 인코딩 값
            System.out.println( "DI_URL"             + URLDecoder.decode( cc.getKeyValue("di_url"      ) ) ); // DI URL 인코딩 값
            System.out.println( "웹사이트 아이디  "  + cc.getKeyValue("web_siteid"  ) ); // 암호화된 웹사이트 아이디
            System.out.println( "암호화된 결과코드"  + cc.getKeyValue("res_cd"      ) ); // 암호화된 결과코드
            System.out.println( "암호화된 결과메시지"+ cc.getKeyValue("res_msg"     ) ); // 암호화된 결과메시지
        }
        else/*if( res_cd.equals( "0000" ) != true )*/
        {
           // 인증실패
        }
    }
    else/*if( cert_enc_use.equals( "Y" ) != true )*/
    {
        // 암호화 인증 안함
    }

    cc = null; // 객체 반납
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
        <title>*** KCP Online Payment System [Jsp Version] ***</title>
        <script type="text/javascript" src="${contextPath}/js/jquery-1.9.1.min.js"></script>
        <script type="text/javascript">
            window.onload=function()
            {
                try
                {
                    var auth_form = document.forms[0];
					
					opener.auth_data( auth_form ); // 부모창으로 값 전달
                    setTimeout('fn_close()',100);
                   
                }
                catch(e)
                {
                    alert(e); // 정상적인 부모창의 iframe 를 못찾은 경우임
                }
            }
            
            function fn_close(){
            	 window.close();// 팝업 닫기
            	
            }
        </script>
    </head>
    <body oncontextmenu="return false;" ondragstart="return false;" onselectstart="return false;">
        <form name="form_auth" method="post">
            <%= sbParam.toString() %>
        </form>
    </body>
</html>
