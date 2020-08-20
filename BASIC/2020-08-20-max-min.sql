<2020-08-20>

    1. MIN, MAX, 
        ������� : MIN(expr), MAX(expr)
        �־��� �÷��̳� ������ �� �� �ּ�(MIN)�Ǵ� �ִ�(MAX)���� ã�� ��ȯ�Ѵ�.
       
        ** GREATEST
        ������� : GREATEST(n1, n2, n3 ... )
        �־��� �ڷ� n1~���� �ִ밪�� ã�� ��ȯ�Ѵ�.
        
        ** LEAST
        ������� : LEASTEST(n1, n2, n3 ... )
        �־��� �ڷ� n1~���� �ּҰ��� ã�� ��ȯ�Ѵ�.
        
            ex. ������ 2005�� 7�� 28���̶�� �����Ͽ� ��ٱ��� ��ȣ�� �����Ͻÿ�.
            solution.
                SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')
                       ||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1, '00000'))
                  FROM CART;
                  /*
                  CART_NO�� ���� ���ڷ� ��ȯ���� �ʴ� ����(���ĺ� ��)�� ��������,
                  ���� ������� ������ �Ѵ�.
                  */
                  
            solution2.
                SELECT MAX(CART_NO)+1
                  FROM CART;
                  /*
                  CART_NO�� �������� ���ڿ������� ���ڷ� ��ȯ���� �ʴ� ���ڰ� ����.
                  ����, MAX�Լ��� ����Ͽ� ������ �������Ѵ�
                  */
            ex. ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ���� ã�� ���ϸ����� 1000���� �����Ͻÿ�.
            solution.
                SELECT MEM_ID AS ȸ����ȣ,
                       MEM_NAME AS ȸ���̸�,
                       GREATEST(MEM_MILEAGE, 1000) AS ���ϸ���
                       -- MILEAGE�� 1000���� ������, �ִ밪�� 1000�� ��µǵ��� �����
                  FROM MEMBER;
                  