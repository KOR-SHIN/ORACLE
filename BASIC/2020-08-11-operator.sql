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
         패턴비교 연산자
         '%', '_' 와일드카드 사용
         '%' : 사용된 위치 이후의 모든 문자열과 대응
            ex. '김%' -> '김'으로 시작되는 모든 문자열과 대응
         '_' : 사용된 위치에서 한글자와 대응
            ex. '홍_동' -> 첫 글자가 '홍'이고 3글자로 구성되고 마지막 글자가 '동'인 문자열과 대응
        패턴비교를 통해 특정 키워드가 들어간 문자열을 삭제하거나, 가져오는 동작이 가능하다.
        LIKE 연산자는 문자열 비교에만 사용한다.
        LIKE 연산자는 관계연산자를 사용하지 않는다.
    
    ex. 회원테이블에서 거주지가 '서울'인 회원을 조회하시오.
        (단, Alias는 회원번호, 회원명, 성별, 주소, 마일리지이며, 주소는 상세주소까지 출력하여라.)
    solution.
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               CASE WHEN SUBSTR(MEM_REGNO2, 1, 1)='1' THEN '남성회원'
                    ELSE '여성회원' END AS 성별,
                /*
                CASE WHEN IF(조건문)
                THEN : TRUE인 경우 
                ELSE : FLASE인 경우 
                END : CASE문 종료
                */
                MEM_ADD1||'-'||MEM_ADD2 AS 주소,
                MEM_MILEAGE AS 마일리지
           FROM MEMBER
          WHERE MEM_ADD1 LIKE '서울%';
       -- WHERE SUBSTR(MEM_ADD1, 1, 2) = '서울' (처리속도가 LIKE연산자보다 빠르다)
    
    ex. 매입테이블(BUYPROD)에서 2005년 5~6월에 매입한 전자제품(P102)매입 현황을 조회하시오.
        (단, Alias는 날짜(DATE), 제품코드(PROD), 수량(QTY), 단가(COST), 금액(QTY*COST)
        (BUYER는 거래처, BUYPROD는 매입장, CART는 매출장)
        
    soltion.
        SELECT BUY_DATE AS 날짜,
               BUY_PROD AS 제품코드,
               BUY_QTY AS 수량,
               BUY_COST AS 단가,
               BUY_QTY * BUY_COST AS 금액
          FROM BUYPROD
         WHERE BUY_DATE >= '20050501'
           AND BUY_DATE <= '20050630'
           AND BUY_PROD LIKE 'P102%'
            -- SUBSTR(BUY_PROD, 1, 4) = 'P102'
      ORDER BY 3 DESC, 1 DESC;
         /*
         ORDER BY <COLUMN | COLUMN NUMBER(1, 2, 3..)> DESC 내림차순 
         ORDER BY <COLUMN | COLUMN NUMBER(1, 2, 3..)> ASC 오름차순 
         키워드를 생략하면 ASC로 정렬된다.
         ORDER BY 첫 번째 조건에서 정렬이 안되는 것(중복값이 있는 경우)은 두 번째 조건을 기준으로 정렬한다.

         BUY_PROD LIKE 'P102' (문자열를 비교할때는 대소문자를 비교한다)
         UPPER(BUY_PROD) LIKE 'P102' (PROD에 있는 데이터를 대문자로 바꿔서 비교하기)
         LOWER(BUY_PROD) LIKE 'p102' (PROD에 있는 데이터를 소문자로 바꿔서 비교하기)
         */
    
    
    6. BETWEEN ~ AND 조건식
        범위를 지정하여 비교하는 경우 사용한다.
        AND(논리연산자)를 대신하여 사용 가능하다.
        문자열, 숫자, 날짜 타입 모두에 적용 가능하다.
        사용형식 : 컬럼명|수식 BETWEEN 값1 AND 값2
                  '컬럼명|수식'에 저장된 값이 '값1'<= 값<='값2'를 만족하면 참(TRUE)이다.
        
    ex. 매입테이블(BUYPROD)에서 2005년 5~6월에 매입한 전자제품(P102)매입 현황을 조회하시오.
        (단, Alias는 날짜(DATE), 제품코드(PROD), 수량(QTY), 단가(COST), 금액(QTY*COST)이고 BETWEEN을 사용해야 한다.)
        
    solution.
        SELECT BUY_DATE AS 날짜,
               BUY_PROD AS 제품코드,
               BUY_QTY AS 수량,
               BUY_COST AS 단가,
               BUY_QTY * BUY_COST AS 금액
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN '20050501' AND '20050630'
           AND BUY_PROD LIKE 'P102%'
            -- SUBSTR(BUY_PROD, 1, 4) = 'P102'
      ORDER BY 3 DESC, 1 DESC;
    
    ex. 장바구니테이블(CART)에서 2005년 6월 회원별 구매현황을 조회하시오.
        (단, Alias는 회원번호, 구매금액합계)
      
    solution.  
        SELECT CART_MEMBER AS 회원번호,
               SUM(CART_QTY * PROD_PRICE) AS "구매금액 합계",
               MEM_NAME AS 회원명
          FROM CART , PROD, MEMBER
         WHERE CART_PROD = PROD_ID --JOIN 조건
           AND CART_MEMBER = MEM_ID
           AND CART_NO LIKE '200506%'
      GROUP BY CART_MEMBER, MEM_NAME;
              
        /*
        CART_NO(8자리 날짜, 5자리는 순차적으로 부여되는 번호이다 00001 ~ 99999까지)
        CART_MEMBER (구매자 이름)
        CART_PROD (구매상품 코드)
        CART_QTY (구매수량)
        PROD_PRICE (판매단가)
        PROD_SAIL (할인단가)
        PROD_ID (상품코드)
        집계함수를 사용 할 때는 GROUP BY를 사용해야한다.
        */
        
          
    ex. 사원테이블(EMPLYOEES)에서 급여가 5000 ~ 12000 사이의 사원정보를 조회하시오
        (단, Alias는 사원번호, 사원명, 급여, 직무코드(JOB_ID))
        
    solution.
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               SALARY AS 급여,
               JOB_ID AS 직무코드
          FROM EMPLOYEES
         WHERE SALARY BETWEEN 5000 AND 12000
      ORDER BY SALARY, EMPLOYEE_ID;
    
         
         
         
         
         