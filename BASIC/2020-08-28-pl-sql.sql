<2020-08-28>

    1. PL/SQL
        procedual language SQL�� �����̴�.
        ������ ����� Ư¡�� ����, �б⹮, �ݺ���, ����ó�� ���� ����� ������ SQL�̴�.
        ��� �ڵ尡 DB���ο� �����ǰ� �����ϵǾ� ����Ǳ� ������ ���� �ӵ��� ������.
        PL/SQL�� ����ϸ� ��Ʈ��ũ�� Ʈ������ �����Ѵ�.
        ǥ�� ������ ����.
        Anonymous Block, stored Procedure, User Defined Function, Package
        
        
            
        1-1. �͸��� (Anonymous Block)
            �⺻���� PL/SQL�� ������ �����Ѵ�.
            �̸��� ���� ���
            
            --------------------------------------------
            �⺻����
                ����� (����, ���, Ŀ��)
                
            BEGIN
                ����� (sql������ �����Ͽ� ����Ͻ� ���� ó��)
                [EXCEPTION ����ó��]
                
            END;
            --------------------------------------------
                ex. ������������ ���� �����ϰ� ¦������ Ȧ������ �����Ͽ� ����ϴ� �͸����� �ۼ��Ͻÿ�.
                
                solution.
                    ACCEPT NUM1 PROMPT '���� �Է� : '
                    DECLARE
                        V_NUM NUMBER := 0;
                        --NUMBER�� 0���� �ʱ�ȭ ���ذ��̴�.
                        --�ʱ�ȭ���� ���������� Ÿ�Կ� ������� �ʱⰪ�� NULL�� �ȴ�.                
                        V_MESSAGE VARCHAR2(100);
                    BEGIN
                        V_NUM := TO_NUMBER('&NUM1');
                        --BEGIN�� C����� SCANF�����̴�.
                        --NUM1�� ���� �Է¹޾� V_NUM���� �����Ѵ�.
                        IF MOD(V_NUM, 2) = 0 THEN 
                            V_MESSAGE := V_NUM||'�� ¦���Դϴ�.';
                        ELSE 
                            V_MESSAGE := V_NUM||'�� Ȧ���Դϴ�.';
                        --'%'�����ڰ� �������� �ʱ⶧���� MOD�� ����Ѵ�.
                        END IF;
                            DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
                        
                            EXCEPTION WHEN OTHERS THEN
                            DBMS_OUTPUT.PUT_LINE('���ܹ߻�'||SQLERRM);
                        END;

        
        1-2. ����
            �ٸ� �������α׷� ����� ���� ����� �����ϴ�.
            ���� �Ϲ� ������ 'V_'��, �Ű������� 'P_'�� �ο��Ѵ�.
            
            ����Ÿ��
                ǥ�� SQL���� ����ϴ� Ÿ�԰� �����ϸ� �߰������� BOOLEAN, BINARY_INTEGER, PLS_INTEGER�� �����ȴ�.
                BOOLEAN : ����(true, false, null)
                BINARY_INTEGER, PLS_INTEGER : -2^31 ~ 2^31-1 ������ ������ ó���� �� �ִ�.
            ��������
                ������ Ÿ�� [:=�ʱⰪ];
                
            ����Ÿ��
                ���̺��.�÷���%TYPE
                    ex. V_PD PROD.PROD_DELIVERY%TYPE;
                ���̺��%ROWTYPE
            
            ex. ȸ�����̺��� ȸ���� ������ �Է¹޾� ȸ����ȣ, ȸ����, ���ϸ����� ����ϴ� �͸����� �ۼ��Ͽ���.
            
            solution.
                ACCEPT A_JOB PROMPT '���� : '
                DECLARE 
                    V_NAME MEMBER.MEM_NAME%TYPE;
                    V_ID MEMBER.MEM_ID%TYPE;
                    V_MILE MEMBER.MEM_MILEAGE%TYPE;
                    --V_NAME�� MEMBER ���̺��� MEM_NAME�÷��� ������Ÿ���� �����Ѵ�.
                    --V_NAME�� MEMBER ���̺��� MEM_ID�÷��� ������Ÿ���� �����Ѵ�.
                    --V_NAME�� MEMBER ���̺��� MEM_MILEAGE�÷��� ������Ÿ���� �����Ѵ�.
                    
                    CURSOR CUR_MEM(V_JOB MEMBER.MEM_JOB%TYPE) IS
                        SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
                          FROM MEMBER
                         WHERE MEM_JOB = V_JOB;
                         --���� 4���� Ŀ���� �����ϴ°��̰� �����ϴ°��� BEGIN����̴�.
                BEGIN
                    OPEN CUR_MEM('&A_JOB');
                    LOOP
                        FETCH CUR_MEM INTO V_ID, V_NAME, V_MILE;
                        --INTO �ڿ� ����� ������ ���� ���ʴ�� �Ҵ��Ѵ�.
                        EXIT WHEN CUR_MEM%NOTFOUND;
                        /*
                        CURSOR ����
                          IS-OPEN,
                          FOUND(FETCH�� ������� �����Ͱ� �����ϴ� ��� TRUE)
                          NOTFOUND(FETCH�� ��� �����Ͱ� ���� ��� TRUE) 
                          COUNT : Ŀ���ȿ� �� ���� �ִ���
                        */
                        DBMS_OUTPUT.PUT_LINE(V_ID||', '||V_NAME||', '||V_MILE);
                    END LOOP;
                    DBMS_OUTPUT.PUT_LINE(CUR_MEM%ROWCOUNT);
                    CLOSE CUR_MEM;
                END;
                    
                
        1-3. ���
            �ٸ� ���� ���α׷� ����� ��� ����� �����ϴ�.
            
            ���� ���� 
                �ĺ���(������) CONSTANT Ÿ�� [:=�ʱⰪ];
                
        1-4. CURSOR
            SQL ����� ��� ����
            ���� ����� �аų� �����ϰų� ������ �۾��� �����ϱ� ���� Ŀ���� ����Ѵ�.
            
            Ŀ�� ���ܰ�
                ����(DECLARE) -> OPEN -> FETCH -> CLOSE
                OPEN ~ CLOSE�� BEGIN������ ó���ȴ�.
            
            Ŀ�� ��������
                CURSOR Ŀ����[(�Ű����� Ÿ��)]
                IS
                    SELECT 
                      FROM
                     WHERE
                   /*
                   '�Ű�����'�� ���� �����ϴ� ���� OPEN������ �����Ѵ�.
                    IS������ ���� �����ϴ� ���� �ƴ϶� ���� �ϴ°��̴�.
                    */
                    
            Ŀ�� ���࿵��
                (1) OPEN Ŀ����(�� [, ��...]);
                
                (2) FETCH Ŀ���� INTO ������[, ������...];
                /*
                FETCH
                    Ŀ���� �����ϴ� �����͸� ������� �о� ������ �����Ѵ�.
                    '����'�� ����ο��� ����� ������ ����Ѵ�.
                    Ŀ���� ���� SELECT���� ����� �÷��� ������ ����, Ÿ���� ��ġ
                    FETCH���� �ݺ��� �ȿ� ����ؾ� �Ѵ�(�ݺ����� ������� ������ �� ù�ٸ� �о�´�)
                */
                
                (3) CLOSE Ŀ����;
                /*
                ����� ����� Ŀ���� �ݾ��ִ� ������ �Ѵ�.
                �ѹ� CLOSE�� Ŀ���� �� �̻� OPEN �Ұ����ϴ�.
                */
                
                (4) Ŀ�� �Ӽ�
                ----------------------------------------------------------------
                Ŀ����%ISOPEN      Ŀ���� OPEN���θ� Ȯ���Ѵ� (CURSOR IS OPEN ? TRUE : FALSE)
                Ŀ����%FOUND       Ŀ���� �о�� �ڷᰡ �ְų� ����� �� ���̶� �����ϸ� TRUE
                Ŀ����%NOTFOUND    Ŀ����%FOUND�� �ݴ밳��
                Ŀ����%ROWCOUNT    Ŀ�� ��� ���տ� �����ϴ� �� ���� ��ȯ
                
                etc. ������ Ŀ���� �Ӽ��� 'Ŀ����'��� 'SQL'�� ����Ѵ�.
                    (SQL%ISOPEN�� �׻� FALSE�̴�)
                
            ex. Ŀ���� ȸ��ID, �̸�, ���ϸ����� ������Ű�� �ش� ȸ���� �������� ����Ͻÿ�.
            
                            

                