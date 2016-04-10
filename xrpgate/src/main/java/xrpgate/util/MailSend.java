package xrpgate.util;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;

import egovframework.com.cop.ems.service.EgovSndngMailRegistService;

import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import egovframework.com.cop.ems.service.SndngMailVO;
import egovframework.com.uss.umt.service.MberManageVO;

@Component
public class MailSend {
	
	private static final Logger logger = LoggerFactory.getLogger(MailSend.class);
	
	@Resource(name = "mailSender")
	protected  JavaMailSender   mailSender;
	
	@Resource(name = "sndngMailRegistService")
	private EgovSndngMailRegistService sndngMailRegistService;
	
	
	public boolean send(MberManageVO mberInfo, String tempPass) throws MailException {
		
		boolean sendSuccess = true;
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			message.setSubject("[안내] 임시 비밀번호 발신 <관리자가 보낸메일>", "utf-8");
			String htmlContent = "고객님의 임시 비밀번호는 <Strong>" + tempPass
					+ "</Strong> 입니다. 사이트에 접속해서 로그인 후 비밀번호를 변경하세요.<br>";
			htmlContent += "<a href='http://xrpgate.com' target='_blank'>홈으로 이동</a>";
			message.setText(htmlContent, "utf-8", "html");
			message.setFrom(new InternetAddress("xrp_user1@daum.net"));
			message.addRecipient(RecipientType.TO, new InternetAddress(mberInfo.getMberEmailAdres()));
			mailSender.send(message);
		} catch (MessagingException e) {
			logger.debug(e.getMessage());
			e.printStackTrace();
			return sendSuccess = false;
		}
		
		return sendSuccess;
	}
	
	public void EgovMailSend(MberManageVO mberInfo, String tempPass) throws Exception {
		
		boolean sendMailresult = false;
		boolean isSimilarUser = false;
		
		 String verifyEmailNumber = new SupportUtil().gererateVerifyEmailNumber();  
    	//3. 유효 시간을 비교하기 위해 10분내 입력한 경우에 한해 인증 번호 유효성 부여
        //  long diffSec = (toDay.getTimeInMillis() - yDay.getTimeInMillis()) / 1000;       //초
    	/*Calendar toDay = Calendar.getInstance();
    	long verifyStampTime = toDay.getTimeInMillis();
    	
    	session.setAttribute("sendVerifyStampTime",verifyStampTime);
    	session.setAttribute("sendVerifyEmailNumber",verifyEmailNumber);*/
    	try {
    		// 2. 임시 비밀번호를 이메일 발송한다.(메일연동솔루션 활용)
        	SndngMailVO sndngMailVO = new SndngMailVO();
        	sndngMailVO.setDsptchPerson("webmaster");
        	sndngMailVO.setRecptnPerson(mberInfo.getMberEmailAdres());
        	sndngMailVO.setSj("[XRPGATE.COM] 회원님의 임시 비밀번호 발송");
        	sndngMailVO.setEmailCn("고객님의 임시 비밀번호는 " + tempPass + " 입니다. 로그인 하신후 마이페이지에서 비밀번호를 재설정하시기 바랍니다.");
        	sndngMailVO.setAtchFileId("");
        	
        	sendMailresult = sndngMailRegistService.insertSndngMail(sndngMailVO);	
    	} catch(Exception e){
    		logger.debug(e.getMessage());
    		e.getStackTrace();
    	}
	}
	
	public StringBuilder makeMailBody(String tempPass, String cid) {
		StringBuilder mailBody = new StringBuilder();
		mailBody.append("<html>The apache logo - <img src=\"cid:"+cid+"\">" );
		mailBody.append("<body>회원님의 임시 비밀번호는 : "+ tempPass +" 입니다.</body>"); 
		mailBody.append("</html>");
		
		return mailBody;
	}
}
