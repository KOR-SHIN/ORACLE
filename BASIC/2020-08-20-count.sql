 
        1-2. COUNT
            ������� : COUNT(*|expr)
            ������ ��� ���� ���Ǽ��� ��ȯ�Ѵ�.
            �ܺ����ο����� expr�� ����ؾ� �Ѵ� ('*'�� ����ϸ� '0'�� '1'�� ��ȯ�ȴ�)
            
                ex. ������̺��� �μ��� ������� ��ȸ�Ͻÿ�.
                solution.
                    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                           B.DEPARTMENT_NAME AS �μ���,
                           COUNT(*) AS �����
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
                  ORDER BY 1;
                  /*
                  DEPARTMETS TABLE���� DEPARTMENT_ID�� �⺻Ű�̱� ������ NULL�� ���� �� ����.
                  ������ EMPLOYEES�� NULL���� ���� �� �ִ�. (������ �μ��ڵ尡 ����)
                  ���� EMPLOYEES TABLE, DEPARTMENTS TABLE�� �����ϸ�, NULL���� �������� ������� �ʴ´�.                
                  */
                  
                  ex. ȸ�����̺��� ������ ȸ������ ���ϸ��� �հ踦 ��ȸ�ϼ���.
                  solution. 
                      SELECT MEM_JOB AS ����,
                             COUNT(*) AS ȸ����,
                             ROUND(SUM(MEM_MILEAGE)) AS "���ϸ��� �հ�"
                        FROM MEMBER
                    GROUP BY MEM_JOB
                    
                 ex. ������̺��� ��ü�������� ��ձ޿����� �޿��� ���� �������� �μ����� ��ȸ�Ͻÿ�.
                 sloution.
                      /*��ձ޿��� ������� �ʴ� ���*/
                      SELECT DEPARTMENT_ID AS �μ���ȣ,
                             COUNT(*) AS �����,
                             ROUND((SELECT AVG(SALARY) FROM EMPLOYEES)) AS ��ձ޿�
                        FROM EMPLOYEES
                       WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
                    GROUP BY DEPARTMENT_ID
                    ORDER BY 1;
                    
                 ex. ������̺�� �μ����̺��� ����Ͽ� ��� �μ��� �ο����� ��ȸ�Ͻÿ�.
                 solution.
                      1) ������̺��� ����ϰ� �ִ� �μ��ڵ�
                        SELECT DISTINCT(DEPARTMENT_ID) FROM EMPLOYEES
                      2) �μ����̺��� ����ϰ� �ִ� �μ��ڵ�
                        SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                          /*DEPARTMENTS�� DEPARTMENTS_ID�� �⺻Ű�̱� ������ �ߺ����Ÿ� ���ص� �ȴ�*/
                      3) �����ذ�
                        SELECT B.DEPARTMENT_ID �μ��ڵ�, 
                               B.DEPARTMENT_NAME �μ���, 
                               COUNT(*) AS �ο���
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                      GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
                      ORDER BY 1
                      /*
                      JOIN�� �ϴµ� �μ��ڵ带 DEPARTMENTS TABLE�� ����Ѵ�.
                      DEPARTMENTS TABLE�� DEPARTMENT_ID�� ������ �� ���� ������ DEPARTMENTS TABLE���� ����
                      EMPLOYEES TABLE���� �ִ� DEPARTMENT_ID�� ���õȴ�.
                      */
                      
                      /*
                        SELECT A.DEPARTMENT_ID �μ��ڵ�, 
                               B.DEPARTMENT_NAME �μ���, 
                               COUNT(*) AS �ο���
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID (+)= B.DEPARTMENT_ID
                      GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
                      ORDER BY 1
                      (+) : OUTTER JOIN ������
                      ���� ��� �ܺ������� �ϴµ� COUNT(*)�� ����Ͽ���.
                      �̷��� ���, 0�� 1�� ��ȯ�ǰ�, NULL���� ��µȴ�.
                      */
                      
                 ex. ������̺��� ���� �������� ������� �μ����� ��ȸ�Ͻÿ�.
                    1) ����ó��
                        UPDATE EMPLOYEES
                           SET RETIRE_DATE = SYSDATE
                         WHERE EMPLOYEE_ID IN (200, 110, 130)
                    2) �����ذ�
                        SELECT DEPARTMENT_ID AS �μ��ڵ�,
                               COUNT(*) AS �����
                          FROM EMPLOYEES  
                         WHERE RETIRE_DATE IS NULL
                      GROUP BY DEPARTMENT_ID
                      ORDER BY 1
                      