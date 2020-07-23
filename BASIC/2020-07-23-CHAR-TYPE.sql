<2020-07-23-03>

        -- 오라클에서 사용되는 자료형에는 숫자, 문자열, 날짜, 기타 등으로 구분된다.
        
    1. 문자열 자료형
        오라클의 문자열 자료는 ''로 묶어서 표현한다. 
        문자열 자료형에는 CHAR, VARCHAR, VARCHAR2, LONG, CLOB, NVARCHAR, NCLOB 등이 있다.
        LONG : 2GB까지 표현 가능하지만 제약사항이 많아 사용하지 않는다.
        CLOB : 4GB까지 표현 가능하고 제약사항이 거의 없어서 많이 사용된다. 
            -- 접두어로 N이 붙은것은 NATIONAL의 약자로서 국제표준이지만 많이 사용하지 않는다.
        VARCHAR, VARCHAR2 : 둘의 차이점은 거의 없지만 oracle에서 VARCHAR2사용을 권장한다
            -- VARCHAR2는 오직 ORACLE에서만 사용한다.
        한글과 영어 : 한글은 한 글자에 3BYTE를 점유하고 영어는 한 글자에 1BYTE를 점유한다.
            -- 변수의 BYTE_SIZE를 지정할 때 고려해야 한다.
            
            /* 
                CHAR을 제외한 모든 문자열 자료형은 가변길이다.
                
                <가변길이>
                사용자가 VARCHAR2(50)으로 정의한 경우 30BYTE를 사용하면 20BYTE는 반환한다.
                하지만 사용자가 지정해놓은 크기보다 큰 데이터를 입력하는 경우 ERROR를 발생시킨다.
                
                <고정길이>
                지정해놓은 크기보다 작은 데이터를 입력한 경우 남는 공간을 반환하지 않고 공백으로 채운다.
                사용자가 지정해놓은 크기보다 큰 데이터를 입력하는 경우 ERROR를 발생시킨다.
            */
        1) CHAR
            고정길이 문자열이기 때문에 기본키 컬럼의 데이터 타입으로 사용한다.
            왼쪽부터 저장되고 남는 공간은 공백으로 채운다.
            사용형식 : <컬럼명> CHAR(크기 [BYTE|CHAR]); 
            
            /*
                2000BYTE 까지 사용 가능
                [BYTE|CHAR]를 생략하면 DEFAULT 값인 BYTE로 지정된다.
                CHAR를 사용하는 경우 '크기'는 글자수를 의미한다.
                단, CHAR를 기술해도 2000BYTE를 초과할 수 없다.
                    ex. 2000byte라고 해도 2000글자를 넣을 수 없다. (한글 2000글자 = 6000byte)
            */
        ex. CREATE TABLE TEMP01(
                COL1 CHAR(10),
                COL2 CHAR(10 BYTE),
                COL3 CHAR(10 CHAR)); --한글도 10글자 넣을 수 있음
            
            INSERT INTO TEMP01
                VALUES('대한', 'ABCDEF', '대전시대흥동중앙로다');
            
            SELECT * FROM TEMP01;            
            
            SELECT LENGTHB(COL1), LENGTHB(COL2), LENGTHB(COL3) 
            FROM TEMP01;
            --LENGTHB(COLUMN) => COLUMN의 기억공간을 BYTE단위로 반환해줌
    
        2. VARCHAR2
            가변길이 문자열 저장에 사용
            4000BYTE 까지 사용가능
            사용형식 : <컬럼명> VARCHAR2(크기 [BYTE|CHAR])
            
        ex. CREATE TABLE TEMP02 (
                COL1 VARCHAR2(4000),
                COL2 VARCHAR2(4000 BYTE),
                COL3 VARCHAR2(4000 CHAR));
            
            INSERT INTO TEMP02
                VALUES('대한민국', 'KOREA', 'AAAAAAAAAAAAAAAAAA'),
            INSERT INTO TEMP02
                VALUES('Oracle', 'IL POSITION', 'Persimon');
            
            SELECT LENGTHB(COL1),
                   LENGTHB(COL2),
                   LENGTHB(COL3)
              FROM TEMP02;
              
            SELECT * FROM TEMP02
             WHERE COL1='대한민국'; 
            -- TEMP02 TABLE에서 COL1값이 '대한민국'인 열을 가져옴
        
        3. VARCHAR
            VARCHAR2와 동일 기능 제공
            Oracle 사에서는 VARCHAR2 사용을 권고
            다른 DBMS에서는 기본 문자열 타입으로 사용된다.
             
        4. NVARCHAR2
            국제표준 코드(다국적 언어)를 사용하여 문자열 저장
            UTF-8(가변길이), UTF-16(고정길이) 형식으로 처리
            
        5. LONG
            가변길이 문자열을 저장하는 데이터 타입
            2GB까지 저장가능하지만 제약사항이 많아 잘 사용하지 않음
                -- 제약사항 : 한 테이블에서 하나의 컬럼만 사용 가능하다.
            현재 CLOB 타입으로 대체되면서 더 이상 업데이트 하지않는다.
                -- LONG을 사용하거나 실행 할 수는 있다.
            SELECT문 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절에서 사용 가능하다.
                -- 위에 언급된 부분을 제외하고 사용 불가능하다.
            사용형식 : 컬럼명 LONG;
            
        ex. CREATE TABLE TEMP03 (
                COL1 LONG,
                COL2 VARCHAR2(100));
                
            INSERT INTO TEMP03 
                VALUES('DSADADLSADLASDAS;LDLSA;LDVDMKDMVKDVD', '대전시');
            SELECT * FROM TEMP03
           
        6. CLOB
            가변길이 문자열 저장을 위한 데이터 타입
            최대 4GB까지 저장가능하다.
            일부 기능들은 DBMS_LOB API의 지원을 받아야 한다.
            사용형식 : 컬럼명 CLOB
            
        ex. CREATE TABLE TEMP04 (
                COL1 CLOB,
                COL2 CLOB,
                COL3 CLOB,
                COL4 VARCHAR2(50));
            
            INSERT INTO TEMP04
                VALUES('가나다라마바사아자카타파하', '대한민국민주공화국', 'CLOBCLOBCLOBCLOB', 'ABCDEFGHIJKLMN');

            SELECT DBMS_LOB.SUBSTR(COL1, 10, 2),
                   -- DBMS_LOB.SUTSTR(컬럼명, 끝인덱스, 시작인덱스)
                   DBMS_LOB.GETLENGTH(COL2),
                   LENGTH(COL3),
                   -- CLOB는 저장 할 수 있는 데이터가 매우크기 때문에 DMBS_LOB API를 사용하는것을 추천한다.
                   -- 글자수가 적을때는 LENGTH(컬럼명)을 통해서 
                   -- LENGTHB(컬럼명)이 지원되지 않기때문에 사용 불가능하다.
                   SUBSTR(COL4, 2, 4)
                   -- SUTSTR(컬럼명, 시작인덱스, 끝인덱스)
              FROM TEMP04;