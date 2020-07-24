<2020-07-24-02>
    1. ��¥�� �ڷ�
        ��¥�ڷ�(��, ��, ��, ��, ��, ��)�� �����ϴ� ������ Ÿ��
        DATE, TIMESTAMP ����
        
        1-1. DATE
            �⺻ ��¥��
            ���� ���� ����ϴ� ��¥�� ������ Ÿ��
            '+', '-'�� ����� �� �� �ִ�. ('/', '*'�� �Ұ����ϴ�)
            ������� : <�÷���> DATE --DATE TYPE�� ũ�⸦ �������� �ʴ´�.
            SYSDATE : �ý����� ��¥ ������ ��ȯ
                ex. CREATE TABLE TEMP05 (
                      COL1 DATE,
                      COL2 DATE,
                      COL3 DATE);
                    
                    INSERT INTO TEMP05
                      VALUES('20191130', SYSDATE, SYSDATE-20);
                      -- ���ڿ��� ���������� �÷��� ������ �� ���ڿ��� ��¥ǥ�� �����̸� ���ڿ��� ������������ ����ȯ���ش�.
                      
                    SELECT * FROM TEMP05;
                    SELECT TO_CHAR(COL1, 'YYYY-MM-DD HH24:MI:SS'),
                           TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
                           TO_CHAR(COL3, 'YYYY-MM-DD HH24:MI:SS')
                           FROM TEMP05;
                     /*
                        COL1�� �ִ� �����Ϳ��� �ð��� �������� �ʾұ� ������ 00:00:00���� �ʱ�ȭ �ȴ�
                        TO_CHAR(COL1, 'YYYY-NN-DD HH24:MI:SS')
                        COL1�� �ִ� �����͸� 'YYYY-NN-DD HH24:MI:SS'�������� CHAR�� ����ȯ�ؼ� �������
                     */
        1-2. TIMESTAMP
            �ð��� ����(TIMEZONE)�� 10����� 1�� ������ �ð����� ����
            �����(�ƽþ�, �����ƴϾ�) / ���ø�(����, �̱�)
            TIMESTAMP : TIME ZONE ������ ����.
            TIMESTAMP WITH TIME ZONE : TIME ZONE ������ �����ϰ� �ִ�.
            TIMESTAMP WITH LOCAL TIME ZONE : ������ ��ġ�� Ÿ���� ������ �����Ѵ�.
            
            ������� : <�÷���> TIMESTAMP;
                ex. CREATE TABLE TEMP06 (
                        COL1 TIMESTAMP,
                        COL2 TIMESTAMP WITH TIME ZONE,
                        COL3 TIMESTAMP WITH LOCAL TIME ZONE);
                    
                    INSERT INTO TEMP06
                      VALUES(SYSDATE, SYSDATE, SYSDATE);
                      
                      SELECT * FROM TEMP06