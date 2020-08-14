<2020-08-13-01>
    
    1. ���ڿ� �Լ�
        
        1-1. INITCAP, LOWER, UPPER
                LOWER(c) : �־��� �Ű�����(���ڿ�)�� ��� ���ڸ� �ҹ��ڷ� �����Ͽ� ��ȯ�Ѵ�.
                           �ַ� �񱳹����� ���ȴ�.
                
                ex. ������̺��� ����� �̸��� �̸��� ���� ���ڷ� ��ȯ�Ͽ� ����Ͻÿ�.
                
                solution.
                    SELECT EMP_NAME AS "����̸�(������)",
                           EMAIL AS "�̸���(������)",
                           LOWER(EMP_NAME) AS "�����(��ȯ��)",
                           LOWER(EMAIL) AS "�̸���(��ȯ��)"
                      FROM EMPLOYEES
                    
              
                ex. ������̺��� LAST NAME�� 'G'�� �����ϴ� ����� ��ȸ�Ͻÿ�.
                    (��, Alias�� �����, �μ��ڵ�, ��å�ڵ�, �޿�)

                solution.
                    SELECT EMP_NAME AS �����,
                           DEPARTMENT_ID AS �μ��ڵ�,
                           JOB_ID AS ��å�ڵ�,
                           SALARY AS �޿�
                      FROM EMPLOYEES
                     WHERE LOWER(SUBSTR(EMP_NAME, 1, 1)) = 'g';
                     
               
                ex. ��ǰ���̺�(PROD)���� �з��� ������ǰ(p102)�� ���� ��ǰ�� ���� ����Ͻÿ�.
                    
                solution.
                    SELECT COUNT(*)
                      FROM PROD
                     WHERE LOWER(PROD_LGU) ='p102';
                     
                ex. ������̺��� ����̸��� ��� �ҹ��ڷ� ��ȯ�Ͽ� �����Ͻÿ�.
                
                solution.
                    UPDATE EMPLOYEES
                       SET EMP_NAME = LOWER(EMP_NAME);
                       
                    SELECT EMP_NAME
                      FROM EMPLOYEES
                      
                      
            UPPER(c) : �Ű������� ����� ���ڿ��� ��� ���ڸ� �빮�ڷ� �����Ͽ� ��ȯ�Ѵ�.
            
                ex. ������̺��� ����̸��� ��� �빮�ڷ� ��ȯ�Ͽ� �����Ͻÿ�.
                
                solution.
                    UPDATE EMPLOYEES
                       SET EMP_NAME = UPPER(EMP_NAME);
                       
                    SELECT EMP_NAME 
                      FROM EMPLOYEES
                      
            INITCAP(c) : �� �ܾ��� ù ���ڸ� �빮�ڷ� �����Ͽ� ��ȯ�Ѵ�.
                         �̸� ǥ����� �ַ� ���ȴ�.
                         ������ �����ڷ� ���ڿ��� �����Ѵ�.
                         
                ex. ������̺��� �̸��� ù ���ڸ� �빮�ڷ� ��ȯ�Ͻÿ�.
                
                solution.
                    UPDATE EMPLOYEES
                       SET EMP_NAME = INITCAP(EMP_NAME);
                       
                    SELECT EMP_NAME 
                      FROM EMPLOYEES
                                 
        1-2. CONCAT
                ù ��° �Ű������� �� ��° �Ű������� ������ ���ڿ��� ��ȯ�Ѵ�.
                '||'�����ڿ� ������ ����� �����Ѵ�.
                ������� : CONCAT(c1, c2)
                
                ex. ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ���� ��ȸ�Ͻÿ�.
                    (��, Alias�� ȸ����, �ֹι�ȣ, ���ϸ���, �����̰� �ֹι�ȣ�� XXXXXX-XXXXXXX �������� ����ϸ�
                     CONCAT �Լ��� �̿��ؾ� �Ѵ�.)
                
                solution.
                    SELECT MEM_NAME AS ȸ����,
                           CONCAT(CONCAT(MEM_REGNO1, '-'), MEM_REGNO2) AS �ֹι�ȣ,
                           MEM_MILEAGE AS ���ϸ���,
                           MEM_JOB AS ����
                      FROM MEMBER
                     WHERE MEM_MILEAGE >= 3000
                     
        1-3. SUBSTR
                �־��� ���ڿ����� POS��ġ���� LEN���� ��ŭ�� ���ڿ��� �����Ͽ� ��ȯ�Ѵ�.
                POS���� 0�� ��� 1�� ����Ѵ�.
                LEN�� �����Ǹ� POS��ġ ������ ��� ���ڿ��� ��ȯ�Ѵ�.
                ���� ���� ���Ǵ� ���ڿ� �Լ��̴�.
                WHERE������ ���� ���ȴ�.
                
                ex. SUBSTR(MEM_NAME, 1, 3) : MEM_NAME�� ���ڿ� ù ��°���� 3���ڸ� �����Ͽ���.
                
                ex. ȸ�����̺��� �ֹε�Ϲ�ȣ�� �̿��Ͽ� ����ȸ������ ���̸� ����Ͻÿ�.
                    (��, Alias�� ȸ����, �ֹι�ȣ, ����, ���ϸ����̴�.)
                    
                soluton.
                    SELECT MEM_NAME AS ȸ����,
                           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
                           EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19'||SUBSTR(MEM_REGNO1, 1, 2)) AS ����,
                                                     -- 1900 + TO_NUMBER(SUBSTR(MEM_REGON,1 ,2) 2000��� ���� ������� ���� ������
                           MEM_MILEAGE AS ���ϸ���
                      FROM MEMBER
                     WHERE SUBSTR(MEM_REGNO2, 1, 1) = '2';
                    /*
                    EXTRACT : �����ϴ� �޼���
                    EXTRACT(YEAR FROM SYSDATE)
                    EXTRACT(MONTH FROM SYSDATE)
                    EXTRACT(DAY FROM SYSDATE)
                    
                    HOUR, MINUTE, SECOND�� TIMESTAMP�� ����ؾ� ��
                    SELECT SYSTIMESTAMP,
                           EXTRACT( HOUR FROM SYSTIMESTAMP) HOUR,
                           EXTRACT( MINUTE FROM SYSTIMESTAMP) MINUTE,
                           EXTRACT( SECOND FROM SYSTIMESTAMP) SECOND
                      FROM DUAL
                    */
                    
                QUIZ. ������̺��� �ټӳ�� 15�� �̻��� ����鿡�� Ư�� ���ʽ��� �����Ϸ��� �Ѵ�.
                      ���ʽ� = �޿� * (�ټӳ�� / 100)�̸� �Ҽ��� ù ° �ڸ����� �ݿø��ϸ� 
                      ���޾� = �޿� +  ���ʽ��̰�, �ټӳ���� �⵵�θ� ����Ѵ�.
                      ��, Alias�� �����, �μ��ڵ�, �Ի���, �ټӳ��, ���ʽ�, �޿�, ���޾��̴�.
                               
                solution.
                    SELECT EMP_NAME AS �����,
                           DEPARTMENT_ID AS �μ��ڵ�,
                           HIRE_DATE AS �Ի���,
                           EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE, 1, 4) AS �ټӳ��,
                           ROUND(SALARY * ( EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE, 1, 4)) / 100) AS ���ʽ�,
                           SALARY AS �޿�,
                           SALARY + SALARY * ((EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE, 1, 4)) / 100) AS ���޾�                    
                      FROM EMPLOYEES
                     WHERE EXTRACT(YEAR FROM SYSDATE) - SUBSTR(HIRE_DATE,1,4) >= 15
                ORDER BY HIRE_DATE DESC
                      
        1-4. LTRIM, RTRIM, TRIM
                ��ȿ�� ������ �����ϴ� �Լ�
                LTRIM�� ���ʿ� �����ϴ� ��ȿ�� ������ �����Ѵ�.
                RTRIM�� �����ʿ� �����ϴ� ��ȿ�� ������ �����Ѵ�.
                TRIM�� ���ʿ� �����ϴ� ��ȿ�� ������ �����Ѵ�.
                
                ������� : LTRIM(c, [,set]), RTRIM(c, [,set]), TRIM(c, [,set])
                �־��� ���ڿ� c���� set���� ������ ���ڿ��� ����(LTRIM), ������(RTRIM) ã�� ����
                set�� �����Ǹ� set�� ������ �ǹ��Ѵ�.
                
                VARCHAR2�� ��ȿ������ �˾Ƽ� ó���ϱ� ������ ����� �ʿ����.
                ������ ���ڰ� ���ڷ� ��ȯ�̵Ǿ� ���ĵ� �����̰ų�, ���������� ��ȿ������ ä���ִ� ������ Ÿ�Կ� ���ؼ��� ����Ѵ�.
               
                ex. �ŷ�ó���� ������ Ÿ���� CHAR(40) ���� �ٲٽÿ�.
                solution.
                    ALTER TABLE BUYER
                    MODIFY BUYER_NAME CHAR(40);
                
                
                ex. �ŷ�ó���̺��� �ŷ�ó���� '����'�� �ŷ�ó ������ ��ȸ�Ͻÿ�.
                    (��, Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�ּ��̰�, �ŷ�ó���̴�.)
                solution.
                    SELECT BUYER_ID AS �ŷ�ó�ڵ�,
                           BUYER_NAME AS �ŷ�ó��,
                           BUYER_ADD1||' '||BUYER_ADD2 AS �ŷ�ó�ּ�
                      FROM BUYER
                     WHERE BUYER_NAME = '����'
                
                
                ex. �ŷ�ó���̺��� �ŷ�ó���� '����'�� �ŷ�ó ������ ��ȸ�Ͻÿ�.
                    (��, Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�ּ��̰�, �ŷ�ó���� TRIM�� ����Ͽ� ������ �����Ѵ�)
                solution.
                    SELECT BUYER_ID AS �ŷ�ó�ڵ�,
                           RTRIM(BUYER_NAME) AS �ŷ�ó��,
                           BUYER_ADD1||' '||BUYER_ADD2 AS �ŷ�ó�ּ�
                      FROM BUYER
                     WHERE BUYER_NAME = '����'
                

                ex. �ŷ�ó���̺��� �ŷ�ó �⺻�ּ�(ADD1) �� ������ �ִ� �ŷ�ó�� �˻��Ͽ�
                    '����'���ڿ��� �����Ͻÿ�.
                solution.
                    SELECT BUYER_ID AS �ŷ�ó�ڵ�,
                           TRIM(BUYER_NAME) AS �ŷ�ó��,
                           LTRIM(BUYER_ADD1, '����') AS �⺻�ּ�
                      FROM BUYER
                     WHERE BUYER_ADD1 LIKE '����%'
                     /*
                     LTRIM(BUYER_ADD1, '����')�� ADD1���� ���ʿ� �ִ� '����%'�� �����Ǵ� �� ���Ž�Ų��.
                     RTRIM(BUYER_ADD1, '����')�� ��� ���Ž�Ű�� ���Ѵ� 
                            ex. ���� ����� ������ ��Ϻ���
                                -> RTRIM�� �����ʺ��� �񱳸� �����ϱ� ������ '��', '��'�� �����Ǵ� ���ڿ��� ���������� �񱳰� ������.
                                -> '����'�̶�� ���Ͽ� �°� ����� ���� �ƴ϶�, '��','��'�� ������ �´°��� �����.
                                -> ���鵵 ���� ����̱� ������, set������ ������ �־����� ������ ������ ������ ��� ���ڿ��� ��ȯ�Ѵ�.
                                -> ���� �߰��� '��', '��'�� �����Ǵ� ������ ������ ������ ������ �ʰ� ���ڿ��� ��ȯ�Ѵ�.
                                
                                SELECT RTRIM('���� ����� ������ ��Ϻ���', '���������뵿������� ')
                                FROM DUAL
                      */
                      
        1-5. LPAD, RPAD 
                LPAD : c���ڿ��� ���ʿ� n�ڸ���ŭ expr���ڿ��� �����Ͽ� c�� ��ȯ
                       expr�� �����Ǹ� ������ ����
                       
                RPAD : c���ڿ��� �����ʿ� n�ڸ���ŭ expr���ڿ��� �����Ͽ� c�� ��ȯ
                       expr�� �����Ǹ� ������ ����
                       
                ������� : LPAD(c, n, expr)
                          RPAD(c, n, expr)
                
                ex. SELECT LPAD(MEM_NAME, 11, '����:') 
                      FROM MEMBER
                    -- �ѱ��� ��� n���� ������ �� �ȵǴ� ��찡 �ִ�.
                
                ex. SELECT LPAD(EMAIL, 13, 'mail:')
                      FROM EMPLOYEES
                    
                ex. SELECT LPAD(EMAIL, 13, '*')
                      FROM EMPLOYEES
                        
                ex. SELECT EMAIL,
                           LPAD(EMAIL, 13)
                      FROM EMPLOYEES
                    -- ���ʺ��� 13���ڸ� �����ؼ�, ���ڰ� ���� ���°����� �������� ä���
                    -- ��������� ���ڿ��� ��������������, ���ʿ� ������ ä���־� ������ ���ķ� �����.
                    
                ex. SELECT TO_CHAR(MEM_MILEAGE) AS "AD"
                      FROM MEMBER
                    -- ���ڸ� ���ڿ��� ��ȯ�Ͽ� ��������
                    
                ex. SELECT LPAD(TO_CHAR(MEM_MILEAGE), 5) AS "AD"
                      FROM MEMBER
                    -- ���ڸ� ���ڿ��� ��ȯ�ϰ� �������ĵ� ���ڿ��� ���ʿ� ������ �־� ������ ���ķ� �����.
                

        1-6. REPLACE
                ������� : REPLACE(c, ser_c, rep_c)
                ���ڿ� c���� ser_c���ڿ��� ã�Ƽ� rep_c���ڿ��� ��ü��Ų��.
                
                ex. SELECT MEM_NAME AS ����̸�,
                           REPLACE(MEM_NAME, '��', 'KIM') AS "����� ���ڿ�"
                      FROM MEMBER
                
                ex. SELECT REPLACE('IL POSTINO  BOY HOOD', ' ', '')
                      FROM DUAL
                    -- ���ڿ��� ���ԵǾ� �ִ� ������ �����Ѵ�.
                    
                ex. �ŷ�ó���̺��� �ŷ�ó���� ������ Ÿ���� VARCHAR2(40)���� �����Ͻÿ�.
                    (�ŷ�ó���� ������ Ÿ���� ���� VARCHAR2���� CHAR�� ��ȯ�ϰ� ������ ���� �����̴�)
                solution.
                    ALTER TABLE BUYER
                    MODIFY BUYER_NAME VARCHAR2(40)
                    -- ���� VARCHAR2�� ����������, ������ ������ �����ִ� ����.
                    
                    UPDATE BUYER
                       SET BUYER_NAME = TRIM(BUYER_NAME)
                    -- UPDATE�� TRIM�� ����Ͽ� ������ �������ش�.
                    -- SET BUYER_NAME = REPLACE(BUYER_NAME, ' ', '') ����
 
        1-7. INSTR
                �ڹ��� chatAt(i)�޼���� ���� ����� �����Ѵ�.
                ������� : INSRT(c, substr[, pos][, occur])
                occur, pos ������ ��� : �־��� ���ڿ� c���� substr�� ã�Ƽ�, ù ��° ������ substr�� �ε��� ���� ��ȯ���ش�.
                occur, pos �������� ���� ��� : �־��� ���ڿ� c���� pos��°���� �����ؼ� occur��°�� ���� substr�� �ε��� ���� ��ȯ���ش�.
                occur�� ������ ��� : �־��� ���ڿ� c���� pos��°���� �����ؼ� ù ��° ������ substr�� �ε��� ���� ��ȯ���ش�.
                
                ex. SELECT INSTR('����ȭ ���� �Ǿ����� ����ȭ ���� �츮���� �� �Դϴ�.', '��', 6, 2) AS ���
                      FROM DUAL
                      -- 6��° ���ں��� �����ؼ� 2��°�� ���� ���� �ε������� ��ȯ�Ѵ�.
                      
        1-8. LENGTH, LENGTHB
                -- B�� BYTE, b�� bit�� �ǹ��Ѵ�.
                LENGTH(c) : c�� ���̸� ��ȯ�Ѵ�.
                LENGTHB(c) : ���ڿ��� byte�� ��ȯ�Ѵ�.
                      
                ex. SELECT LENGTH('KOR-SHIN')
                      FROM DUAL
                      
                      
                      
                      
                      