<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
  <li>
    <img src="/images/sub/meminfo_chk_title.png" />
  </li>
</div> 

<form:form commandName="mberManageVO"  id="form" method="POST">
<div class="content">
    <div class="content_in">
        <div class="con_info">
        	<div class="mem_chk_info">
            	<li>★ 개인정보 변경을 위해 비밀번호를 다시 한 번 확인 합니다.</li>
                <li>★ 비밀번호는 항상 타인에게 노출되지 않도록 주의해 주세요.</li>
            </div>
            <div class="mem_chk_box">
            	<div class="mem_chk_box_in">  
                	<div class="mem_idpw_box"> 
                        <div class="mem_id_box">
                            <li class="mem_title">아이디</li>
                            <li class="mem_id">홍길동</li>
                        </div>
                        <div class="mem_pw_box">
                            <li class="mem_title">비밀번호</li>
                            <li><input type="password" name="password"/></li>
                        </div>
                    </div>
                </div>            	
            </div>
            <div class="mem_info_btn">
            	<a href="#" name="btnPassChk"><img src="/images/btn/square_ok_btn.png" /></a>
            </div>
        </div>
    </div>    
</div>   
</form:form>
<script type="text/javaScript" language="javascript">
	$(function(){
		$("[name=btnPassChk]").on("click", function(e){
			var pass = $("[name=password]").val();
			if(pass =="" || pass == null ) {
				return;
			}
			// 태그중 기본 속성으로 먼저 이동하려는 경향이 있는 태그들은 해당 속성으로 이동하지 못하게 제한을 
			// 걸어둔 후 필요한 로직을 실행한다.
			e.preventDefault();
			$("#form").attr({action:"${contextPath}/myInfo/memberPasswordChk.do"});
			$("#form").submit();
		});
		
	});

</script>
        