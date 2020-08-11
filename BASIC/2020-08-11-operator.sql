<2020-08-11-01>

    1. 관계 연산자를 사용하여 조건문 구성
        개발언어의 if문에 사용되는 조건문과 동일하다.
        >, <, <=, >=, !=(<>), = 사용
        
    2. 논리연산자(NOT(!), AND, OR)
        복수개의 조건문을 구성한다.
        우선순위 : NOT > AND > OR
        
    3. 기타 연산자
        ANY, SOME, IN, ALL, EXISTS 등이 제공된다.
        ANY, SOME, IN 은 동일한 기능을 가진다
        
        IN : 관계연산자가 붙지않는다. 
             컬럼의 값이 복수개로 주어진 값 중 어느 한가지와 일치하면 전체가 참(TRUE)을 반환한다.
             사용형식 : 컬럼명 IN (값1, 값2, ... )
             OR연산자로 변환이 가능하다.
                
        ANY : 모든 조건이 만족해야 조건이 만족된다.
              사용형식 : 컬럼명(표현식) 관계연산자 ANY (값1, 값2, ... )
              OR 연산자로 변환가능
              IN 연산자로 변환 할 때는 관계연산자를 생략 해야한다.
              나머지 성질은 IN 연산자와 같다.
        
        ALL : 모든 조건이 만족해야한다.
              ALL을 사용해서 결과가 나온경우는 다중값을 가진 경우가 많다(제 1 정규화를 위배한 경우)
              ALL 연산자를 사용하여 결과가 나오는 경우는 거의 없다.
              
        EXISTS : 뒤에 반드시 서브쿼리가 나와야 한다. (일반 조건문 불가능)
        /* 연산자를 잘 활용하면 코드의 길이를 줄일 수 있다.
           연산자를 사용할 때 피연산자의 타입을 반드시 고려해야 한다 */
        
    ex. 회원테이블(MEMBER)에서 출생년도가 1973년도 이후 출생한 회원을 조회하시오.
        (단, alias 는 회원번호, 회원명, 주민등록번호이다)
        
    solution1 1.
        MEM_REGNO1을 조건문에서 사용하는 경우 (CHAR TYPE)
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||'-'||MEM_REGNO2 AS 주민등록번호 --ORACLE에서 ||은 '+'연산자이다.
          FROM MEMBER
         WHERE SUBSTR(MEM_REGNO1,1,2)>='73';
         
    solution 2. 
        MEM_BIR을 조건문으로 사용하는 경우 (DATE TYPE)
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||'-'||MEM_REGNO2 AS 주민등록번호 --ORACLE에서 ||은 '+'연산자이다.
          FROM MEMBER
         WHERE MEM_BIR>='19730101';
         /*
         문자열은 날짜형식으로 변환가능하지만, DATE TYPE의 FORMAT에 맞게 써야한다 (YYYY-MM-DD '-'생략)
         MEM_MIR 는 DATE TYPE, REGNO는 CHAR TYPE
         WHERE MEM_BIR>='19730101' => '19730101'이 DATE TYPE으로 캐스팅된다.
         */
         
    ex. 사원테이블(EMPLOYEES)에서 급여(SALARY)가 5000이상이고, 
        부서코드(DEPARTMENT_ID)가 80번인 사원을 조회하시오.
        (단, Alias는 사원번호, 사원명, 부서코드, 급여, 전화번호이다)
        
    solution.
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               DEPARTMENT_ID AS 부서코드,
               SALARY AS 급여,
               PHONE_NUMBER AS 전화번호
          FROM EMPLOYEES
         WHERE DEPARTMENT_ID=80 AND SALARY>=5000;
    
    
    ex. 사원테이블에서 30, 40, 60번 부서에 속한 사원정보를 조회하시오.
        (단, Alias는 사원명, 부서코드, 부서명, 직무명이다)
        
    solution 1.
        (OR 연산자 사용)
        SELECT A.EMP_NAME AS 사원명,
               A.DEPARTMENT_ID AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               C.JOB_TITLE AS 직무명
          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
          /*FROM에서 선언된 별칭은 FROM절 이후에 실행되는 절에서 모두 사용가능하다*/
         WHERE A.DEPARTMENT_ID = 30
            OR A.DEPARTMENT_ID = 40
            OR A.DEPARTMENT_ID = 60
           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.JOB_ID = C.JOB_ID;
            /*JOIN은 N개의 TABLE을 사용할 때 적어도 N-1개를 사용해야 한다*/
            
     solution 2.
        (IN 연산자 사용)
        SELECT A.EMP_NAME AS 사원명,
               A.DEPARTMENT_ID AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               C.JOB_TITLE AS 직무명
          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
         WHERE A.DEPARTMENT_ID IN(30, 40, 60)
           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.JOB_ID = C.JOB_ID;
         
    solution 3.
        (ANY 연산자 사용)
         SELECT A.EMP_NAME AS 사원명,
               A.DEPARTMENT_ID AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               C.JOB_TITLE AS 직무명
          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
         WHERE A.DEPARTMENT_ID = ANY(30, 40, 60)
           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.JOB_ID = C.JOB_ID;
           
           
    4. NULL 조건식
        NULL값의 비교는 관계연산자('-')로 비교할 수 없음
        IS NULL, IS NOT NULL 사용하여 비교한다.
        !=을 사용하지 않는다. (!=를 사용해도 컴파일은 잘 되지만 조건비교가 안된다)
        
    ex. 사원테이블(EMPLOYEES)에서 영업실적코드(COMMISSION_PCT)가 NULL인 사원을 조회하시오.
        (단, Alias는 사원이름, 부서코드, 영업실적)
        
    solution.
        SELECT EMP_NAME AS 사원이름,
               DEPARTMENT_ID AS 부서코드,
               COMMISSION_PCT AS 영업실적
          FROM EMPLOYEES
         WHERE COMMISSION_PCT IS NOT NULL;
         
    ex. 사원테이블(EMPLOYEES)에서 보너스를 지급하여 급애액을 조회하시오.
        보너스 = 본봉(SALARY) * 영업실적
        급애액 = 본봉+보너스
        (단, Alias는 사원명, 본봉, 보너스, 지급액이다.)
        
        SELECT EMP_NAME AS 사원명,
               SALARY AS 본봉,
               SALARY * COMMISSION_PCT AS 보너스,
               SALARY + (SALARY * COMMISSION_PCT) AS 지급액
          FROM EMPLOYEES;
          /*
          위 예시는 NULL값으로 인해 잘못된 결과가 나오는 예시
          SELECT 절에서 수식을 넣었을 경우, 피연산자 중 하나라도 NULL값을 가지는것이 있다면
          계산 결과가 모두 NULL값이 되기때문에 NULL CHECK를 반드시 하거나, 조건을 넣어야 한다
          */
         
         
         
    5. LIKE 연산자
         
    
    
    
    6. BETWEEN ~ AND 조건식
    
         
         
         
         
         