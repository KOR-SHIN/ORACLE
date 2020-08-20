
        1. AVG
            사용형식 : AVG(expr)
            expr은 컬럼명이나 수식이다.
            그룹핑된 expr에 저장된 값에 대한 평균을 반환한다.

                ex. 사원테이블에서 각 부서별 평균 평균급여를 구하시오.
                solution.
                    SELECT DEPARTMENT_ID AS 부서코드,
                           ROUND(AVG(SALARY), 1) AS 평균급여
                      FROM EMPLOYEES
                  GROUP BY DEPARTMENT_ID
                  ORDER BY 1
                  
                  ex. 매입테이블(BUYPROD)에서 2005년 3월 제품별 평균 매입수량을 조회하시오.
                  solution.
                      SELECT BUY_PROD AS 제품코드,
                             ROUND(AVG(BUY_QTY)) AS "평균 매입수량",
                             ROUND(AVG(BUY_QTY * BUY_COST)) AS "평균 매입금액"
                        FROM BUYPROD
                       WHERE BUY_DATE BETWEEN '20050301' AND '20050331'
                    GROUP BY BUY_PROD
                    ORDER BY 1
                  /* BUY_PROD는 일반 컬럼이고, 나머지 2개는 집계함수이다.
                     집계함수와 일반컬럼이 함께 사용되면, 반드시 GROUP BY를 사용해야 한다.*/
                     
                     
                   QUIZ. 회원테이블에서 50대 회원 성별 평균 마일리지를 구하시오.
                   solution.
                        SELECT CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' THEN '남성회원'
                                    WHEN SUBSTR(MEM_REGNO2, 1, 1) = '2' THEN '여성회원' END AS 성별,
                               ROUND(AVG(MEM_MILEAGE)) AS "마일리지 평균"
                          FROM MEMBER
                         WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) BETWEEN 50 AND 59
                      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' THEN '남성회원'
                                    WHEN SUBSTR(MEM_REGNO2, 1, 1) = '2' THEN '여성회원' END
                                    /*GROUP BY절에는 SELECT절에 사용된 일반컬럼을 그대로 기술해야 한다*/
                    
                    
                    QUIZ. 장바구니테이블에서 2005년 5월 회원별 평균매출액을 구하시오.
                          평균매출액이 100만원 이상인 회원만 조회하시오. 
                          (단, Alias는 회원번호, 평균 매출액)

                    solution.
                        SELECT CART_MEMBER AS 회원번호,
                               TO_CHAR(AVG(CART_QTY * PROD_PRICE), '99,999,999') AS 평균매출액
                          FROM CART A, PROD B
                         WHERE CART_PROD = PROD_ID
                           AND SUBSTR(CART_NO,1 , 8) BETWEEN '20050501' AND '20050531'
                      GROUP BY CART_MEMBER
                        HAVING AVG(CART_QTY * PROD_PRICE) >= 1000000
                
                    QUIZ. 사원테이블에서 부서별 사원들의 평균 근속년수를 구하고 근속년수가 가장 많은 부서 3개만 출력하시오.
                          /*ROWNUM은 WHERE절에서만 사요가능하다*/
                    solution.
                        SELECT A.DID AS 부서번호,
                               B.DEPARTMENT_ID AS 부서명,
                               ROUND(A.AVGCNT) AS 평균근속년수
                          FROM DEPARTMENTS B, (SELECT DEPARTMENT_ID DID,
                                                      AVG(EXTRACT(YEAR FROM SYSDATE) -
                                                          EXTRACT(YEAR FROM HIRE_DATE)) AS AVGCNT
                                                 FROM EMPLOYEES
                                             GROUP BY DEPARTMENT_ID
                                             ORDER BY 2 DESC) A
                          WHERE A.DID = B.DEPARTMENT_ID
                            AND ROWNUM <= 3;
                        /*
                        FROM절이 가장 먼저 수행되기 때문에
                        SELECT절이 수행되기 전에 서브쿼리가 먼저 실행된다.
                        따라서 마지막에 수행되는 SELECT절에서 서브쿼리의 컬럼 별칭을 사용가능하다.
                        서브쿼를 사용하면 테이블을 두 개 사용하는 것이다 -> 조인 -> 조인조건을 넣어줘야함.
                        
                        서브쿼리를 사용한 이유
                        서브 쿼리를 사용하지 않으면, 실행순서로 인해 ROWNUM 조건이 제대로 수행되지 않는다.
                        */