<2020-07-29-02>
    
    1. SELECT
        ���̺� ���� �ڷḦ ��ȸ�� �� ����Ѵ�.
        ������� : SELECT [*|DISTINCT] <�÷���>|EXPR [AS] ["]<�÷���Ī>["],
                        <�÷���>|EXPR [AS] ["]<�÷���Ī>["],
                        <�÷���>|EXPR [AS] ["]<�÷���Ī>["],
                        ...
                        <�÷���>|EXPR [AS] ["]<�÷���Ī>["]
                    FROM <���̺��> [��Ī]
                   [WHERE ����]
                   [GROUP BY �÷��� [,�÷���...]]
                   [HAVING ����]
                   [ORDER BY �÷���|�÷��ε��� [ASC|DESC]...]
        
        �������(GROUP BY, HAVING, ORDER BY ���� ���) : FROM -> WHERE -> SELECT 
        �������(GROUP BY, HAVING, ORDER BY �ִ� ���) : FROM -> WHERE -> (GROUP BY, HAVING, ORDER BY) -> SELECT
         /* 
         SELECT������ �����ϴ� �÷���Ī�� ��� ���� ����ǰ� ���� �ԷµǴ� ���̱� ������
         ���� ����Ǵ� �ٸ� ���� SELECT���� ����ϴ� ��Ī�̸��� ����� �� ����
         */
         
        �÷���Ī ������ "" �����Ұ� ��� : ������ ����,����Ŭ��ɾ�, ����Ŭ���� ���Ұ� ���
        
        �÷���Ī ���� : SELECT COLL AS "ù ��° �÷�"
                             COLL AS ù��°Į�� --(���帹�� ����ϴ� ����)
                             COLL ù��°Į��
                             
        [WHERE ����]: WHERE �������� �����Ǹ� �÷��� ��� ���� ��ȸ�Ѵ�.                     
        [ASC|DESC] : ASC�� ������������, DESC�� �������������� �����Ѵ�. (������ DEFAULT : ASC)
        
               [*] : '*'�� �ش� ���̺� �ִ� ��� �÷��� ��ȸ 
        [DISTINCT] : �ߺ��� �ڷḦ ���ܽ����ִ� �����
            ex. ȸ�����̺�(MEMBER)���� ȸ������ �ּ���(������) ������ ��ȸ�Ͻÿ�.
                SELECT SUBSTR(MEM_ADD1, 1, 2) AS �ּ���
                  FROM MEMBER; --��� �ּ��� ���� ���
                  
                SELECT DISTINCT SUBSTR(MEM_ADD1, 1, 2) AS �ּ���
                  FROM MEMBER; --�ߺ����� �������ش�.
        
            ex. ��ٱ������̺�(CART)���� 2005�� 6���� �Ǹŵ� ��ǰ�� ������ ��ȸ�Ͻÿ�. (�ǸŻ�ǰ ��ü��ȸ)
                -- �ǸŻ�ǰ ������ȸ�� �ߺ��� �����ؾ� �Ѵ�.
                SELECT COUNT(DISTINCT CART_PROD) AS ��ǰ�ڵ� 
                  FROM CART
                 WHERE CART_NO LIKE '200506%'
                 ORDER BY CART_PROD;
                 -- COUNT(DISTINCT CART_PROD) 
                 -- CART_PROD �÷����� �ߺ��� ������ ���� ���ڸ� ��ȯ���ش�.
                 
            ex. ������̺�(EMPLOYEES)���� ���Ǵ� �μ��ڵ带 ��ȸ�Ͻÿ�.
                SELECT EMPLOYEES.DEPARTMENT_ID AS �μ��ڵ�,
                       DEPARTMENT_NAME AS �μ���
                  FROM EMPLOYEES, DEPARTMENTS
                 WHERE EMPLOYEES.DEPARTMENT_ID= DEPARTMENTS.DEPARTMENT_ID
                 ORDER BY 1;
                  /*
                  [ORDER BY 1]
                    DEPARTMENT_ID�� �������� �������� �����϶�� �ǹ��̴�. (1 SELECT���� ������ �÷� �� ù ��°)
                    '�÷��ε���'�� SELECT���� ���� �÷��� �����̴� (1���� �����Ѵ�)
                  
                  TABLE 2�� �̻� ����ϴ� ��츦 JOIN�̶�� �ϸ�, WHERE���� �����ϸ� �ȵȴ�.
                  
                  [WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID]
                     DEPARTMENT_ID�� �� ���̺� ��� �����ϱ� ������ �����ϱ� ���� ���̺��.�÷������� �ۼ��Ѵ�.
                  */
                  
                SELECT DISTINCT A.DEPARTMENT_ID AS �μ��ڵ�,
                       DEPARTMENT_NAME AS �μ���
                  FROM EMPLOYEES A , DEPARTMENTS B
                 WHERE A.DEPARTMENT_ID= B.DEPARTMENT_ID
                 ORDER BY 1;
                 /*
                 [FROM EMPLOYEES A , DEPARTMENTS B]
                    ���̺� ��Ī�� ����ؼ� �ڵ带 ª�� ��밡���ϴ�.
                
                 JOIN�� ���� TABLE������ ���� ������ �޶�����.
                    ���� TABLE������ 2���� ��� 1���� ������ ����ؾ��Ѵ�. (TABLE - 1)��
                    
                 TABLE�� ������ �÷��� ���ٸ� �� TABLE�� ���谡 ���°��̴�.
                 */