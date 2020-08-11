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
         
    
    
    
    6. BETWEEN ~ AND ���ǽ�
    
         
         
         
         
         