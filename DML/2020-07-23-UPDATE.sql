<2020-07-23-01>
    UPDATE
        ����� �������� ������ �����ϱ� ���� ����Ѵ�.
        ������� : UPDATE <���̺��> 
                    SET <�÷��� = ��>[,
                        �÷��� = ��...,
                  [WHERE ����]; 
                  /*[WHERE ����]���� �����Ǹ� ���̺��� ��� �࿡ �����ϴ�
                    �÷��� ���ο� ������ �����Ѵ�.
                  */
        
    quiz) ������̺� (EMPLOYEES)���̺��� ��� ������� �޿��� 15000���� �����Ͻÿ�.
    solv) 
        SELECT EMP_NAME AS �����,
               DEPARTMENT_ID AS �μ��ڵ�,
               SALARY AS �޿�
          FROM EMPLOYEES;
        
        UPDATE EMPLOYEES
        SET SALARY = 15000;
            -- [WHERE ����]���� ������ ���
    
    quiz) ������̺� (EMPLOYEES)���̺��� �μ��ڵ尡 50���� �޿����� �޿��� 15000���� �����Ͻÿ�.
    solv)
        SELECT EMP_NAME AS �����,
               DEPARTMENT_ID AS �μ��ڵ�,
               SALARY AS �޿�
          FROM EMPLOYEES
          WHERE DEPARTMENT_ID=50;
          
          UPDATE EMPLOYEES
             SET SALARY = 15000
           WHERE DEPARTMENT_ID=50;
            /* 
               ROLLBACK : ������ COMMIT ���·� �ǵ����� (ROLLBACK�� ����� ��ɾ ����)
               COMMIT : COMMIT�� �ϸ� COMMIT���� ���·� ROLLBACK �Ұ���
                        SQLDeveloper�� �����ϸ� �ڵ� COMMIT �ȴ�.
            */
            
            
    quiz) ȸ�����̺�(MEMBER)���� ȸ������ ���ϸ����� 20% �߰������Ͻÿ�
    solv)
        SELECT MEM_NAME, MEM_MILEAGE
          FROM MEMBER;
        -- ��� ȸ���� ��ȸ�ϱ� ������ WHERE�� ����
        
        UPDATE MEMBER
           SET MEM_MILEAGE = MEM_MILEAGE+MEM_MILEAGE*0.2;
    
    
    
    
    
    
    