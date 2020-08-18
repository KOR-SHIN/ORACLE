<2020-08-18>

    1. 집계함수
        데이터를 특정 컬럼을 기준으로 같은 값을 갖는 것끼리 그룹화시키고 이를 기준으로 합(SUM), 평균(AVg), 개수(행의 수, COUNT), 최대값(MAX), 최소값(MIN)을 구하는 함수
        GROUP BY 절을 사용한다.
        집계함수에 조건이 부여될 경우 HAVING 절 사용
        SELECT 절에 기술된 그룹함수가 아닌 일반컬럼은 반드시 GROUP BY절에 기술되어야 함
        
        ex. 사원테이블에서 부서별 급여합계를 구하시오.
        solution.
            SELECT EMPLOYEE_ID AS 사원번호,
                   DEPARTMENT_ID AS 부서코드,
                   SALARY AS 급여,
                   SUM(SALARY) AS 급여합계
              FROM EMPLOYEES
          GROUP BY DEPARTMENT_ID, EMPLOYEE_ID, SALARY
          ORDER BY 1 DESC;
          
          
          ex. 상품테이블에서 분류별 가격의 합계를 구하시오.
              (단, Alias는 분류코드, 분류명, 가격합계이다)
              
          solution.
            SELECT A.PROD_LGU AS 분류코드,
                   B.LPROD_NM AS 분류명,
                   SUM(A.PROD_PRICE) AS 가격합계
              FROM PROD A, LPROD_ B
             WHERE A.PROD_LGU = B.LPROD_GU
          GROUP BY A.PROD_LGU, B.LPROD_NM
          ORDER BY 1;
          
          ex. 회원테이블에서 성별 마일리지 합계를 구하시오.
              (단, Alias는 성별, 마일리지 합계이다)
          
          solution.
            SELECT CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' OR
                             SUBSTR(MEM_REGNO2, 1, 1) = '3' TEHN '남성회원
                        ELSE '여성회원 END AS 성별,
                   SUM(MEM_MILEAGE) AS "마일리지 합계"
              FROM MEMBER
          GROUP BY SUBSTR(MEM_REGNO2, 1, 1)
          
          ex. 2005년 3월 거래처별 매입급액합계를 구하시오.
              (단, Alias는 거래처코드, 거래처명, 매입액이다)
              
          solution.
            SELECT A.BUYER_ID AS 거래처코드,
                   A.BUYER_NAME AS 거래처명,
                   SUM(B.BUY_QTY * C.PROD_COST) AS 매입액
              FROM BUYER A, BUYPROD D, PROD C
             WHERE A.BUYER_ID = C.PROD_ID
               AND B.BUY_PROD = C.PROD_ID
               AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
          GROUP BY A.BUYER_ID, A.BUYER_NAME
          ORDER BY 1;
          
          
          ex. 회원테이블에서 모든 여성회원의 마일리지 합계를 구하시오.
          
          solution.
            SELECT SUM(MEM_MILEAGE) AS "마일리지 합계",
              FROM MEMBER
             WHERE SUBSTR(REGNO2, 1, 1) = '2'
                OR SUBSTR(REGNO2, 1, 1) = '4'
                
                
          QUIZ. 2005년 5월 회원별 판매수량 합계를 구하되, 판매수량합계가 20개 이상인 회원만 조회하시오.
          
          solution. 
            SELECT CART_MEMBER AS 회원번호,
                   SUM(CART_QTY) AS "판매수량 합계"
              FROM CART
             WHERE CART_NO LIKE '200505%'
          GROUP BY CART_MEMBER
            HAVING SUM(CART_QTY) >= 20
          ORDER BY 1;
          
          