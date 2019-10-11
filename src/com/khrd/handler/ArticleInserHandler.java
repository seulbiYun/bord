package com.khrd.handler;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.khrd.controller.CommandHandler;
import com.khrd.dao.ArticleDAO;
import com.khrd.dao.MemberDAO;
import com.khrd.dto.Article;
import com.khrd.dto.Member;
import com.khrd.jdbc.ConnectionProvider;
import com.khrd.jdbc.JdbcUtil;

public class ArticleInserHandler  implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(request.getMethod().equalsIgnoreCase("get")) {
			return "/WEB-INF/view/articleInsertForm.jsp";
		}else if(request.getMethod().equalsIgnoreCase("post")) {
			request.setCharacterEncoding("utf-8");
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			Connection conn = null;
			
			try {
				conn = ConnectionProvider.getConnection();
				conn.setAutoCommit(false);//자동 변경 박음
				ArticleDAO dao = ArticleDAO.getInstance();
				MemberDAO mDao = MemberDAO.getInstance();
				HttpSession session = request.getSession();
				String writer_id = (String) session.getAttribute("Auth");
				Member member = mDao.selectById(conn, writer_id);
				
				Article a = new Article(0, writer_id, member.getName(), title, null, null, 0, content);
				
				dao.insertArticle(conn, a);  
				dao.insertContent(conn, a);
				conn.commit();//table값 변경
				
				response.sendRedirect(request.getContextPath() + "/article/list.do");
				
				return null;
			}catch (Exception e) {
				e.printStackTrace();
				conn.rollback();
			}finally {
				JdbcUtil.close(conn);
			}
		}
		return null;
	}

}
