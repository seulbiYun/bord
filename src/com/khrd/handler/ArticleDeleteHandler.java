package com.khrd.handler;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khrd.controller.CommandHandler;
import com.khrd.dao.ArticleDAO;
import com.khrd.dto.Article;
import com.khrd.jdbc.ConnectionProvider;
import com.khrd.jdbc.JdbcUtil;

public class ArticleDeleteHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sNo = request.getParameter("no");
		int no = Integer.parseInt(sNo);
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			ArticleDAO dao = ArticleDAO.getInstance();
			dao.deleteArticle(conn, no);
			dao.deleteArticleContent(conn, no);
			
			conn.commit();
			
			response.sendRedirect(request.getContextPath() + "/article/list.do");
			
			return null;
		}catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
		}finally {
			JdbcUtil.close(conn);
		}
		
		
		
		return null;
	}

}
