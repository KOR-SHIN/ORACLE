<2020-07-29-01>
    ��Ÿ�ڷ���
    
    1. BFILE
        ���� ������ ����
        ����� �Ǵ� ���� �����͸� �����ͺ��̽� '�ܺ�'�� ����
        ��� ����(DIRECTORY ��ü)�� �����ͺ��̽��� ����
        4GB���� ó�� ����
        ���丮 ��Ī(Alias)�� 30BYTE, ���ϸ��� 256BYTE���� ����
        
        ������� : <�÷���> BFILE;
        
            ex. �����ڷ�(�׸�)�� ����� ���丮 ��ü ����
                CREATE DIRECTORY TEST_DIR AS 'E:\A_TeachingMaterial\2.Oracle';
            --  CREATE DIRECTORY <���丮 �̸�> AS <������>
            
                CREATE TABLE TEMP08(
                   COL BFILE
                );
                
                INSERT INTO TEMP08
                 VALUES(BFILENAME('TEST_DIR','sample.jpg'));
                 -- ' '�ȿ����� ��ҹ��ڰ� ���еȴ�.
                 
                SELECT * FROM TEMP08
                
                CREATE TABLE TEMP09(
                  COL1 BLOB);
          
    2. BLOB
        ���� ������ ����
        ����� �Ǵ� ���� �����͸� �����ͺ��̽� '����(�ϳ��� COLUMN �ȿ�)'�� ����
        4GB���� ó������
        �͸������� ���� ������ �ۼ�
            �͸��� ���� : 
                          DECLARE
                           L_DIR VARCHAR2(20) := 'TEST_DIR';
                           -- VARCHAR2(20)Ÿ���� L_DIR�� 'TEST_DIR'�� �Է��϶�.
                           L_FILE VARCHAR2(30) := 'sample.jpg';
                           L_BFILE BFILE;
                           L_BLOB BLOB;
                            
                          BEGIN 
                            INSERT INTO TEMP09 VALUES(EMPTY_BLOB()),
                             RETURN COL1 INTO L_BLOB;
                             -- TEMP09�� ���̾��� BLOB�� �ִ´�.
                             -- COL1
                           
                            L_BFILE := BFILENAME(L_DIR, L_FILE);
                            -- L_BFILE �� L_DIR, L_FILE�� 
                              
                            DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.READONLY);
                            -- L_BFILE�� READONLY�� OPEN�Ѵ�.
                              
                            DBMS_LOB.LOADFROMFILE(L_BLOB, L_BFILE, DBMS_LOB.GETLENGTH(B_FILE));
                            -- FILE�� LOAD�Ѵ�
                            -- B_FILE�� ���̸�ŭ L_BFILE���� �о�鿩��, L_BLOB�� �����Ѵ�.
                              
                            DMBS_LOB.FILECLOSE(L_BFILE);
                            -- L_BFILE�� �ݴ´�.
                              
                            COMMIT;
                        END;
                        
        ������� : <�÷���> BLOB;
        
            ex. CREATE TABLE TEMP09(
                   COL BLOB);
                   
                
            
    
    
    
    
    
    
    
    
    
    
    
    