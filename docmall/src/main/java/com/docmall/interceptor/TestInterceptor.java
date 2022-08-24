package com.docmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//이 클래스가 interceptor 기능을 하려면 HandlerInterceptorAdapter 추상클래스를 상속
//설정 : servlet-context.xml에 클래스 정보 등록
public class TestInterceptor extends HandlerInterceptorAdapter{

	//컨트롤러(메소드) 이전에 동작하는 메소드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		return super.preHandle(request, response, handler);
	}

	//컨트롤러(메소드) 이후에 동작하는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	//뷰가 실행이 되고 난 이후에 동작하는 메소드
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
	
	
}
