<2020-07-23-03>

        -- ����Ŭ���� ���Ǵ� �ڷ������� ����, ���ڿ�, ��¥, ��Ÿ ������ ���еȴ�.
        
    1. ���ڿ� �ڷ���
        ����Ŭ�� ���ڿ� �ڷ�� ''�� ��� ǥ���Ѵ�. 
        ���ڿ� �ڷ������� CHAR, VARCHAR, VARCHAR2, LONG, CLOB, NVARCHAR, NCLOB ���� �ִ�.
        LONG : 2GB���� ǥ�� ���������� ��������� ���� ������� �ʴ´�.
        CLOB : 4GB���� ǥ�� �����ϰ� ��������� ���� ��� ���� ���ȴ�. 
            -- ���ξ�� N�� �������� NATIONAL�� ���ڷμ� ����ǥ�������� ���� ������� �ʴ´�.
        VARCHAR, VARCHAR2 : ���� �������� ���� ������ oracle���� VARCHAR2����� �����Ѵ�
            -- VARCHAR2�� ���� ORACLE������ ����Ѵ�.
        �ѱ۰� ���� : �ѱ��� �� ���ڿ� 3BYTE�� �����ϰ� ����� �� ���ڿ� 1BYTE�� �����Ѵ�.
            -- ������ BYTE_SIZE�� ������ �� ����ؾ� �Ѵ�.
            
            /* 
                CHAR�� ������ ��� ���ڿ� �ڷ����� �������̴�.
                
                <��������>
                ����ڰ� VARCHAR2(50)���� ������ ��� 30BYTE�� ����ϸ� 20BYTE�� ��ȯ�Ѵ�.
                ������ ����ڰ� �����س��� ũ�⺸�� ū �����͸� �Է��ϴ� ��� ERROR�� �߻���Ų��.
                
                <��������>
                �����س��� ũ�⺸�� ���� �����͸� �Է��� ��� ���� ������ ��ȯ���� �ʰ� �������� ä���.
                ����ڰ� �����س��� ũ�⺸�� ū �����͸� �Է��ϴ� ��� ERROR�� �߻���Ų��.
            */
        1) CHAR
            �������� ���ڿ��̱� ������ �⺻Ű �÷��� ������ Ÿ������ ����Ѵ�.
            ���ʺ��� ����ǰ� ���� ������ �������� ä���.
            ������� : <�÷���> CHAR(ũ�� [BYTE|CHAR]); 
            
            /*
                2000BYTE ���� ��� ����
                [BYTE|CHAR]�� �����ϸ� DEFAULT ���� BYTE�� �����ȴ�.
                CHAR�� ����ϴ� ��� 'ũ��'�� ���ڼ��� �ǹ��Ѵ�.
                ��, CHAR�� ����ص� 2000BYTE�� �ʰ��� �� ����.
                    ex. 2000byte��� �ص� 2000���ڸ� ���� �� ����. (�ѱ� 2000���� = 6000byte)
            */
        ex. CREATE TABLE TEMP01(
                COL1 CHAR(10),
                COL2 CHAR(10 BYTE),
                COL3 CHAR(10 CHAR)); --�ѱ۵� 10���� ���� �� ����
            
            INSERT INTO TEMP01
                VALUES('����', 'ABCDEF', '�����ô��ﵿ�߾ӷδ�');
            
            SELECT * FROM TEMP01;            
            
            SELECT LENGTHB(COL1), LENGTHB(COL2), LENGTHB(COL3) 
            FROM TEMP01;
            --LENGTHB(COLUMN) => COLUMN�� �������� BYTE������ ��ȯ����
    
        2. VARCHAR2
            �������� ���ڿ� ���忡 ���
            4000BYTE ���� ��밡��
            ������� : <�÷���> VARCHAR2(ũ�� [BYTE|CHAR])
            
        ex. CREATE TABLE TEMP02 (
                COL1 VARCHAR2(4000),
                COL2 VARCHAR2(4000 BYTE),
                COL3 VARCHAR2(4000 CHAR));
            
            INSERT INTO TEMP02
                VALUES('���ѹα�', 'KOREA', 'AAAAAAAAAAAAAAAAAA'),
            INSERT INTO TEMP02
                VALUES('Oracle', 'IL POSITION', 'Persimon');
            
            SELECT LENGTHB(COL1),
                   LENGTHB(COL2),
                   LENGTHB(COL3)
              FROM TEMP02;
              
            SELECT * FROM TEMP02
             WHERE COL1='���ѹα�'; 
            -- TEMP02 TABLE���� COL1���� '���ѹα�'�� ���� ������
        
        3. VARCHAR
            VARCHAR2�� ���� ��� ����
            Oracle �翡���� VARCHAR2 ����� �ǰ�
            �ٸ� DBMS������ �⺻ ���ڿ� Ÿ������ ���ȴ�.
             
        4. NVARCHAR2
            ����ǥ�� �ڵ�(�ٱ��� ���)�� ����Ͽ� ���ڿ� ����
            UTF-8(��������), UTF-16(��������) �������� ó��
            
        5. LONG
            �������� ���ڿ��� �����ϴ� ������ Ÿ��
            2GB���� ���尡�������� ��������� ���� �� ������� ����
                -- ������� : �� ���̺��� �ϳ��� �÷��� ��� �����ϴ�.
            ���� CLOB Ÿ������ ��ü�Ǹ鼭 �� �̻� ������Ʈ �����ʴ´�.
                -- LONG�� ����ϰų� ���� �� ���� �ִ�.
            SELECT�� SELECT��, UPDATE���� SET��, INSERT���� VALUES������ ��� �����ϴ�.
                -- ���� ��޵� �κ��� �����ϰ� ��� �Ұ����ϴ�.
            ������� : �÷��� LONG;
            
        ex. CREATE TABLE TEMP03 (
                COL1 LONG,
                COL2 VARCHAR2(100));
                
            INSERT INTO TEMP03 
                VALUES('DSADADLSADLASDAS;LDLSA;LDVDMKDMVKDVD', '������');
            SELECT * FROM TEMP03
           
        6. CLOB
            �������� ���ڿ� ������ ���� ������ Ÿ��
            �ִ� 4GB���� ���尡���ϴ�.
            �Ϻ� ��ɵ��� DBMS_LOB API�� ������ �޾ƾ� �Ѵ�.
            ������� : �÷��� CLOB
            
        ex. CREATE TABLE TEMP04 (
                COL1 CLOB,
                COL2 CLOB,
                COL3 CLOB,
                COL4 VARCHAR2(50));
            
            INSERT INTO TEMP04
                VALUES('�����ٶ󸶹ٻ����īŸ����', '���ѹα����ְ�ȭ��', 'CLOBCLOBCLOBCLOB', 'ABCDEFGHIJKLMN');

            SELECT DBMS_LOB.SUBSTR(COL1, 10, 2),
                   -- DBMS_LOB.SUTSTR(�÷���, ���ε���, �����ε���)
                   DBMS_LOB.GETLENGTH(COL2),
                   LENGTH(COL3),
                   -- CLOB�� ���� �� �� �ִ� �����Ͱ� �ſ�ũ�� ������ DMBS_LOB API�� ����ϴ°��� ��õ�Ѵ�.
                   -- ���ڼ��� �������� LENGTH(�÷���)�� ���ؼ� 
                   -- LENGTHB(�÷���)�� �������� �ʱ⶧���� ��� �Ұ����ϴ�.
                   SUBSTR(COL4, 2, 4)
                   -- SUTSTR(�÷���, �����ε���, ���ε���)
              FROM TEMP04;