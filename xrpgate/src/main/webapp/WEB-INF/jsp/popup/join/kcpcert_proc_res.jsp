<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.util.Enumeration" %>
<%@ page import="kr.co.kcp.CT_CLI"%>
<%@ page import="java.net.URLDecoder"%>
<%
    /* ============================================================================== */
    /* =   ���������� ���� �� ��ȣȭ ������                                         = */
    /* = -------------------------------------------------------------------------- = */
    /* =   �ش� �������� �ݵ�� ������ ������ ���ε� �Ǿ�� �ϸ�                    = */ 
    /* =   ������ �������� ����Ͻñ� �ٶ��ϴ�.                                     = */
    /* ============================================================================== */
%>
<%!
    /* ============================================================================== */
    /* =   null ���� ó���ϴ� �޼ҵ�                                                = */
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
    /*  :: ��ü �Ķ���� �����                                               */
    /*------------------------------------------------------------------------*/
    StringBuffer sbParam = new StringBuffer();
    CT_CLI       cc      = new CT_CLI();
    
    // request �� �Ѿ�� �� ó��
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
            // ��� �޽����� �ѱ� ������ URL decoding ������մϴ�.
            // �θ�â���� �ѱ�� form ������ ���� �ʵ�
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
    
    // ��� ó��
    if( cert_enc_use.equals( "Y" ) )
    {
        if( res_cd.equals( "0000" ) )
        {
            // dn_hash ����
            // KCP �� ������ �帮�� dn_hash �� ����Ʈ �ڵ�, �ֹ���ȣ , ������ȣ�� �����Ͽ�
            // �ش� �������� �������� �����մϴ�
            if ( !cc.checkValidHash( dn_hash, ( site_cd + ordr_idxx + cert_no ) ) )
            {
                // ���� ���н� ó�� ����

                System.out.println("dn_hash ���� ��������");
                //cc = null; // ��ü �ݳ� ( ��ƾ Ż��ÿ��� ȣ�� )
            }

            // ������ DB ó�� ������ ����

            System.out.println(site_cd);
            System.out.println(cert_no);
            System.out.println(enc_cert_data);
            
            // ���������� ��ȣȭ �Լ�
            // �ش� �Լ��� ��ȣȭ�� enc_cert_data ��
            // site_cd �� cert_no �� ������ ��ȭȭ �ϴ� �Լ� �Դϴ�.
            // ���������� ��ȣȭ �Ȱ�쿡�� ���������͸� �����ü� �ֽ��ϴ�.
            cc.decryptEncCert( site_cd, cert_no, enc_cert_data );
            //cc.setCharSetUtf8(); // ��ȣ�� ����� ���ڵ� ���� �޼��� ( UTF-8 ���ڵ� ���� �ּ��� �����Ͻñ� �ٶ��ϴ�.)
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
            System.out.println( "�̵���Ż� �ڵ�"    + cc.getKeyValue("comm_id"     ) ); // �̵���Ż� �ڵ�   
            System.out.println( "��ȭ��ȣ"           + cc.getKeyValue("phone_no"    ) ); // ��ȭ��ȣ          
            System.out.println( "�̸�"               + cc.getKeyValue("user_name"   ) ); // �̸�              
            System.out.println( "�������"           + cc.getKeyValue("birth_day"   ) ); // �������          
            System.out.println( "�����ڵ�"           + cc.getKeyValue("sex_code"    ) ); // �����ڵ�          
            System.out.println( "��/�ܱ��� ���� "    + cc.getKeyValue("local_code"  ) ); // ��/�ܱ��� ����    
            System.out.println( "CI"                 + cc.getKeyValue("ci"          ) ); // CI                
            System.out.println( "DI �ߺ����� Ȯ�ΰ�" + cc.getKeyValue("di"          ) ); // DI �ߺ����� Ȯ�ΰ�
            System.out.println( "CI_URL"             + URLDecoder.decode( cc.getKeyValue("ci_url"      ) ) ); // CI URL ���ڵ� ��
            System.out.println( "DI_URL"             + URLDecoder.decode( cc.getKeyValue("di_url"      ) ) ); // DI URL ���ڵ� ��
            System.out.println( "������Ʈ ���̵�  "  + cc.getKeyValue("web_siteid"  ) ); // ��ȣȭ�� ������Ʈ ���̵�
            System.out.println( "��ȣȭ�� ����ڵ�"  + cc.getKeyValue("res_cd"      ) ); // ��ȣȭ�� ����ڵ�
            System.out.println( "��ȣȭ�� ����޽���"+ cc.getKeyValue("res_msg"     ) ); // ��ȣȭ�� ����޽���
        }
        else/*if( res_cd.equals( "0000" ) != true )*/
        {
           // ��������
        }
    }
    else/*if( cert_enc_use.equals( "Y" ) != true )*/
    {
        // ��ȣȭ ���� ����
    }

    cc = null; // ��ü �ݳ�
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
					
					opener.auth_data( auth_form ); // �θ�â���� �� ����
                    setTimeout('fn_close()',100);
                   
                }
                catch(e)
                {
                    alert(e); // �������� �θ�â�� iframe �� ��ã�� �����
                }
            }
            
            function fn_close(){
            	 window.close();// �˾� �ݱ�
            	
            }
        </script>
    </head>
    <body oncontextmenu="return false;" ondragstart="return false;" onselectstart="return false;">
        <form name="form_auth" method="post">
            <%= sbParam.toString() %>
        </form>
    </body>
</html>
