<2020-08-12>

    1. 변환함수
        데이터의 형을 변환할 때 사용한다.
        
        1-1. TO_CHAR
                사용형식 : TO_CHAR(, [, fmt])
        
                   <날짜변환 형식>
        -------------------------------------
            fmt                      설명
        -------------------------------------
            AM, PM                오전, 오후 표시
            A.M, P.M
            YYYY, YYY, YY, Y      연도 표시
            MM                    월(01 ~ 12)
            D                     주중의 일(1~7)
            DD                    월중의 일(1~31)
            DDD                   연중의 일(1~365)
            DAY                   주중의 일을 요일로 표시
            DL                    날짜와 요일 표시
            HH, HH12              12시간으로 시간 표시
            HH24                  24시간으로 시간 표시
            MI                    분
            SS                    초
            SSSSS                 오늘 전체 경과된 시간을 초로 환산
            WW                    연중 주차를 나타냄(1~53주)
            
            ex.
                SELECT TO_CHAR(SYSDATE, 'YYY-MM-D'),
                       TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
                       TO_CHAR(SYSDATE, 'DD'),
                       TO_CHAR(SYSDATE, 'AM DDD'),
                       TO_CHAR(SYSDATE, 'DAY')
                  FROM DUAL
                  
                SELECT TO_CHAR(TO_DATE('19810126'), 'DAY'),
                       TO_CHAR(SYSDATE, 'HH24'),
                       TO_CHAR(SYSDATE, 'HH24 : MI : SSSSS'),
                       TO_CHAR(SYSDATE, 'HH24 : MI : SS'),
                       TO_CHAR(SYSDATE, 'WW HH24 : MI : SS'),
                       TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH12 : MI : SS')
                  FROM DUAL
                       

                   <숫자변환 형식>
        -------------------------------------
            fmt                      설명
        -------------------------------------
            .(dot)             소수점자리 구분
            ,(comma)           정수 자리구분
            (9, 0)             9는 무효의 0을 공백으로 대치
                               0은 무효의 0을 '0'으로 반환
            PR                 음수인 경우 < >로 묶어서 표시
            RN, M              숫자 자료를 로마자로 변환하여 표시
            
                       
            사용자 지정 문자열 : " "안에 기술
                ex. 오늘 날짜를 YYYY년 MM월 DD일 형식으로 표시하시오
                solution.
                    SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"')
                      FROM DUAL
            
                ex. 사원테이블에서 부서번호 70번 부서의 사원을 조회하시오.
                    (단, Alias는 사원명, 직책, 급여이며 급여는 123,456.0 형식으로 출력한다)
                
                solution.
                    SELECT EMP_NAME AS 사원명,
                           JOB_ID AS 직책,
                           TO_CHAR(SALARY, '999,999.0') AS 급여
                      FROM EMPLOYEES
                     WHERE DEPARTMENT_ID = 70
                
                ex. 상품테이블(PROD)에서 매매가에서 판매가를 차감하여 출력하시오
                    (Alias는 상품코드, 상품명, 분류코드, 매입가격, 판매가격, 차감)
                
                solution.              
                    SELECT PROD_ID AS 상품코드,
                           PROD_NAME AS 상품명,
                           PROD_LGU AS 분류코드,
                           TO_CHAR(PROD_COST,'99,999,999') AS 매입가격,
                           TO_CHAR(PROD_PRICE,'99,999,999') AS 판매가격,
                           TO_CHAR(PROD_COST - PROD_PRICE, '999,999,999PR') AS 차감 
                      FROM PROD;
                                 
                 ex. 제품분류테이블(LPROD)의 LPROD_ID(순차적으로 부여된 숫자)를 로마표기로 변환하여라.
                     (Alias는 순번, 구분코드, 상품명)
               
                 solution.
                    SELECT LPROD_ID AS 순번,
                           TO_CHAR(LPROD_ID, 'RN') AS "순번(로마)",
                           LPROD_GU AS 구분코드,
                           LPROD_NM AS 구분명
                      FROM LPROD;


        1-2. TO_NUMBER
                문자나 다른 유형의 숫자를 NUMBER타입으로 반환한다.
                사용형식 : TO_NUMBER(c [,fmt])
                
                ex. 회원테이블에서 주민번호 앞 자리를 이용하여 나이를 계산하여라
                    (단, Alias는 회원이름, 출생년도 2자리, 나이이다)
                    
                solution.
                    SELECT MEM_NAME AS 회원이름,
                           SUBSTR(MEM_REGNO1, 1, 2)||'년' AS 출생년도,
                           2020 - TO_NUMBER((SUBSTR(MEM_REGNO1, 1, 2)) + 1900) AS 나이
                      FROM MEMBER
                  ORDER BY MEM_REGNO1;
                  
                  etc. 
                  SELECT TO_NUMBER('12345', '99,999') FROM DUAL
                         -- ','가 들어가면 연산이 안되기 때문에 실행이 불가능함.
                  SELECT TO_NUMBER('12345', '99999.0') FROM DUAL
                  SELECT TO_DATE('19961203', 'YYYY-MM-DD') FROM DUAL
                  
        1-3. TO_DATE
                문자열을 날짜형으로 반환한다.
                사용형식 : TO_DATE(c, [, fmt])
                
                ex. 회원테이블에서 주민등록 번호를 이용하여 생년월일을 출력하시오.
                
                solution.
                    SELECT MEM_NAME AS 회원명,
                           TO_CHAR(TO_DATE('19'||SUBSTR(MEM_REGNO1, 1, 2), 'YYYY"년" MM"월" DD"일"') AS 생년월일,
                      FROM MEMBER
                     
                    SELECT MEM_NAME AS 회원명,
                           TO_CHAR(CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' OR SUBSTR(MEM_REGNO2,1,1) = '2' THEN TO_DATE('19' || MEM_REGNO1)
                           ELSE TO_DATE('20' || MEM_REGNO1) END, 'YYYY"년" MM"월" DD"일"') AS 생년월일
                      FROM MEMBER;
     