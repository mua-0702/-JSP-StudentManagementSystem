package com.administrator.servlet;

import java.io.Console;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jdbc.jdbc;

/**
 * Servlet implementation class administratorStudentInfoEdit
 */
@WebServlet("/administratorStudentInfoEdit")
public class administratorStudentInfoEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public administratorStudentInfoEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		request.setCharacterEncoding("utf-8");
		String sno=request.getParameter("sno");
		String name=request.getParameter("name");
		String sex=request.getParameter("sex");
		String birthday=request.getParameter("birthday");
		String major=request.getParameter("major");
		String className=request.getParameter("className");
		String address=request.getParameter("address");
		String phone=request.getParameter("phone");
		String remark=request.getParameter("remark");
		
		String sql="update student_info set sno='"+sno+"',name='"+name+"',sex='"+sex+"',birthday='"+birthday+"',major='"+major+"',"
				+ "class='"+className+"',address='"+address+"',phone='"+phone+"',remark='"+remark+"' where sno='"+sno+"';";
		jdbc.update(sql);
		System.out.println(sql);
		HttpSession session=request.getSession();
		session.setAttribute("success","����ɹ���");
		response.sendRedirect("./administratorStudentInfoGet");
		//System.out.println(sno+sex+birthday);
	}

}
