
        1. AVG
            ������� : AVG(expr)
            expr�� �÷����̳� �����̴�.
            �׷��ε� expr�� ����� ���� ���� ����� ��ȯ�Ѵ�.

                ex. ������̺��� �� �μ��� ��� ��ձ޿��� ���Ͻÿ�.
                solution.
                    SELECT DEPARTMENT_ID AS �μ��ڵ�,
                           ROUND(AVG(SALARY), 1) AS ��ձ޿�
                      FROM EMPLOYEES
                  GROUP BY DEPARTMENT_ID
                  ORDER BY 1
                  
                  ex. �������̺�(BUYPROD)���� 2005�� 3�� ��ǰ�� ��� ���Լ����� ��ȸ�Ͻÿ�.
                  solution.
                      SELECT BUY_PROD AS ��ǰ�ڵ�,
                             ROUND(AVG(BUY_QTY)) AS "��� ���Լ���",
                             ROUND(AVG(BUY_QTY * BUY_COST)) AS "��� ���Աݾ�"
                        FROM BUYPROD
                       WHERE BUY_DATE BETWEEN '20050301' AND '20050331'
                    GROUP BY BUY_PROD
                    ORDER BY 1
                  /* BUY_PROD�� �Ϲ� �÷��̰�, ������ 2���� �����Լ��̴�.
                     �����Լ��� �Ϲ��÷��� �Բ� ���Ǹ�, �ݵ�� GROUP BY�� ����ؾ� �Ѵ�.*/
                     
                     
                   QUIZ. ȸ�����̺��� 50�� ȸ�� ���� ��� ���ϸ����� ���Ͻÿ�.
                   solution.
                        SELECT CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' THEN '����ȸ��'
                                    WHEN SUBSTR(MEM_REGNO2, 1, 1) = '2' THEN '����ȸ��' END AS ����,
                               ROUND(AVG(MEM_MILEAGE)) AS "���ϸ��� ���"
                          FROM MEMBER
                         WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) BETWEEN 50 AND 59
                      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' THEN '����ȸ��'
                                    WHEN SUBSTR(MEM_REGNO2, 1, 1) = '2' THEN '����ȸ��' END
                                    /*GROUP BY������ SELECT���� ���� �Ϲ��÷��� �״�� ����ؾ� �Ѵ�*/
                    
                    
                    QUIZ. ��ٱ������̺��� 2005�� 5�� ȸ���� ��ո������ ���Ͻÿ�.
                          ��ո������ 100���� �̻��� ȸ���� ��ȸ�Ͻÿ�. 
                          (��, Alias�� ȸ����ȣ, ��� �����)

                    solution.
                        SELECT CART_MEMBER AS ȸ����ȣ,
                               TO_CHAR(AVG(CART_QTY * PROD_PRICE), '99,999,999') AS ��ո����
                          FROM CART A, PROD B
                         WHERE CART_PROD = PROD_ID
                           AND SUBSTR(CART_NO,1 , 8) BETWEEN '20050501' AND '20050531'
                      GROUP BY CART_MEMBER
                        HAVING AVG(CART_QTY * PROD_PRICE) >= 1000000
                
                    QUIZ. ������̺��� �μ��� ������� ��� �ټӳ���� ���ϰ� �ټӳ���� ���� ���� �μ� 3���� ����Ͻÿ�.
                          /*ROWNUM�� WHERE�������� ��䰡���ϴ�*/
                    solution.
                        SELECT A.DID AS �μ���ȣ,
                               B.DEPARTMENT_ID AS �μ���,
                               ROUND(A.AVGCNT) AS ��ձټӳ��
                          FROM DEPARTMENTS B, (SELECT DEPARTMENT_ID DID,
                                                      AVG(EXTRACT(YEAR FROM SYSDATE) -
                                                          EXTRACT(YEAR FROM HIRE_DATE)) AS AVGCNT
                                                 FROM EMPLOYEES
                                             GROUP BY DEPARTMENT_ID
                                             ORDER BY 2 DESC) A
                          WHERE A.DID = B.DEPARTMENT_ID
                            AND ROWNUM <= 3;
                        /*
                        FROM���� ���� ���� ����Ǳ� ������
                        SELECT���� ����Ǳ� ���� ���������� ���� ����ȴ�.
                        ���� �������� ����Ǵ� SELECT������ ���������� �÷� ��Ī�� ��밡���ϴ�.
                        �������� ����ϸ� ���̺��� �� �� ����ϴ� ���̴� -> ���� -> ���������� �־������.
                        
                        ���������� ����� ����
                        ���� ������ ������� ������, ��������� ���� ROWNUM ������ ����� ������� �ʴ´�.
                        */