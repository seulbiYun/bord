package com.khrd.controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class ControllerUsingURI extends HttpServlet {
	
	private HashMap<String, CommandHandler> commandHandlerMap = new HashMap<>();
	
	@Override
	public void init() throws ServletException {
		//configFile = /WEB-INF/commandHandler.properties = 상대 주소
		String configFile = getInitParameter("configFile");
		
		//properties 파일의 절대 주소를 가져옴
		String configFilePath = getServletContext().getRealPath(configFile);
		
		Properties prop = new Properties();
		//properties 파일 안의 내용을 읽어 들임
		try(FileReader fis = new FileReader(configFilePath)) {
				prop.load(fis);
		}catch(Exception e) {
			throw new ServletException(e);
		}
		Iterator keyIter = prop.keySet().iterator();
		while(keyIter.hasNext()) {
			String command = (String) keyIter.next();// /simple.do
			String handlerClassName = prop.getProperty(command);//handlerClassName = com.khrd.handler.SimpleHandler
			try {
				
				// handler = new SimpleHandler(); == 밑에 두줄이 하는 역할
				Class<?> handlerClass = Class.forName(handlerClassName);
				CommandHandler handler = (CommandHandler) handlerClass.newInstance();//인스턴스화
				commandHandlerMap.put(command, handler);
			}catch(Exception e) {
				throw new ServletException(e);
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	private void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String command = req.getRequestURI();
		if(command.indexOf(req.getContextPath()) == 0) {
			//req.getContextPath() : / chapter18
			command = command.substring(req.getContextPath().length());
			//command = /simple.do
		}
		
		//command에 해당하는 class를 가져온다.
		CommandHandler handler = commandHandlerMap.get(command);
		if(handler == null) {
			handler = new NullHandler();
		}
		
		String viewPage = null;// 화면에 보일 jsp파일
		try {
			viewPage = handler.process(req, resp);
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		if(viewPage != null) { //forward처리
			RequestDispatcher dispatcher = req.getRequestDispatcher(viewPage);
			dispatcher.forward(req, resp);
		}

	}
	
}











