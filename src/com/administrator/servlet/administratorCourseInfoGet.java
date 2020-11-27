package com.administrator.servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.administrator.bean.CourseInfo;
import com.jdbc.jdbc;

/**
 * Servlet implementation class administratorCourseInfoGet
 */
@WebServlet("/administratorCourseInfoGet")
public class administratorCourseInfoGet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public administratorCourseInfoGet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		Cookie[] cookies = request.getCookies();
        Cookie remember = null;
        String[] data=null;
        if (cookies != null && cookies.length > 0) {
            for (Cookie c : cookies) {
                if (c.getName().equals("rememberAdministrator")) {
                    remember = c;
                    //�ַ����ָ�
                    data=URLDecoder.decode(remember.getValue(),"utf-8").split(",");  /*ʹ��utf-8��ȡ*/
                   	//System.out.println(data[2]);
                }
            }
        }
        if(data!=null){
        	String sql="SELECT * FROM course_info;";
    		ResultSet rSet = jdbc.query(sql);
    		List<CourseInfo> list=new ArrayList<CourseInfo>();
    		//System.out.println(sql);
    		try {
    			while(rSet.next()){
    				//��װ��javaBean��
    				CourseInfo courseInfo=new CourseInfo(rSet.getInt(1),rSet.getString(2),rSet.getString(3),rSet.getInt(4));
    				//�Ѷ����������
    				list.add(courseInfo);
    			}
    			//����������session
				HttpSession session=request.getSession();
				session.setAttribute("CourseInfo",list);
				session.setAttribute("searchContent", "");
				//System.out.println(myInfo.getBirthday());
				response.sendRedirect("administrator/CourseInfo.jsp");
    			
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
        }else{
        	response.sendRedirect("./administrator/Login.jsp");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}