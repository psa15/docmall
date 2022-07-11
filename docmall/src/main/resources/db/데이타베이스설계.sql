/*
작성자 : 박수아
편집일 : 2022-07-05
프로젝트명 : 쇼핑몰(공통)
*/
--1. 회원테이블 (MEMBER)
CREATE TABLE MEMBER_TBL (
    M_USERID            VARCHAR2(15)        CONSTRAINT PK_MEMBER PRIMARY KEY, -- 회원 id
    M_USERNAME      VARCHAR2(30)            NOT NULL, -- 회원 이름
    M_PASSWD           VARCHAR2(60)             NOT NULL, --회원 비밀번호
    M_POSTNUM         CHAR(5)                       NOT NULL, --우편번호
    M_ADDR               VARCHAR2(100)              NOT NULL, --주소
    M_ADDR_D             VARCHAR2(100)           NOT NULL, --상세 주소
    M_TEL                    VARCHAR2(15)               NOT NULL, --전화번호
    M_NICKNAME          VARCHAR2(20)                UNIQUE  NOT NULL, --???? 닉네임은 없어도 될 것 같음
    M_EMAIL                VARCHAR2(50)                 UNIQUE NOT NULL, --이메일
    M_EMAIL_ACCEPT    CHAR(1)         default 'Y'                  NOT NULL,
    M_POINT                 NUMBER  DEFAULT 0           NOT NULL,
    M_REGDATE             DATE    DEFAULT SYSDATE    NOT NULL,
    M_UPDATEDATE       DATE    DEFAULT SYSDATE   NOT NULL,
    M_LASTDATE            DATE    DEFAULT SYSDATE    NOT NULL,
    M_AUTHCODE          char(1) default 'N'                              NOT NULL --이메일 인증코드
);
--m_userid, m_username, m_passwd, m_postnum, m_addr, m_addr_d, m_tel, m_nickname, m_email, m_email_accept, m_point, m_regdate, m_updatedate, m_lastdate, m_authcode
--2. 카테고리 테이블(CATEGORY)
CREATE TABLE CATEGORY_TBL(
    CT_CODE     NUMBER  CONSTRAINT PK_CATEGORY  PRIMARY KEY,
    CT_P_CODE   NUMBER,
    CT_NAME     VARCHAR2(50)    NOT NULL
);

--3. 상품 테이블(PRODUCT)
CREATE TABLE PRODUCT_TBL(
    P_NUM               NUMBER              CONSTRAINT PK_PRODUCT   PRIMARY KEY,
    F_CT_CODE           NUMBER,
    S_CT_CODE           NUMBER,
    P_NAME              VARCHAR2(50)       NOT NULL,
    P_COST              NUMBER                NOT NULL,
    P_DISCOUNT       NUMBER                NOT NULL,
    P_COMPANY        VARCHAR2(30)       NOT NULL,
    P_DETAIL             CLOB                      NOT NULL,
    P_IMAGE              VARCHAR2(50)         NOT NULL,
    P_AMOUNT          NUMBER                  NOT NULL,
    P_BUY_OK             CHAR(1)                    NOT NULL,
    P_REGDATE           DATE    DEFAULT SYSDATE         NOT NULL,
    P_UPDATEDATE      DATE    DEFAULT SYSDATE     NOT NULL
);

--4. 장바구니(CART)
CREATE TABLE CART_TBL(
    CART_CODE     NUMBER      CONSTRAINT PK_CART  PRIMARY KEY,
    P_NUM            NUMBER     NOT NULL,
    M_USERID        VARCHAR2(15)    NOT NULL,
    CART_ACOUNT NUMBER      NOT NULL
);

--5. 주문 테이블 (T_ORDER)
CREATE TABLE ORDER_TBL (
    O_CODE              NUMBER      CONSTRAINT  PK_T_ORDER    PRIMARY KEY,
    M_USERID            VARCHAR2(15)        NOT NULL,
    O_NAME              VARCHAR2(30)        NOT NULL,
    O_POST               CHAR(5)                  NOT NULL,
    O_ADDR              VARCHAR2(100)       NOT NULL,
    O_ADDR_D            VARCHAR2(100)       NOT NULL,
    O_TEL                   NUMBER                  NOT NULL,
    O_TOTALCOST         NUMBER                  NOT NULL,
    O_DATE                  DATE    DEFAULT SYSDATE
);

--6. 주문 상세 테이블(T_ORDER_D)
CREATE TABLE ORDER_D_TBL(
    O_CODE              NUMBER,
    P_NUM               NUMBER,
    O_AMOUNT        NUMBER          NOT NULL,
    O_COST              NUMBER          NOT NULL,
    PRIMARY KEY(O_CODE, P_NUM)
);

--7. 게시판(BOARD)
CREATE TABLE BOARD_TBL(
	B_NUM				NUMBER							CONSTRAINT PK_BOARD 	PRIMARY KEY,
	M_USERID					VARCHAR2(15)						NOT NULL,
	B_TITLE				VARCHAR2(100)						NOT NULL,
	B_CONTENT			VARCHAR2(4000)					NOT NULL,
	B_REGDATE			DATE DEFAULT SYSDATE			NOT NULL
);

--8. 리뷰
CREATE TABLE REVIEW_TBL(
	R_NUM					NUMBER							CONSTRAINT PK_REVIEW 	PRIMARY KEY, 
	M_USERID					VARCHAR2(15)						NOT NULL,
	P_NUM				NUMBER								NOT NULL,
	R_CONTENT			VARCHAR2(200)						NOT NULL,
	R_SCORE				NUMBER								NOT NULL,
	R_REGDATE			DATE DEFAULT SYSDATE			NOT NULL
);

--9. 관리자 테이블 (ADMIN)
CREATE TABLE ADMIN_TBL(
	ADMIN_ID				VARCHAR2(15)					CONSTRAINT PK_ADMIN 	PRIMARY KEY,
	ADMIN_PW				VARCHAR2(60)						NOT NULL,
	ADMIN_NAME			VARCHAR2(100)						NOT NULL,
	ADMIN_LASTDATE	DATE DEFAULT	SYSDATE			NOT NULL
);



