<2020-08-20>

    1. ROLLUP과 CUBE
          
          1-1. ROLLUP
            기본집계함수에서 제공하지 않는 부분별 소계를 제공한다.
            GROUP BY 절에서 사용한다.
            사용형식 : ROLLUP(c1, c2 ... )
            명시된 컬럼(c1, c2 ... )의 수와 순서(오른쪽 -> 왼쪽)에 따라 레벨별 집계결과를 반환한다.
            사용된 컬럼의 수가 n개이면 n+1레벨까지 하위레벨에서 상위레벨 순으로 집계를 반환한다.
            
                ex. KOR_LOAN_STATUS TABLE에서 기간별 지역별 대출잔액합계를 조회하시오.
                solution.
                    SELECT PERIOD,
                           REGION,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY ROLLUP(PERIOD, REGION)
                  ORDER BY 2;
            
            
                ex. 상품테이블에서 분류별, 거래처별, 매입가격 합계와 상품의 수를 조회하시오.
                solution.
                    SELECT PROD_LGU AS 분류,
                           PROD_BUYER AS 거래처,
                           SUM(PROD_COST) AS 매입가격,
                           COUNT(*) AS 상품개수
                      FROM PROD
                  GROUP BY PROD_LGU, PROD_BUYER
                  ORDER BY 1

                /*
                P101	P10101	930000	3
                P101	P10102	6450000	3
                P102	P10201	2130000	3
                P102	P10202	4230000	4
                P201	P20101	561000	12
                P201	P20102	1158000	9
                P202	P20201	547500	12
                P202	P20202	1192000	9
                P301	P30101	87000	4
                P302	P30201	266000	6
                P302	P30202	332000	6
                P302	P30203	123500	3
                */
                
                solution2.
                    SELECT PROD_LGU AS 분류,
                           PROD_BUYER AS 거래처,
                           SUM(PROD_COST) AS 매입가격,
                           COUNT(*) AS 상품개수
                      FROM PROD
                  GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
                  ORDER BY 1
                  
                /*
                P101	P10101	930000	3 <- PROD_LGU 기준 집계
                P101	P10102	6450000	3 <- PROD_BUYER 기준 집계
                P101	NULL    7380000	6 <- 전체집계
                P102	P10201	2130000	3
                P102	P10202	4230000	4
                P102	NULL    6360000	7
                P201	P20101	561000	12
                P201	P20102	1158000	9
                P201	NULL    1719000	21
                P202	P20201	547500	12
                P202	P20202	1192000	9
                P202	NULL    1739500	21
                P301	P30101	87000	4
                P301	NULL    87000	4
                P302	P30201	266000	6
                P302	P30202	332000	6
                P302	P30203	123500	3
                P302	NULL    721500	15 <- 전체 합계
                NULL    NULL    18007000 74 <- 전체 합계
                */
                
                

          1-2. CUBE
            ROLLUP과 비슷한 개념
            CUBE는 기술된 모든 컬럼을 조합할 수 있는 모든 가지수만큼의 합계를 반환한다.
            n개의 컬럼이 사용되면 2의 n승 종류만큼의 합계를 반환한다.
            
                ex. 대출잔액 테이블에서 기간별, 지역별, 구분별 대출잔액의 합계를 조회하시오.
                solution 1. 기본집계함수를 사용하는 경우
                    SELECT PERIOD AS 기간,
                           REGION AS 지역,
                           GUBUN AS 구분,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY PERIOD, REGION, GUBUN
                  
                solution 2. ROLLUP을 적용한 경우
                    SELECT PERIOD AS 기간,
                           REGION AS 지역,
                           GUBUN AS 구분,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY ROLLUP(PERIOD, REGION, GUBUN)
                  
                solution 3. CUBE를 적용한 경우
                    SELECT PERIOD AS 기간,
                           REGION AS 지역,
                           GUBUN AS 구분,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY CUBE(PERIOD, REGION, GUBUN)