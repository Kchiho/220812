CREATE TABLE MEMBER(
	MID VARCHAR(20) PRIMARY KEY,
	MPW VARCHAR(20) NOT NULL,
	MNAME VARCHAR(20) NOT NULL,
	ROLE VARCHAR(20) NOT NULL
);
INSERT INTO MEMBER VALUES('admin','1234','관리자','ADMIN');
SELECT * FROM MEMBER;
DROP TABLE MEMBER;
SELECT MLIKE FROM MEMBER WHERE MID='admin';
SELECT MID FROM MEMBER WHERE MID='1';