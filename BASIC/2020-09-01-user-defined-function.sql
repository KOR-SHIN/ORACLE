<2020-09-01>

    1. 사용자 정의 함수(USER DEFINED FUNCTION)
        반환(한 개)값이 있음
        반환되는 위치는 함수 호출문의 위치이다.
        사용형식은 PROCEDURE와 유사하다.
        
        사용형식 : 
            CREATE [OR REPLACE] FUNCTION 함수명 [(
                매개변수 IN | OUT | INOUT 타입명 [:= DEFAULT 값],
                매개변수 IN | OUT | INOUT 타입명 [:= DEFAULT 값],
                ...
                매개변수 IN | OUT | INOUT 타입명 [:= DEFAULT 값]
                
                RETURN 타입명
                IS | AS
                BEGIN
                    RETURN 변수 | 값 | 수식;
                END;
                
                
                
        ex. 회원번호를 입력받아 나이를 반환하는 함수를 작성하시오.
        solution 1. COMPILE
            CREATE OR REPLACE FUNCTION FN_MEM01 (
                P_MEM_ID MEMBER.MEM_ID%TYPE)
                RETURN NUMBER
            IS
                V_AGE NUMBER := 0;
            BEGIN
                SELECT EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM MEM_BIR) INTO V_AGE
                  FROM MEMBER
                 WHERE MEM_ID = P_MEM_ID;
                RETURN V_AGE;
                
                EXCEPTION WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('오류발생 : '||SQLERRM);
                RETURN NULL;
            END;
            
        solution 1-1. EXCUTE
            SELECT MEM_NAME AS 회원명,
                   FN_MEM01(MEM_ID) AS 나이,
                   MEM_MILEAGE AS 마일리지
              FROM MEMBER
             WHERE FN_MEM01(MEM_ID) >= 50;
             
        ex. 상품코드와 년도를 입력받아 매출액집계를 반환하는 함수를 작성하시오.
            (단, Alias는 상품코드, 상품명, 매출액합계이다)
        
        solution 1. COMPILE
            CREATE OR REPLACE FUNCTION FN_CART01 (
                P_ID PROD.PROD_ID%TYPE,
                P_YEAR CHAR)
                RETURN NUMBER
            IS
                V_SUM NUMBER(15) := 0;
                V_YEAR CHAR(5) := P_YEAR||'%';
            BEGIN
                SELECT SUM(CART_QTY * PROD_PRICE)
                       INTO V_SUM
                  FROM CART, PROD
                 WHERE CART_PROD = P_ID
                   AND PROD_ID = CART_PROD
                   AND CART_NO LIKE V_YEAR;
                RETURN V_SUM;
            END;
        
        solution 1-1. EXCUTE
            SELECT PROD_ID AS 상품코드,
                   PROD_NAME AS 상품명,
                   FN_CART01(PROD_ID, '2005') AS 매출액합계
              FROM PROD;
            