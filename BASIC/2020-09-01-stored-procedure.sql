<2020-09-01>

    1. 저장 프로시져(Stored Procedure)
        비즈니스 로직을 처리하는 모듈을 작성하여 컴파일하고
        해당 기능이 필요한곳에서 함수처럼 호출 할 수 있는 단위
        
        컴파일된 프로시져는 캐시메모리에 저장되어 처리 속도가 빠르고,
        네트워크의 트래픽 감소 효과가 있다.
        
        사용자에게 내부 모듈을 감추기 때문에 보안성이 확보된다.
        프로시져는 반환값이 없다.
        
        '변수명' : 매개변수명으로 보통 P_로 시작한다.
        '모드' : IN(입력용), OUT(출력용), IN/OUT(입출력 공용), DEFAULT(IN)
        '타입명' : 매개변수의 타입으로 크기 설정을 하지않는다.
        
        사용형식 :
            CREATE [OR REPLACE] PROCEDURE 프로시져명 [(
                변수명 [모드] 타입명 [:=DEFAULT 값],
                변수명 [모드] 타입명 [:=DEFAULT 값],
                ...
                변수명 [모드] 타입명 [:=DEFAULT 값])]
            IS | AS
                선언문;
            BEGIN
                처리문;
                EXCEPTION
                    예외처리문;
            END;
            
        실행문 사용형식 :
            EXEC | EXECUTE 프로시져명[(매개변수 | 값...)];
            /* PL/SQL에서 프로시져 실행시 EXEC | EXECUTE 생략 */
        
        ex. 회원테이블에서 'd001'회원의 회원번호를 입력받아 회원명, 주소, 직업을 출력하는 프로시져를 작성하시오.
        
        solution 1. COMPILE
            CREATE OR REPLACE PROCEDURE PROC_MEM01 (
                P_MEM_ID IN MEMBER.MEM_ID%TYPE)
            IS
                V_NAME MEMBER.MEM_NAME%TYPE;
                V_ADDR VARCHAR2(100);
                V_JOB MEMBER.MEM_JOB%TYPE;
            BEGIN
                SELECT MEM_NAME, MEM_ADD1||' '||MEM_ADD2,
                       MEM_JOB INTO V_NAME, V_ADDR, V_JOB
                  FROM MEMBER
                 WHERE MEM_ID = P_MEM_ID;
                DBMS_OUTPUT.PUT_LINE(V_NAME||', '||V_ADDR||', '||V_JOB);
            END;
            
        solution 1-1. EXECUTE
            EXECUTE PROC_MEM01('d001');
            
        ex. 상품테이블에서 분류코드 'P301'에 속한 상품의 상품명, 분류코드, 매입가격, 매출가격을
            출력하는 프로시져를 작성하시오.
        
        solution 1. COMPILE
            CREATE OR REPLACE PROCEDURE PROC_POD01 (
                P_ID IN PROD.PROD_ID%TYPE)
            IS
                V_PNAME PROD.PROD_NAME%TYPE;
                V_LGU LPROD.LPROD_GU%TYPE;
                V_COST PROD.PROD_COST%TYPE;
                V_PRICE PROD.PROD_PRICE%TYPE;
                V_RES VARCHAR(100);
            BEGIN
                SELECT PROD_NAME, PROD_LGU, PROD_COST, PROD_PRICE 
                       INTO V_PNAME, V_LGU, V_COST, V_PRICE
                  FROM PROD
                 WHERE PROD_ID = P_ID;
                V_RES := V_PNAME||' '||V_LGU||' '||V_COST||' '||V_PRICE;
                DBMS_OUTPUT.PUT_LINE(V_RES);
            END;
        
        solution 1-1. EXECUTE
            DECLARE
            BEGIN
                FOR REC_PR IN (SELECT PROD_ID
                                 FROM PROD
                                WHERE PROD_LGU = 'P301')
                    LOOP
                        PROC_POD01(REC_PR.PROD_ID);
                END LOOP;
            END;
            
            
        ex. 2005년 6월 가장 많이 판매된 상품의 상품코드와 수량을 입력받아 재고수불 테이블에
            해당제품에 대한 재고를 수정하시오.
            (2005년 6월 가장 많이 판매된 상품의 상품코드와 수량)
        
        solution 1. QUERY
            SELECT A.CART_PROD AS ID,
                   B.MAXQTY AS MQTY
              FROM CART A, (
                            SELECT CART_PROD AS CID,
                                   MAX(CART_QTY) AS MAXQTY
                              FROM CART
                             WHERE CART_NO LIKE '200506%'
                          GROUP BY CART_PROD
                          ORDER BY 2 DESC) B
             WHERE A.CART_PROD = B.CID
               AND A.CART_QTY = B.MAXQTY
               AND A.CART_NO LIKE '200506%'
               AND ROWNUM = 1;
            
        solution 2. PROCEDURE
            CREATE OR REPLACE PROCEDURE PROC_CART01(
                P_PROD IN CART.CART_PROD%TYPE,
                P_QTY IN NUMBER,
                P_DATE CART.CART_NO%TYPE)
            IS
                V_DATE DATE := TO_DATE(SUBSTR(P_DATE,1,8));
            BEGIN
                UPDATE REMAIN
                   SET REMAIN_O=REMAIN_O+P_QTY,
                       REMAIN_J_99=REMAIN_J_99-P_QTY,
                       REMAIN_DATE=V_DATE
                 WHERE REMAIN_YEAR='2005'
                   AND REMAIN_PROD=P_PROD;
            END;
            
        solution 2-1. EXECUTE
            DECLARE
                V_ID CART.CART_PROD%TYPE;
                V_QTY NUMBER(2) := 0;
                V_NO CART.CART_NO%TYPE;
            BEGIN
                SELECT A.CART_PROD, B.MAXQTY, A.CART_NO
                       INTO V_ID, V_QTY, V_NO
                  FROM CART A, (
                                SELECT CART_PROD AS CID,
                                       MAX(CART_QTY) AS MAXQTY
                                  FROM CART
                                 WHERE CART_NO LIKE '200506%'
                              GROUP BY CART_PROD
                              ORDER BY 2 DESC) B
                 WHERE A.CART_PROD = B.CID
                   AND A.CART_QTY = B.MAXQTY
                   AND A.CART_NO LIKE '200506%'
                   AND ROWNUM = 1;
                PROC_CART01(V_ID, V_QTY, V_NO);
            END;
            
            ROLLBACK
            
            SELECT *
              FROM REMAIN
             WHERE REMAIN_PROD = 'P302000014'