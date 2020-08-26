<2020-08-26>

    1. 집합연산자
        여러개의 SELECT문을 연결하여 하나의 쿼리문으로 만드는 역할을 수행한다.
        JOIN 대신 많이 사용된다.
        UNION, UNION ALL, INTERSECT, MINUS
        
        ** 제약사항
        집합연산자로 연결되는 각 SELECT문의 SELECT절에 사용되는 컬럼의 개수와 DATA TYPE은 일치해야 한다.
        ORDER BY절은 맨 마지막 SELECT문에서만 사용가능하다.
        BLOB, CLOB, BFILE타입의 컬럼에 대하여 집합 연산자 사용이 금지되어 있다.
        UNION, INTERSECT, MINUS 연산자는 LONG형 컬럼에는 사용할 수 없다.
        출력되는 컬럼은 첫 번째 SELECT문 기준이다.
        
        
        
        1-2. UNION
            합집합의 결과를 반환한다.
            사용형식 : SELECT 컬럼LIST 
                        FROM 테이블명1
                       WHERE 조건
                       UNION
                      SELECT 컬럼LIST 
                        FROM 테이블명2
                       WHERE 조건
                       -- 테이블1을 기준으로 출력된다.
                
                ex. 회원테이블에서 직업이 자영업이거나 마일리지가 4000이상인
                    회원의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
                    
                solution.
                    SELECT MEM_ID AS 회원번호,
                           MEM_NAME AS 회원이름,
                           MEM_JOB AS 직업,
                           MEM_MILEAGE AS 마일리지
                      FROM MEMBER
                     WHERE MEM_JOB = '자영업'
                     UNION
                    SELECT MEM_ID AS 회원번호,
                           MEM_NAME AS 회원이름,
                           MEM_JOB AS 직업,
                           MEM_MILEAGE AS 마일리지
                      FROM MEMBER
                     WHERE MEM_MILEAGE >= 4000
                     /*
                     위 예시와 같은경우 사용된 테이블이 한 개이기 때문에 OR로 연결해도 되지만
                     테이블을 두 개 이상 사용하는 경우에는 OR를 사용하지 못하기 때문에 UNION을 사용한다.
                     */
                     
                ex. 매입테이블과 매출테이블에서 2005년 5월 제품별 매입수량과 매출수량을 조회하시오.
                    (단, Alias는 제품코드, 제품명, 매입/매출수량이다)
                    
                solution 1. 집합연산자를 사용하지 않는 경우
                    SELECT 
                      FROM (제품별 매출수량) A, 
                           (제품별 매입수량) B
                     WHERE A.상품코드 = B.상품코드
                     
                solutin 1-1. 서브쿼리 작성 (제품별 매출수량)
                    SELECT CART_PROD AS CID,
                           SUM(CART_QTY) AS CAMT
                      FROM CART
                     WHERE CART_NO LIKE '200505%'
                  GROUP BY CART_PROD
                  ORDER BY 1
                    
                solutin 1-2. 서브쿼리 작성 (제품별 매입수량)
                    SELECT BUY_PROD AS BID,
                           SUM(BUY_QTY) AS BAMT
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
                  GROUP BY BUY_PROD
                  ORDER BY 1
                  
                solution 1-3. 쿼리작성
                    SELECT C.PROD_ID AS 제품코드,
                           C.PROD_NAME AS 제품명,
                           B.BAMT AS 매입수량,
                           A.CAMT AS 매출수량
                      FROM (SELECT CART_PROD AS CID,
                                   SUM(CART_QTY) AS CAMT
                              FROM CART
                             WHERE CART_NO LIKE '200505%'
                          GROUP BY CART_PROD
                          ORDER BY 1) A, 
                           (SELECT BUY_PROD AS BID,
                                   SUM(BUY_QTY) AS BAMT
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
                          GROUP BY BUY_PROD
                          ORDER BY 1) B,
                           PROD C
                     WHERE A.CID = B.BID(+)
                       AND C.PROD_ID = A.CID
                
                
                solution 2. 집합연산자를 사용하는 경우
                    SELECT CART_PROD AS 제품코드,
                           PROD_NAME AS 제품명,
                           SUM(CART_QTY) AS 매출수량
                      FROM CART, PROD
                     WHERE CART_PROD = PROD_ID
                       AND CART_NO LIKE '200505%'
                  GROUP BY CART_PROD, PROD_NAME
                  
                 UNION ALL
                    SELECT BUY_PROD AS 제품코드,
                           PROD_NAME AS 제품명,
                           SUM(BUY_QTY) AS 매입수량
                      FROM BUYPROD, PROD
                     WHERE BUY_PROD = PROD_ID
                       AND BUY_DATE BETWEEN '20050501' AND0
                       '20050531'
                  GROUP BY BUY_PROD, PROD_NAME