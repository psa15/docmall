package com.docmall.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//@RequiredArgsConstructor : final or @NonNull어노테이션이 존재하는 필드를 대상으로 생성자 메소드가 생성됨
@Data // : @Getter, @Setter, @RequiredArgsConstructor, @ToString, @EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class LoginDTO {

	private String m_userid;
	private String m_passwd;
}
