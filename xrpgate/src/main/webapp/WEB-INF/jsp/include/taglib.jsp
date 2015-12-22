<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"      uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form"     uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"   uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security"  uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="ui"         uri="http://egovframework.gov/ctl/ui"%>

<security:authorize access="hasAnyRole('ROLE_ADMIN')">
	<security:authentication property="principal.username" var="isAdminRole" />
</security:authorize>
