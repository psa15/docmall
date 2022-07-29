package com.docmall.domain;

import java.util.Date;

import lombok.Data;

//TBL_REVIEW
@Data
public class ReviewVO {

	//r_num, m_userid, p_num, r_content, r_score, r_regdate
	private Integer r_num;
	private String m_userid;
	private Integer p_num;
	private String r_content;
	private int r_score;
	private Date r_regdate;
}
