<2020-08-12>

    1. ��ȯ�Լ�
        �������� ���� ��ȯ�� �� ����Ѵ�.
        
        1-1. TO_CHAR
                ������� : TO_CHAR(, [, fmt])
        
                   <��¥��ȯ ����>
        -------------------------------------
            fmt                      ����
        -------------------------------------
            AM, PM                ����, ���� ǥ��
            A.M, P.M
            YYYY, YYY, YY, Y      ���� ǥ��
            MM                    ��(01 ~ 12)
            D                     ������ ��(1~7)
            DD                    ������ ��(1~31)
            DDD                   ������ ��(1~365)
            DAY                   ������ ���� ���Ϸ� ǥ��
            DL                    ��¥�� ���� ǥ��
            HH, HH12              12�ð����� �ð� ǥ��
            HH24                  24�ð����� �ð� ǥ��
            MI                    ��
            SS                    ��
            SSSSS                 ���� ��ü ����� �ð��� �ʷ� ȯ��
            WW                    ���� ������ ��Ÿ��(1~53��)
            
            ex.
                SELECT TO_CHAR(SYSDATE, 'YYY-MM-D'),
                       TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
                       TO_CHAR(SYSDATE, 'DD'),
                       TO_CHAR(SYSDATE, 'AM DDD'),
                       TO_CHAR(SYSDATE, 'DAY')
                  FROM DUAL
                  
                SELECT TO_CHAR(TO_DATE('19810126'), 'DAY'),
                       TO_CHAR(SYSDATE, 'HH24'),
                       TO_CHAR(SYSDATE, 'HH24 : MI : SSSSS'),
                       TO_CHAR(SYSDATE, 'HH24 : MI : SS'),
                       TO_CHAR(SYSDATE, 'WW HH24 : MI : SS'),
                       TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH12 : MI : SS')
                  FROM DUAL
                       

                   <���ں�ȯ ����>
        -------------------------------------
            fmt                      ����
        -------------------------------------
            .(dot)             �Ҽ����ڸ� ����
            ,(comma)           ���� �ڸ�����
            (9, 0)             9�� ��ȿ�� 0�� �������� ��ġ
                               0�� ��ȿ�� 0�� '0'���� ��ȯ
            PR                 ������ ��� < >�� ��� ǥ��
            RN, M              ���� �ڷḦ �θ��ڷ� ��ȯ�Ͽ� ǥ��
            
                       
            ����� ���� ���ڿ� : " "�ȿ� ���
                ex. ���� ��¥�� YYYY�� MM�� DD�� �������� ǥ���Ͻÿ�
                solution.
                    SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"')
                      FROM DUAL
            
                ex. ������̺��� �μ���ȣ 70�� �μ��� ����� ��ȸ�Ͻÿ�.
                    (��, Alias�� �����, ��å, �޿��̸� �޿��� 123,456.0 �������� ����Ѵ�)
                
                solution.
                    SELECT EMP_NAME AS �����,
                           JOB_ID AS ��å,
                           TO_CHAR(SALARY, '999,999.0') AS �޿�
                      FROM EMPLOYEES
                     WHERE DEPARTMENT_ID = 70
                
                ex. ��ǰ���̺�(PROD)���� �ŸŰ����� �ǸŰ��� �����Ͽ� ����Ͻÿ�
                    (Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, ���԰���, �ǸŰ���, ����)
                
                solution.              
                    SELECT PROD_ID AS ��ǰ�ڵ�,
                           PROD_NAME AS ��ǰ��,
                           PROD_LGU AS �з��ڵ�,
                           TO_CHAR(PROD_COST,'99,999,999') AS ���԰���,
                           TO_CHAR(PROD_PRICE,'99,999,999') AS �ǸŰ���,
                           TO_CHAR(PROD_COST - PROD_PRICE, '999,999,999PR') AS ���� 
                      FROM PROD;
                                 
                 ex. ��ǰ�з����̺�(LPROD)�� LPROD_ID(���������� �ο��� ����)�� �θ�ǥ��� ��ȯ�Ͽ���.
                     (Alias�� ����, �����ڵ�, ��ǰ��)
               
                 solution.
                    SELECT LPROD_ID AS ����,
                           TO_CHAR(LPROD_ID, 'RN') AS "����(�θ�)",
                           LPROD_GU AS �����ڵ�,
                           LPROD_NM AS ���и�
                      FROM LPROD;


        1-2. TO_NUMBER
                ���ڳ� �ٸ� ������ ���ڸ� NUMBERŸ������ ��ȯ�Ѵ�.
                ������� : TO_NUMBER(c [,fmt])
                
                ex. ȸ�����̺��� �ֹι�ȣ �� �ڸ��� �̿��Ͽ� ���̸� ����Ͽ���
                    (��, Alias�� ȸ���̸�, ����⵵ 2�ڸ�, �����̴�)
                    
                solution.
                    SELECT MEM_NAME AS ȸ���̸�,
                           SUBSTR(MEM_REGNO1, 1, 2)||'��' AS ����⵵,
                           2020 - TO_NUMBER((SUBSTR(MEM_REGNO1, 1, 2)) + 1900) AS ����
                      FROM MEMBER
                  ORDER BY MEM_REGNO1;
                  
                  etc. 
                  SELECT TO_NUMBER('12345', '99,999') FROM DUAL
                         -- ','�� ���� ������ �ȵǱ� ������ ������ �Ұ�����.
                  SELECT TO_NUMBER('12345', '99999.0') FROM DUAL
                  SELECT TO_DATE('19961203', 'YYYY-MM-DD') FROM DUAL
                  
        1-3. TO_DATE
                ���ڿ��� ��¥������ ��ȯ�Ѵ�.
                ������� : TO_DATE(c, [, fmt])
                
                ex. ȸ�����̺��� �ֹε�� ��ȣ�� �̿��Ͽ� ��������� ����Ͻÿ�.
                
                solution.
                    SELECT MEM_NAME AS ȸ����,
                           TO_CHAR(TO_DATE('19'||SUBSTR(MEM_REGNO1, 1, 2), 'YYYY"��" MM"��" DD"��"') AS �������,
                      FROM MEMBER
                     
                    SELECT MEM_NAME AS ȸ����,
                           TO_CHAR(CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = '1' OR SUBSTR(MEM_REGNO2,1,1) = '2' THEN TO_DATE('19' || MEM_REGNO1)
                           ELSE TO_DATE('20' || MEM_REGNO1) END, 'YYYY"��" MM"��" DD"��"') AS �������
                      FROM MEMBER;
     