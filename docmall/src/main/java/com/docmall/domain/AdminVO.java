package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminVO {

	//admin_id, admin_pw, admin_name, admin_lastdate
	private String admin_id;
	private String admin_pw;
	private String admin_name;
	private Date admin_lastdate;
}
