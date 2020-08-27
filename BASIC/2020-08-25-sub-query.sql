<2020-08-25>

    1. 서브쿼리(sub-query)
        SQL문장 안에서 보조로 사용되는 또 다른 쿼리
            **최종 산출물을 내기 위한 메인쿼리를 보조해준다. (중간 계산결과를 저장하고 있다가 메인쿼리에 사용한다.)
        서브쿼리는 반드시 '( )'안에 기술해야 한다.
        FROM절의 서브쿼리는 독립실행이 가능해야 한다 (FROM절이 가장 먼저 실행되기 때문이다)
        서브쿼리를 사용할 때, 메인쿼리에 무엇을 출력해야하는지 생각해야한다.
        
        1-1. 서브쿼리 분류 기준 
            연관성 여부 
                연관성 없는 서브쿼리 : 메인쿼리와 서브쿼리에 사용된 테이블이 JOIN으로 연결되지 않은 서브쿼리
                    ex. 회원테이블에서 평균마일리지보다 많은 마일리지를 보유한 회원의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
                        
                    solution 1. 메인쿼리 판단
                        회원테이블에서 회원의 회원번호, 회원명, 직업, 마일리지를 출력해야 한다.
                        
                    solution 1-1. 메인쿼리 작성
                        SELECT MEM_ID AS 회원번호,
                               MEM_NAME AS 회원명,
                               MEM_JOB AS 직업,
                               MEM_MILEAGE AS 마일리지
                          FROM MEMBER
                         WHERE MEM_MILEAGE > (평균 마일리지)
                        
                    solution 2-1. 서브쿼리 판단
                        WHERE절에서 집계함수 AVG를 사용불가 하기때문에, 메인쿼리에서 평균 마일리지를 계산할 수 없다.
                        따라서 서브쿼리를 사용해서 평균 마일리지를 구한다.
                        
                    solution 2-2. 서브쿼리 작성
                        SELECT AVG(MEM_MILEAGE)
                          FROM MEMBER
                          
                    solution 3. 쿼리작성
                        SELECT MEM_ID AS 회원번호,
                               MEM_NAME AS 회원명,
                               MEM_JOB AS 직업,
                               MEM_MILEAGE AS 마일리지
                          FROM MEMBER
                         WHERE MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE) 
                                                FROM MEMBER)
                    /* 
                    위의 예시에서는 서브쿼리가 회원수만큼 실행되기 때문에 성능에 영향을 미친다
                    WHERE절에서 서브쿼리가 실행됐기 때문에 중첩 서브쿼리이다.
                    */
                    
                    solution 4. IN-LINE 서브쿼리 작성
                        SELECT MEM_ID AS 회원번호,
                               MEM_NAME AS 회원명,
                               MEM_JOB AS 직업,
                               MEM_MILEAGE AS 마일리지
                          FROM MEMBER, (SELECT AVG(MEM_MILEAGE) AS AMILE
                                          FROM MEMBER) A
                         WHERE MEM_MILEAGE > A.AMILE
                    /* 
                    FROM절은 쿼리에서 가장 먼저 실행되고, 위의 예시에서의 서브쿼리는 단 한번만 실행된다. (비교횟수는 회원수)
                    FROM절에서 서브쿼리가 실행됐기 때문에 IN-LINE 서브쿼리이다.                 
                    */
                    
                    
                    ex. 부서테이블에서 상위부서코드가 NULL인 부서에 소속된 사원수를 조회하시오.
                    solution 1. 메인쿼리 판단
                        최종적으로 출력되어야하는 산출물은 사원수이다.
                        
                    solution 1-1. 메인쿼리 작성
                        SELECT COUNT(*) AS 사원수
                          FROM EMPLOYEES
                         WHERE DEPARTMENT_ID = (상위부서코드가 NULL인 부서)
                        
                    solution 2. 서브쿼리 판단
                        상위부서코드가 NULL인 부서를 메인쿼리에서 구할 수 없기때문에 서브쿼리를 사용한다.
                        
                    solution 2-1. 서브쿼리 작성
                        SELECT DEPARTMENT_ID AS 부서코드
                          FROM DEPARTMENTS
                         WHERE PARENT_ID IS NULL
                         
                    solutin 3. 쿼리작성
                        SELECT COUNT(*) AS 사원수
                          FROM EMPLOYEES
                         WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID AS 부서코드
                                                  FROM DEPARTMENTS
                                                 WHERE PARENT_ID IS NOT NULL)



            연관성 있는 서브쿼리
                메인쿼리와 서브쿼리에 사용된 테이블이 조인으로 연결된 서브쿼리
                
                    ex. 각 부서의 평균급여를 계산하고 각 부서에서 자기 부서의 평균급여보다
                        많은 급여를 지급받는 직원이 있는 부서코드와 부서명을 출력하시오.
                        
                    solution 1. 메인쿼리 판단
                        최종적으로 출력하는 것은 부서코드와 부서명이다.
                        
                    solution 1-1. 메인쿼리 작성
                        SELECT A.DEPARTMENT_ID AS 부서코드,
                               A.DEPARTMENT_NAME AS 부서명
                          FROM DEPARTMENTS A
                         WHERE A.DEPARTMENT_ID IN (서브쿼리);
                         
                    solution 2. 서브쿼리 판단
                        자기 부서의 평균급여보다 많은 급여를 지급받는 직원이 있는 부서의 부서코드를 찾아야 한다.
                        서브쿼리 안에 또 다른 서브쿼리를 사용해야 하는 형태이다.
                        
                        1차 서브쿼리 : 자기 부서의 평균급여보다 많은 급여를 지급 받는 직원이 있는 부서의 부서코드
                        2차 서브쿼리 : 자기부서의 평균급여
                        
                    solution 2-1. 1차 서브쿼리 작성
                        SELECT B.DEPARTMENT_ID
                          FROM EMPLOYEES B
                         WHERE B.SALARY > (자기부서의 평균급여)
                        
                    solution 2-2. 2차 서브쿼리 작성
                        SELECT C.DEPARTMENT_ID,
                               ROUND(AVG(C.SALARY))
                          FROM EMPLOYEES C
                      GROUP BY C.DEPARTMENT_ID
                      
                    solution 3. 쿼리작성
                        SELECT A.DEPARTMENT_ID AS 부서코드,
                               A.DEPARTMENT_NAME AS 부서명
                          FROM DEPARTMENTS A
                         WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                                                     FROM EMPLOYEES B
                                                    WHERE B.SALARY > (SELECT ROUND(AVG(C.SALARY))
                                                                        FROM EMPLOYEES C
                                                                       WHERE C.DEPARTMENT_ID = B.DEPARTMENT_ID
                                                                       -- 자기부서인지 구분하기 위한 JOIN
                                                                    GROUP BY C.DEPARTMENT_ID))
                    /*
                    1차 서브쿼리에서 EMPLOYEES의 첫 번째 사람을 꺼낸다
                    1차 서브쿼리의 WHERE절 수행
                    2차 서브쿼리에서 C.DEPARTMENT_ID = B.DEPARTMENT_ID을 만족하는 모든 사람의 평균급여를 계산
                    계산결과를 1차 서브쿼리의 WHERE절로 반환하여 B.SALARY와 비교
                    비교결과를 메인쿼리의 WHERE절로 반환하여 메인쿼리 WHERE절 비교
                    */
                    
                    
                    ex. 장바구니테이블에서 회원별 최고구매수량을 가진 자료의 회원번호, 장바구니 번호, 상품번호, 구매수량을 조회하시오.
                    
                    solution 1. 메인쿼리 판단
                        최종적인 산출물은 회원번호, 장바구니 번호, 상품번호, 최고구매수량이다.
                        
                    solution 1-1. 메인쿼리 작성
                        SELECT A.CART_MEMBER AS 회원번호,
                               A.CART_NO AS "장바구니 번호",
                               A.CART_PROD AS 상품번호,
                               A.CART_QTY AS 최고구매수량
                          FROM CART A
                         WHERE A.CART_QTY = (회원별 최대 구매수량)
                        
                    solution 2. 서브쿼리 판단
                        문제의 조건을 만족하기 위해 회원별 최대 구매수량을 구해야 한다.
                        
                    solution 2-1. 서브쿼리 작성
                        SELECT MAX(B.CART_QTY)
                          FROM CART B
                         WHERE A.CART_MEMBER = B.CART_MEMBER
                         
                    solution 3. 쿼리작성
                        SELECT A.CART_MEMBER AS 회원번호,
                               A.CART_NO AS "장바구니 번호",
                               A.CART_PROD AS 상품번호,
                               A.CART_QTY AS 최고구매수량
                          FROM CART A
                         WHERE A.CART_QTY = (SELECT MAX(B.CART_QTY)
                                               FROM CART B
                                              WHERE A.CART_MEMBER = B.CART_MEMBER)
                      ORDER BY 1
                      
                      
                    ex. 사원테이블의 사원급여를 아래 조건대로 변경하시오.
                        [조건]
                        1. 사원이 소속된 부서의 상위부서가 90번인 부서
                        2. 상위부서가 90에 속한 부서의 각 부서의 평균급여 계산
                        3. 상위부서가 90에 속한 부서에 속한 사원의 급여를 자신의 부서 평균 급여로 변경
                        
                    solution 1. 상위부서가 90번인 부서에 속한 사원
                        SELECT A.EMPLOYEE_ID,
                               A.EMP_NAME, 
                               A.DEPARTMENT_ID, 
                               B.PARENT_ID
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                           AND B.PARENT_ID = 90
                           
                    solution 2. 상위부서가 90번인 부서에 속한 사원의 평균급여
                        SELECT A.DEPARTMENT_ID,
                               ROUND(AVG(A.SALARY))
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                           AND B.PARENT_ID = 90
                      GROUP BY A.DEPARTMENT_ID
                      ORDER BY 1

                    solution 3. ???
                        SELECT C.SAL
                          FROM (SELECT A.DEPARTMENT_ID AS 부서코드,
                                       ROUND(AVG(A.SALARY)) AS SAL
                                  FROM EMPLOYEES A, DEPARTMENTS B
                                 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                                   AND B.PARENT_ID = 90
                              GROUP BY A.DEPARTMENT_ID ) C
                         WHERE B.DEPARTMENT_ID 
                              
                    solution 4. 쿼리작성
                        UPDATE EMPLOYEES D
                           SET SALARY = ( SELECT C.SAL
                                            FROM (SELECT A.DEPARTMENT_ID AS DID,
                                                         ROUND(AVG(A.SALARY)) AS SAL
                                                    FROM EMPLOYEES A, DEPARTMENTS B
                                                   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                                                     AND B.PARENT_ID = 90
                                                GROUP BY A.DEPARTMENT_ID) C
                                           WHERE D.DEPARTMENT_ID = C.DID)
                         WHERE D.DEPARTMENT_ID =ANY(SELECT DEPARTMENT_ID
                                                      FROM DEPARTMENTS
                                                     WHERE PARENT_ID=90)
                        
                        **확인해보기(검증)
                        SELECT A.EMP_NAME,
                               A.DEPARTMENT_ID,
                               A.SALARY
                          FROM DEPARTMENTS B, EMPLOYEES A
                         WHERE B.PARENT_ID = 90
                           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
                      
                      
       1-2. 사용되는 형태, 위치 여부 : 일반 서브쿼리(SELECT 절), 인라인 서브쿼리(FROM절), 중첩 서브쿼리(WHERE절)
       1-3. 반환값의 개수 여부 : 단일행/단일열, 단일행/다중열, 다중행/단일열, 다중행/다중열
        