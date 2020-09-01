<2020-09-01>

    1. OUT 매개변수
        실행이 BLOCK에 기술된다.
        
        ex. 회원번호를 입력받아 이름과 직업을 출력하는 프로시져를 작성하시오.
            (단, 이름과 직업은 OUT 매개변수를 사용하시오)
        
        solution 1. COMPILE
            CREATE OR REPLACE PROCEDURE PROC_MEM02 (
                P_MEM_ID IN MEMBER.MEM_ID%TYPE,
                P_NAME OUT MEMBER.MEM_NAME%TYPE,
                P_JOB OUT MEMBER.MEM_JOB%TYPE)
            IS
            BEGIN
                SELECT MEM_NAME, MEM_JOB INTO P_NAME, P_JOB
                  FROM MEMBER
                 WHERE MEM_ID = P_MEM_ID;
            END;
            
        solution 1-1. EXCUTE
            DECLARE
                V_NAME MEMBER.MEM_NAME%TYPE;
                V_JOB MEMBER.MEM_JOB%TYPE;
            BEGIN
                --EXEC PROC_MEM02('g001', : V_NAME, : V_JOB);
                --SQPPLUS에 코딩하는 경우는 위같이 코딩한다 (LINE 단위)
                PROC_MEM02('g001', V_NAME, V_JOB);
                DBMS_OUTPUT.PUT_LINE('회원명 : ' || V_NAME);
                DBMS_OUTPUT.PUT_LINE('직업 : ' || V_JOB);
            END;
                    
            **SQLPLUS
             SQL>VAR V_NAME MEMBER.MEM_NAME%TYPE;
             SQL>VAR V_JOB MEMBER.MEM_JOB%TYPE;
             SQL>EXEC  PROC_MEM02('g001',:V_NAME,:V_JOB);
             SQL>PRINT V_NAME;
             SQL>PRINT V_JOB;
             SQL>/

                