<2020-09-01>

    1. OUT �Ű�����
        ������ BLOCK�� ����ȴ�.
        
        ex. ȸ����ȣ�� �Է¹޾� �̸��� ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�.
            (��, �̸��� ������ OUT �Ű������� ����Ͻÿ�)
        
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
                --SQPPLUS�� �ڵ��ϴ� ���� ������ �ڵ��Ѵ� (LINE ����)
                PROC_MEM02('g001', V_NAME, V_JOB);
                DBMS_OUTPUT.PUT_LINE('ȸ���� : ' || V_NAME);
                DBMS_OUTPUT.PUT_LINE('���� : ' || V_JOB);
            END;
                    
            **SQLPLUS
             SQL>VAR V_NAME MEMBER.MEM_NAME%TYPE;
             SQL>VAR V_JOB MEMBER.MEM_JOB%TYPE;
             SQL>EXEC  PROC_MEM02('g001',:V_NAME,:V_JOB);
             SQL>PRINT V_NAME;
             SQL>PRINT V_JOB;
             SQL>/

                