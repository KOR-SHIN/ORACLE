<2020-08-26>

    ex) ��� �ŷ�ó�� 2005�� ���������� ��ȸ�Ͻÿ�.
        ����� �ŷ�ó�ڵ�, �ŷ�ó��, ��������
        
    solution 1. �������� �Ǵ�
        ���� ���⹰�� �ŷ�ó�ڵ�, �ŷ�ó��, ���������̴�.
        
    solution 1-1. �������� �ۼ�
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��,
               B. AS ���Աݾ�
          FROM BUYER A, (2005�⵵ ��������) B
         WHERE A.BUYER_ID = B.�ŷ�ó�ڵ�(+)
      ORDER BY 1;
      --OUTER JOIN�� �� ���� NULL���� �����ϱ� ���� SELEC������ ���� ���� �÷��� ���� ���̺��� ����Ѵ�.
      
    solution 2. �������� �Ǵ�
        2005�⵵ ���������� ���������� �ۼ��Ѵ�.
        
    solution 2-1. �������� �ۼ�
        SELECT A.BUYER_ID AS DID,
               SUM(B.BUY_QTY * B.BUY_COST) AS IAMT
          FROM BUYER A, BUYPROD B, PROD C
         WHERE A.BUYER_ID = C.PROD_BUYER
           AND B.BUY_PROD = C.PROD_ID
           AND B.BUY_DATE BETWEEN '20050101' AND '20051231'
      GROUP BY A.BUYER_ID
      ORDER BY 1
      
      solution 3. ���� �ۼ�
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��,
              NVL(B.IAMT, 0) AS ���Աݾ�
          FROM BUYER A, (SELECT A.BUYER_ID AS DID,
                                SUM(B.BUY_QTY * B.BUY_COST) AS IAMT
                           FROM BUYER A, BUYPROD B, PROD C
                          WHERE A.BUYER_ID = C.PROD_BUYER
                            AND B.BUY_PROD = C.PROD_ID
                            AND B.BUY_DATE BETWEEN '20050101' AND '20051231'
                       GROUP BY A.BUYER_ID
                          ) B
         WHERE A.BUYER_ID = B.DID(+)
         -- �Ϲ� OUTER JOIN�̱� ������ ������ �������ʿ� (+)�����ڸ� ����Ѵ�.
      ORDER BY 1;
      
      
    ex) ��� �ŷ�ó�� 2005�⵵ ����ݾ��� ��ȸ�Ͻÿ�.
        ����� �ŷ�ó�ڵ�, �ŷ�ó��, ������̴�.
        -- �ŷ�ó�� ��ǰ�� ��ǰ�� ��ŭ �ȷȴ��� ��ȸ�ϴ� ����
        -- ��� �ŷ�ó���̱⶧���� �ŷ�ó ���̺��� �߽��̴�.
        
    solution 1. �������� �Ǵ�
        ���� ���⹰�� �ŷ�ó�ڵ�, �ŷ�ó��, ������̴�.
        �ŷ�ó�� �����̱⶧���� BUYER TABLE�� �߽��̵ȴ�.
        
    solution 1-1. �������� �ۼ�
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��, 
               B. AS �����
          FROM BUYER A, (2005�⵵ �ŷ�ó�� ����) B
          -- B TABLE�� ��� �ŷ�ó�� �ƴ϶� ������ �߻��� �ŷ�ó�� ����Ѵ�.
         WHERE A.BUYER_ID = B.�ŷ�ó�ڵ�(+)
      ORDER BY 1
         
    solution 2. �������� �Ǵ�
        2005�⵵ �ŷ�ó�� ����ݾ��� ���ϴ� �κ��� ���������� �ۼ��Ѵ�.
        ��� �ŷ�ó�� �ƴ� ������ �߻��� �ŷ�ó�� ��µȴ�.
        
    solution 2-1. �������� �ۼ�
        SELECT C.BUYER_ID AS DID,
               SUM(D.CART_QTY * E.PROD_PRICE) AS IAMT
          FROM BUYER C, CART D, PROD E
         WHERE D.CART_PROD = E.PROD_ID
           AND E.PROD_BUYER = C.BUYER_ID
      GROUP BY C.BUYER_ID
        
    solution 3. �����ۼ�
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��, 
               NVL(B.OAMT, 0) AS �����
          FROM BUYER A, (
                        SELECT C.BUYER_ID AS DID,
                               SUM(D.CART_QTY * E.PROD_PRICE) AS OAMT
                          FROM BUYER C, CART D, PROD E
                         WHERE D.CART_PROD = E.PROD_ID
                           AND E.PROD_BUYER = C.BUYER_ID
                      GROUP BY C.BUYER_ID
                        ) B
          WHERE A.BUYER_ID = B.DID(+)
       ORDER BY 1
