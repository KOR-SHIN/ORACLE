<2020-07-24-02>
    1. 날짜형 자료
        날짜자료(년, 월, 일, 시, 분, 초)를 저장하는 데이터 타입
        DATE, TIMESTAMP 제공
        
        1-1. DATE
            기본 날짜형
            가장 많이 사용하는 날짜형 데이터 타입
            '+', '-'의 대상이 될 수 있다. ('/', '*'은 불가능하다)
            사용형식 : <컬럼명> DATE --DATE TYPE은 크기를 지정하지 않는다.
            SYSDATE : 시스템의 날짜 정보를 반환
                ex. CREATE TABLE TEMP05 (
                      COL1 DATE,
                      COL2 DATE,
                      COL3 DATE);
                    
                    INSERT INTO TEMP05
                      VALUES('20191130', SYSDATE, SYSDATE-20);
                      -- 문자열을 날싸형식의 컬럼에 저장할 때 문자열이 날짜표시 형식이면 문자열을 날씨형식으로 형변환해준다.
                      
                    SELECT * FROM TEMP05;
                    SELECT TO_CHAR(COL1, 'YYYY-MM-DD HH24:MI:SS'),
                           TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
                           TO_CHAR(COL3, 'YYYY-MM-DD HH24:MI:SS')
                           FROM TEMP05;
                     /*
                        COL1에 있는 데이터에는 시간을 지정하지 않았기 때문에 00:00:00으로 초기화 된다
                        TO_CHAR(COL1, 'YYYY-NN-DD HH24:MI:SS')
                        COL1에 있는 데이터를 'YYYY-NN-DD HH24:MI:SS'형식으로 CHAR로 형변환해서 출력해줌
                     */
        1-2. TIMESTAMP
            시간대 정보(TIMEZONE)와 10억분의 1초 단위의 시간정보 제공
            대륙명(아시아, 오세아니아) / 도시명(서울, 미국)
            TIMESTAMP : TIME ZONE 정보가 없다.
            TIMESTAMP WITH TIME ZONE : TIME ZONE 정보를 포함하고 있다.
            TIMESTAMP WITH LOCAL TIME ZONE : 서버가 위치한 타임존 정보를 포함한다.
            
            사용형식 : <컬럼명> TIMESTAMP;
                ex. CREATE TABLE TEMP06 (
                        COL1 TIMESTAMP,
                        COL2 TIMESTAMP WITH TIME ZONE,
                        COL3 TIMESTAMP WITH LOCAL TIME ZONE);
                    
                    INSERT INTO TEMP06
                      VALUES(SYSDATE, SYSDATE, SYSDATE);
                      
                      SELECT * FROM TEMP06