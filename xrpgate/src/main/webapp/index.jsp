<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	application.setAttribute("systemCode", egovframework.com.cmm.service.EgovProperties.getProperty("Globals.BsnsSe"));
    System.out.println("systemCode : "+egovframework.com.cmm.service.EgovProperties.getProperty("Globals.BsnsSe"));
    System.out.println("systemCode : aa");
%>
asdf
<jsp:forward page="/main/index.do"/>
<%-- <jsp:forward page="/egvIndex.do"/> --%>