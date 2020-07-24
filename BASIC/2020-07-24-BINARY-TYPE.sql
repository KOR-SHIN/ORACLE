<2020-07-24-03>
    1. 이진자료 저장을 위한 자료 타입
        BLOB, RAW, LONG RAW, BFILE
        
        1-1. RAW
            상대적으로 작은양의 이진 자료를 저장할 때 사용한다.
            인덱스 처리가 가능하다.
            데이터베이스에서 해석이나 변화 작업은 수행하지 않는다. 
            최대 2000BYTE 까지 저장 가능
            사용형식 : <컬럼명> RAW(크기)
                ex. CREATE TABLE TEMP07 (
                      COL1 RAW(1000),
                      COL2 RAW(200));
                      
                    INSERT INTO TEMP07
                      VALUES(HEXTORAW('6ADC'), HEXTORAW('FF'))
                    -- 내부에는 이진수로 변경되어 저장되지만 테이블 조회에서는 해석되어 지지않는다.
                    SELECT * FROM TEMP07;