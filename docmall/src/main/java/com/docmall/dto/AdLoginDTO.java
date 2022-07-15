package com.docmall.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@AllArgsConstructor
@NoArgsConstructor
public class AdLoginDTO {

	private String admin_id;
	private String admin_pw;
}
