<2020-07-29-01>
    기타자료형
    
    1. BFILE
        이진 데이터 저장
        대상이 되는 이진 데이터를 데이터베이스 '외부'에 저장
        경로 정보(DIRECTORY 객체)만 데이터베이스에 저장
        4GB까지 처리 가능
        디렉토리 별칭(Alias)은 30BYTE, 파일명은 256BYTE까지 가능
        
        사용형식 : <컬럼명> BFILE;
        
            ex. 원본자료(그림)이 저장된 디렉토리 객체 생성
                CREATE DIRECTORY TEST_DIR AS 'E:\A_TeachingMaterial\2.Oracle';
            --  CREATE DIRECTORY <디렉토리 이름> AS <절대경로>
            
                CREATE TABLE TEMP08(
                   COL BFILE
                );
                
                INSERT INTO TEMP08
                 VALUES(BFILENAME('TEST_DIR','sample.jpg'));
                 -- ' '안에서는 대소문자가 구분된다.
                 
                SELECT * FROM TEMP08
                
                CREATE TABLE TEMP09(
                  COL1 BLOB);
          
    2. BLOB
        이진 데이터 저장
        대상이 되는 이진 데이터를 데이터베이스 '내부(하나의 COLUMN 안에)'에 저장
        4GB까지 처리가능
        익명블록으로 저장 쿼리를 작성
            익명블록 구조 : 
                          DECLARE
                           L_DIR VARCHAR2(20) := 'TEST_DIR';
                           -- VARCHAR2(20)타입의 L_DIR에 'TEST_DIR'을 입력하라.
                           L_FILE VARCHAR2(30) := 'sample.jpg';
                           L_BFILE BFILE;
                           L_BLOB BLOB;
                            
                          BEGIN 
                            INSERT INTO TEMP09 VALUES(EMPTY_BLOB()),
                             RETURN COL1 INTO L_BLOB;
                             -- TEMP09에 값이없는 BLOB를 넣는다.
                             -- COL1
                           
                            L_BFILE := BFILENAME(L_DIR, L_FILE);
                            -- L_BFILE 에 L_DIR, L_FILE을 
                              
                            DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.READONLY);
                            -- L_BFILE을 READONLY로 OPEN한다.
                              
                            DBMS_LOB.LOADFROMFILE(L_BLOB, L_BFILE, DBMS_LOB.GETLENGTH(B_FILE));
                            -- FILE을 LOAD한다
                            -- B_FILE의 길이만큼 L_BFILE에서 읽어들여서, L_BLOB에 저장한다.
                              
                            DMBS_LOB.FILECLOSE(L_BFILE);
                            -- L_BFILE을 닫는다.
                              
                            COMMIT;
                        END;
                        
        사용형식 : <컬럼명> BLOB;
        
            ex. CREATE TABLE TEMP09(
                   COL BLOB);
                   
                
            
    
    
    
    
    
    
    
    
    
    
    
    