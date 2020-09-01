<2020-09-01>

    1. ���� ���ν���(Stored Procedure)
        ����Ͻ� ������ ó���ϴ� ����� �ۼ��Ͽ� �������ϰ�
        �ش� ����� �ʿ��Ѱ����� �Լ�ó�� ȣ�� �� �� �ִ� ����
        
        �����ϵ� ���ν����� ĳ�ø޸𸮿� ����Ǿ� ó�� �ӵ��� ������,
        ��Ʈ��ũ�� Ʈ���� ���� ȿ���� �ִ�.
        
        ����ڿ��� ���� ����� ���߱� ������ ���ȼ��� Ȯ���ȴ�.
        ���ν����� ��ȯ���� ����.
        
        '������' : �Ű����������� ���� P_�� �����Ѵ�.
        '���' : IN(�Է¿�), OUT(��¿�), IN/OUT(����� ����), DEFAULT(IN)
        'Ÿ�Ը�' : �Ű������� Ÿ������ ũ�� ������ �����ʴ´�.
        
        ������� :
            CREATE [OR REPLACE] PROCEDURE ���ν����� [(
                ������ [���] Ÿ�Ը� [:=DEFAULT ��],
                ������ [���] Ÿ�Ը� [:=DEFAULT ��],
                ...
                ������ [���] Ÿ�Ը� [:=DEFAULT ��])]
            IS | AS
                ����;
            BEGIN
                ó����;
                EXCEPTION
                    ����ó����;
            END;
            
        ���๮ ������� :
            EXEC | EXECUTE ���ν�����[(�Ű����� | ��...)];
            /* PL/SQL���� ���ν��� ����� EXEC | EXECUTE ���� */
        
        ex. ȸ�����̺��� 'd001'ȸ���� ȸ����ȣ�� �Է¹޾� ȸ����, �ּ�, ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�.
        
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
            
        ex. ��ǰ���̺��� �з��ڵ� 'P301'�� ���� ��ǰ�� ��ǰ��, �з��ڵ�, ���԰���, ���Ⱑ����
            ����ϴ� ���ν����� �ۼ��Ͻÿ�.
        
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
            
            
        ex. 2005�� 6�� ���� ���� �Ǹŵ� ��ǰ�� ��ǰ�ڵ�� ������ �Է¹޾� ������ ���̺�
            �ش���ǰ�� ���� ��� �����Ͻÿ�.
            (2005�� 6�� ���� ���� �Ǹŵ� ��ǰ�� ��ǰ�ڵ�� ����)
        
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