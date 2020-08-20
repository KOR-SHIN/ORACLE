<2020-08-20>

    1. JOIN
        RDB�� �ٽ� ����̴�.
        ��ȸ�� �÷��� ���� ���� ���̺� �л�Ǿ� ���� �� ���,
        ���̺� ������ ����(Relationship)�� �̿��Ͽ� �˻��� �� ����Ѵ�.
        
        �Ϲ� JOIN�� ANSI JOIN���� ���еȴ�.
        ���谡 �ξ����� ���� ���̺��� JOIN�� ���� �߻����� �ʴ´�. (��������, �������� ��� ����)
        
        ** ���� : A ���̺��� �⺻Ű�� B ���̺��� �ܷ�Ű�� ���Ǵ� ���
        ** ��ĺ� : A���̺��� �⺻Ű�� B ���̺��� �Ϲ� �׸����� �� �ִ� ���
        ** �ĺ��ڰ��� : A���̺��� �⺻Ű�� B ���̺��� �ܷ�Ű���� �⺻Ű�� ��� (A <- B ��Ӱ���)
        
        1-1. Cartesian Product
            ��� ����� ������ ����� ��ȯ�Ѵ�.
                ex. A ���̺��� 100�� 20��, B ���̺��� 2000�� 10���� �����Ǿ��ٸ�,
                    A, B ���̺��� Cartesian Product ����� 200000��, 30���� ������� ��ȯ�Ѵ�.
            JOIN������ ���� ���, JOIN������ �߸� ����� ���, Cartesian Product�� ����ȴ�.
            ANSI������ CROSS JOIN�̶�� �θ���.
            �Ұ����� ��찡 �ƴ϶��, Cartesian Product�� ������� �ʴ´�.
            
                ex. CART TABLE�� ���� ��
                    SELECT COUNT(*) FROM CART;
                    
                ex. MEMBER TABLE�� ���� ��
                    SELECT COUNT(*) FROM MEMBER;
                    
                ex. CART TABLE�� MEMBER TABLE�� Cartesian Product�� ����
                    SELECT COUNT(*)
                      FROM MEMBER, CART
                      
        1-2. Equi-JOIN
            JOIN���ǿ� '='�����ڸ� ����ϴ� ��������
            ���������� ���� ���̺��� ������ n���� ���, JOIN������ ��� n-1�� �̻��̾�� �Ѵ�.
            ���������̶�� �θ��⵵ �Ѵ�.
            ��ġ���� �ʴ� ������(�� ����)�� �����Ͽ� ����� ��Ÿ���� �ʴ´�.
            ANSI������ INNER JOIN�̶�� �Ѵ�.
            
                ex. �Ϲ�����
                    SELECT <�÷� LIST>
                      FROM <���̺� �̸� [��Ī]>, <���̺� �̸� [��Ī]>
                     WHERE <JOIN ���� 1>
                      [AND <JOIN ���� 2>]
                      
                ex. ANSI ����
                    SELECT <�÷� LIST>
                      FROM <���̺� 1 �̸� [��Ī]>
                INNER JOIN <���̺� 2 �̸�> ON (���� ���� 1)
                      [AND <�Ϲ� ����>]
                    [WHERE <�Ϲ� ����>]
               [INNER JOIN <���̺� 3 �̸�> ON (���� ���� 1) <- ���̺� 1�� ���̺� 2�� ���ΰ���� ���̺� 3�� �����ϴ� ��
                      [AND <�Ϲ� ����>]
                    [WHERE <�Ϲ� ����>]]
                    
                    
                    
                ex. ������̺��� ��������� ��ȸ�Ͻÿ�.
                    (��, Alias�� �����ȣ, �����, �μ��ڵ�, �μ���)
                
                solution 1. �Ϲ����� 
                    SELECT EMPLOYEE_ID AS �����ȣ,
                           EMP_NAME AS ����̸�,
                           B.DEPARTMENT_ID AS �μ��ڵ�,
                           DEPARTMENT_NAME AS �μ���
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  ORDER BY B.DEPARTMENT_ID
                  
                solution 2. ANSI ����
                    SELECT A.EMPLOYEE_ID AS �����ȣ,
                           A.EMP_NAME AS ����̸�,
                           A.DEPARTMENT_ID AS �μ��ڵ�,
                           B.DEPARTMENT_NAME AS �μ���
                      FROM EMPLOYEES A
                INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
                  ORDER BY B.DEPARTMENT_ID
                  
                
                ex. ������̺��� 100�� �μ��� ��������� ��ȸ�Ͻÿ�.
                    (��, Alias�� �����ȣ, �����, �μ��ڵ�, �μ���)
                    
                solution 1. �Ϲ�����
                    SELECT EMPLOYEE_ID AS �����ȣ,
                           EMP_NAME AS ����̸�,
                           B.DEPARTMENT_ID AS �μ��ڵ�,
                           DEPARTMENT_NAME AS �μ���
                      FROM EMPLOYEES A, DEPARTMENTS B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                       AND A.DEPARTMENT_ID = 100
                                         
                solution 2. ANSI ����
                    SELECT A.EMPLOYEE_ID AS �����ȣ,
                           A.EMP_NAME AS ����̸�,
                           A.DEPARTMENT_ID AS �μ��ڵ�,
                           B.DEPARTMENT_NAME AS �μ���
                      FROM EMPLOYEES A
                INNER JOIN DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
                     WHERE A.DEPARTMENT_ID = 100
                
                
                ex. 2005�� 6�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
                    (��, Alias�� ��ǰ�ڵ�, ��ǰ��, �ݾ��̴�)
                    
                solution 1. �Ϲ�����
                    SELECT B.PROD_ID AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS �ݾ�                          
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO BETWEEN '20050601' AND '20050630'
                  GROUP BY B.PROD_ID, B.PROD_NAME
                  ORDER BY 1
                  
                solution 2. ANSI ����
                    SELECT B.PROD_ID AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS �ݾ�                          
                      FROM CART A
                INNER JOIN PROD B ON (A.CART_PROD = B.PROD_ID)
                     WHERE A.CART_NO BETWEEN '20050601' AND '20050630'
                  GROUP BY B.PROD_ID, B.PROD_NAME
                  ORDER BY 1