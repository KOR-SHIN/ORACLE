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
                      
                        