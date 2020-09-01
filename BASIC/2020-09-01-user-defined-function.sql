<2020-09-01>

    1. ����� ���� �Լ�(USER DEFINED FUNCTION)
        ��ȯ(�� ��)���� ����
        ��ȯ�Ǵ� ��ġ�� �Լ� ȣ�⹮�� ��ġ�̴�.
        ��������� PROCEDURE�� �����ϴ�.
        
        ������� : 
            CREATE [OR REPLACE] FUNCTION �Լ��� [(
                �Ű����� IN | OUT | INOUT Ÿ�Ը� [:= DEFAULT ��],
                �Ű����� IN | OUT | INOUT Ÿ�Ը� [:= DEFAULT ��],
                ...
                �Ű����� IN | OUT | INOUT Ÿ�Ը� [:= DEFAULT ��]
                
                RETURN Ÿ�Ը�
                IS | AS
                BEGIN
                    RETURN ���� | �� | ����;
                END;
                
                
                
        ex. ȸ����ȣ�� �Է¹޾� ���̸� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
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
                    DBMS_OUTPUT.PUT_LINE('�����߻� : '||SQLERRM);
                RETURN NULL;
            END;
            
        solution 1-1. EXCUTE
            SELECT MEM_NAME AS ȸ����,
                   FN_MEM01(MEM_ID) AS ����,
                   MEM_MILEAGE AS ���ϸ���
              FROM MEMBER
             WHERE FN_MEM01(MEM_ID) >= 50;
             
        ex. ��ǰ�ڵ�� �⵵�� �Է¹޾� ��������踦 ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
            (��, Alias�� ��ǰ�ڵ�, ��ǰ��, ������հ��̴�)
        
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
            SELECT PROD_ID AS ��ǰ�ڵ�,
                   PROD_NAME AS ��ǰ��,
                   FN_CART01(PROD_ID, '2005') AS ������հ�
              FROM PROD;
            