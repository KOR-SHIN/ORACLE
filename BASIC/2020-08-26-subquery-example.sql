<2020-08-26>

    ex) 모든 거래처별 2005년 매입정보를 조회하시오.
        출력은 거래처코드, 거래처명, 매입정보
        
    solution 1. 메인쿼리 판단
        최종 산출물은 거래처코드, 거래처명, 매입정보이다.
        
    solution 1-1. 메인쿼리 작성
        SELECT A.BUYER_ID AS 거래처코드,
               A.BUYER_NAME AS 거래처명,
               B. AS 매입금액
          FROM BUYER A, (2005년도 매입정보) B
         WHERE A.BUYER_ID = B.거래처코드(+)
      ORDER BY 1;
      --OUTER JOIN을 할 때는 NULL값을 방지하기 위해 SELEC절에서 가장 많은 컬럼을 가진 테이블을 써야한다.
      
    solution 2. 서브쿼리 판단
        2005년도 매입정보를 서브쿼리로 작성한다.
        
    solution 2-1. 서브쿼리 작성
        SELECT A.BUYER_ID AS DID,
               SUM(B.BUY_QTY * B.BUY_COST) AS IAMT
          FROM BUYER A, BUYPROD B, PROD C
         WHERE A.BUYER_ID = C.PROD_BUYER
           AND B.BUY_PROD = C.PROD_ID
           AND B.BUY_DATE BETWEEN '20050101' AND '20051231'
      GROUP BY A.BUYER_ID
      ORDER BY 1
      
      solution 3. 쿼리 작성
        SELECT A.BUYER_ID AS 거래처코드,
               A.BUYER_NAME AS 거래처명,
              NVL(B.IAMT, 0) AS 매입금액
          FROM BUYER A, (SELECT A.BUYER_ID AS DID,
                                SUM(B.BUY_QTY * B.BUY_COST) AS IAMT
                           FROM BUYER A, BUYPROD B, PROD C
                          WHERE A.BUYER_ID = C.PROD_BUYER
                            AND B.BUY_PROD = C.PROD_ID
                            AND B.BUY_DATE BETWEEN '20050101' AND '20051231'
                       GROUP BY A.BUYER_ID
                          ) B
         WHERE A.BUYER_ID = B.DID(+)
         -- 일반 OUTER JOIN이기 때문에 종류가 부족한쪽에 (+)연산자를 사용한다.
      ORDER BY 1;
      
      
    ex) 모든 거래처별 2005년도 매출금액을 조회하시오.
        출력은 거래처코드, 거래처명, 매출액이다.
        -- 거래처가 납품한 제품이 얼만큼 팔렸는지 조회하는 문제
        -- 모든 거래처별이기때문에 거래처 테이블이 중심이다.
        
    solution 1. 메인쿼리 판단
        최종 산출물은 거래처코드, 거래처명, 매출액이다.
        거래처별 매출이기때문에 BUYER TABLE이 중심이된다.
        
    solution 1-1. 메인쿼리 작성
        SELECT A.BUYER_ID AS 거래처코드,
               A.BUYER_NAME AS 거래처명, 
               B. AS 매출액
          FROM BUYER A, (2005년도 거래처별 매출) B
          -- B TABLE은 모든 거래처가 아니라 매출이 발생한 거래처만 출력한다.
         WHERE A.BUYER_ID = B.거래처코드(+)
      ORDER BY 1
         
    solution 2. 서브쿼리 판단
        2005년도 거래처별 매출금액을 구하는 부분을 서브쿼리로 작성한다.
        모든 거래처가 아닌 매출이 발생된 거래처만 출력된다.
        
    solution 2-1. 서브쿼리 작성
        SELECT C.BUYER_ID AS DID,
               SUM(D.CART_QTY * E.PROD_PRICE) AS IAMT
          FROM BUYER C, CART D, PROD E
         WHERE D.CART_PROD = E.PROD_ID
           AND E.PROD_BUYER = C.BUYER_ID
      GROUP BY C.BUYER_ID
        
    solution 3. 쿼리작성
        SELECT A.BUYER_ID AS 거래처코드,
               A.BUYER_NAME AS 거래처명, 
               NVL(B.OAMT, 0) AS 매출액
          FROM BUYER A, (
                        SELECT C.BUYER_ID AS DID,
                               SUM(D.CART_QTY * E.PROD_PRICE) AS OAMT
                          FROM BUYER C, CART D, PROD E
                         WHERE D.CART_PROD = E.PROD_ID
                           AND E.PROD_BUYER = C.BUYER_ID
                      GROUP BY C.BUYER_ID
                        ) B
          WHERE A.BUYER_ID = B.DID(+)
       ORDER BY 1
