<2020-08-31>

    1. IF문
        다른 응용 프로그램언어의 IF문과 같은 기능을 가진다
        사용형식 1. 
            IF 조건 THEN
                명령 1;
            [ELSE
                명령 2;]
            END IF;
            
        사용형식 2. 
            /* Nested IF*/
            IF 조건 1 THEN
                명령 1;
            ELSIF 조건 2 THEN
                명령 2;
            ELSIF 조건 3 THEN
                명령 3;
            ELSE
                명령 4;
            END IF
            
        사용형식 3.
            /*Nested IF*/
            IF 조건 1: THEN
                IF 조건 2: THEN
                    명령 1;
                ELSE
                    명령 2;
                END IF;
                /*내부 IF문에서도 반드시 END IF를 써준다*/
            ELSE 
                명령 3;
            END IF
            
            
        ex. 임의의 부서코드(10-110)를 하나 생성하여 해당부서에 속한 사원정보를 조회하고 
            첫 번째 검색된 사원의 급여가 3000미만이면 '낮은임금', 3000~5999이면 '중간임금'
            그 이상이면 '높은 임금'을 출력하시오.
            출력할 데이터는 사원명, 부서명, 급여, 비고이다.
            
        solution.
            DECLARE
                V_NAME EMPLOYEES.EMP_NAME%TYPE;
                V_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                V_SAL EMPLOYEES.SALARY%TYPE;
                V_REMARKS VARCHAR2(50);
                V_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
            BEGIN
                V_DEPT_ID := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
                /*
                10 ~ 110 까지의 난수를 발생시킨다 
                10의 단위 난수만을 발생시키기 위해 정수 1의 자리에서 반올림한다.
                */
                
                SELECT A.EMP_NAME,
                       B.DEPARTMENT_NAME,
                       A.SALARY INTO V_NAME, V_DEPT_NAME, V_SAL
                  FROM EMPLOYEES A, DEPARTMENTS B
                 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                   AND A.DEPARTMENT_ID = V_DEPT_ID
                   AND ROWNUM = 1;
                   
                IF V_SAL BETWEEN 1 AND 2999 THEN 
                   V_REMARKS := '낮은임금';
                ELSIF V_SAL BETWEEN 3000 AND 5999 THEN
                    V_REMARKS := '중간임금';
                ELSE
                    V_REMARKS := '높은임금';
                END IF;
                
                DBMS_OUTPUT.PUT_LINE(V_NAME||', '||V_DEPT_NAME||' ,'||V_SAL||'=>'||V_REMARKS);
                
            END;
            
