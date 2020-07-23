<2020-07-23-01>
    UPDATE
        저장된 데이터의 내용을 변경하기 위해 사용한다.
        사용형식 : UPDATE <테이블명> 
                    SET <컬럼명 = 값>[,
                        컬럼명 = 값...,
                  [WHERE 조건]; 
                  /*[WHERE 조건]절이 생략되면 테이블의 모든 행에 존재하는
                    컬럼에 새로운 값으로 변경한다.
                  */
        
    quiz) 사원테이블 (EMPLOYEES)테이블에서 모든 사원들의 급여를 15000으로 변경하시오.
    solv) 
        SELECT EMP_NAME AS 사원명,
               DEPARTMENT_ID AS 부서코드,
               SALARY AS 급여
          FROM EMPLOYEES;
        
        UPDATE EMPLOYEES
        SET SALARY = 15000;
            -- [WHERE 조건]절이 생략된 경우
    
    quiz) 사원테이블 (EMPLOYEES)테이블에서 부서코드가 50번인 급원들의 급여를 15000으로 변경하시오.
    solv)
        SELECT EMP_NAME AS 사원명,
               DEPARTMENT_ID AS 부서코드,
               SALARY AS 급여
          FROM EMPLOYEES
          WHERE DEPARTMENT_ID=50;
          
          UPDATE EMPLOYEES
             SET SALARY = 15000
           WHERE DEPARTMENT_ID=50;
            /* 
               ROLLBACK : 마지막 COMMIT 상태로 되돌려줌 (ROLLBACK의 대상인 명령어만 가능)
               COMMIT : COMMIT을 하면 COMMIT이전 상태로 ROLLBACK 불가능
                        SQLDeveloper를 종료하면 자동 COMMIT 된다.
            */
            
            
    quiz) 회원테이블(MEMBER)에서 회원들의 마일리지를 20% 추가지급하시오
    solv)
        SELECT MEM_NAME, MEM_MILEAGE
          FROM MEMBER;
        -- 모든 회원을 조회하기 때문에 WHERE절 생략
        
        UPDATE MEMBER
           SET MEM_MILEAGE = MEM_MILEAGE+MEM_MILEAGE*0.2;
    
    
    
    
    
    
    