package com.khrd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.khrd.dto.Article;
import com.khrd.jdbc.JdbcUtil;

public class ArticleDAO {
	private static final ArticleDAO dao = new ArticleDAO();
	
	public static ArticleDAO getInstance() {
		return dao;
	}
	
	private ArticleDAO() {}
	
	public int insertArticle(Connection conn, Article a) {
		PreparedStatement pstmt = null;
		
		try{
			String sql = "insert into article values(null,?,?,?, now(),now(),0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, a.getWriter_id());
			pstmt.setString(2, a.getWriter_name());
			pstmt.setString(3, a.getTitle());
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
		return -1;
	}
	
	public int insertContent(Connection conn,Article a) {
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into article_content values(last_insert_id(),?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, a.getContent());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
		return -1;
	}
	
	public ArrayList<Article> selectArticleList(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from article order by article_no desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<Article> list = new ArrayList<>();
			
			while(rs.next()) {
				Article a = new Article(rs.getInt("article_no"),
						rs.getString("writer_id"),
						rs.getString("writer_name"),
						rs.getString("title"),
						rs.getDate("regdate"),
						rs.getTimestamp("moddate"),
						rs.getInt("read_cnt"),
						null);
				list.add(a);
			}
			return list;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		
		return null;
	}
	
	public Article selectByNo(Connection conn, int article_no) {
		PreparedStatement pstmt = null;
		ResultSet rs =  null;
		try {
			String sql = "select * from article as a left join article_content as c "
							+ "on a.article_no = c.article_no where a.article_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Article article = new Article(rs.getInt("article_no"),
										rs.getString("writer_id"),
										rs.getString("writer_name"),
										rs.getNString("title"),
										rs.getTimestamp("regdate"),
										rs.getTimestamp("moddate"),
										rs.getInt("read_cnt"),
										rs.getString("content"));
				return article;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return null;
	}
	
	public int deleteArticle(Connection conn,int article_no) {
		PreparedStatement pstmt = null;
		
		try {
			String sql = "delete from article where article_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article_no);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
		
		return -1;
	}
	
	public int deleteArticleContent(Connection conn,int article_no) {
		PreparedStatement pstmt = null;
		
		try {
			String sql = "delete from article_content where article_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article_no);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
		
		return -1;
	}
	
	public int updateArticle(Connection conn, int no, String title) {
		PreparedStatement pstmt = null;
		
		try {
			String sql = "update article set title = ? where article_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setInt(2, no);
			return pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
		return -1;
	}
	
	public int updateArticleContent(Connection conn, int no, String content) {
		PreparedStatement pstmt = null;
		
		try {
			String sql = "update article_content set content = ? where article_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, no);
			return pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
		return -1;
	}
	
	
	
}
