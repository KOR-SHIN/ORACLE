<2020-08-27>

    ** 다음 조건에 맞는 재고수불테이블을 생성하시오.
    
        테이블명  REMAIN
             컬럼명             데이터 타입              NULL ABLE               제약사항
        ------------------------------------------------------------------------------------
        REMAIN_YEAR             CHAR(4)                 NOT NULL                PK
        REMAIN_PROD             VARCHAR2(10)            NOT NULL                PK, FK
        REMAIN_J_00             NUMBER(5)               
        REMAIN_I                NUMBER(5)
        REMAIN_O                NUMBER(5)
        REMAIN_J_99             NUMBER(5)
        REMAIN_DATE             DATE
        ------------------------------------------------------------------------------------
        REMAIN_J_00 : 기초재고
        REMAIN_I    : 입고수량
        REMAIN_O    : 출고수량
        REMAIN_J_99 : 기말재고 (기초재고 + 입고수량 - 출고수량)
        
        CREATE TABLE REMAIN(
            REMAIN_YEAR CHAR(4),
            REMAIN_PROD VARCHAR2(10),
            REMAIN_J_00 NUMBER(5),
            REMAIN_I NUMBER(5),
            REMAIN_O NUMBER(5),
            REMAIN_J_99 NUMBER(5),
            REMAIN_DATE DATE,
            
            CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, REMAIN_PROD),
            CONSTRAINT fk_ramain FOREIGN KEY(REMAIN_PROD)
                        REFERENCES PROD(PROD_ID));
                        
                        
    ** REMAIN 테이블에 다음 조건에 맞도록 자료를 PROD 테이블로부터 입력하시오.    
        (HINT. 서브쿼리가 사용된 INSERT문으로 일괄입력 해야한다 / 서브쿼리로 INSERT문을 작성할 때는 'VALUES'와 '( )'가 생략된다)
            INSERT INTO REMAIN(REMAIN_YEAR, REMAIN_PROD, REMAIN_J_00,
                              REMAIN_I, REMAIN_O, REMAIN_J_99, REMAIN_DATE)
                 SELECT '2005', PROD_ID, PROD_PROPERSTOCK,
                         0, 0, PROD_PROPERSTOCK, '20050103'
                   FROM PROD;
                    
    ** REMAIN 테이블에 정보가 삽입되었는지 확인하시오.
        SELECT * FROM REMAIN
                          
    ** 원본테이블을 보존하기 위해 테이블을 복사하시오 (제약사항<pk, fk>은 복사가 불가능하다)
        CREATE TABLE REMAIN1 AS 
        SELECT * FROM REMAIN
        
    ** 복사 테이블에 정보가 삽입되었는지 확인하시오.
        SELECT * FROM REMAIN1

    ** UPDATE (REVIEW)
        단순 UPDATE는 한 개의 데이터를 UPDATE하는 경우
            UPDATE 테이블명
               SET 컬럼명=값[,
                   컬렴명=값[,
                   ...컬럼명=값]
            [WHERE 조건];
            
        UPDATE문 줄여쓰는 경우
            UPDATE 테이블명
               SET (컬럼명1, 컬럼명2, 컬럼명3 ...) =
                   (값1, 값2, 값3 ...)
            [WHERE 조건];
        
        서브쿼리를 이용하여 값을 일괄적으로 UPDATE 경우
            UPDATE 테이블명
               SET (컬럼명1, ...) = (서브쿼리)
             [WHERE 조건];
            /* '(컬럼명1, ...)'의 컬럼 갯수 및 순서와 서브쿼리의 SELECT 절의 컬럼의 갯수 및 순서가 동일해야 한다 */
            
    
    ex. 2005년 1월 입고상품을 조회하여 재고수불테이블 값을 변경하시오.
    
    solution 1. 1월에 입고된 상품의 상품코드, 상품수량 조회
        SELECT BUY_PROD, SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
      GROUP BY BUY_PROD
      
    solution 2. UPDATE 수행
        UPDATE REMAIN A
           SET (A.REMAIN_I,
                A.REMAIN_J_99,
                A.REMAIN_DATE) = (SELECT B.IAMT, 
                                         REMAIN_J_00 + B.IAMT - REMAIN_O,
                                         '20050131'
                                    FROM (    SELECT PROD_ID, 
                                                     NVL(SUM(BUY_QTY), 0) AS IAMT
                                                FROM BUYPROD
                                    RIGHT OUTER JOIN PROD
                                                  ON (BUY_PROD = PROD_ID)
                                                 AND BUY_DATE BETWEEN '20050101' AND '20050131'
                                               GROUP BY PROD_ID) B
                                   WHERE B.PROD_ID = A.REMAIN_PROD)
         WHERE REMAIN_YEAR = '2005'
         
    ROLLBACK
         UPDATE REMAIN A
           SET (A.REMAIN_I,
                A.REMAIN_J_99,
                A.REMAIN_DATE) = (SELECT B.IAMT, 
                                         REMAIN_J_00 + B.IAMT - REMAIN_O,
                                         '20050331'
                                    FROM (    SELECT PROD_ID, 
                                                     NVL(SUM(BUY_QTY), 0) AS IAMT
                                                FROM BUYPROD
                                    RIGHT OUTER JOIN PROD
                                                  ON (BUY_PROD = PROD_ID)
                                                 AND BUY_DATE BETWEEN '20050101' AND '20050331'
                                               GROUP BY PROD_ID) B
                                   WHERE B.PROD_ID = A.REMAIN_PROD)
         WHERE REMAIN_YEAR = '2005'
         
         SELECT * FROM REMAIN
         
      
      
      
      
      
      