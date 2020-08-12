<2020-08-11-01>

    1. ���� �����ڸ� ����Ͽ� ���ǹ� ����
        ���߾���� if���� ���Ǵ� ���ǹ��� �����ϴ�.
        >, <, <=, >=, !=(<>), = ���
        
    2. ��������(NOT(!), AND, OR)
        �������� ���ǹ��� �����Ѵ�.
        �켱���� : NOT > AND > OR
        
    3. ��Ÿ ������
        ANY, SOME, IN, ALL, EXISTS ���� �����ȴ�.
        ANY, SOME, IN �� ������ ����� ������
        
        IN : ���迬���ڰ� �����ʴ´�. 
             �÷��� ���� �������� �־��� �� �� ��� �Ѱ����� ��ġ�ϸ� ��ü�� ��(TRUE)�� ��ȯ�Ѵ�.
             ������� : �÷��� IN (��1, ��2, ... )
             OR�����ڷ� ��ȯ�� �����ϴ�.
                
        ANY : ��� ������ �����ؾ� ������ �����ȴ�.
              ������� : �÷���(ǥ����) ���迬���� ANY (��1, ��2, ... )
              OR �����ڷ� ��ȯ����
              IN �����ڷ� ��ȯ �� ���� ���迬���ڸ� ���� �ؾ��Ѵ�.
              ������ ������ IN �����ڿ� ����.
        
        ALL : ��� ������ �����ؾ��Ѵ�.
              ALL�� ����ؼ� ����� ���°��� ���߰��� ���� ��찡 ����(�� 1 ����ȭ�� ������ ���)
              ALL �����ڸ� ����Ͽ� ����� ������ ���� ���� ����.
              
        EXISTS : �ڿ� �ݵ�� ���������� ���;� �Ѵ�. (�Ϲ� ���ǹ� �Ұ���)
        /* �����ڸ� �� Ȱ���ϸ� �ڵ��� ���̸� ���� �� �ִ�.
           �����ڸ� ����� �� �ǿ������� Ÿ���� �ݵ�� ����ؾ� �Ѵ� */
        
    ex. ȸ�����̺�(MEMBER)���� ����⵵�� 1973�⵵ ���� ����� ȸ���� ��ȸ�Ͻÿ�.
        (��, alias �� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ�̴�)
        
    solution1 1.
        MEM_REGNO1�� ���ǹ����� ����ϴ� ��� (CHAR TYPE)
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹε�Ϲ�ȣ --ORACLE���� ||�� '+'�������̴�.
          FROM MEMBER
         WHERE SUBSTR(MEM_REGNO1,1,2)>='73';
         
    solution 2. 
        MEM_BIR�� ���ǹ����� ����ϴ� ��� (DATE TYPE)
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹε�Ϲ�ȣ --ORACLE���� ||�� '+'�������̴�.
          FROM MEMBER
         WHERE MEM_BIR>='19730101';
         /*
         ���ڿ��� ��¥�������� ��ȯ����������, DATE TYPE�� FORMAT�� �°� ����Ѵ� (YYYY-MM-DD '-'����)
         MEM_MIR �� DATE TYPE, REGNO�� CHAR TYPE
         WHERE MEM_BIR>='19730101' => '19730101'�� DATE TYPE���� ĳ���õȴ�.
         */
         
    ex. ������̺�(EMPLOYEES)���� �޿�(SALARY)�� 5000�̻��̰�, 
        �μ��ڵ�(DEPARTMENT_ID)�� 80���� ����� ��ȸ�Ͻÿ�.
        (��, Alias�� �����ȣ, �����, �μ��ڵ�, �޿�, ��ȭ��ȣ�̴�)
        
    solution.
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               DEPARTMENT_ID AS �μ��ڵ�,
               SALARY AS �޿�,
               PHONE_NUMBER AS ��ȭ��ȣ
          FROM EMPLOYEES
         WHERE DEPARTMENT_ID=80 AND SALARY>=5000;
    
    
    ex. ������̺��� 30, 40, 60�� �μ��� ���� ��������� ��ȸ�Ͻÿ�.
        (��, Alias�� �����, �μ��ڵ�, �μ���, �������̴�)
        
    solution 1.
        (OR ������ ���)
        SELECT A.EMP_NAME AS �����,
               A.DEPARTMENT_ID AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               C.JOB_TITLE AS ������
          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
          /*FROM���� ����� ��Ī�� FROM�� ���Ŀ� ����Ǵ� ������ ��� ��밡���ϴ�*/
         WHERE A.DEPARTMENT_ID = 30
            OR A.DEPARTMENT_ID = 40
            OR A.DEPARTMENT_ID = 60
           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.JOB_ID = C.JOB_ID;
            /*JOIN�� N���� TABLE�� ����� �� ��� N-1���� ����ؾ� �Ѵ�*/
            
     solution 2.
        (IN ������ ���)
        SELECT A.EMP_NAME AS �����,
               A.DEPARTMENT_ID AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               C.JOB_TITLE AS ������
          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
         WHERE A.DEPARTMENT_ID IN(30, 40, 60)
           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.JOB_ID = C.JOB_ID;
         
    solution 3.
        (ANY ������ ���)
         SELECT A.EMP_NAME AS �����,
               A.DEPARTMENT_ID AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               C.JOB_TITLE AS ������
          FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
         WHERE A.DEPARTMENT_ID = ANY(30, 40, 60)
           AND A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.JOB_ID = C.JOB_ID;
           
           
    4. NULL ���ǽ�
        NULL���� �񱳴� ���迬����('-')�� ���� �� ����
        IS NULL, IS NOT NULL ����Ͽ� ���Ѵ�.
        !=�� ������� �ʴ´�. (!=�� ����ص� �������� �� ������ ���Ǻ񱳰� �ȵȴ�)
        
    ex. ������̺�(EMPLOYEES)���� ���������ڵ�(COMMISSION_PCT)�� NULL�� ����� ��ȸ�Ͻÿ�.
        (��, Alias�� ����̸�, �μ��ڵ�, ��������)
        
    solution.
        SELECT EMP_NAME AS ����̸�,
               DEPARTMENT_ID AS �μ��ڵ�,
               COMMISSION_PCT AS ��������
          FROM EMPLOYEES
         WHERE COMMISSION_PCT IS NOT NULL;
         
    ex. ������̺�(EMPLOYEES)���� ���ʽ��� �����Ͽ� �޾־��� ��ȸ�Ͻÿ�.
        ���ʽ� = ����(SALARY) * ��������
        �޾־� = ����+���ʽ�
        (��, Alias�� �����, ����, ���ʽ�, ���޾��̴�.)
        
        SELECT EMP_NAME AS �����,
               SALARY AS ����,
               SALARY * COMMISSION_PCT AS ���ʽ�,
               SALARY + (SALARY * COMMISSION_PCT) AS ���޾�
          FROM EMPLOYEES;
          /*
          �� ���ô� NULL������ ���� �߸��� ����� ������ ����
          SELECT ������ ������ �־��� ���, �ǿ����� �� �ϳ��� NULL���� �����°��� �ִٸ�
          ��� ����� ��� NULL���� �Ǳ⶧���� NULL CHECK�� �ݵ�� �ϰų�, ������ �־�� �Ѵ�
          */
             
   5. LIKE ������
         ���Ϻ� ������
         '%', '_' ���ϵ�ī�� ���
         '%' : ���� ��ġ ������ ��� ���ڿ��� ����
            ex. '��%' -> '��'���� ���۵Ǵ� ��� ���ڿ��� ����
         '_' : ���� ��ġ���� �ѱ��ڿ� ����
            ex. 'ȫ_��' -> ù ���ڰ� 'ȫ'�̰� 3���ڷ� �����ǰ� ������ ���ڰ� '��'�� ���ڿ��� ����
        ���Ϻ񱳸� ���� Ư�� Ű���尡 �� ���ڿ��� �����ϰų�, �������� ������ �����ϴ�.
        LIKE �����ڴ� ���ڿ� �񱳿��� ����Ѵ�.
        LIKE �����ڴ� ���迬���ڸ� ������� �ʴ´�.
    
    ex. ȸ�����̺��� �������� '����'�� ȸ���� ��ȸ�Ͻÿ�.
        (��, Alias�� ȸ����ȣ, ȸ����, ����, �ּ�, ���ϸ����̸�, �ּҴ� ���ּұ��� ����Ͽ���.)
    solution.
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               CASE WHEN SUBSTR(MEM_REGNO2, 1, 1)='1' THEN '����ȸ��'
                    ELSE '����ȸ��' END AS ����,
                /*
                CASE WHEN IF(���ǹ�)
                THEN : TRUE�� ��� 
                ELSE : FLASE�� ��� 
                END : CASE�� ����
                */
                MEM_ADD1||'-'||MEM_ADD2 AS �ּ�,
                MEM_MILEAGE AS ���ϸ���
           FROM MEMBER
          WHERE MEM_ADD1 LIKE '����%';
       -- WHERE SUBSTR(MEM_ADD1, 1, 2) = '����' (ó���ӵ��� LIKE�����ں��� ������)
    
    ex. �������̺�(BUYPROD)���� 2005�� 5~6���� ������ ������ǰ(P102)���� ��Ȳ�� ��ȸ�Ͻÿ�.
        (��, Alias�� ��¥(DATE), ��ǰ�ڵ�(PROD), ����(QTY), �ܰ�(COST), �ݾ�(QTY*COST)
        (BUYER�� �ŷ�ó, BUYPROD�� ������, CART�� ������)
        
    soltion.
        SELECT BUY_DATE AS ��¥,
               BUY_PROD AS ��ǰ�ڵ�,
               BUY_QTY AS ����,
               BUY_COST AS �ܰ�,
               BUY_QTY * BUY_COST AS �ݾ�
          FROM BUYPROD
         WHERE BUY_DATE >= '20050501'
           AND BUY_DATE <= '20050630'
           AND BUY_PROD LIKE 'P102%'
            -- SUBSTR(BUY_PROD, 1, 4) = 'P102'
      ORDER BY 3 DESC, 1 DESC;
         /*
         ORDER BY <COLUMN | COLUMN NUMBER(1, 2, 3..)> DESC �������� 
         ORDER BY <COLUMN | COLUMN NUMBER(1, 2, 3..)> ASC �������� 
         Ű���带 �����ϸ� ASC�� ���ĵȴ�.
         ORDER BY ù ��° ���ǿ��� ������ �ȵǴ� ��(�ߺ����� �ִ� ���)�� �� ��° ������ �������� �����Ѵ�.

         BUY_PROD LIKE 'P102' (���ڿ��� ���Ҷ��� ��ҹ��ڸ� ���Ѵ�)
         UPPER(BUY_PROD) LIKE 'P102' (PROD�� �ִ� �����͸� �빮�ڷ� �ٲ㼭 ���ϱ�)
         LOWER(BUY_PROD) LIKE 'p102' (PROD�� �ִ� �����͸� �ҹ��ڷ� �ٲ㼭 ���ϱ�)
         */
    
    
    6. BETWEEN ~ AND ���ǽ�
        ������ �����Ͽ� ���ϴ� ��� ����Ѵ�.
        AND(��������)�� ����Ͽ� ��� �����ϴ�.
        ���ڿ�, ����, ��¥ Ÿ�� ��ο� ���� �����ϴ�.
        ������� : �÷���|���� BETWEEN ��1 AND ��2
                  '�÷���|����'�� ����� ���� '��1'<= ��<='��2'�� �����ϸ� ��(TRUE)�̴�.
        
    ex. �������̺�(BUYPROD)���� 2005�� 5~6���� ������ ������ǰ(P102)���� ��Ȳ�� ��ȸ�Ͻÿ�.
        (��, Alias�� ��¥(DATE), ��ǰ�ڵ�(PROD), ����(QTY), �ܰ�(COST), �ݾ�(QTY*COST)�̰� BETWEEN�� ����ؾ� �Ѵ�.)
        
    solution.
        SELECT BUY_DATE AS ��¥,
               BUY_PROD AS ��ǰ�ڵ�,
               BUY_QTY AS ����,
               BUY_COST AS �ܰ�,
               BUY_QTY * BUY_COST AS �ݾ�
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN '20050501' AND '20050630'
           AND BUY_PROD LIKE 'P102%'
            -- SUBSTR(BUY_PROD, 1, 4) = 'P102'
      ORDER BY 3 DESC, 1 DESC;
    
    ex. ��ٱ������̺�(CART)���� 2005�� 6�� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�.
        (��, Alias�� ȸ����ȣ, ���űݾ��հ�)
      
    solution.  
        SELECT CART_MEMBER AS ȸ����ȣ,
               SUM(CART_QTY * PROD_PRICE) AS "���űݾ� �հ�",
               MEM_NAME AS ȸ����
          FROM CART , PROD, MEMBER
         WHERE CART_PROD = PROD_ID --JOIN ����
           AND CART_MEMBER = MEM_ID
           AND CART_NO LIKE '200506%'
      GROUP BY CART_MEMBER, MEM_NAME;
              
        /*
        CART_NO(8�ڸ� ��¥, 5�ڸ��� ���������� �ο��Ǵ� ��ȣ�̴� 00001 ~ 99999����)
        CART_MEMBER (������ �̸�)
        CART_PROD (���Ż�ǰ �ڵ�)
        CART_QTY (���ż���)
        PROD_PRICE (�ǸŴܰ�)
        PROD_SAIL (���δܰ�)
        PROD_ID (��ǰ�ڵ�)
        �����Լ��� ��� �� ���� GROUP BY�� ����ؾ��Ѵ�.
        */
        
          
    ex. ������̺�(EMPLYOEES)���� �޿��� 5000 ~ 12000 ������ ��������� ��ȸ�Ͻÿ�
        (��, Alias�� �����ȣ, �����, �޿�, �����ڵ�(JOB_ID))
        
    solution.
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               SALARY AS �޿�,
               JOB_ID AS �����ڵ�
          FROM EMPLOYEES
         WHERE SALARY BETWEEN 5000 AND 12000
      ORDER BY SALARY, EMPLOYEE_ID;
    
         
         
         
         
         