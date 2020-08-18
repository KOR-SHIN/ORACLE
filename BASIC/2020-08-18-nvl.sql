<2020-08-18>
    
    1. NULLó�� �Լ�
    
        1-1. NVL
            �־��� �ڷᰡ NULL���� �Ǻ��Ͽ� NULL�� ��� �ٸ� ���� ��ȯ�Ѵ�.
            ������� : NVL(col, val)
                col�� ���� NULL�̸� val���� ��ȯ�ϰ�, NULL�� �ƴϸ� col���� ��ȯ�Ѵ�.
                col�� val�� ���� ���̾�� �Ѵ�.
            
            ex. ��ǰ���̺��� PROD_COLOR�� NULL�̸� '�������� ����'
                NULL�� �ƴϸ� ������ ����Ͻÿ�.
                (��, Alias�� ��ǰ��, �з��ڵ�, ���������̴�)
                
            solution.
                SELECT PROD_NAME AS ��ǰ��,
                       PROD_LGU AS �з��ڵ�,
                       PROD_COLOR,
                       NVl(PORD_COLOR, '�������� ����') AS ��������
                  FROM PROD;
                  
                  
            ex. ��ٱ��� ���Ժ��� ��� ȸ���� ���� ��Ȳ�� ��ȸ�Ͻÿ�.
                (��, Alias�� ȸ����ȣ, ȸ����, ���űݾ�(���� * ��ǰ��ȣ)�̴�)
                
            solution.
                SELECT B.MEM_ID AS ȸ����ȣ,    -- ���̺��� ũ�⸦ ������ �� ū ���̺��� ���
                       B.MEM_NAME AS ȸ����,
                       NVL(SUM(C.PROD_PRICE * A.CART_QTY),0) AS ���űݾ�
                  FROM CART A
                 RIGHT OUTER JOIN MEMBER B  
                    ON(A.CART_MEMBER = B.MEM_ID AND A.CART_NO LIKE '200506%')
                  LEFT OUTER JOIN PROD C
                    ON(C.PROD_ID = A.CART_PROD)
              GROUP BY B.MEM_ID, B.MEM_NAME;
              
        1-2. NVL2
            ������� : NVL(c, r1, r2)
                c�� ���� NULL�̸� r2�� ��ȯ�ϰ�, NULL�� �ƴϸ� r1�� ���� ��ȯ�Ѵ�.
                r1, r2�� ������ Ÿ���� ���ƾ� �Ѵ�.
            
            ex. ȸ�����̺��� ȸ���� ������ '��'���� ȸ������ ���ϸ����� NULL�� �ٲٽÿ�.
            solution.
                SELECT MEM_NAME AS �̸�
                  FROM MEMBER
                 WHERE MEM_NAME LIKE '��%'
                 
                UPDATE MEMBER
                   SET MEM_MILEAGE = NULL
                 WHERE MEM_NAME LIKE '��%'

            
            ex. ������̺��� COMMISSION_PCT�� �����Ͽ� NULL�̸� ������������ 0��,
                NULL�� �ƴϸ� ������������ %�� ȯ��� ���������� ����Ͻÿ�.
                (��, Alias�� �����, �μ��ڵ�, ��å�ڵ�, ���������̸� ������ ���������� ����Ѵ�.)
                
            solution.
                SELECT NVL2(COMMISSION_PCT, COMMISSION_PCT*100||'%', 0) AS ��������,
                       DEPARTMENT_ID AS �μ��ڵ�,
                       JOB_ID AS ��å�ڵ�,
                       EMP_NAME AS �����
                  FROM EMPLOYEES
              ORDER BY COMMISSION_PCT DESC;
              
              
            ex. ȸ�����̺��� ȸ���� ���ϸ����� NULL�� ȸ���� NULL�� �ƴ� ȸ���� �Ǻ��Ͽ�
                NULL�� ȸ���� ������ '�޸�ȸ��', NULL�� �ƴ� ȸ���� 'Ȱ��ȸ��'�� ������ ����Ͻÿ�.
                (��, Alias�� ȸ����, ���ϸ���, ����̴�)
            
            solution.
                SELECT NAME AS ȸ����,
                       MEM_MILEAGE AS ���ϸ���,
                       NVL2(MEM_MILEAGE, 'Ȱ��ȸ��', '�޸�ȸ��') AS ���
                  FROM MEMBER
                
                
                