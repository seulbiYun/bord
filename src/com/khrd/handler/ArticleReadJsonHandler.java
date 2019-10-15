package com.khrd.handler;

import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import com.khrd.controller.CommandHandler;
import com.khrd.dao.ArticleDAO;
import com.khrd.dto.Article;
import com.khrd.jdbc.ConnectionProvider;
import com.khrd.jdbc.JdbcUtil;

//json data를 만들어서 돌려주는 핸들러
public class ArticleReadJsonHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//게시물 번호
		String sNo = request.getParameter("no");
		int no = Integer.parseInt(sNo);
		
		//db로 부터 no 데이터 가져오기
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			ArticleDAO dao = ArticleDAO.getInstance();
			Article article = dao.selectByNo(conn, no);
			
			//article -> json String
			ObjectMapper om = new ObjectMapper();
			String jsonData = om.writeValueAsString(article);
			
			System.out.println(jsonData);
			
			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(jsonData);
			out.flush();//고객(브라우저)에게 보냄
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
		}
		
		
		
		return null;
	}

}
