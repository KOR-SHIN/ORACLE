<2020-08-28>

    1. PL/SQL
        procedual language SQL의 약자이다.
        절차적 언어의 특징인 변수, 분기문, 반복문, 예외처리 등의 기능이 지원된 SQL이다.
        모든 코드가 DB내부에 생성되고 컴파일되어 저장되기 때문에 실행 속도가 빠르다.
        PL/SQL을 사용하면 네트워크의 트래픽이 감소한다.
        표준 문법이 없다.
        Anonymous Block, stored Procedure, User Defined Function, Package
        
        
            
        1-1. 익명블록 (Anonymous Block)
            기본적인 PL/SQL의 구조를 정의한다.
            이름이 없는 블록
            
            --------------------------------------------
            기본구조
                선언부 (변수, 상수, 커서)
                
            BEGIN
                실행부 (sql문으로 구성하여 비즈니스 로직 처리)
                [EXCEPTION 예외처리]
                
            END;
            --------------------------------------------
                ex. 정수형변수에 값을 배정하고 짝수인지 홀수인지 구분하여 출력하는 익명블록을 작성하시오.
                
                solution.
                    ACCEPT NUM1 PROMPT '정수 입력 : '
                    DECLARE
                        V_NUM NUMBER := 0;
                        --NUMBER를 0으로 초기화 해준것이다.
                        --초기화값을 넣지않으면 타입에 상관없이 초기값이 NULL이 된다.                
                        V_MESSAGE VARCHAR2(100);
                    BEGIN
                        V_NUM := TO_NUMBER('&NUM1');
                        --BEGIN은 C언어의 SCANF개념이다.
                        --NUM1의 값을 입력받아 V_NUM으로 대입한다.
                        IF MOD(V_NUM, 2) = 0 THEN 
                            V_MESSAGE := V_NUM||'은 짝수입니다.';
                        ELSE 
                            V_MESSAGE := V_NUM||'은 홀수입니다.';
                        --'%'연산자가 제공되지 않기때문에 MOD를 사용한다.
                        END IF;
                            DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
                        
                            EXCEPTION WHEN OTHERS THEN
                            DBMS_OUTPUT.PUT_LINE('예외발생'||SQLERRM);
                        END;

        
        1-2. 변수
            다른 응용프로그램 언어의 변수 개념과 동일하다.
            보통 일반 변수는 'V_'로, 매개변수는 'P_'로 부여한다.
            
            변수타입
                표준 SQL에서 사용하는 타입과 동일하며 추가적으로 BOOLEAN, BINARY_INTEGER, PLS_INTEGER가 지원된다.
                BOOLEAN : 논리값(true, false, null)
                BINARY_INTEGER, PLS_INTEGER : -2^31 ~ 2^31-1 까지의 정수를 처리할 수 있다.
            선언형식
                변수명 타입 [:=초기값];
                
            참조타입
                테이블명.컬럼명%TYPE
                    ex. V_PD PROD.PROD_DELIVERY%TYPE;
                테이블명%ROWTYPE
            
            ex. 회원테이블에서 회원의 직업을 입력받아 회원번호, 회원명, 마일리지를 출력하는 익명블록을 작성하여라.
            
            solution.
                ACCEPT A_JOB PROMPT '직업 : '
                DECLARE 
                    V_NAME MEMBER.MEM_NAME%TYPE;
                    V_ID MEMBER.MEM_ID%TYPE;
                    V_MILE MEMBER.MEM_MILEAGE%TYPE;
                    --V_NAME을 MEMBER 테이블의 MEM_NAME컬럼의 데이터타입을 선언한다.
                    --V_NAME을 MEMBER 테이블의 MEM_ID컬럼의 데이터타입을 선언한다.
                    --V_NAME을 MEMBER 테이블의 MEM_MILEAGE컬럼의 데이터타입을 선언한다.
                    
                    CURSOR CUR_MEM(V_JOB MEMBER.MEM_JOB%TYPE) IS
                        SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
                          FROM MEMBER
                         WHERE MEM_JOB = V_JOB;
                         --위의 4줄은 커서를 선언하는것이고 실행하는것은 BEGIN블록이다.
                BEGIN
                    OPEN CUR_MEM('&A_JOB');
                    LOOP
                        FETCH CUR_MEM INTO V_ID, V_NAME, V_MILE;
                        --INTO 뒤에 기술된 변수에 값을 차례대로 할당한다.
                        EXIT WHEN CUR_MEM%NOTFOUND;
                        /*
                        CURSOR 변수
                          IS-OPEN,
                          FOUND(FETCH한 결과에서 데이터가 존재하는 경우 TRUE)
                          NOTFOUND(FETCH한 결과 데이터가 없는 경우 TRUE) 
                          COUNT : 커서안에 몇 행이 있는지
                        */
                        DBMS_OUTPUT.PUT_LINE(V_ID||', '||V_NAME||', '||V_MILE);
                    END LOOP;
                    DBMS_OUTPUT.PUT_LINE(CUR_MEM%ROWCOUNT);
                    CLOSE CUR_MEM;
                END;
                    
                
        1-3. 상수
            다른 응용 프로그램 언어의 상수 개념과 동일하다.
            
            선언 형식 
                식별자(변수명) CONSTANT 타입 [:=초기값];
                
        1-4. CURSOR
            SQL 명령의 결과 집합
            쿼리 결과를 읽거나 수정하거나 별도의 작업을 수행하기 위해 커서를 사용한다.
            
            커서 사용단계
                생성(DECLARE) -> OPEN -> FETCH -> CLOSE
                OPEN ~ CLOSE는 BEGIN문에서 처리된다.
            
            커서 선언형식
                CURSOR 커서명[(매개변수 타입)]
                IS
                    SELECT 
                      FROM
                     WHERE
                   /*
                   '매개변수'에 값을 배정하는 곳은 OPEN문에서 수행한다.
                    IS에서는 값을 배정하는 것이 아니라 선언만 하는것이다.
                    */
                    
            커서 실행영역
                (1) OPEN 커서명(값 [, 값...]);
                
                (2) FETCH 커서명 INTO 변수명[, 변수명...];
                /*
                FETCH
                    커서에 존재하는 데이터를 행단위로 읽어 변수에 저장한다.
                    '변수'는 선언부에서 선언된 변수를 사용한다.
                    커서문 내의 SELECT절에 기술된 컬럼의 순서와 갯수, 타입이 일치
                    FETCH문은 반복문 안에 기술해야 한다(반복문을 사용하지 않으면 맨 첫줄만 읽어온다)
                */
                
                (3) CLOSE 커서명;
                /*
                사용이 종료된 커서를 닫아주는 역할을 한다.
                한번 CLOSE된 커서는 더 이상 OPEN 불가능하다.
                */
                
                (4) 커서 속성
                ----------------------------------------------------------------
                커서명%ISOPEN      커서의 OPEN여부를 확인한다 (CURSOR IS OPEN ? TRUE : FALSE)
                커서명%FOUND       커서에 읽어올 자료가 있거나 결과에 한 행이라도 존재하면 TRUE
                커서명%NOTFOUND    커서명%FOUND의 반대개념
                커서명%ROWCOUNT    커서 결과 집합에 존재하는 행 갯수 반환
                
                etc. 묵시적 커서의 속성은 '커서명'대신 'SQL'을 사용한다.
                    (SQL%ISOPEN은 항상 FALSE이다)
                
            ex. 커서로 회원ID, 이름, 마일리지를 생성시키고 해당 회원의 성별까지 출력하시오.
            
                            

                