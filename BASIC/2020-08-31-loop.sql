<2020-08-31>

    1. �ݺ���
        PL/SQL�� �ݺ������� LOOP, WHILE, FOR���� �����ȴ�.
        
        1-1. LOOP
            �ݺ����� �⺻����
            '����'�� ���̸� �ݺ����� �����Ѵ�. (ȥ������ �ʵ��� �����Ѵ�.)
            
            ������� : 
                LOOP
                    �ݺ�ó����;
                    EXIT WHEN ����;
                END LOOP;
                
            ex. ���� �Է¹޾� �ش� �������� ����Ͻÿ�.
            
            solution.
                ACCEPT P_BASE PROMPT '��(2~9) �Է� : '
                DECLARE
                    V_BASE NUMBER := TO_NUMBER('&P_BASE');
                    V_CNT NUMBER := 1;
                BEGIN
                    LOOP
                        DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||V_CNT||'='||V_BASE*V_CNT);
                        EXIT WHEN V_CNT=9;
                        V_CNT := V_CNT+1;
                    END LOOP;
                END;
                
                
            ex. 1~50������ FIBONACCI NUMBER�� ���Ͻÿ�.
            solution.
                DECLARE
                    V_NUM NUMBER := 0; --�Ǻ���ġ ��
                    VP_NUM NUMBER := 1; -- ��(��) ��
                    VPP_NUM NUMBER := 1; -- ����(����) ��
                    V_RESULT VARCHAR2(100);
                    
                BEGIN
                    V_RESULT := TO_CHAR(VP_NUM)||', '||
                                TO_CHAR(VPP_NUM);
                    LOOP
                        V_NUM := VP_NUM + VPP_NUM;
                        EXIT WHEN V_NUM >= 50;
                        V_RESULT := V_RESULT||', '||
                                    TO_CHAR(V_NUM);
                        VPP_NUM := VP_NUM;
                        VP_NUM := V_NUM;
                    END LOOP;
                    DBMS_OUTPUT.PUT_LINE(V_RESULT);
                END;
                
            ex. ȸ�����̺��� ���ϸ����� 4000�̻��� ȸ���� �̸�, ����, ���ϸ����� ���ϴ� Ŀ���� �����ϰ�
                Ŀ������� ó���Ҷ� ������ �����ϸ� '����ȸ��', '����ȸ��'�� ����Ͻÿ�.
                
            solution.
                DECLARE
                    V_NAME MEMBER.MEM_NAME%TYPE;
                    V_JOB MEMBER.MEM_JOB%TYPE;
                    V_MILE MEMBER.MEM_MILEAGE%TYPE;
                    V_GENDER VARCHAR2(30);
                    V_ID CHAR(1);
                    
                    CURSOR CUR_MEM2 IS
                        SELECT MEM_NAME, MEM_JOB, MEM_MILEAGE
                          FROM MEMBER
                         WHERE MEM_MILEAGE >= 3000;
                
                BEGIN
                    OPEN CUR_MEM2;
                    LOOP
                        FETCH CUR_MEM2 INTO V_NAME, V_JOB, V_MILE;
                        /*
                        ������ ������ ������ CURSOR�� ���� �־��ش� 
                        (CUR_MEM2�� SELECT���� INTO�� ������ �����ؾ��Ѵ�)
                        */
                        EXIT WHEN CUR_MEM2%NOTFOUND;
                        SELECT SUBSTR(MEM_REGNO2, 1, 1) INTO V_ID
                          FROM MEMBER
                         WHERE MEM_NAME = V_NAME;
                         
                        IF V_ID = '1' OR V_ID='3' THEN
                           V_GENDER := '����ȸ��';
                        ELSE 
                           V_GENDER := '����ȸ��';
                        END IF;
                        
                        DBMS_OUTPUT.PUT_LINE('ȸ���� : ' || V_NAME);
                        DBMS_OUTPUT.PUT_LINE('���� :   ' || V_GENDER);
                        DBMS_OUTPUT.PUT_LINE('���� : ' || V_JOB);
                        DBMS_OUTPUT.PUT_LINE('���ϸ��� : ' || V_MILE);
                        
                    END LOOP;
                    DBMS_OUTPUT.PUT_LINE('ȸ���� : ' || CUR_MEM2%ROWCOUNT);
                    CLOSE CUR_MEM2;
                END;
                

        1-2. WHILE
            �ٸ� ���ø����̼� ���߾���� WHILE���� ���� ����� �����Ѵ�.
            '����'�� ���̸� �ݺ��� �����ϰ�, �����̸� �ݺ����� �����Ѵ�.
            ������� :
                WHILE ����
                    LOOP
                        �ݺ�ó����;
                END LOOP;
        
            ex. �������� 7���� ����Ͻÿ�.
            solution.
                DECLARE
                    V_CNT NUMBER := 0;
                    V_RESULT VARCHAR2(50);
                BEGIN
                    WHILE V_CNT < 9 LOOP
                        V_CNT := V_CNT+1;
                        V_RESULT := '7 * '||V_CNT||' = '||V_CNT*7;
                        DBMS_OUTPUT.PUT_LINE(V_RESULT);
                    END LOOP;
                END;
                
            ex. ������̺��� �μ��ڵ� 50���� �μ��� �����, �μ���, ��å���� �����ϴ�
                Ŀ���� �����ϰ� ����ϴ� PL/SQL�� �ۼ��Ͽ���.
                /* LOOP, FOR�� ����ϴ� CURSOR�� ����ϰ��� �ϴ� �����͸� ���� ������ �ݵ�� �����ؾ� �Ѵ�. */
            solution.
                DECLARE
                    V_EMP_NAME EMPLOYEES.EMP_NAME%TYPE;
                    V_DEFT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                    V_JOB_NAME JOBS.JOB_TITLE%TYPE;
            
                    CURSOR CUR_EMP02 IS
                        SELECT A.EMP_NAME, B.DEPARTMENT_NAME, C.JOB_TITLE
                          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                           AND A.JOB_ID = C.JOB_ID
                           AND A.DEPARTMENT_ID = 50;
                BEGIN
                    OPEN CUR_EMP02;
                    FETCH CUR_EMP02 INTO V_EMP_NAME, V_DEFT_NAME, V_JOB_NAME;
                    WHILE CUR_EMP02%FOUND LOOP
                        DBMS_OUTPUT.PUT_LINE('����� : ' || V_EMP_NAME);
                        DBMS_OUTPUT.PUT_LINE('�μ��� : ' || V_DEFT_NAME);
                        DBMS_OUTPUT.PUT_LINE('��å�� : ' || V_JOB_NAME);
                        DBMS_OUTPUT.PUT_LINE('--------------------------');
                    FETCH CUR_EMP02 INTO V_EMP_NAME, V_DEFT_NAME, V_JOB_NAME;
                    END LOOP;
                    DBMS_OUTPUT.PUT_LINE('��� �� : ' || CUR_EMP02%ROWCOUNT);
                    CLOSE CUR_EMP02;
                END;
                

        1-3. �Ϲ� FOR��
            �ٸ� ���ø����̼� ���߾���� FOR���� ������ �����Ѵ�.
            '�ε���'�� �ý��ۿ��� �����ȴ�. (�������� �ʾƵ� �ȴ�)
            ������� : 
                FOR �ε��� IN [REVERSE] �ʱⰪ..������
                    LOOP
                        �ݺ�ó����;
                END LOOP;
           
           
            ex. �������� 7���� ����Ͻÿ�.
            
            solution.
                DECLARE
                    V_BASE NUMBER := 7;
                    V_RESULT VARCHAR2(30);
                BEGIN
                    FOR I IN 1..9 LOOP
                        V_RESULT := V_BASE||' * '||I||' = '||V_BASE*I;
                    DBMS_OUTPUT.PUT_LINE(V_RESULT);
                    END LOOP;
                END;
                
            ex. �������� 7���� �������� ����Ͻÿ�.
                DECLARE
                    V_BASE NUMBER := 7;
                    V_RESULT VARCHAR2(30);
                BEGIN
                    FOR I IN REVERSE 1..9 LOOP
                        V_RESULT := V_BASE||' * '||I||' = '||V_BASE*I;
                    DBMS_OUTPUT.PUT_LINE(V_RESULT);
                    END LOOP;
                END;
                
                
        1-4. CURSOR�� ����ϴ� FOR��
            Ŀ���� OPEN, FETCH, CLOSE���� ���������ϴ� (FOR�� �ȿ��� �ڵ����� ó���ȴ�)
            Ŀ���� �÷����� '���ڵ��.�÷���'���� �����Ѵ�. (���� ������ ���ʿ��ϴ�)
            ���ڵ���� �ý��ۿ��� �����ȴ� (������ ���ʿ��ϴ�)
            
            ������� :
                FOR ���ڵ�� IN Ŀ���� LOOP
                    Ŀ�� ó����;
                END LOOP;
            
            
            ex. ������̺��� �μ��ڵ� 50���� �μ��� �����, �μ���, ��å���� �����ϴ�
                Ŀ���� �����ϰ� ����ϴ� PL/SQL�� �ۼ��Ͽ���.
            solution.
                DECLARE
                    CURSOR CUR_EMP03 IS
                        SELECT A.EMP_NAME AS ENAME,
                               B.DEPARTMENT_NAME AS DNAME,
                               C.JOB_TITLE AS JNAME
                          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                           AND A.JOB_ID = C.JOB_ID
                           AND A.DEPARTMENT_ID = 50;
                BEGIN
                    FOR REC_EMP IN CUR_EMP03 LOOP
                        DBMS_OUTPUT.PUT_LINE('����� : ' || REC_EMP.ENAME);
                        DBMS_OUTPUT.PUT_LINE('�μ��� : ' || REC_EMP.DNAME);
                        DBMS_OUTPUT.PUT_LINE('��å�� : ' || REC_EMP.JNAME);
                        DBMS_OUTPUT.PUT_LINE('--------------------------');
                    END LOOP;
                END;
                        
            ex. Ű����� ������ �Է� �޾� �ش� ������ ���� ȸ���� �̸�, ����, ���ϸ����� ����ϴ�
                Ŀ���� for���� �̿��Ͽ� �ۼ��Ͽ���.
                
            solution 1.
                ACCEPT P_JOB PROMPT '���� : '
                DECLARE
                    V_JOB MEMBER.MEM_JOB%TYPE;
                    
                    CURSOR CUR_MEM_JOB IS
                        SELECT MEM_NAME, MEM_JOB, MEM_MILEAGE
                          FROM MEMBER
                         WHERE MEM_JOB = '&P_JOB';
                BEGIN
                    FOR REC_MEM IN CUR_MEM_JOB LOOP
                        DBMS_OUTPUT.PUT_LINE('ȸ���� : '||REC_MEM.MEM_NAME);
                        DBMS_OUTPUT.PUT_LINE('���� : '||REC_MEM.MEM_JOB);
                        DBMS_OUTPUT.PUT_LINE('���ϸ��� : ' ||REC_MEM.MEM_MILEAGE);
                    END LOOP;
                END;    
            
            solution 2. IN-LINE FOR��
                ACCEPT P_JOB PROMPT '���� : '
                DECLARE
                BEGIN
                    FOR REC_MEM IN
                        (SELECT MEM_NAME, MEM_JOB, MEM_MILEAGE
                           FROM MEMBER
                          WHERE MEM_JOB='&P_JOB')
                    LOOP
                        DBMS_OUTPUT.PUT_LINE('ȸ���� : '||REC_MEM.MEM_NAME);
                        DBMS_OUTPUT.PUT_LINE('���� : '||REC_MEM.MEM_JOB); 
                        DBMS_OUTPUT.PUT_LINE('���ϸ��� : ' ||REC_MEM.MEM_MILEAGE);
                    END LOOP;
                END;
                        
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                