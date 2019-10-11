package com.khrd.handler;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khrd.controller.CommandHandler;
import com.khrd.dao.MemberDAO;
import com.khrd.dto.Member;
import com.khrd.jdbc.ConnectionProvider;
import com.khrd.jdbc.JdbcUtil;

public class UpdateHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(request.getMethod().equalsIgnoreCase("get")) {
			return "/WEB-INF/view/pwUpdateFrom.jsp";
		}else if(request.getMethod().equalsIgnoreCase("post")) {
			request.setCharacterEncoding("utf-8");
			
			Connection conn = null;
			String password = request.getParameter("password");
			String pw = request.getParameter("newPassword");
			String id = request.getParameter("id");
			
			try {
				conn = ConnectionProvider.getConnection();
				MemberDAO dao = MemberDAO.getInstance();
				Member m = dao.pwOk(conn, id);
				if(password.equals(m.getPassword()) == false) {
					request.setAttribute("pw", true);
					return "/WEB-INF/view/pwUpdateFrom.jsp";
				}
				
				
				int result = dao.update(conn, id, pw);
				request.setAttribute("result", result);
				
				return "/WEB-INF/view/pwUpdate.jsp";
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				JdbcUtil.close(conn);
			}
		}
		return null;
	}

}
