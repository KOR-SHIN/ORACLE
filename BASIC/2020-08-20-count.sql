 
        1-2. COUNT
            사용형식 : COUNT(*|expr)
            쿼리의 결과 내의 행의수를 반환한다.
            외부조인에서는 expr를 사용해야 한다 ('*'를 사용하면 '0'이 '1'로 반환된다)
            
                ex. 사원테이블에서 부서별 사원수를 조회하시오.
                solution.
                    SELECT A.DEPARTMENT_ID AS 부서코드,
                           B.DEPARTMENT_NAME AS 부서명,
                           COUNT(*) AS 사원수
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
                  ORDER BY 1;
                  /*
                  DEPARTMETS TABLE에서 DEPARTMENT_ID는 기본키이기 때문에 NULL을 가질 수 없다.
                  하지만 EMPLOYEES는 NULL값을 가질 수 있다. (사장은 부서코드가 없다)
                  따라서 EMPLOYEES TABLE, DEPARTMENTS TABLE을 조인하면, NULL값을 가진것을 출력하지 않는다.                
                  */
                  
                  ex. 회원테이블에서 직업별 회원수와 마일리지 합계를 조회하세요.
                  solution. 
                      SELECT MEM_JOB AS 직업,
                             COUNT(*) AS 회원수,
                             ROUND(SUM(MEM_MILEAGE)) AS "마일리지 합계"
                        FROM MEMBER
                    GROUP BY MEM_JOB
                    
                 ex. 사원테이블에서 전체직원들의 평균급여보다 급여가 많은 직원수를 부서별로 조회하시오.
                 sloution.
                      /*평균급여를 출력하지 않는 경우*/
                      SELECT DEPARTMENT_ID AS 부서번호,
                             COUNT(*) AS 사원수,
                             ROUND((SELECT AVG(SALARY) FROM EMPLOYEES)) AS 평균급여
                        FROM EMPLOYEES
                       WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
                    GROUP BY DEPARTMENT_ID
                    ORDER BY 1;
                    
                 ex. 사원테이블과 부서테이블을 사용하여 모든 부서의 인원수를 조회하시오.
                 solution.
                      1) 사원테이블에서 사용하고 있는 부서코드
                        SELECT DISTINCT(DEPARTMENT_ID) FROM EMPLOYEES
                      2) 부서테이블에서 사용하고 있는 부서코드
                        SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                          /*DEPARTMENTS의 DEPARTMENTS_ID가 기본키이기 때문에 중복제거를 안해도 된다*/
                      3) 문제해결
                        SELECT B.DEPARTMENT_ID 부서코드, 
                               B.DEPARTMENT_NAME 부서명, 
                               COUNT(*) AS 인원수
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                      GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
                      ORDER BY 1
                      /*
                      JOIN을 하는데 부서코드를 DEPARTMENTS TABLE을 사용한다.
                      DEPARTMENTS TABLE의 DEPARTMENT_ID의 개수가 더 많기 때문에 DEPARTMENTS TABLE에는 없고
                      EMPLOYEES TABLE에는 있는 DEPARTMENT_ID는 무시된다.
                      */
                      
                      /*
                        SELECT A.DEPARTMENT_ID 부서코드, 
                               B.DEPARTMENT_NAME 부서명, 
                               COUNT(*) AS 인원수
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID (+)= B.DEPARTMENT_ID
                      GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
                      ORDER BY 1
                      (+) : OUTTER JOIN 연산자
                      위의 경우 외부조인을 하는데 COUNT(*)를 사용하였다.
                      이러한 경우, 0이 1로 반환되고, NULL값이 출력된다.
                      */
                      
                 ex. 사원테이블에서 현재 재직중인 사원수를 부서별로 조회하시오.
                    1) 퇴직처리
                        UPDATE EMPLOYEES
                           SET RETIRE_DATE = SYSDATE
                         WHERE EMPLOYEE_ID IN (200, 110, 130)
                    2) 문제해결
                        SELECT DEPARTMENT_ID AS 부서코드,
                               COUNT(*) AS 사원수
                          FROM EMPLOYEES  
                         WHERE RETIRE_DATE IS NULL
                      GROUP BY DEPARTMENT_ID
                      ORDER BY 1
                      