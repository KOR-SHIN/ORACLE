<2020-08-14-01>
    
    1. ��¥�Լ�
    
        1-1. SYSDATE, SYSTIMESTAMP
                �ý����� �����ϴ� ��¥ �Լ�
                '+'�� '-'�� ������ �����ϴ�.
                
                SYSDATE : �ý��ۻ��� ��¥�� ǥ�����ش�.
                SYSTIMESTAMP : ��¥�� YY/MM/DD �������� ǥ�õǰ� 1/10���� ������ ǥ���ȴ�.
                               �ڿ� ������ +09:00�� �׸���ġõ���� ���ؽð��̴�.
                ex. SELECT SYSDATE,
                           SYSDATE+7,
                           SYSDATE-7,
                           SYSTIMESTAMP
                      FROM DUAL
                      
                      
        1-2. ADD_MONTHS
                ������� : ADD_MONTHS(d, n)
                �־��� ��¥������ d�� ���� n��ŭ�� ���� ���� ��¥�� ��ȯ�Ѵ�.
                
                ex. ���ú��� 2���� �� 7���� ��¥�� ��Ÿ���ÿ�.
                solution.
                    SELECT ADD_MONTHS(SYSDATE, 2) -7
                      FROM DUAL
                
                quiz. ȸ�����̺��� ȸ������ ���Ϲ��ڸ� �������� �Ѵ�.
                      ������ ������ �ִ� ȸ���� ã�� ���� 2������ ���ڸ� �߼��� �� �ֵ��� ȸ�������� ��ȸ�Ͻÿ�.
                      (��, Alias�� ȸ����ȣ, ȸ����, �̸����ּ�, �ڵ�����ȣ, ���ڹ߼����̴�.)
                      
                solution.
                    SELECT MEM_ID AS ȸ����ȣ,
                           MEM_NAME AS ȸ����,
                           MEM_MAIL AS �̸����ּ�,
                           MEM_HP AS �ڵ�����ȣ,
                           EXTRACT( YEAR FROM SYSDATE )||'��'||
                           EXTRACT( MONTH FROM MEM_BIR )||'��'||
                           (EXTRACT( DAY FROM MEM_BIR ) - 2)||'��' AS ���ڹ߼���
                           --���� ��¥�� 1�� or 2���� ��츦 ����ؼ� �ٽ� �ۼ��ؾ���
                      FROM MEMBER
                     WHERE EXTRACT( MONTH FROM MEM_BIR ) = EXTRACT( MONTH FROM SYSDATE ) + 1
                           
                