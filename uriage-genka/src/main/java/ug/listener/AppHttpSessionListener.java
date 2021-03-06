package ug.listener;

import java.util.Date;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class AppHttpSessionListener implements HttpSessionListener{

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		//HttpSession session = se.getSession();
		//System.out.println(getTime() + "Created session :ID=" + session.getId());

	}

	private String getTime() {
		return new Date(System.currentTimeMillis()).toString();
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		/*
		HttpSession session = se.getSession();
		System.out.println(getTime()+"Destroy session :ID=" + session.getId());
		if(session.getAttribute("loginId")!=null){
			System.out.println("exist loginId:" + session.getAttribute("loginId"));
		}
		if(session.getAttribute("userDataDto")!=null){
			System.out.println("exist userDataDto:"+session.getAttribute("userDataDto"));
		}

*/
	}

}
