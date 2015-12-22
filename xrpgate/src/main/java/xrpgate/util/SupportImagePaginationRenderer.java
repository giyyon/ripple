package xrpgate.util;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class SupportImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public SupportImagePaginationRenderer() {

	}

	public void initVariables(){
//		firstPageLabel    = "<a href=\"?pageIndex={1}\" class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_pre_page.png\" alt=\"처음\"   border=\"0\"/></a>&#160;";
//        previousPageLabel = "<a href=\"?pageIndex={1}\"  class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_prev.png\"    alt=\"이전\"   border=\"0\"/></a>&#160;";
//        currentPageLabel  = "<strong>{0}</strong>&#160;";
//        otherPageLabel    = "<a href=\"?pageIndex={1}\" >{2}</a>&#160;";
//        nextPageLabel     = "<a href=\"?pageIndex={1}\"  class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_next.png\"    alt=\"다음\"   border=\"0\"/></a>&#160;";
//        lastPageLabel     = "<a href=\"?pageIndex={1}\"  class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_next_page.png\" alt=\"마지막\" border=\"0\"/></a>&#160;";

		firstPageLabel    = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_pre_page.png\" alt=\"처음\"   border=\"0\"/></a>&#160;";
        previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"  class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_prev.png\"    alt=\"이전\"   border=\"0\"/></a>&#160;";
        currentPageLabel  = "<strong>{0}</strong>&#160;";
        otherPageLabel    = "<a href=\"#\" onclick=\"{0}({1}); return false;\" >{2}</a>&#160;";
        nextPageLabel     = "<a href=\"#\" onclick=\"{0}({1}); return false;\"  class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_next.png\"    alt=\"다음\"   border=\"0\"/></a>&#160;";
        lastPageLabel     = "<a href=\"#\" onclick=\"{0}({1}); return false;\"  class=\"direction\"><img src=\"" + servletContext.getContextPath() +  "/img/btn_next_page.png\" alt=\"마지막\" border=\"0\"/></a>&#160;";

	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
