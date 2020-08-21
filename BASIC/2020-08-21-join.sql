<2020-08-20>

    1. JOIN
        RDB의 핵심 기능이다.
        조회할 컬럼이 여러 개의 테이블에 분산되어 저장 된 경우,
        테이블 사이의 관계(Relationship)을 이용하여 검색할 때 사용한다.
        
        일반 JOIN과 ANSI JOIN으로 구분된다.
        관계가 맺어지지 않은 테이블간의 JOIN은 절대 발생하지 않는다. (직접관계, 간접관계 모두 가능)
        
        ** 관계 : A 테이블의 기본키가 B 테이블의 외래키로 사용되는 경우
        ** 비식별 : A테이블의 기본키가 B 테이블의 일반 항목으로 들어가 있는 경우
        ** 식별자관계 : A테이블의 기본키가 B 테이블의 외래키이자 기본키인 경우 (A <- B 상속관계)
        
        1-1. Cartesian Product
            모든 행들의 조합을 결과로 반환한다.
                ex. A 테이블이 100행 20열, B 테이블이 2000행 10열로 구성되었다면,
                    A, B 테이블의 Cartesian Product 결과는 200000행, 30열로 결과값을 반환한다.
            JOIN조건이 없는 경우, JOIN조건을 잘못 기술한 경우, Cartesian Product가 실행된다.
            ANSI에서는 CROSS JOIN이라고 부른다.
            불가피한 경우가 아니라면, Cartesian Product는 사용하지 않는다.
            
                ex. CART TABLE의 행의 수
                    SELECT COUNT(*) FROM CART;
                    
                ex. MEMBER TABLE의 행의 수
                    SELECT COUNT(*) FROM MEMBER;
                    
                ex. CART TABLE과 MEMBER TABLE에 Cartesian Product를 수행
                    SELECT COUNT(*)
                      FROM MEMBER, CART
                      
        1-2. Equi-JOIN
            JOIN조건에 '='연산자를 사용하는 조인형식
            조인조건은 사용된 테이블의 갯수가 n개일 경우, JOIN조건은 적어도 n-1개 이상이어야 한다.
            내부조인이라고 부르기도 한다.
            일치하지 않는 데이터(행 단위)는 무시하여 결과로 나타내지 않는다.
            ANSI에서는 INNER JOIN이라고 한다.
            
                ex. 일반조인
                    SELECT <컬럼 LIST>
                      FROM <테이블 이름 [별칭]>, <테이블 이름 [별칭]>
                     WHERE <JOIN 조건 1>
                      [AND <JOIN 조건 2>]
                      
                ex. ANSI 조인
                    SELECT <컬럼 LIST>
                      FROM <테이블 1 이름 [별칭]>
                INNER JOIN <테이블 2 이름> ON (조인 조건 1)
                      [AND <일반 조건>]
                    [WHERE <일반 조건>]
               [INNER JOIN <테이블 3 이름> ON (조인 조건 1) <- 테이블 1과 테이블 2의 조인결과와 테이블 3을 조인하는 것
                      [AND <일반 조건>]
                    [WHERE <일반 조건>]]
                    
                    
                    
                ex. 사원테이블에서 사원정보를 조회하시오.
                    (단, Alias는 사원번호, 사원명, 부서코드, 부서명)
                
                solution 1. 일반조인 
                    SELECT EMPLOYEE_ID AS 사원번호,
                           EMP_NAME AS 사원이름,
                           B.DEPARTMENT_ID AS 부서코드,
                           DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  ORDER BY B.DEPARTMENT_ID
                  
                solution 2. ANSI 조인
                    SELECT A.EMPLOYEE_ID AS 사원번호,
                           A.EMP_NAME AS 사원이름,
                           A.DEPARTMENT_ID AS 부서코드,
                           B.DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A
                INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
                  ORDER BY B.DEPARTMENT_ID
                  
                
                ex. 사원테이블에서 100번 부서의 사원정보를 조회하시오.
                    (단, Alias는 사원번호, 사원명, 부서코드, 부서명)
                    
                solution 1. 일반조인
                    SELECT EMPLOYEE_ID AS 사원번호,
                           EMP_NAME AS 사원이름,
                           B.DEPARTMENT_ID AS 부서코드,
                           DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                       AND A.DEPARTMENT_ID = 100
                                         
                solution 2. ANSI 조인
                    SELECT A.EMPLOYEE_ID AS 사원번호,
                           A.EMP_NAME AS 사원이름,
                           A.DEPARTMENT_ID AS 부서코드,
                           B.DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A
                INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
                     WHERE A.DEPARTMENT_ID = 100
                
                
                ex. 2005년 6월 상품별 매출현황을 조회하시오.
                    (단, Alias는 상품코드, 상품명, 금액이다)
                    
                solution 1. 일반조인
                    SELECT B.PROD_ID AS 상품코드,
                           B.PROD_NAME AS 상품명,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS 금액                          
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO BETWEEN '20050601' AND '20050630'
                  GROUP BY B.PROD_ID, B.PROD_NAME
                  ORDER BY 1
                  
                solution 2. ANSI 조인
                    SELECT B.PROD_ID AS 상품코드,
                           B.PROD_NAME AS 상품명,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS 금액                          
                      FROM CART A
                INNER JOIN PROD B ON (A.CART_PROD = B.PROD_ID)
                     WHERE A.CART_NO BETWEEN '20050601' AND '20050630'
                  GROUP BY B.PROD_ID, B.PROD_NAME
                  ORDER BY 1
                  
                  
                ex. 매입테이블에서 2005년 3월 거래처별 매입현황을 조회하시오.
                    (단, Alias는 거래처코드, 거래처명, 매입금액합계이다)
                    
                solution 1. 일반조인
                    SELECT B.BUYER_ID AS 거래처코드,
                           B.BUYER_NAME AS 거래처명,
                           SUM(A.BUY_COST*A.BUY_QTY) AS 매입금액합계
                      FROM BUYPROD A, BUYER B, PROD C
                     WHERE A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331')
                       AND A.BUY_PROD = C.PROD_ID
                       AND B.BUYER_ID = C.PROD_BUYER
                  GROUP BY B.BUYER_NAME, B.BUYER_ID
                  ORDER BY 1
                  
                ex. 매입테이블에서 2005년 3월 거래처별 매입현황을 조회하시오.
                    (단, Alias는 거래처코드, 거래처명, 매입금액합계이다)
                    
                solution 2. ANSI 조인
                    SELECT B.BUYER_ID AS 거래처코드,
                           B.BUYER_NAME AS 거래처명,
                           SUM(A.BUY_COST*A.BUY_QTY) AS 매입금액합계
                      FROM BUYPROD A
                INNER JOIN PROD C ON(A.BUY_PROD = C.PROD_ID)
                /* BUYER TABLE과 BUYPROD TABLE은 JOIN이 안됨으로 BUYPROD TABLE과 PROD TABLE을 먼저 JOIN해야한다. */
                INNER JOIN BUYER B ON(C.PROD_BUYER = B.BUYER_ID)
                     WHERE A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331')
                  GROUP BY B.BUYER_NAME, B.BUYER_ID
                  ORDER BY 1
                  
                  
                ex. 2005년 5월 상품별 매입/매출 정보를 조회하시오.
                    (단, Alias는 상품코드, 상품명, 매입수량, 매출수량이다)
                    
                solution 1. 일반 조인
                    SELECT C.PROD_ID AS 상품코드,
                           C.PROD_NAME AS 상품명,
                           SUM(A.BUY_QTY) AS 매입수량,
                           SUM(B.CART_QTY) AS 매출수량
                      FROM BUYPROD A, CART B, PROD C
                     WHERE A.BUY_PROD = C.PROD_ID
                       AND C.PROD_ID = B.CART_PROD
                       -- PROD TABLE과 CART TABLE은 직접관계가 없으므로, PROD TABLE을 이용한다.
                       AND B.CART_NO LIKE '200505%'
                        OR A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
                  GROUP BY C.PROD_ID, C.PROD_NAME
                  ORDER BY 1
                  
                  solution 2. 일반조인에서의 OUTER JOIN
                    SELECT C.PROD_ID AS 상품코드,
                           C.PROD_NAME AS 상품명,
                           SUM(A.BUY_QTY) AS 매입수량,
                           SUM(B.CART_QTY) AS 매출수량
                      FROM BUYPROD A, CART B, PROD C
                     WHERE A.BUY_PROD(+) = C.PROD_ID
                       AND C.PROD_ID = B.CART_PROD(+)
                       -- PROD TABLE과 CART TABLE은 직접관계가 없으므로, PROD TABLE을 이용한다.
                       AND B.CART_NO LIKE '200505%'
                       AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
                  GROUP BY C.PROD_ID, C.PROD_NAME
                  ORDER BY 1
                  
                  /*
                  일반조인에서 OUTER JOIN은 종류의 개수가 부족한 쪽에 JOIN조건에 (+)를 넣어주는 것
                  하지만 일반조인은 가끔 부정확한 결과를 출력하거나 기능이 부족하다.
                  따라서 서브쿼리를 사용하거나 ANSI조인을 사용해야 한다.
                  */
                  
                  solution 1. ASNI 조인에서의 OUTRE JOIN
                    SELECT C.PROD_ID AS 상품코드,
                           C.PROD_NAME AS 상품명,
                           NVL(SUM(A.BUY_QTY), 0) AS 매입수량,
                           NVL(SUM(B.CART_QTY), 0) AS 매출수량
                      FROM BUYPROD A
          RIGHT OUTER JOIN PROD C ON(A.BUY_PROD = C.PROD_ID
                                     AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531'))
           LEFT OUTER JOIN CART B ON(C.PROD_ID = B.CART_PROD
                                     AND B.CART_NO LIKE '200505%')
                  GROUP BY C.PROD_ID, C.PROD_NAME
                  ORDER BY 1
                  /*
                  RIGHT OUTER JOIN은 BUYPROD와 PROD중 오른쪽에 위치한 PROD가 종류가 더 많다는 것이다.
                  LEFT OUTER JOIN은 CART와 PROD 중 왼쪽에 위치한 PROD가 종류가 더 많다는 것이다.
                  */
                  
                  solution 4. SUBQUERY 작성법
                    SELECT A.PROD_ID AS 상품코드,
                           A.PROD_NAME AS 상품명,
                           NVL(B.INAMT, 0) AS 매입수량,
                           NVL(C.OUTAMT, 0) AS 매출수량
                      FROM PROD A,(
                            SELECT BUY_PROD AS BID,
                                   SUM(BUY_QTY) AS INAMT
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
                          GROUP BY BUY_PROD) B, (
                          SELECT CART_PROD AS CID,
                                 SUM(CART_QTY) AS OUTAMT
                            FROM CART
                           WHERE CART_NO LIKE '200505%'
                        GROUP BY CART_PROD) C
                      WHERE A.PROD_ID = B.BID(+)
                        AND A.PROD_ID = C.CID(+)
                   ORDER BY 1;
                          
                          
                          
        1-2. SEMI JOIN
            세미조인은 서브쿼리를 사용하여 서브쿼리에 존재하는 데이터만 메인쿼리에서 추출하는 조인이다.
            EXISTS 연산자가 사용된다.
            
                ex. 사원테이블에서 급여가 8000이상인 사원이 있는 부서를 조회하시오.
                    (단, Alias는 부서코드, 부서명, 상위부서코드이다)
                    
                solutin 1. SUBQUERY JOIN
                    SELECT A.DEPARTMENT_ID AS 부서코드,
                           A.DEPARTMENT_NAME AS 부서이름,
                           A.PARENT_ID AS 상위부서코드
                      FROM DEPARTMENTS A
                     WHERE A.DEPARTMENT_ID IN 
                          (SELECT B.DEPARTMENT_ID
                             FROM EMPLOYEES B
                            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                              AND B.SALARY >= 8000)
                  ORDER BY 1;
                  
                  solutin 2. SEMI JOIN
                    SELECT A.DEPARTMENT_ID AS 부서코드,
                           A.DEPARTMENT_NAME AS 부서이름,
                           A.PARENT_ID AS 상위부서코드
                      FROM DEPARTMENTS A
                     WHERE EXISTS (SELECT B.DEPARTMENT_ID
                                    /*
                                    EXISTS를 사용할 때 SELECT절에서는 1을 사용한다.
                                    의미없는 숫자를 이용하여 서브쿼리의 내용이 참인지 구분하는 것이다. 
                                    */
                                     FROM EMPLOYEES B
                                    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                                      AND B.SALARY >= 8000)
                  ORDER BY 1;