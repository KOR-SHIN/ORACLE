<2020-07-21>

    사용자 생성
        사용자 계정 생성 -> 권한부여 -> 접속메뉴 추가

    사용자 계정생성
        사용자 계정명과 암호(java) 지정
    
    계정생성 사용형식
        CREATE USER <사용자 이름> IDENTIFIED BY <패스워드>;      
        
    권한설정 사용형식
        GRANT <권한명,권한명, ...> TO <사용자 이름>;
        
    1) 역사
        - 1973 : SQUARE (Structured Queries As Relational Express)
        - 1974 : System R용의 SEQUEL (Structured English Query Language)
        - 1980 : SQL (Structured Query Language)로 명칭 변경
        - 1988 : ANSL ISO 국제표준으로 재정 
        - 1989 : SQL-1 (SQL/89) 표준안 재정 (현재까지 사용하는 규정)
        - 1992 : SQL-2 표준안 재정 
        - 1999 : SQL-3 표준안 재정

    2) SQL 명령의 분류
        - DDL(DATA DEFINITION LANGUAGE)
            CREATE(생성), DROP(삭제), ALTER(구조변경 OR 테이블 변경)
            DATA 정의어
        
        - DCL(DATA CONTROL LANGUAGE)
            GRANT, REVOKE, COMMIT, ROLLBACK
            DATA 제어어
            
        - DML(DATA MANIPULATION LANGUAGE)
            INSERT, UPDATE, DELETE
            DATA 조작어
            
        - QUERY LANGUAGE
            SELECT
            질의어
    
    3) SQL 언어의 특징
        구조적언어이기 때문에 변수/상수, 비교문, 반복문, 분기문이 없다.
    
    <표현규칙>
        한글로 되어있는 부분은 사용자 정의어
        [ ] : 선택사항 (생략가능)
        | : 두 개중 한 개를 선택하여 사용한다.
            ex) ident1 | ident2 : ident1 or ident2를 사용해야한다. (생략 불가, 동시사용 불가)
        .... : 앞의 기술 내용이 반복 적용 될 수 있음을 의미한다.
                    
    4) DDL
        테이블 생성 사용형식 
            CREATE TABLE <테이블명>(
                <컬럼명> <데이터 타입>[(크기)] [NOT NULL | NULL] [DEFAULT 값],
                <컬럼명> <데이터 타입>[(크기)] [NOT NULL | NULL] [DEFAULT 값],
                ....
                <컬럼명> <데이터 타입>[(크기)] [NOT NULL | NULL] [DEFAULT 값],
                [CONSTRAINT <기본키설정명> PRIMARY KEY (컬럼명[,컬럼명...])],
                [CONSTRAINT <외래키설정명> FOREIGN KEY (컬럼명[,컬럼명...])
                    REFERENCES 외부테이블명(컬럼명))]
            ---------------------------------------------------------------------------------------------
           | CREATE TABLE <테이블명> : 테이블명은 고유이름으로 작성해야 한다.                                    
           | [NOT NULL | NULL] : 생략하면 null로 설정된다.
           | [DEFAULT 값] : 생략하면 데이터 타입에 상관없이 null로 설정된다.
           | ',' : 앞문장과 뒷문장을 구분하는 것
           | [CONSTRAINT <기본키설정명> PRIMARY KEY (컬럼명[,컬럼명...])] : 외래키가 없을경우 여기까지 작성가능하다.
           | (컬럼명[,컬럼명...]) : 키 설정시 컬럼이 여러개면 써야한다.
           | REFERENCES 외부테이블명(컬럼명) : 외래키를 가져온 테이블 이름을 써야한다.. (외래키가 여러개면 모두 써야함.)
           | <외래키설정명>, <기본키설정명> : 고유값으로 작성되어야 한다. (다른 테이블에 같은값이 들어있으면 오류가 된다.)
             ---------------------------------------------------------------------------------------------
             
    quiz) 다음 조건에 맞는 테이블을 생성하시오. 
        테이블명 : EMP
        컬럼명     데이터타입(크기) NULLABLE   PK
        ---------------------------------
        E_EMP_NO   CHAR(4)         N.N     PK
        E_NAME     VARCHAR2(10)    N.N      
        E_ADDRESS  VARCHAR2(50)    N.N
        E_TEL_NO   VARCHAR2(15)       
        E_POSITION VARCHAR2(20)    N.N
        E_DEPT     VARCHAR2(20)    N.N
        ---------------------------------
        
    solv)
        CREATE TABLE EMP (
        E_EMP_NO CHAR(4) NOT NULL,
        E_NAME VARCHAR2(10) NOT NULL,      
        E_ADDRESS VARCHAR2(50) NOT NULL,
        E_TEL_NO VARCHAR2(15),       
        E_POSITION VARCHAR2(20) NOT NULL,
        E_DEPT VARCHAR2(20) NOT NULL,
        
        CONSTRAINT pk_emp PRIMARY KEY (E_EMP_NO));
        

CREATE USER SKJ IDENTIFIED BY java;  -- 사용자 계정 생성
GRANT CONNECT, RESOURCE, DBA TO SKJ; -- 권한부여  
/*  
    CONNECT : 연결권한  
    RESOURCE : 자원사용권한  
    DBA :모든권한 부여
*/
