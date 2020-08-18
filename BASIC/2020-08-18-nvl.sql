<2020-08-18>
    
    1. NULL처리 함수
    
        1-1. NVL
            주어진 자료가 NULL인지 판별하여 NULL인 경우 다른 값을 반환한다.
            사용형식 : NVL(col, val)
                col의 값이 NULL이면 val값을 반환하고, NULL이 아니면 col값을 반환한다.
                col과 val은 같은 값이어야 한다.
            
            ex. 상품테이블에서 PROD_COLOR가 NULL이면 '색상정보 없음'
                NULL이 아니면 색상을 출력하시오.
                (단, Alias는 상품명, 분류코드, 색상정보이다)
                
            solution.
                SELECT PROD_NAME AS 상품명,
                       PROD_LGU AS 분류코드,
                       PROD_COLOR,
                       NVl(PORD_COLOR, '색상정보 없음') AS 색상정보
                  FROM PROD;
                  
                  
            ex. 장바구니 테입블에서 모든 회원별 구매 현황을 조회하시오.
                (단, Alias는 회원번호, 회원명, 구매금액(수량 * 제품번호)이다)
                
            solution.
                SELECT B.MEM_ID AS 회원번호,    -- 테이블의 크기를 비교했을 때 큰 테이블을 사용
                       B.MEM_NAME AS 회원명,
                       NVL(SUM(C.PROD_PRICE * A.CART_QTY),0) AS 구매금액
                  FROM CART A
                 RIGHT OUTER JOIN MEMBER B  
                    ON(A.CART_MEMBER = B.MEM_ID AND A.CART_NO LIKE '200506%')
                  LEFT OUTER JOIN PROD C
                    ON(C.PROD_ID = A.CART_PROD)
              GROUP BY B.MEM_ID, B.MEM_NAME;
              
        1-2. NVL2
            사용형식 : NVL(c, r1, r2)
                c의 값이 NULL이면 r2를 반환하고, NULL이 아니면 r1의 값을 반환한다.
                r1, r2는 데이터 타입이 같아야 한다.
            
            ex. 회원테이블에서 회원의 성씨가 '이'씨인 회원들의 마일리지를 NULL로 바꾸시오.
            solution.
                SELECT MEM_NAME AS 이름
                  FROM MEMBER
                 WHERE MEM_NAME LIKE '이%'
                 
                UPDATE MEMBER
                   SET MEM_MILEAGE = NULL
                 WHERE MEM_NAME LIKE '이%'

            
            ex. 사원테이블에서 COMMISSION_PCT를 조사하여 NULL이면 영업실적란에 0을,
                NULL이 아니면 영업실적란에 %로 환산된 영업실적을 출력하시오.
                (단, Alias는 사원명, 부서코드, 직책코드, 영업실적이며 실적이 높은순으로 출력한다.)
                
            solution.
                SELECT NVL2(COMMISSION_PCT, COMMISSION_PCT*100||'%', 0) AS 영업실적,
                       DEPARTMENT_ID AS 부서코드,
                       JOB_ID AS 직책코드,
                       EMP_NAME AS 사원명
                  FROM EMPLOYEES
              ORDER BY COMMISSION_PCT DESC;
              
              
            ex. 회원테이블에서 회원의 마일리지가 NULL인 회원과 NULL이 아닌 회원을 판별하여
                NULL인 회원은 비고란에 '휴면회원', NULL이 아닌 회원은 '활동회원'을 비고란에 출력하시오.
                (단, Alias는 회원명, 마일리지, 비고이다)
            
            solution.
                SELECT NAME AS 회원명,
                       MEM_MILEAGE AS 마일리지,
                       NVL2(MEM_MILEAGE, '활동회원', '휴면회원') AS 비고
                  FROM MEMBER
                
                
                