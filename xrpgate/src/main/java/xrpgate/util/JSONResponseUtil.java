package xrpgate.util;

import java.io.IOException;

import net.sf.json.JSONSerializer;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import xrpgate.login.web.LoginController;
 
/**
 * @version <tt>Revision: 1.0</tt> 2013. 8. 22.
 * @author <a href="mailto:hejin@nkia.co.kr">hejin</a>
 */
public class JSONResponseUtil{
     
	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(JSONResponseUtil.class);

	
    /**
     * JSON View 화면 처리를 위해 JSON변환 후 ResponseEntity로 반환.
     * @param obj
     * @return
     * @throws IOException 
     * @throws JsonMappingException 
     * @throws JsonGenerationException 
     */
    public static ResponseEntity<String> getJSONResponse(Object obj) throws JsonGenerationException, JsonMappingException, IOException{
    	ObjectMapper mapper = new ObjectMapper();
    	String json = mapper.writeValueAsString(obj);
//        String json = new JSONSerializer().toJSON(obj).toString();
        LOGGER.debug("[json 변환 결과]"+json);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "application/json; charset=UTF-8");
        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
    }
     
    /**
     * JSON View 화면 처리를 위해 JSON변환 후 ResponseEntity로 반환.
     * @param obj
     * @return
     */
    public static String getJSONString(Object obj){
        return new JSONSerializer().toJSON(obj).toString();
    }
}
