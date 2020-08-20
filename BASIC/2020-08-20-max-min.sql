<2020-08-20>

    1. MIN, MAX, 
        사용형식 : MIN(expr), MAX(expr)
        주어진 컬럼이나 수식의 값 중 최소(MIN)또는 최대(MAX)값을 찾아 반환한다.
       
        ** GREATEST
        사용형식 : GREATEST(n1, n2, n3 ... )
        주어진 자료 n1~에서 최대값을 찾아 반환한다.
        
        ** LEAST
        사용형식 : LEASTEST(n1, n2, n3 ... )
        주어진 자료 n1~에서 최소값을 찾아 반환한다.
        
            ex. 오늘이 2005년 7월 28일이라고 가정하여 장바구니 번호를 생성하시오.
            solution.
                SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')
                       ||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1, '00000'))
                  FROM CART;
                  /*
                  CART_NO에 만약 숫자로 변환되지 않는 문자(알파벳 등)이 들어가있으면,
                  위의 방법으로 만들어야 한다.
                  */
                  
            solution2.
                SELECT MAX(CART_NO)+1
                  FROM CART;
                  /*
                  CART_NO는 고정길이 문자열이지만 숫자로 변환되지 않는 문자가 없다.
                  따라서, MAX함수를 사용하여 간단히 값을구한다
                  */
            ex. 회원테이블에서 마일리지가 1000미만인 회원을 찾아 마일리지를 1000으로 조정하시오.
            solution.
                SELECT MEM_ID AS 회원번호,
                       MEM_NAME AS 회원이름,
                       GREATEST(MEM_MILEAGE, 1000) AS 마일리지
                       -- MILEAGE가 1000보다 작으면, 최대값인 1000이 출력되도록 만든것
                  FROM MEMBER;
                  