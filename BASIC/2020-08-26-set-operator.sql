<2020-08-26>

    1. ���տ�����
        �������� SELECT���� �����Ͽ� �ϳ��� ���������� ����� ������ �����Ѵ�.
        JOIN ��� ���� ���ȴ�.
        UNION, UNION ALL, INTERSECT, MINUS
        
        ** �������
        ���տ����ڷ� ����Ǵ� �� SELECT���� SELECT���� ���Ǵ� �÷��� ������ DATA TYPE�� ��ġ�ؾ� �Ѵ�.
        ORDER BY���� �� ������ SELECT�������� ��밡���ϴ�.
        BLOB, CLOB, BFILEŸ���� �÷��� ���Ͽ� ���� ������ ����� �����Ǿ� �ִ�.
        UNION, INTERSECT, MINUS �����ڴ� LONG�� �÷����� ����� �� ����.
        ��µǴ� �÷��� ù ��° SELECT�� �����̴�.
        
        
        
        1-1. UNION
            �������� ����� ��ȯ�Ѵ�.
            ������� : SELECT �÷�LIST 
                        FROM ���̺��1
                       WHERE ����
                       UNION
                      SELECT �÷�LIST 
                        FROM ���̺��2
                       WHERE ����
                       -- ���̺�1�� �������� ��µȴ�.
                
                ex. ȸ�����̺��� ������ �ڿ����̰ų� ���ϸ����� 4000�̻���
                    ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
                    
                solution.
                    SELECT MEM_ID AS ȸ����ȣ,
                           MEM_NAME AS ȸ���̸�,
                           MEM_JOB AS ����,
                           MEM_MILEAGE AS ���ϸ���
                      FROM MEMBER
                     WHERE MEM_JOB = '�ڿ���'
                     UNION
                    SELECT MEM_ID AS ȸ����ȣ,
                           MEM_NAME AS ȸ���̸�,
                           MEM_JOB AS ����,
                           MEM_MILEAGE AS ���ϸ���
                      FROM MEMBER
                     WHERE MEM_MILEAGE >= 4000
                     /*
                     �� ���ÿ� ������� ���� ���̺��� �� ���̱� ������ OR�� �����ص� ������
                     ���̺��� �� �� �̻� ����ϴ� ��쿡�� OR�� ������� ���ϱ� ������ UNION�� ����Ѵ�.
                     */
                     
                ex. �������̺�� �������̺��� 2005�� 5�� ��ǰ�� ���Լ����� ��������� ��ȸ�Ͻÿ�.
                    (��, Alias�� ��ǰ�ڵ�, ��ǰ��, ����/��������̴�)
                    
                solution 1. ���տ����ڸ� ������� �ʴ� ���
                    SELECT 
                      FROM (��ǰ�� �������) A, 
                           (��ǰ�� ���Լ���) B
                     WHERE A.��ǰ�ڵ� = B.��ǰ�ڵ�
                     
                solutin 1-1. �������� �ۼ� (��ǰ�� �������)
                    SELECT CART_PROD AS CID,
                           SUM(CART_QTY) AS CAMT
                      FROM CART
                     WHERE CART_NO LIKE '200505%'
                  GROUP BY CART_PROD
                  ORDER BY 1
                    
                solutin 1-2. �������� �ۼ� (��ǰ�� ���Լ���)
                    SELECT BUY_PROD AS BID,
                           SUM(BUY_QTY) AS BAMT
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
                  GROUP BY BUY_PROD
                  ORDER BY 1
                  
                solution 1-3. �����ۼ�
                    SELECT C.PROD_ID AS ��ǰ�ڵ�,
                           C.PROD_NAME AS ��ǰ��,
                           B.BAMT AS ���Լ���,
                           A.CAMT AS �������
                      FROM (SELECT CART_PROD AS CID,
                                   SUM(CART_QTY) AS CAMT
                              FROM CART
                             WHERE CART_NO LIKE '200505%'
                          GROUP BY CART_PROD
                          ORDER BY 1) A, 
                           (SELECT BUY_PROD AS BID,
                                   SUM(BUY_QTY) AS BAMT
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
                          GROUP BY BUY_PROD
                          ORDER BY 1) B,
                           PROD C
                     WHERE A.CID = B.BID(+)
                       AND C.PROD_ID = A.CID
                
                
                solution 2. ���տ����ڸ� ����ϴ� ���
                    SELECT CART_PROD AS ��ǰ�ڵ�,
                           PROD_NAME AS ��ǰ��,
                           SUM(CART_QTY) AS �������
                      FROM CART, PROD
                     WHERE CART_PROD = PROD_ID
                       AND CART_NO LIKE '200505%'
                  GROUP BY CART_PROD, PROD_NAME
                  
                 UNION ALL
                    SELECT BUY_PROD AS ��ǰ�ڵ�,
                           PROD_NAME AS ��ǰ��,
                           SUM(BUY_QTY) AS ���Լ���
                      FROM BUYPROD, PROD
                     WHERE BUY_PROD = PROD_ID
                       AND BUY_DATE BETWEEN '20050501' AND0
                       '20050531'
                  GROUP BY BUY_PROD, PROD_NAME
                  
                  
                  
                  
        1-2. UNION ALL
            �����Ǵ� �κ�(�ߺ�)�� ����ڷḦ ��ȯ�Ѵ�.
            ORDER BY�� ������ query���� ����Ѵ�.
            
                ex. ȸ�����̺��� �������� '����'�̰ų� ����ȸ���̰� ���ϸ����� 2000�̻��� ȸ���� ��ȸ�Ͻÿ�.
                    (�� Alias�� ȸ���̸�, �ּ�, ����, ���ϸ����̴�)
                    
                solution.
                    SELECT MEM_NAME AS ȸ���̸�,
                           MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
                           CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' THEN '����'
                                ELSE '����' END AS ����,
                           MEM_MILEAGE AS ���ϸ���
                      FROM MEMBER
                     WHERE MEM_ADD1 LIKE '����%'
                 UNION ALL
                 
                    SELECT MEM_NAME AS ȸ���̸�,
                           MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
                           CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' THEN '����'
                                ELSE '����' END AS ����,
                           MEM_MILEAGE AS ���ϸ���
                      FROM MEMBER
                     WHERE SUBSTR(MEM_REGNO2, 1, 1) = '2'
                 UNION ALL
                     
                     SELECT MEM_NAME AS ȸ���̸�,
                               MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
                               CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' THEN '����'
                                    ELSE '����' END AS ����,
                               MEM_MILEAGE AS ���ϸ���
                          FROM MEMBER
                         WHERE MEM_MILEAGE >= 2000
                      ORDER BY 1
                      
                      
                    
        1-3. INTERSECT
            �������� ���� ��� �� �����Ǵ� �κи� ��ȯ��Ű�� ���տ�����
            
                ex. ��ٱ������̺��� 4���� 6���� ��� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�.
                    (��, Alias�� ��ǰ�ڵ�, ��ǰ���̴�)
                    
                solution 1. 4�� �ڷ�
                    -- �� ��ǰ�� ������ �ȸ��� ��찡 �ֱ⶧���� �ߺ��� �����ؾ��Ѵ�.
                    SELECT DISTINCT(A.CART_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO LIKE '200504%'
                       
                solution 2. 6�� �ڷ�
                    SELECT DISTINCT(A.CART_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO LIKE '200506%'
                       
                solution 3. INTERSECT�� ������ ���ϱ�
                    SELECT DISTINCT(A.CART_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO LIKE '200504%'
                 INTERSECT
                 
                 SELECT DISTINCT(A.CART_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO LIKE '200506%'
                  
                  solution 4. EXISTS ����ϱ�
                    SELECT DISTINCT(A.CART_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO LIKE '200504%'
                       AND EXISTS (
                                    SELECT 1
                                      FROM CART C
                                     WHERE C.CART_PROD = A.CART_PROD
                                       AND C.CART_NO LIKE '200506%'
                                  )
                                  
                   etc. 4������ �ǸŵǾ�����, 6������ �Ǹŵ��� ���� ��ǰ
                    SELECT DISTINCT(A.CART_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND A.CART_NO LIKE '200504%'
                       AND NOT EXISTS (
                                    SELECT 1
                                      FROM CART C
                                     WHERE C.CART_PROD = A.CART_PROD
                                       AND C.CART_NO LIKE '200506%'
                                  )
                  
                  
        1-4. MINUS
            ������ ���� ����� �������� ��ȯ�ϴ� ���տ�����
            
                ex. �������̺��� 2���� �԰�� ��ǰ �� 4������ �԰���� ���� ��ǰ�� ��ȸ�Ͻÿ�.
                    (��, Alias�� ��ǰ�ڵ�� ��ǰ���̴�)
                    
                solution 1. 2���� �԰�� ��ǰ
                    SELECT DISTINCT(A.BUY_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM BUYPROD A, PROD B
                     WHERE A.BUY_PROD = B.PROD_ID
                       AND A.BUY_DATE BETWEEN '20050201' AND '20050228'
                       
                solution 2. 4���� �԰�� ��ǰ
                    SELECT DISTINCT(A.BUY_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM BUYPROD A, PROD B
                     WHERE A.BUY_PROD = B.PROD_ID
                       AND A.BUY_DATE BETWEEN '20050401' AND '20050430'
                  
                solution 3. 
                    SELECT DISTINCT(A.BUY_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM BUYPROD A, PROD B
                     WHERE A.BUY_PROD = B.PROD_ID
                       AND A.BUY_DATE BETWEEN '20050201' AND '20050228'
                    MINUS
                    
                    SELECT DISTINCT(A.BUY_PROD) AS ��ǰ�ڵ�,
                           B.PROD_NAME AS ��ǰ��
                      FROM BUYPROD A, PROD B
                     WHERE A.BUY_PROD = B.PROD_ID
                       AND A.BUY_DATE BETWEEN '20050401' AND '20050430'
                  ORDER BY 1
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  