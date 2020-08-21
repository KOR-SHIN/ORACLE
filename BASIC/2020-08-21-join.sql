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
                  
                  
                ex. �������̺��� 2005�� 3�� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
                    (��, Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ��̴�)
                    
                solution 1. �Ϲ�����
                    SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
                           B.BUYER_NAME AS �ŷ�ó��,
                           SUM(A.BUY_COST*A.BUY_QTY) AS ���Աݾ��հ�
                      FROM BUYPROD A, BUYER B, PROD C
                     WHERE A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331')
                       AND A.BUY_PROD = C.PROD_ID
                       AND B.BUYER_ID = C.PROD_BUYER
                  GROUP BY B.BUYER_NAME, B.BUYER_ID
                  ORDER BY 1
                  
                ex. �������̺��� 2005�� 3�� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
                    (��, Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ��̴�)
                    
                solution 2. ANSI ����
                    SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
                           B.BUYER_NAME AS �ŷ�ó��,
                           SUM(A.BUY_COST*A.BUY_QTY) AS ���Աݾ��հ�
                      FROM BUYPROD A
                INNER JOIN PROD C ON(A.BUY_PROD = C.PROD_ID)
                /* BUYER TABLE�� BUYPROD TABLE�� JOIN�� �ȵ����� BUYPROD TABLE�� PROD TABLE�� ���� JOIN�ؾ��Ѵ�. */
                INNER JOIN BUYER B ON(C.PROD_BUYER = B.BUYER_ID)
                     WHERE A.BUY_DATE BETWEEN TO_DATE('20050301') AND TO_DATE('20050331')
                  GROUP BY B.BUYER_NAME, B.BUYER_ID
                  ORDER BY 1
                  
                  
                ex. 2005�� 5�� ��ǰ�� ����/���� ������ ��ȸ�Ͻÿ�.
                    (��, Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ��������̴�)
                    
                solution 1. �Ϲ� ����
                    SELECT C.PROD_ID AS ��ǰ�ڵ�,
                           C.PROD_NAME AS ��ǰ��,
                           SUM(A.BUY_QTY) AS ���Լ���,
                           SUM(B.CART_QTY) AS �������
                      FROM BUYPROD A, CART B, PROD C
                     WHERE A.BUY_PROD = C.PROD_ID
                       AND C.PROD_ID = B.CART_PROD
                       -- PROD TABLE�� CART TABLE�� �������谡 �����Ƿ�, PROD TABLE�� �̿��Ѵ�.
                       AND B.CART_NO LIKE '200505%'
                        OR A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
                  GROUP BY C.PROD_ID, C.PROD_NAME
                  ORDER BY 1
                  
                  solution 2. �Ϲ����ο����� OUTER JOIN
                    SELECT C.PROD_ID AS ��ǰ�ڵ�,
                           C.PROD_NAME AS ��ǰ��,
                           SUM(A.BUY_QTY) AS ���Լ���,
                           SUM(B.CART_QTY) AS �������
                      FROM BUYPROD A, CART B, PROD C
                     WHERE A.BUY_PROD(+) = C.PROD_ID
                       AND C.PROD_ID = B.CART_PROD(+)
                       -- PROD TABLE�� CART TABLE�� �������谡 �����Ƿ�, PROD TABLE�� �̿��Ѵ�.
                       AND B.CART_NO LIKE '200505%'
                       AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
                  GROUP BY C.PROD_ID, C.PROD_NAME
                  ORDER BY 1
                  
                  /*
                  �Ϲ����ο��� OUTER JOIN�� ������ ������ ������ �ʿ� JOIN���ǿ� (+)�� �־��ִ� ��
                  ������ �Ϲ������� ���� ����Ȯ�� ����� ����ϰų� ����� �����ϴ�.
                  ���� ���������� ����ϰų� ANSI������ ����ؾ� �Ѵ�.
                  */
                  
                  solution 1. ASNI ���ο����� OUTRE JOIN
                    SELECT C.PROD_ID AS ��ǰ�ڵ�,
                           C.PROD_NAME AS ��ǰ��,
                           NVL(SUM(A.BUY_QTY), 0) AS ���Լ���,
                           NVL(SUM(B.CART_QTY), 0) AS �������
                      FROM BUYPROD A
          RIGHT OUTER JOIN PROD C ON(A.BUY_PROD = C.PROD_ID
                                     AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531'))
           LEFT OUTER JOIN CART B ON(C.PROD_ID = B.CART_PROD
                                     AND B.CART_NO LIKE '200505%')
                  GROUP BY C.PROD_ID, C.PROD_NAME
                  ORDER BY 1
                  /*
                  RIGHT OUTER JOIN�� BUYPROD�� PROD�� �����ʿ� ��ġ�� PROD�� ������ �� ���ٴ� ���̴�.
                  LEFT OUTER JOIN�� CART�� PROD �� ���ʿ� ��ġ�� PROD�� ������ �� ���ٴ� ���̴�.
                  */
                  
                  solution 4. SUBQUERY �ۼ���
                    SELECT A.PROD_ID AS ��ǰ�ڵ�,
                           A.PROD_NAME AS ��ǰ��,
                           NVL(B.INAMT, 0) AS ���Լ���,
                           NVL(C.OUTAMT, 0) AS �������
                      FROM PROD A,(
                            SELECT BUY_PROD AS BID,
                                   SUM(BUY_QTY) AS INAMT
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
                          GROUP BY BUY_PROD) B, (
                          SELECT CART_PROD AS CID,
                                 SUM(CART_QTY) AS OUTAMT
                            FROM CART
                           WHERE CART_NO LIKE '200505%'
                        GROUP BY CART_PROD) C
                      WHERE A.PROD_ID = B.BID(+)
                        AND A.PROD_ID = C.CID(+)
                   ORDER BY 1;
                          
                          
                          
        1-2. SEMI JOIN
            ���������� ���������� ����Ͽ� ���������� �����ϴ� �����͸� ������������ �����ϴ� �����̴�.
            EXISTS �����ڰ� ���ȴ�.
            
                ex. ������̺��� �޿��� 8000�̻��� ����� �ִ� �μ��� ��ȸ�Ͻÿ�.
                    (��, Alias�� �μ��ڵ�, �μ���, �����μ��ڵ��̴�)
                    
                solutin 1. SUBQUERY JOIN
                    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                           A.DEPARTMENT_NAME AS �μ��̸�,
                           A.PARENT_ID AS �����μ��ڵ�
                      FROM DEPARTMENTS A
                     WHERE A.DEPARTMENT_ID IN 
                          (SELECT B.DEPARTMENT_ID
                             FROM EMPLOYEES B
                            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                              AND B.SALARY >= 8000)
                  ORDER BY 1;
                  
                  solutin 2. SEMI JOIN
                    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                           A.DEPARTMENT_NAME AS �μ��̸�,
                           A.PARENT_ID AS �����μ��ڵ�
                      FROM DEPARTMENTS A
                     WHERE EXISTS (SELECT B.DEPARTMENT_ID
                                    /*
                                    EXISTS�� ����� �� SELECT�������� 1�� ����Ѵ�.
                                    �ǹ̾��� ���ڸ� �̿��Ͽ� ���������� ������ ������ �����ϴ� ���̴�. 
                                    */
                                     FROM EMPLOYEES B
                                    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                                      AND B.SALARY >= 8000)
                  ORDER BY 1;