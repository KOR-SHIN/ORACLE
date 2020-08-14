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
                      
        1-4. LTRIM, RTRIM, TRIM
                무효의 공백을 제거하는 함수
                LTRIM은 왼쪽에 존재하는 무효의 공백을 제거한다.
                RTRIM은 오른쪽에 존재하는 무효의 공백을 제거한다.
                TRIM은 양쪽에 존재하는 무효의 공백을 제거한다.
                
                사용형식 : LTRIM(c, [,set]), RTRIM(c, [,set]), TRIM(c, [,set])
                주어진 문자열 c에서 set으로 지정된 문자열을 왼쪽(LTRIM), 오른쪽(RTRIM) 찾아 제거
                set이 생략되면 set은 공백을 의미한다.
                
                VARCHAR2는 무효공백을 알아서 처리하기 때문에 사용할 필요없다.
                하지만 숫자가 문자로 변환이되어 정렬된 상태이거나, 남은공간을 무효값으로 채워주는 데이터 타입에 대해서는 사용한다.
               
                ex. 거래처명의 데이터 타입을 CHAR(40) 으로 바꾸시오.
                solution.
                    ALTER TABLE BUYER
                    MODIFY BUYER_NAME CHAR(40);
                
                
                ex. 거래처테이블에서 거래처명이 '대현'인 거래처 정보를 조회하시오.
                    (단, Alias는 거래처코드, 거래처명, 거래처주소이고, 거래처명이다.)
                solution.
                    SELECT BUYER_ID AS 거래처코드,
                           BUYER_NAME AS 거래처명,
                           BUYER_ADD1||' '||BUYER_ADD2 AS 거래처주소
                      FROM BUYER
                     WHERE BUYER_NAME = '대현'
                
                
                ex. 거래처테이블에서 거래처명이 '대현'인 거래처 정보를 조회하시오.
                    (단, Alias는 거래처코드, 거래처명, 거래처주소이고, 거래처명은 TRIM을 사용하여 공백을 제거한다)
                solution.
                    SELECT BUYER_ID AS 거래처코드,
                           RTRIM(BUYER_NAME) AS 거래처명,
                           BUYER_ADD1||' '||BUYER_ADD2 AS 거래처주소
                      FROM BUYER
                     WHERE BUYER_NAME = '대현'
                

                ex. 거래처테이블에서 거래처 기본주소(ADD1) 중 대전에 있는 거래처를 검색하여
                    '대전'문자열을 제거하시오.
                solution.
                    SELECT BUYER_ID AS 거래처코드,
                           TRIM(BUYER_NAME) AS 거래처명,
                           LTRIM(BUYER_ADD1, '대전') AS 기본주소
                      FROM BUYER
                     WHERE BUYER_ADD1 LIKE '대전%'
                     /*
                     LTRIM(BUYER_ADD1, '대전')은 ADD1에서 왼쪽에 있는 '대전%'와 대응되는 을 제거시킨다.
                     RTRIM(BUYER_ADD1, '대전')의 경우 제거시키지 못한다 
                            ex. 대전 대덕구 오정동 운암빌딩
                                -> RTRIM은 오른쪽부터 비교를 시작하기 때문에 '대', '전'과 대응되는 문자열을 만나기전에 비교가 끝난다.
                                -> '대전'이라는 패턴에 맞게 지우는 것이 아니라, '대','전'과 패턴이 맞는것을 지운다.
                                -> 공백도 비교의 대상이기 때문에, set영역에 공백을 넣어주지 않으면 공백을 만나는 즉시 문자열을 반환한다.
                                -> 만약 중간에 '대', '전'에 대응되는 패턴이 없으면 끝까지 비교하지 않고 문자열을 반환한다.
                                
                                SELECT RTRIM('대전 대덕구 오정동 운암빌딩', '구오덕정대동운딩빌암 ')
                                FROM DUAL
                      */
                      
        1-5. LPAD, RPAD 
                LPAD : c문자열에 왼쪽에 n자리만큼 expr문자열을 삽입하여 c를 반환
                       expr이 생략되면 공백이 삽입
                       
                RPAD : c문자열에 오른쪽에 n자리만큼 expr문자열을 삽입하여 c를 반환
                       expr이 생략되면 공백이 삽입
                       
                사용형식 : LPAD(c, n, expr)
                          RPAD(c, n, expr)
                
                ex. SELECT LPAD(MEM_NAME, 11, '성명:') 
                      FROM MEMBER
                    -- 한글의 경우 n값이 적용이 잘 안되는 경우가 있다.
                
                ex. SELECT LPAD(EMAIL, 13, 'mail:')
                      FROM EMPLOYEES
                    
                ex. SELECT LPAD(EMAIL, 13, '*')
                      FROM EMPLOYEES
                        
                ex. SELECT EMAIL,
                           LPAD(EMAIL, 13)
                      FROM EMPLOYEES
                    -- 왼쪽부터 13글자를 지정해서, 글자가 들어가고 남는공간을 공백으로 채운다
                    -- 결과적으로 문자열은 왼쪽정렬이지만, 왼쪽에 공백을 채워넣어 오른쪽 정렬로 만든다.
                    
                ex. SELECT TO_CHAR(MEM_MILEAGE) AS "AD"
                      FROM MEMBER
                    -- 숫자를 문자열로 변환하여 왼쪽정렬
                    
                ex. SELECT LPAD(TO_CHAR(MEM_MILEAGE), 5) AS "AD"
                      FROM MEMBER
                    -- 숫자를 문자열로 변환하고 왼쪽정렬된 문자열의 왼쪽에 공백을 넣어 오른쪽 정렬로 만든다.
                

        1-6. REPLACE
                사용형식 : REPLACE(c, ser_c, rep_c)
                문자열 c에서 ser_c문자열을 찾아서 rep_c문자열로 대체시킨다.
                
                ex. SELECT MEM_NAME AS 멤버이름,
                           REPLACE(MEM_NAME, '김', 'KIM') AS "변경된 문자열"
                      FROM MEMBER
                
                ex. SELECT REPLACE('IL POSTINO  BOY HOOD', ' ', '')
                      FROM DUAL
                    -- 문자열에 포함되어 있는 공백을 제거한다.
                    
                ex. 거래처테이블의 거래처명의 데이터 타입을 VARCHAR2(40)으로 변경하시오.
                    (거래처명의 데이터 타입은 원래 VARCHAR2에서 CHAR로 변환하고 공백을 넣은 상태이다)
                solution.
                    ALTER TABLE BUYER
                    MODIFY BUYER_NAME VARCHAR2(40)
                    -- 현재 VARCHAR2로 변경했지만, 이전의 공백이 남아있는 상태.
                    
                    UPDATE BUYER
                       SET BUYER_NAME = TRIM(BUYER_NAME)
                    -- UPDATE와 TRIM을 사용하여 공백을 제거해준다.
                    -- SET BUYER_NAME = REPLACE(BUYER_NAME, ' ', '') 가능
 
        1-7. INSTR
                자바의 chatAt(i)메서드와 같은 기능을 수행한다.
                사용형식 : INSRT(c, substr[, pos][, occur])
                occur, pos 생략한 경우 : 주어진 문자열 c에서 substr을 찾아서, 첫 번째 만나는 substr의 인덱스 값을 반환해준다.
                occur, pos 생략하지 않은 경우 : 주어진 문자열 c에서 pos번째부터 시작해서 occur번째에 만난 substr의 인덱스 값을 반환해준다.
                occur만 생략한 경우 : 주어진 문자열 c에서 pos번째부터 시작해서 첫 번째 만나는 substr의 인덱스 값을 반환해준다.
                
                ex. SELECT INSTR('무궁화 꽃이 피었을까 무궁화 꽃은 우리나라 꽃 입니다.', '꽃', 6, 2) AS 결과
                      FROM DUAL
                      -- 6번째 글자부터 시작해서 2번째에 만난 꽃의 인덱스값을 반환한다.
                      
        1-8. LENGTH, LENGTHB
                -- B는 BYTE, b는 bit를 의미한다.
                LENGTH(c) : c의 길이를 반환한다.
                LENGTHB(c) : 문자열의 byte를 반환한다.
                      
                ex. SELECT LENGTH('KOR-SHIN')
                      FROM DUAL
                      
                      
                      
                      
                      