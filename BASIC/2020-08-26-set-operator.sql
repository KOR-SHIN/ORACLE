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
        
        
        
        1-2. UNION
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