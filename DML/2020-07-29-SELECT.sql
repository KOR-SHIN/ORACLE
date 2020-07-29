<2020-07-29-02>
    
    1. SELECT
        테이블 내의 자료를 조회할 때 사용한다.
        사용형식 : SELECT [*|DISTINCT] <컬럼명>|EXPR [AS] ["]<컬럼별칭>["],
                        <컬럼명>|EXPR [AS] ["]<컬럼별칭>["],
                        <컬럼명>|EXPR [AS] ["]<컬럼별칭>["],
                        ...
                        <컬럼명>|EXPR [AS] ["]<컬럼별칭>["]
                    FROM <테이블명> [별칭]
                   [WHERE 조건]
                   [GROUP BY 컬럼명 [,컬럼명...]]
                   [HAVING 조건]
                   [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC]...]
        
        실행순서(GROUP BY, HAVING, ORDER BY 없는 경우) : FROM -> WHERE -> SELECT 
        실행순서(GROUP BY, HAVING, ORDER BY 있는 경우) : FROM -> WHERE -> (GROUP BY, HAVING, ORDER BY) -> SELECT
         /* 
         SELECT절에서 지정하는 컬럼별칭은 모든 절이 수행되고 나서 입력되는 것이기 때문에
         먼저 수행되는 다른 절은 SELECT에서 사용하는 별칭이름을 사용할 수 없다
         */
         
        컬럼별칭 지정시 "" 생략불가 경우 : 공백을 포함,오라클명령어, 오라클에서 사용불가 언어
        
        컬럼별칭 형식 : SELECT COLL AS "첫 번째 컬럼"
                             COLL AS 첫번째칼럼 --(가장많이 사용하는 형식)
                             COLL 첫번째칼럼
                             
        [WHERE 조건]: WHERE 조건절이 생략되면 컬럼의 모든 행을 조회한다.                     
        [ASC|DESC] : ASC는 오름차순정렬, DESC는 내림차순정렬을 지정한다. (생략시 DEFAULT : ASC)
        
               [*] : '*'은 해당 테이블에 있는 모든 컬럼을 조회 
        [DISTINCT] : 중복된 자료를 제외시켜주는 예약어
            ex. 회원테이블(MEMBER)에서 회원들의 주소지(광역시) 종류를 조회하시오.
                SELECT SUBSTR(MEM_ADD1, 1, 2) AS 주소지
                  FROM MEMBER; --모든 주소지 종류 출력
                  
                SELECT DISTINCT SUBSTR(MEM_ADD1, 1, 2) AS 주소지
                  FROM MEMBER; --중복값을 제거해준다.
        
            ex. 장바구니테이블(CART)에서 2005년 6월에 판매된 상품의 종류를 조회하시오. (판매상품 전체조회)
                -- 판매상품 종류조회는 중복을 배제해야 한다.
                SELECT COUNT(DISTINCT CART_PROD) AS 상품코드 
                  FROM CART
                 WHERE CART_NO LIKE '200506%'
                 ORDER BY CART_PROD;
                 -- COUNT(DISTINCT CART_PROD) 
                 -- CART_PROD 컬럼에서 중복을 제외한 행의 숫자를 반환해준다.
                 
            ex. 사원테이블(EMPLOYEES)에서 사용되는 부서코드를 조회하시오.
                SELECT EMPLOYEES.DEPARTMENT_ID AS 부서코드,
                       DEPARTMENT_NAME AS 부서명
                  FROM EMPLOYEES, DEPARTMENTS
                 WHERE EMPLOYEES.DEPARTMENT_ID= DEPARTMENTS.DEPARTMENT_ID
                 ORDER BY 1;
                  /*
                  [ORDER BY 1]
                    DEPARTMENT_ID를 기준으로 오름차순 정렬하라는 의미이다. (1 SELECT절에 나열된 컬럼 중 첫 번째)
                    '컬럼인덱스'는 SELECT절에 사용된 컬럼의 순번이다 (1부터 시작한다)
                  
                  TABLE 2개 이상 사용하는 경우를 JOIN이라고 하며, WHERE절을 생략하면 안된다.
                  
                  [WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID]
                     DEPARTMENT_ID가 두 테이블에 모두 존재하기 때문에 구분하기 위해 테이블명.컬럼명으로 작성한다.
                  */
                  
                SELECT DISTINCT A.DEPARTMENT_ID AS 부서코드,
                       DEPARTMENT_NAME AS 부서명
                  FROM EMPLOYEES A , DEPARTMENTS B
                 WHERE A.DEPARTMENT_ID= B.DEPARTMENT_ID
                 ORDER BY 1;
                 /*
                 [FROM EMPLOYEES A , DEPARTMENTS B]
                    테이블 별칭을 사용해서 코드를 짧게 사용가능하다.
                
                 JOIN에 사용된 TABLE개수에 따라 조건이 달라진다.
                    사용된 TABLE개수가 2개면 적어도 1개의 조건을 사용해야한다. (TABLE - 1)개
                    
                 TABLE에 동일한 컬럼이 없다면 두 TABLE은 관계가 없는것이다.
                 */