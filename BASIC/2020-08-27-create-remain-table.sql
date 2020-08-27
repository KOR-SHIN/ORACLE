<2020-08-27>

    ** ���� ���ǿ� �´� ���������̺��� �����Ͻÿ�.
    
        ���̺��  REMAIN
             �÷���             ������ Ÿ��              NULL ABLE               �������
        ------------------------------------------------------------------------------------
        REMAIN_YEAR             CHAR(4)                 NOT NULL                PK
        REMAIN_PROD             VARCHAR2(10)            NOT NULL                PK, FK
        REMAIN_J_00             NUMBER(5)               
        REMAIN_I                NUMBER(5)
        REMAIN_O                NUMBER(5)
        REMAIN_J_99             NUMBER(5)
        REMAIN_DATE             DATE
        ------------------------------------------------------------------------------------
        REMAIN_J_00 : �������
        REMAIN_I    : �԰����
        REMAIN_O    : ������
        REMAIN_J_99 : �⸻��� (������� + �԰���� - ������)
        
        CREATE TABLE REMAIN(
            REMAIN_YEAR CHAR(4),
            REMAIN_PROD VARCHAR2(10),
            REMAIN_J_00 NUMBER(5),
            REMAIN_I NUMBER(5),
            REMAIN_O NUMBER(5),
            REMAIN_J_99 NUMBER(5),
            REMAIN_DATE DATE,
            
            CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, REMAIN_PROD),
            CONSTRAINT fk_ramain FOREIGN KEY(REMAIN_PROD)
                        REFERENCES PROD(PROD_ID));
                        
                        
    ** REMAIN ���̺� ���� ���ǿ� �µ��� �ڷḦ PROD ���̺�κ��� �Է��Ͻÿ�.    
        (HINT. ���������� ���� INSERT������ �ϰ��Է� �ؾ��Ѵ� / ���������� INSERT���� �ۼ��� ���� 'VALUES'�� '( )'�� �����ȴ�)
            INSERT INTO REMAIN(REMAIN_YEAR, REMAIN_PROD, REMAIN_J_00,
                              REMAIN_I, REMAIN_O, REMAIN_J_99, REMAIN_DATE)
                 SELECT '2005', PROD_ID, PROD_PROPERSTOCK,
                         0, 0, PROD_PROPERSTOCK, '20050103'
                   FROM PROD;
                    
    ** REMAIN ���̺� ������ ���ԵǾ����� Ȯ���Ͻÿ�.
        SELECT * FROM REMAIN
                          
    ** �������̺��� �����ϱ� ���� ���̺��� �����Ͻÿ� (�������<pk, fk>�� ���簡 �Ұ����ϴ�)
        CREATE TABLE REMAIN1 AS 
        SELECT * FROM REMAIN
        
    ** ���� ���̺� ������ ���ԵǾ����� Ȯ���Ͻÿ�.
        SELECT * FROM REMAIN1

    ** UPDATE (REVIEW)
        �ܼ� UPDATE�� �� ���� �����͸� UPDATE�ϴ� ���
            UPDATE ���̺��
               SET �÷���=��[,
                   �÷Ÿ�=��[,
                   ...�÷���=��]
            [WHERE ����];
            
        UPDATE�� �ٿ����� ���
            UPDATE ���̺��
               SET (�÷���1, �÷���2, �÷���3 ...) =
                   (��1, ��2, ��3 ...)
            [WHERE ����];
        
        ���������� �̿��Ͽ� ���� �ϰ������� UPDATE ���
            UPDATE ���̺��
               SET (�÷���1, ...) = (��������)
             [WHERE ����];
            /* '(�÷���1, ...)'�� �÷� ���� �� ������ ���������� SELECT ���� �÷��� ���� �� ������ �����ؾ� �Ѵ� */
            
    
    ex. 2005�� 1�� �԰��ǰ�� ��ȸ�Ͽ� ���������̺� ���� �����Ͻÿ�.
    
    solution 1. 1���� �԰�� ��ǰ�� ��ǰ�ڵ�, ��ǰ���� ��ȸ
        SELECT BUY_PROD, SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
      GROUP BY BUY_PROD
      
    solution 2. UPDATE ����
        UPDATE REMAIN A
           SET (A.REMAIN_I,
                A.REMAIN_J_99,
                A.REMAIN_DATE) = (SELECT B.IAMT, 
                                         REMAIN_J_00 + B.IAMT - REMAIN_O,
                                         '20050131'
                                    FROM (    SELECT PROD_ID, 
                                                     NVL(SUM(BUY_QTY), 0) AS IAMT
                                                FROM BUYPROD
                                    RIGHT OUTER JOIN PROD
                                                  ON (BUY_PROD = PROD_ID)
                                                 AND BUY_DATE BETWEEN '20050101' AND '20050131'
                                               GROUP BY PROD_ID) B
                                   WHERE B.PROD_ID = A.REMAIN_PROD)
         WHERE REMAIN_YEAR = '2005'
         
    ROLLBACK
         UPDATE REMAIN A
           SET (A.REMAIN_I,
                A.REMAIN_J_99,
                A.REMAIN_DATE) = (SELECT B.IAMT, 
                                         REMAIN_J_00 + B.IAMT - REMAIN_O,
                                         '20050331'
                                    FROM (    SELECT PROD_ID, 
                                                     NVL(SUM(BUY_QTY), 0) AS IAMT
                                                FROM BUYPROD
                                    RIGHT OUTER JOIN PROD
                                                  ON (BUY_PROD = PROD_ID)
                                                 AND BUY_DATE BETWEEN '20050101' AND '20050331'
                                               GROUP BY PROD_ID) B
                                   WHERE B.PROD_ID = A.REMAIN_PROD)
         WHERE REMAIN_YEAR = '2005'
         
         SELECT * FROM REMAIN
         
      
      
      
      
      
      