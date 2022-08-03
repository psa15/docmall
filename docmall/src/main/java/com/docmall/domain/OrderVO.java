package com.docmall.domain;

import java.util.Date;

import lombok.Data;

//TBL_ORDER
@Data
public class OrderVO {

	//o_code, m_userid, o_name, o_post, o_addr, o_addr_d, o_tel, o_totalcost, o_date
	private Long o_code;
	private String m_userid;
	private String o_name;
	private String o_post;
	private String o_addr;
	private String o_addr_d;
	private String o_tel;
	private int o_totalcost;
	private Date o_date;
}
