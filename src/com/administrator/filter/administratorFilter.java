package com.administrator.filter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet Filter implementation class administratorFilter
 */
@WebFilter("/administratorFilter")
public class administratorFilter implements Filter {

    /**
     * Default constructor. 
     */
    public administratorFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain
		// 设置请求的字符编码
		request.setCharacterEncoding("UTF-8");
		// 设置返回请求的字符编码
		response.setCharacterEncoding("UTF-8");
		// 转换ServletRequest为 HttpServletRequest
		HttpServletRequest req = (HttpServletRequest) request;
		// 转换ServletResponse为HttpServletRequest
		HttpServletResponse res = (HttpServletResponse) response;
		// 获取Session
		//HttpSession session = req.getSession();
		// 获取Session中存储的对象
		
		// 获取当前请求的URI
		String url = req.getRequestURI();
		// 判断Session中的对象是否为空；判断请求的URI是否为不允许过滤的URI
	/*	if (o == null && url.indexOf("test.jsp") < 0 && url.indexOf("comment.jsp") < 0 && url.indexOf("link.jsp") < 0) {
			chain.doFilter(request, response);
			res.setHeader("Cache-Control", "no-store");
			res.setDateHeader("Expires", 0);
			res.setHeader("Pragma", "no-cache");
			res.flushBuffer();
		}*/
	    Cookie[] cookies = req.getCookies();
        Cookie remember = null;
        String[] data=null;
        if (cookies != null && cookies.length > 0) {
            for (Cookie c : cookies) {
                if (c.getName().equals("rememberAdministrator")) {
                    remember = c;
                    //字符串分割
                    data=URLDecoder.decode(remember.getValue(),"utf-8").split(",");  /*使用utf-8读取*/
                   	//out.print(data[2]);
                }
            }
        }
        
		if (!(url.indexOf("administrator")<0)&&data==null) {
			res.sendRedirect(req.getContextPath()+"/Login.jsp");
			//response提交后会继续向下执行  再次提交response就会报错 
			//因此需要加入return 阻止代码继续向下执行
			return;
		}
		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
