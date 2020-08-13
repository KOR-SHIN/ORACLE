<2020-08-13-01>
    
    1. 문자열 함수
        
        1-1. INITCAP, LOWER, UPPER
                LOWER(c) : 주어진 매개변수(문자열)의 모든 문자를 소문자로 변경하여 반환한다.
                           주로 비교문에서 사용된다.
                
                ex. 사원테이블에서 사원의 이름과 이메일 값을 문자로 변환하여 출력하시오.
                
                solution.
                    SELECT EMP_NAME AS "사원이름(원본값)",
                           EMAIL AS "이메일(원본값)",
                           LOWER(EMP_NAME) AS "사원명(변환값)",
                           LOWER(EMAIL) AS "이메일(변환값)"
                      FROM EMPLOYEES
                    
              
                ex. 사원테이블에서 LAST NAME이 'G'로 시작하는 사원을 조회하시오.
                    (단, Alias는 사원명, 부서코드, 직책코드, 급여)

                solution.
                    SELECT EMP_NAME AS 사원명,
                           DEPARTMENT_ID AS 부서코드,
                           JOB_ID AS 직책코드,
                           SALARY AS 급여
                      FROM EMPLOYEES
                     WHERE LOWER(SUBSTR(EMP_NAME, 1, 1)) = 'g';
                     
               
                ex. 상품테이블(PROD)에서 분류가 전자제품(p102)에 속한 상품의 수를 출력하시오.
                    
                solution.
                    SELECT COUNT(*)
                      FROM PROD
                     WHERE LOWER(PROD_LGU) ='p102';
                     
                ex. 사원테이블의 사원이름을 모두 소문자로 변환하여 저장하시오.
                
                solution.
                    UPDATE EMPLOYEES
                       SET EMP_NAME = LOWER(EMP_NAME);
                       
                    SELECT EMP_NAME
                      FROM EMPLOYEES
                      
                      
            UPPER(c) : 매개변수에 저장된 문자열의 모든 문자를 대문자로 변형하여 반환한다.
            
                ex. 사원테이블의 사원이름을 모두 대문자로 변환하여 저장하시오.
                
                solution.
                    UPDATE EMPLOYEES
                       SET EMP_NAME = UPPER(EMP_NAME);
                       
                    SELECT EMP_NAME 
                      FROM EMPLOYEES
                      
            INITCAP(c) : 각 단어의 첫 글자만 대문자로 변형하여 반환한다.
                         이름 표기법에 주로 사용된다.
                         공백을 구분자로 문자열을 구분한다.
                         
                ex. 사원테이블의 이름을 첫 글자만 대문자로 변환하시오.
                
                solution.
                    UPDATE EMPLOYEES
                       SET EMP_NAME = INITCAP(EMP_NAME);
                       
                    SELECT EMP_NAME 
                      FROM EMPLOYEES
                      
        1-2. CONCAT
                첫 번째 매개변수와 두 번째 매개변수를 결합한 문자열을 반환한다.
                '||'연산자와 동일한 기능을 수행한다.
                사용형식 : CONCAT(c1, c2)
                
                ex. 회원테이블에서 마일리지가 3000이상인 회원을 조회하시오.
                    (단, Alias는 회원명, 주민번호, 마일리지, 직업이고 주민번호는 XXXXXX-XXXXXXX 형식으로 출력하며
                     CONCAT 함수를 이용해야 한다.)
                
                solution.
                    SELECT MEM_NAME AS 회원명,
                           CONCAT(CONCAT(MEM_REGNO1, '-'), MEM_REGNO2) AS 주민번호,
                           MEM_MILEAGE AS 마일리지,
                           MEM_JOB AS 직업
                      FROM MEMBER
                     WHERE MEM_MILEAGE >= 3000
                     
        1-3. SUBSTR
                주어진 문자열에서 POS위치에서 LEN개수 만큼의 문자열을 추출하여 반환한다.
                POS값이 0인 경우 1로 취급한다.
                LEN이 생략되면 POS위치 이후의 모든 문자열을 반환한다.
                가장 많이 사용되는 문자열 함수이다.
                WHERE절에서 많이 사용된다.
                
                ex. SUBSTR(MEM_NAME, 1, 3) : MEM_NAME의 문자열 첫 번째부터 3글자를 추출하여라.
                
                ex. 회원테이블에서 주민등록번호를 이용하여 여성회원들의 나이를 출력하시오.
                    (단, Alias는 회원명, 주민번호, 나이, 마일리지이다.)
                    
                soluton.
                    SELECT MEM_NAME AS 회원명,
                           MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
                           EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1, 1, 2)) AS 나이,
                                                     -- 1900 + TO_NUMBER(SUBSTR(MEM_REGON,1 ,2) 2000년대 생을 고려하지 않은 예제임
                           MEM_MILEAGE AS 마일리지
                      FROM MEMBER
                     WHERE SUBSTR(MEM_REGNO2, 1, 1) = '2';
                    /*
                    EXTRACT : 추출하는 메서드
                    EXTRACT(YEAR FROM SYSDATE)
                    EXTRACT(MONTH FROM SYSDATE)
                    EXTRACT(DAY FROM SYSDATE)
                    
                    HOUR, MINUTE, SECOND는 TIMESTAMP를 사용해야 함
                    SELECT SYSTIMESTAMP,
                           EXTRACT( HOUR FROM SYSTIMESTAMP) HOUR,
                           EXTRACT( MINUTE FROM SYSTIMESTAMP) MINUTE,
                           EXTRACT( SECOND FROM SYSTIMESTAMP) SECOND
                      FROM DUAL
                    */
                    
                QUIZ. 사원테이블에서 근속년수 15년 이상인 사람들에게 특별 보너스를 지급하려고 한다.
                      보너스 = 급여 * (근속년수 / 100)이며 소수점 첫 째 자리에서 반올림하며 
                      지급액 = 급여 +  보너스이고, 근속년수는 년도로만 계산한다.
                      단, Alias는 사원명, 부서코드, 입사일, 근속년수, 보너스, 급여, 지급액이다.
                               
                solution.
                    SELECT EMP_NAME AS 사원명,
                           DEPARTMENT_ID AS 부서코드,
                           HIRE_DATE AS 입사일,
                           EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE, 1, 4) AS 근속년수,
                           ROUND(SALARY * ( EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE, 1, 4)) / 100) AS 보너스,
                           SALARY AS 급여,
                           SALARY + SALARY * ((EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE, 1, 4)) / 100) AS 지급액                    
                      FROM EMPLOYEES
                     WHERE EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE,1,4) >= 15
                ORDER BY HIRE_DATE DESC
                      
                        