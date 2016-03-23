<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
  <li>
    <img src="/images/sub/mem_join_title.png" />
  </li>
</div> 
<div class="content">
    <div class="content_in">
        <div class="con_info">
        	<div class="join_turn">
            	<img src="/images/sub/mem_join01.png" />            
            </div>
            <div class="join_person">
            	<div class="personal">
                	<li><img src="/images/sub/per_mem.png" /></li>
                    <li><a href="${contextPath}/join/mem_join_chk.do?userTy=USR01"><img src="/images/btn/per_mem_btn.png" /></a></li>
                </div>
                <div class="join-line"></div>
                <div class="company">
                	<li><img src="/images/sub/com_mem.png" /></li>
                    <li><a href="${contextPath}/join/mem_join_chk.do?userTy=USR02"><img src="/images/btn/com_mem_btn.png" /></a></li>
                </div>
            </div>
        </div>
    </div>    
</div>
        