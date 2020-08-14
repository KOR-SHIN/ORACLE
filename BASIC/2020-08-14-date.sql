<2020-08-14-01>
    
    1. 날짜함수
    
        1-1. SYSDATE, SYSTIMESTAMP
                시스템이 제공하는 날짜 함수
                '+'와 '-'의 연산이 가능하다.
                
                SYSDATE : 시스템상의 날짜를 표시해준다.
                SYSTIMESTAMP : 날짜가 YY/MM/DD 형식으로 표시되고 1/10억초 단위로 표현된다.
                               뒤에 나오는 +09:00은 그리니치천문대 기준시간이다.
                ex. SELECT SYSDATE,
                           SYSDATE+7,
                           SYSDATE-7,
                           SYSTIMESTAMP
                      FROM DUAL
                      
                      
        1-2. ADD_MONTHS
                사용형식 : ADD_MONTHS(d, n)
                주어진 날짜데이터 d에 정수 n만큼의 월을 더한 날짜를 반환한다.
                
                ex. 오늘부터 2개월 후 7일전 날짜를 나타내시오.
                solution.
                    SELECT ADD_MONTHS(SYSDATE, 2) -7
                      FROM DUAL
                
                quiz. 회원테이블에서 회원들의 생일문자를 보내려고 한다.
                      다음달 생일이 있는 회원을 찾아 생일 2일전에 문자를 발송할 수 있도록 회원정보를 조회하시오.
                      (단, Alias는 회원번호, 회원명, 이메일주소, 핸드폰번호, 문자발송일이다.)
                      
                solution.
                    SELECT MEM_ID AS 회원번호,
                           MEM_NAME AS 회원명,
                           MEM_MAIL AS 이메일주소,
                           MEM_HP AS 핸드폰번호,
                           EXTRACT( YEAR FROM SYSDATE )||'년'||
                           EXTRACT( MONTH FROM MEM_BIR )||'월'||
                           (EXTRACT( DAY FROM MEM_BIR ) - 2)||'일' AS 문자발송일
                           --생일 날짜가 1일 or 2일인 경우를 고려해서 다시 작성해야함
                      FROM MEMBER
                     WHERE EXTRACT( MONTH FROM MEM_BIR ) = EXTRACT( MONTH FROM SYSDATE ) + 1
                           
                