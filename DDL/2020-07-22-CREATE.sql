<2020-07-22-01>
    테이블 설계
        외래키가 없는 테이블부터 작성한다.
        외래키가 없는 테이블을 핵심 엔터티, 자립 엔터티, 스트롱 엔터티라고 부른다
        
    quiz) 사업장 테이블을 생성하시오.
        테이블명 : SITE
        속성명           데이터타입(크기)    NULL허용    키
        ------------------------------------------------
        S_SITE_NO        CHAR(4)            N.N     P.K
        S_SITE_NAME      VARCHAR2(30)       N.N      
        S_SITE_ADDRESS   VARCHAR2(50)       N.N        
        S_SITE_TEL       VARCHAR2(15)
        S_SITE_AMT       NUMBER(8)          N.N
        S_INPUT_PER      NUMBER(4)
        S_SITE_REMARK    VARCHAR2(100)
    
    solv) 
        CREATE TABLE SITE (
        S_SITE_NO        CHAR(4),            
        S_SITE_NAME      VARCHAR2(30)       NOT NULL,      
        S_SITE_ADDRESS   VARCHAR2(50)       NOT NULL,        
        S_SITE_TEL       VARCHAR2(15),
        S_SITE_AMT       NUMBER(8)          NOT NULL,
        S_INPUT_PER      NUMBER(4),
        S_SITE_REMARK    VARCHAR2(100),
        
        CONSTRAINT pk_site PRIMARY KEY(S_SITE_NO));
        --S_SITE_NO는 기본키이기 때문에 NOT NULL을 안써도 상관없다. (기본키는 무조건 NOT NULL이기때문이다)
        
    quiz) 사업장 테이블을 생성하시오.
        테이블명 : SITE_ITEM
        속성명           데이터타입(크기)    NULL허용    키
        ------------------------------------------------
        SI_ITEM_NO        CHAR(4)          N.N      P.K
        SI_ITEM_NAME      VARCHAR2(30)     N.N
        SI_AMOUNT         NUMBER(3)        N.N
        SI_PRICE          NUMBER(12)       N.N
        SI_BUY_DATE       DATE             N.N
        S_SITE_NO         CHAR(4)          N.N      F.K
        -- DATE는 크기를 지정하지않음
   solv)     
        CREATE TABLE SITE_ITEM(
        SI_ITEM_NO        CHAR(4)          NOT NULL,
        SI_ITEM_NAME      VARCHAR2(30)     NOT NULL,
        SI_AMOUNT         NUMBER(3)        NOT NULL,
        SI_PRICE          NUMBER(12)       NOT NULL,
        SI_BUY_DATE       DATE             NOT NULL,
        S_SITE_NO         CHAR(4)          NOT NULL,
        
        CONSTRAINT pk_site_item PRIMARY KEY(SI_ITEM_NO),
        CONSTRAINT fk_site_item_site FOREIGN KEY(S_SITE_NO)
            REFERENCES SITE(S_SITE_NO));
            -- 외래키이름 fk_참조테이블_해당테이블
            
    quiz) 사업장 테이블을 생성하시오.
        테이블명 : WORK
        속성명           데이터타입(크기)    NULL허용    키
        ------------------------------------------------
        E_EMP_NO           CHAR(4)         N.N      P.K/F.K
        S_SITE_NO          CHAR(4)         N.N      P.K/F.K
        ES_INSERT_DATE     DATE            N.N      
    
    solv)  
        CREATE TABLE WORK (    
        E_EMP_NO           CHAR(4)         NOT NULL,
        S_SITE_NO          CHAR(4)         NOT NULL,
        ES_INSERT_DATE     DATE            NOT NULL,
        
        CONSTRAINT pk_work PRIMARY KEY(E_EMP_NO, S_SITE_NO),
        CONSTRAINT fk_emp_work FOREIGN KEY(E_EMP_NO)
            REFERENCES EMP(E_EMP_NO),
        CONSTRAINT fk_site_work FOREIGN KEY(S_SITE_NO)
            REFERENCES SITE(S_SITE_NO));
            
    테이블 삭제
        DROP 명령 사용
        사용형식 : DROP <대상객체> <객체이름> 
    
    quiz) EMP 테이블을 삭제하세요.
        DROP TABLE WORK;
        DROP TABLE EMP; 
        -- EMP TABLE을 참조하는 WORK를 먼저 삭제해야 삭제가 가능하다
        -- CONSTRAINT를 삭제하여 EMP와 WORK의 관계를 삭제하고 EMP를 삭제한다.
        -- EMP TABLE(참조를 당하는 TABLE)은 WORK TABLE(참조를 하는 TABLE)가 삭제되기 전에 삭제될 수 없다.
        
                 
    