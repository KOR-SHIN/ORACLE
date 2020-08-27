<2020-08-25>

    1. ��������(sub-query)
        SQL���� �ȿ��� ������ ���Ǵ� �� �ٸ� ����
            **���� ���⹰�� ���� ���� ���������� �������ش�. (�߰� ������� �����ϰ� �ִٰ� ���������� ����Ѵ�.)
        ���������� �ݵ�� '( )'�ȿ� ����ؾ� �Ѵ�.
        FROM���� ���������� ���������� �����ؾ� �Ѵ� (FROM���� ���� ���� ����Ǳ� �����̴�)
        ���������� ����� ��, ���������� ������ ����ؾ��ϴ��� �����ؾ��Ѵ�.
        
        1-1. �������� �з� ���� 
            ������ ���� 
                ������ ���� �������� : ���������� ���������� ���� ���̺��� JOIN���� ������� ���� ��������
                    ex. ȸ�����̺��� ��ո��ϸ������� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
                        
                    solution 1. �������� �Ǵ�
                        ȸ�����̺��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ����ؾ� �Ѵ�.
                        
                    solution 1-1. �������� �ۼ�
                        SELECT MEM_ID AS ȸ����ȣ,
                               MEM_NAME AS ȸ����,
                               MEM_JOB AS ����,
                               MEM_MILEAGE AS ���ϸ���
                          FROM MEMBER
                         WHERE MEM_MILEAGE > (��� ���ϸ���)
                        
                    solution 2-1. �������� �Ǵ�
                        WHERE������ �����Լ� AVG�� ���Ұ� �ϱ⶧����, ������������ ��� ���ϸ����� ����� �� ����.
                        ���� ���������� ����ؼ� ��� ���ϸ����� ���Ѵ�.
                        
                    solution 2-2. �������� �ۼ�
                        SELECT AVG(MEM_MILEAGE)
                          FROM MEMBER
                          
                    solution 3. �����ۼ�
                        SELECT MEM_ID AS ȸ����ȣ,
                               MEM_NAME AS ȸ����,
                               MEM_JOB AS ����,
                               MEM_MILEAGE AS ���ϸ���
                          FROM MEMBER
                         WHERE MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE) 
                                                FROM MEMBER)
                    /* 
                    ���� ���ÿ����� ���������� ȸ������ŭ ����Ǳ� ������ ���ɿ� ������ ��ģ��
                    WHERE������ ���������� ����Ʊ� ������ ��ø ���������̴�.
                    */
                    
                    solution 4. IN-LINE �������� �ۼ�
                        SELECT MEM_ID AS ȸ����ȣ,
                               MEM_NAME AS ȸ����,
                               MEM_JOB AS ����,
                               MEM_MILEAGE AS ���ϸ���
                          FROM MEMBER, (SELECT AVG(MEM_MILEAGE) AS AMILE
                                          FROM MEMBER) A
                         WHERE MEM_MILEAGE > A.AMILE
                    /* 
                    FROM���� �������� ���� ���� ����ǰ�, ���� ���ÿ����� ���������� �� �ѹ��� ����ȴ�. (��Ƚ���� ȸ����)
                    FROM������ ���������� ����Ʊ� ������ IN-LINE ���������̴�.                 
                    */
                    
                    
                    ex. �μ����̺��� �����μ��ڵ尡 NULL�� �μ��� �Ҽӵ� ������� ��ȸ�Ͻÿ�.
                    solution 1. �������� �Ǵ�
                        ���������� ��µǾ���ϴ� ���⹰�� ������̴�.
                        
                    solution 1-1. �������� �ۼ�
                        SELECT COUNT(*) AS �����
                          FROM EMPLOYEES
                         WHERE DEPARTMENT_ID = (�����μ��ڵ尡 NULL�� �μ�)
                        
                    solution 2. �������� �Ǵ�
                        �����μ��ڵ尡 NULL�� �μ��� ������������ ���� �� ���⶧���� ���������� ����Ѵ�.
                        
                    solution 2-1. �������� �ۼ�
                        SELECT DEPARTMENT_ID AS �μ��ڵ�
                          FROM DEPARTMENTS
                         WHERE PARENT_ID IS NULL
                         
                    solutin 3. �����ۼ�
                        SELECT COUNT(*) AS �����
                          FROM EMPLOYEES
                         WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID AS �μ��ڵ�
                                                  FROM DEPARTMENTS
                                                 WHERE PARENT_ID IS NOT NULL)



            ������ �ִ� ��������
                ���������� ���������� ���� ���̺��� �������� ����� ��������
                
                    ex. �� �μ��� ��ձ޿��� ����ϰ� �� �μ����� �ڱ� �μ��� ��ձ޿�����
                        ���� �޿��� ���޹޴� ������ �ִ� �μ��ڵ�� �μ����� ����Ͻÿ�.
                        
                    solution 1. �������� �Ǵ�
                        ���������� ����ϴ� ���� �μ��ڵ�� �μ����̴�.
                        
                    solution 1-1. �������� �ۼ�
                        SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                               A.DEPARTMENT_NAME AS �μ���
                          FROM DEPARTMENTS A
                         WHERE A.DEPARTMENT_ID IN (��������);
                         
                    solution 2. �������� �Ǵ�
                        �ڱ� �μ��� ��ձ޿����� ���� �޿��� ���޹޴� ������ �ִ� �μ��� �μ��ڵ带 ã�ƾ� �Ѵ�.
                        �������� �ȿ� �� �ٸ� ���������� ����ؾ� �ϴ� �����̴�.
                        
                        1�� �������� : �ڱ� �μ��� ��ձ޿����� ���� �޿��� ���� �޴� ������ �ִ� �μ��� �μ��ڵ�
                        2�� �������� : �ڱ�μ��� ��ձ޿�
                        
                    solution 2-1. 1�� �������� �ۼ�
                        SELECT B.DEPARTMENT_ID
                          FROM EMPLOYEES B
                         WHERE B.SALARY > (�ڱ�μ��� ��ձ޿�)
                        
                    solution 2-2. 2�� �������� �ۼ�
                        SELECT C.DEPARTMENT_ID,
                               ROUND(AVG(C.SALARY))
                          FROM EMPLOYEES C
                      GROUP BY C.DEPARTMENT_ID
                      
                    solution 3. �����ۼ�
                        SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                               A.DEPARTMENT_NAME AS �μ���
                          FROM DEPARTMENTS A
                         WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                                                     FROM EMPLOYEES B
                                                    WHERE B.SALARY > (SELECT ROUND(AVG(C.SALARY))
                                                                        FROM EMPLOYEES C
                                                                       WHERE C.DEPARTMENT_ID = B.DEPARTMENT_ID
                                                                       -- �ڱ�μ����� �����ϱ� ���� JOIN
                                                                    GROUP BY C.DEPARTMENT_ID))
                    /*
                    1�� ������������ EMPLOYEES�� ù ��° ����� ������
                    1�� ���������� WHERE�� ����
                    2�� ������������ C.DEPARTMENT_ID = B.DEPARTMENT_ID�� �����ϴ� ��� ����� ��ձ޿��� ���
                    ������� 1�� ���������� WHERE���� ��ȯ�Ͽ� B.SALARY�� ��
                    �񱳰���� ���������� WHERE���� ��ȯ�Ͽ� �������� WHERE�� ��
                    */
                    
                    
                    ex. ��ٱ������̺��� ȸ���� �ְ��ż����� ���� �ڷ��� ȸ����ȣ, ��ٱ��� ��ȣ, ��ǰ��ȣ, ���ż����� ��ȸ�Ͻÿ�.
                    
                    solution 1. �������� �Ǵ�
                        �������� ���⹰�� ȸ����ȣ, ��ٱ��� ��ȣ, ��ǰ��ȣ, �ְ��ż����̴�.
                        
                    solution 1-1. �������� �ۼ�
                        SELECT A.CART_MEMBER AS ȸ����ȣ,
                               A.CART_NO AS "��ٱ��� ��ȣ",
                               A.CART_PROD AS ��ǰ��ȣ,
                               A.CART_QTY AS �ְ��ż���
                          FROM CART A
                         WHERE A.CART_QTY = (ȸ���� �ִ� ���ż���)
                        
                    solution 2. �������� �Ǵ�
                        ������ ������ �����ϱ� ���� ȸ���� �ִ� ���ż����� ���ؾ� �Ѵ�.
                        
                    solution 2-1. �������� �ۼ�
                        SELECT MAX(B.CART_QTY)
                          FROM CART B
                         WHERE A.CART_MEMBER = B.CART_MEMBER
                         
                    solution 3. �����ۼ�
                        SELECT A.CART_MEMBER AS ȸ����ȣ,
                               A.CART_NO AS "��ٱ��� ��ȣ",
                               A.CART_PROD AS ��ǰ��ȣ,
                               A.CART_QTY AS �ְ��ż���
                          FROM CART A
                         WHERE A.CART_QTY = (SELECT MAX(B.CART_QTY)
                                               FROM CART B
                                              WHERE A.CART_MEMBER = B.CART_MEMBER)
                      ORDER BY 1
                      
                      
                    ex. ������̺��� ����޿��� �Ʒ� ���Ǵ�� �����Ͻÿ�.
                        [����]
                        1. ����� �Ҽӵ� �μ��� �����μ��� 90���� �μ�
                        2. �����μ��� 90�� ���� �μ��� �� �μ��� ��ձ޿� ���
                        3. �����μ��� 90�� ���� �μ��� ���� ����� �޿��� �ڽ��� �μ� ��� �޿��� ����
                        
                    solution 1. �����μ��� 90���� �μ��� ���� ���
                        SELECT A.EMPLOYEE_ID,
                               A.EMP_NAME, 
                               A.DEPARTMENT_ID, 
                               B.PARENT_ID
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                           AND B.PARENT_ID = 90
                           
                    solution 2. �����μ��� 90���� �μ��� ���� ����� ��ձ޿�
                        SELECT A.DEPARTMENT_ID,
                               ROUND(AVG(A.SALARY))
                          FROM EMPLOYEES A, DEPARTMENTS B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                           AND B.PARENT_ID = 90
                      GROUP BY A.DEPARTMENT_ID
                      ORDER BY 1

                    solution 3. ???
                        SELECT C.SAL
                          FROM (SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                                       ROUND(AVG(A.SALARY)) AS SAL
                                  FROM EMPLOYEES A, DEPARTMENTS B
                                 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                                   AND B.PARENT_ID = 90
                              GROUP BY A.DEPARTMENT_ID ) C
                         WHERE B.DEPARTMENT_ID 
                              
                    solution 4. �����ۼ�
                        UPDATE EMPLOYEES D
                           SET SALARY = ( SELECT C.SAL
                                            FROM (SELECT A.DEPARTMENT_ID AS DID,
                                                         ROUND(AVG(A.SALARY)) AS SAL
                                                    FROM EMPLOYEES A, DEPARTMENTS B
                                                   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                                                     AND B.PARENT_ID = 90
                                                GROUP BY A.DEPARTMENT_ID) C
                                           WHERE D.DEPARTMENT_ID = C.DID)
                         WHERE D.DEPARTMENT_ID =ANY(SELECT DEPARTMENT_ID
                                                      FROM DEPARTMENTS
                                                     WHERE PARENT_ID=90)
                        
                        **Ȯ���غ���(����)
                        SELECT A.EMP_NAME,
                               A.DEPARTMENT_ID,
                               A.SALARY
                          FROM DEPARTMENTS B, EMPLOYEES A
                         WHERE B.PARENT_ID = 90
                           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
                      
                      
       1-2. ���Ǵ� ����, ��ġ ���� : �Ϲ� ��������(SELECT ��), �ζ��� ��������(FROM��), ��ø ��������(WHERE��)
       1-3. ��ȯ���� ���� ���� : ������/���Ͽ�, ������/���߿�, ������/���Ͽ�, ������/���߿�
        