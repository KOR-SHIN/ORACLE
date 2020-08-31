<2020-08-31>

    1. IF��
        �ٸ� ���� ���α׷������ IF���� ���� ����� ������
        ������� 1. 
            IF ���� THEN
                ��� 1;
            [ELSE
                ��� 2;]
            END IF;
            
        ������� 2. 
            /* Nested IF*/
            IF ���� 1 THEN
                ��� 1;
            ELSIF ���� 2 THEN
                ��� 2;
            ELSIF ���� 3 THEN
                ��� 3;
            ELSE
                ��� 4;
            END IF
            
        ������� 3.
            /*Nested IF*/
            IF ���� 1: THEN
                IF ���� 2: THEN
                    ��� 1;
                ELSE
                    ��� 2;
                END IF;
                /*���� IF�������� �ݵ�� END IF�� ���ش�*/
            ELSE 
                ��� 3;
            END IF
            
            
        ex. ������ �μ��ڵ�(10-110)�� �ϳ� �����Ͽ� �ش�μ��� ���� ��������� ��ȸ�ϰ� 
            ù ��° �˻��� ����� �޿��� 3000�̸��̸� '�����ӱ�', 3000~5999�̸� '�߰��ӱ�'
            �� �̻��̸� '���� �ӱ�'�� ����Ͻÿ�.
            ����� �����ʹ� �����, �μ���, �޿�, ����̴�.
            
        solution.
            DECLARE
                V_NAME EMPLOYEES.EMP_NAME%TYPE;
                V_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                V_SAL EMPLOYEES.SALARY%TYPE;
                V_REMARKS VARCHAR2(50);
                V_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
            BEGIN
                V_DEPT_ID := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
                /*
                10 ~ 110 ������ ������ �߻���Ų�� 
                10�� ���� �������� �߻���Ű�� ���� ���� 1�� �ڸ����� �ݿø��Ѵ�.
                */
                
                SELECT A.EMP_NAME,
                       B.DEPARTMENT_NAME,
                       A.SALARY INTO V_NAME, V_DEPT_NAME, V_SAL
                  FROM EMPLOYEES A, DEPARTMENTS B
                 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                   AND A.DEPARTMENT_ID = V_DEPT_ID
                   AND ROWNUM = 1;
                   
                IF V_SAL BETWEEN 1 AND 2999 THEN 
                   V_REMARKS := '�����ӱ�';
                ELSIF V_SAL BETWEEN 3000 AND 5999 THEN
                    V_REMARKS := '�߰��ӱ�';
                ELSE
                    V_REMARKS := '�����ӱ�';
                END IF;
                
                DBMS_OUTPUT.PUT_LINE(V_NAME||', '||V_DEPT_NAME||' ,'||V_SAL||'=>'||V_REMARKS);
                
            END;
            
