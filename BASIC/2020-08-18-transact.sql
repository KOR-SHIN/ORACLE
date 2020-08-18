<2020-08-18>

    1. �����Լ�
        �����͸� Ư�� �÷��� �������� ���� ���� ���� �ͳ��� �׷�ȭ��Ű�� �̸� �������� ��(SUM), ���(AVg), ����(���� ��, COUNT), �ִ밪(MAX), �ּҰ�(MIN)�� ���ϴ� �Լ�
        GROUP BY ���� ����Ѵ�.
        �����Լ��� ������ �ο��� ��� HAVING �� ���
        SELECT ���� ����� �׷��Լ��� �ƴ� �Ϲ��÷��� �ݵ�� GROUP BY���� ����Ǿ�� ��
        
        ex. ������̺��� �μ��� �޿��հ踦 ���Ͻÿ�.
        solution.
            SELECT EMPLOYEE_ID AS �����ȣ,
                   DEPARTMENT_ID AS �μ��ڵ�,
                   SALARY AS �޿�,
                   SUM(SALARY) AS �޿��հ�
              FROM EMPLOYEES
          GROUP BY DEPARTMENT_ID, EMPLOYEE_ID, SALARY
          ORDER BY 1 DESC;
          
          
          ex. ��ǰ���̺��� �з��� ������ �հ踦 ���Ͻÿ�.
              (��, Alias�� �з��ڵ�, �з���, �����հ��̴�)
              
          solution.
            SELECT A.PROD_LGU AS �з��ڵ�,
                   B.LPROD_NM AS �з���,
                   SUM(A.PROD_PRICE) AS �����հ�
              FROM PROD A, LPROD_ B
             WHERE A.PROD_LGU = B.LPROD_GU
          GROUP BY A.PROD_LGU, B.LPROD_NM
          ORDER BY 1;
          
          ex. ȸ�����̺��� ���� ���ϸ��� �հ踦 ���Ͻÿ�.
              (��, Alias�� ����, ���ϸ��� �հ��̴�)
          
          solution.
            SELECT CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' OR
                             SUBSTR(MEM_REGNO2, 1, 1) = '3' TEHN '����ȸ��
                        ELSE '����ȸ�� END AS ����,
                   SUM(MEM_MILEAGE) AS "���ϸ��� �հ�"
              FROM MEMBER
          GROUP BY SUBSTR(MEM_REGNO2, 1, 1)
          
          ex. 2005�� 3�� �ŷ�ó�� ���Ա޾��հ踦 ���Ͻÿ�.
              (��, Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Ծ��̴�)
              
          solution.
            SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
                   A.BUYER_NAME AS �ŷ�ó��,
                   SUM(B.BUY_QTY * C.PROD_COST) AS ���Ծ�
              FROM BUYER A, BUYPROD D, PROD C
             WHERE A.BUYER_ID = C.PROD_ID
               AND B.BUY_PROD = C.PROD_ID
               AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
          GROUP BY A.BUYER_ID, A.BUYER_NAME
          ORDER BY 1;
          
          
          ex. ȸ�����̺��� ��� ����ȸ���� ���ϸ��� �հ踦 ���Ͻÿ�.
          
          solution.
            SELECT SUM(MEM_MILEAGE) AS "���ϸ��� �հ�",
              FROM MEMBER
             WHERE SUBSTR(REGNO2, 1, 1) = '2'
                OR SUBSTR(REGNO2, 1, 1) = '4'
                
                
          QUIZ. 2005�� 5�� ȸ���� �Ǹż��� �հ踦 ���ϵ�, �Ǹż����հ谡 20�� �̻��� ȸ���� ��ȸ�Ͻÿ�.
          
          solution. 
            SELECT CART_MEMBER AS ȸ����ȣ,
                   SUM(CART_QTY) AS "�Ǹż��� �հ�"
              FROM CART
             WHERE CART_NO LIKE '200505%'
          GROUP BY CART_MEMBER
            HAVING SUM(CART_QTY) >= 20
          ORDER BY 1;
          
          