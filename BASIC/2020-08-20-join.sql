<2020-08-20>

    1. JOIN
        RDB의 핵심 기능이다.
        조회할 컬럼이 여러 개의 테이블에 분산되어 저장 된 경우,
        테이블 사이의 관계(Relationship)을 이용하여 검색할 때 사용한다.
        
        일반 JOIN과 ANSI JOIN으로 구분된다.
        관계가 맺어지지 않은 테이블간의 JOIN은 절대 발생하지 않는다. (직접관계, 간접관계 모두 가능)
        
        ** 관계 : A 테이블의 기본키가 B 테이블의 외래키로 사용되는 경우
        ** 비식별 : A테이블의 기본키가 B 테이블의 일반 항목으로 들어가 있는 경우
        ** 식별자관계 : A테이블의 기본키가 B 테이블의 외래키이자 기본키인 경우 (A <- B 상속관계)
        
        1-1. Cartesian Product
            모든 행들의 조합을 결과로 반환한다.
                ex. A 테이블이 100행 20열, B 테이블이 2000행 10열로 구성되었다면,
                    A, B 테이블의 Cartesian Product 결과는 200000행, 30열로 결과값을 반환한다.
            JOIN조건이 없는 경우, JOIN조건을 잘못 기술한 경우, Cartesian Product가 실행된다.
            ANSI에서는 CROSS JOIN이라고 부른다.
            불가피한 경우가 아니라면, Cartesian Product는 사용하지 않는다.
            
                ex. CART TABLE의 행의 수
                    SELECT COUNT(*) FROM CART;
                    
                ex. MEMBER TABLE의 행의 수
                    SELECT COUNT(*) FROM MEMBER;
                    
                ex. CART TABLE과 MEMBER TABLE에 Cartesian Product를 수행
                    SELECT COUNT(*)
                      FROM MEMBER, CART
                      
        1-2. Equi-JOIN
            JOIN조건에 '='연산자를 사용하는 조인형식
            조인조건은 사용된 테이블의 갯수가 n개일 경우, JOIN조건은 적어도 n-1개 이상이어야 한다.
            내부조인이라고 부르기도 한다.
            일치하지 않는 데이터(행 단위)는 무시하여 결과로 나타내지 않는다.
            ANSI에서는 INNER JOIN이라고 한다.
            
                ex. 일반조인
                    SELECT <컬럼 LIST>
                      FROM <테이블 이름 [별칭]>, <테이블 이름 [별칭]>
                     WHERE <JOIN 조건 1>
                      [AND <JOIN 조건 2>]
                      
                ex. ANSI 조인
                    SELECT <컬럼 LIST>
                      FROM <테이블 1 이름 [별칭]>
                INNER JOIN <테이블 2 이름> ON (조인 조건 1)
                      [AND <일반 조건>]
                    [WHERE <일반 조건>]
               [INNER JOIN <테이블 3 이름> ON (조인 조건 1) <- 테이블 1과 테이블 2의 조인결과와 테이블 3을 조인하는 것
                      [AND <일반 조건>]
                    [WHERE <일반 조건>]]
                    
                    
                    
                ex. 사원테이블에서 사원정보를 조회하시오.
                    (단, Alias는 사원번호, 사원명, 부서코드, 부서명)
                
                solution 1. 일반조인 
                    SELECT EMPLOYEE_ID AS 사원번호,
                           EMP_NAME AS 사원이름,
                           B.DEPARTMENT_ID AS 부서코드,
                           DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  ORDER BY B.DEPARTMENT_ID
                  
                solution 2. ANSI 조인
                    SELECT A.EMPLOYEE_ID AS 사원번호,
                           A.EMP_NAME AS 사원이름,
                           A.DEPARTMENT_ID AS 부서코드,
                           B.DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A
                INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
                  ORDER BY B.DEPARTMENT_ID
                  
                
                ex. 사원테이블에서 100번 부서의 사원정보를 조회하시오.
                    (단, Alias는 사원번호, 사원명, 부서코드, 부서명)
                    
                solution 1. 일반조인
                    SELECT EMPLOYEE_ID AS 사원번호,
                           EMP_NAME AS 사원이름,
                           B.DEPARTMENT_ID AS 부서코드,
                           DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                       AND A.DEPARTMENT_ID = 100
                                         
                solution 2. ANSI 조인
                    SELECT A.EMPLOYEE_ID AS 사원번호,
                           A.EMP_NAME AS 사원이름,
                           A.DEPARTMENT_ID AS 부서코드,
                           B.DEPARTMENT_NAME AS 부서명
                      FROM EMPLOYEES A
                INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
                     WHERE A.DEPARTMENT_ID = 100
                
                
                ex. 2005년 6월 상품별 매출현황을 조회하시오.
                    (단, Alias는 상품코드, 상품명, 금액이다)
                    
                solution 1. 일반조인
                    SELECT B.PROD_ID AS 상품코드,
                           B.PROD_NAME AS 상품명,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS 금액                          
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO BETWEEN '20050601' AND '20050630'
                  GROUP BY B.PROD_ID, B.PROD_NAME
                  ORDER BY 1
                  
                solution 2. ANSI 조인
                    SELECT B.PROD_ID AS 상품코드,
                           B.PROD_NAME AS 상품명,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS 금액                          
                      FROM CART A
                INNER JOIN PROD B ON (A.CART_PROD = B.PROD_ID)
                     WHERE A.CART_NO BETWEEN '20050601' AND '20050630'
                  GROUP BY B.PROD_ID, B.PROD_NAME
                  ORDER BY 1