<2020-07-22-02>
    테이블 수정
        ALTER 명령으로 수행
        컬럼 추가, 변경, 삭제
        테이블명 수정
        제약조건(기본키, 외래키) 추가, 삭제, 수정
        
    1. 테이블명 수정
        사용형식 : ALTER TABLE <대상 테이블명> RENAME TO <새로운 테이블명>
        ROLLBACK 대상이 아님
    
    quiz) EMP TABLE이름을 EMPLOYEE로 변경하세요.
    solv) ALTER TABLE EMP RENAME TO EMPLOYEE;
    
    2. 컬럼추가
        사용형식 : ALTER TABLE 테이블명
                    ADD <컬럼명> <데이터타입>[(크기)] [NOT NULL | NULL] [DEFAULT 값] --옵션순서는 바뀌어도 된다.
                    
    quiz) 사업장테이블(SITE)에 시공일자 컬럼을 추가하세요.
    solv) ALTER TABLE SITE 
            ADD S_START_DATE DATE DEFAULT SYSDATE --복수개의 컬럼을 추가할 수 있고, ADD를 생략하고 ','로 구분하여 작성하면 된다.
            
    3. 컬럼변경
        사용목적 : 컬럼의 데이터타입, 크기, 기본값을 변경하기 위해 사용한다.
        -- 데이터타입을 변경하기 위해서는 해당 컬럼에 데이터가 존재하면 안된다
        -- 데이터가 존재하는 컬럼의 데이터 타입을 바꾸기 위해서는 기존 자료를 삭제하고 진행해야한다.
        사용형식 : ALTER TABLE <테이블명> 
                    MODIFY <컬럼명> <데이터타입>[(크기)] [NOT NULL | NULL] [DEFAULT 값] --복수개의 경우 ADD와 동일한 방법으로 사용가능하다.
                    
    quiz) 사업장자재 테이블(SITE_ITEM)에서 자재이름(SI_ITEM_NAME)의 데이터 타입을 CHAR(70)으로 변경하세요.
    solv) ALTER TABLE SITE_ITEM
            MODIFY SI_ITEM_NAME CHAR(70)

    4. 컬럼명 변경
        사용목적 : 컬럼의 이름을 변경하기 위해 사용한다.
        사용형식 : ALTER TABLE <태이블명>
                    RENAME COLUMN <대상 컬럼명> TO <새로운 컬럼명>
        
    quiz) 사원테이블(EMPLOYEE)에서 사원의 주소(E_ADDRESS)컬럼명을 E_ADDR로 변경하세요.
    solv) ALTER TABLE EMPLOYEE
            RENAME COLUMN E_ADDRESS TO E_ADDR
            
    5. 컬럼 삭제
        사용목적 : 필요없다고 판단되는 컬럼을 삭제하기 위해 사용한다.
        사용형식 : ALTER TABLE <테이블명>
                    DROP COLUMN <컬럼명>
                    
    quiz) 사업장테이블(SITE)에서 시공일자컬럼(S_START_DATE)을 삭제하세요.
    solv) ALTER TABLE SITE
            DROP COLUMN S_START_DATE
            
    6. 제약조건 변경
        사용목적 : 기본키 및 외래키 설정 추가, 변경, 삭제 하기위해 사용한다.
        추가 사용형식 : ALTER TABLE <테이블명>
                        ADD CONSTRAINT <기본키설정명> PRIMARY KEY(컬럼명[, 컬럼명...]),
                        [CONSTRAINT <외래키설정명> FOREIGN KEY(컬럼명[, 컬럼명...])
                             REFERENCES 외부테이블명(컬럼명)];
                        
        수정 사용형식 : ALTER TABLE <테이블명>
                        MODIFY CONSTRAINT <기본키설정명> PRIMARY KEY(컬럼명[, 컬럼명...]),
                        [CONSTRAINT <외래키설정명> FOREIGN KEY(컬럼명[, 컬럼명...])
                                REFERENCES 외부테이블명(컬럼명)];
        
        삭제 사용형식 : DROP CONSTRAINT <기본키설정명>|<외래키설정명>;
                        