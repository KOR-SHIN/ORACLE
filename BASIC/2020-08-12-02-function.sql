<2020-08-12-02>

    1. 함수(FUNCTION)
        1-1. ABS
            매개변수로 전달 받의 값의 절대값을 반환한다.
            만약 매개변수로 문자가 들어오면 숫자로 바뀐다.
            사용형식 : ABS(n)
                ex. SELECT ABS(100), ABS(-100), ABS('-20')
                      FROM DUAL;
                      
            만약 숫자로 변환하지 못하는 매개변수가 들어오면(16진수 표현 불가능) 오류가 난다.
                ex. SELECT ABS('A')
                      FROM DUAL;
            
        
        1-2. CEIL 과 FLOOR (자주 사용되지는 않는다)
                CEIL : 주어진 매개변수와 같거나 가장 큰 정수를 반환한다. (실수인 경우 실수보다는 크고 가장 가까운 정수를 반환한다)
                사용형식 : CEIL(n)
                    ex. SELECT CEIL(10), CEIL(10.67),
                               CEIL(-10.67), CEIL(10.0001)
                          FROM DUAL;
                          
                 FLOOR : 주어진 매개변수와 같거나 작은쪽에서 가장 큰 정수를 반환
                사용형식 : FLOOR(n)
                    ex. SELECT FLOOR(10), FLOOR(10.67),
                               FLOOR(-10.67), FLOOR(10.0001)
                          FROM DUAL;        
                          
        1-3. ROUND(반올림)와 TRUNC(절삭)
                ROUND : 주어진 n을 
                        i가 양수인 경우 소수점 이하 i+1번째 자리에서 반올림하여 소수점 i번째 자리까지 반환한다.
                        i가 생략되면 0으로 간주한다.
                        i가 음수인 경우 정수부분의 i번째 자리에서 반올림하여 반환한다.
                        (음수의 경우 i = 10^ABS(i)번째 자리에서 반올림 한다, 정수자리수는 소수점 이전부터 -1번째이다.)
                        
                사용형식 : ROUND(n, i)
                    ex. SELECT ROUND(123456, -1), ROUND(123.456, 1)
                          FROM DUAL;
                        
                    ex. 사원테이블의 급여가 연봉이고, 매달급여가 13으로 나눈 값을 지급한다고 할 때,
                        부서번호 50번 부서의 직원들의 한달 급여액을 계산하시오.
                        (단 Alias는 사원번호, 사원명, 연봉(SALARY), 월급여액이고 월급여액은 소수점 2번째 자리에서 반올림한다.)
                        
                    solution.
                        SELECT EMPLOYEE_ID AS 사원번호,
                               EMP_NAME AS 사원명,
                               SALARY AS 연봉,
                               ROUND(SALARY/13, 1) AS 월급여액
                               /*
                               TO_CHAR(ROUND(SALARY/13, 1), '9,999.0') AS 월급여액
                               9,999.0 -> 9 : 네자리 수로 맞추면서 무효의 0은 공백, 유효의 0은 출력한다
                                       -> 0 : 무효의 0, 유효의 0 모두 출력함
                               0200 ->2앞에 있는것은 무효의 0, 2뒤에있는 00은 자릿수를 담당하기 때문에 유효의 0
                               */
                          FROM EMPLOYEES
                         WHERE DEPARTMENT_ID = 50
                TRUNC : 주어진 데이터 n에서
                        i가 양수인 경우 i+1번째 자리에서 절삭한다.
                        i가 음수인 경우 정수부분 i번째에서 절삭한다.
                        
                사용형식 : TRUNC(n, i)
                    ex. SELECT TRUNC(123456, -2), 
                               TRUNC(123456, -1),
                               TRUNC(123.456, 1),
                               TRUNC(1234.56789, 2)
                          FROM DUAL;
                          
                          
        1-4. POWER와 SQRT
                POWER : 첫 번째 매개변수를 두 번째 매개변수로 거듭제곱한 결과를 반환한다.
                사용형식 : POWER(n1, n2)
                    ex. SELECT POWER(10, 2),
                               POWER(10, 3),
                               POWER(10, -1),
                               POWER(10, -3)
                          FROM DUAL;
                          
                SQRT : 매개변수의 평방근(제곱근) 값을 반환한다.
                    ex. SELECT SQRT(4),
                               ROUND(SQRT(23), 2),
                               ROUND(SQRT(8), 2)
                          FROM DUAL;
                          
        1-5. MOD와 REMAINDER
                MOD, REMAINDER : 나머지 값을 반환
                사용형식 : MOD(n2, n1), REMAINDER(n2, n1)
                첫 번째 매개변수를 두 번째 매개변수로 나눈 나머지 값을 반환한다.
                MOD와 REMAINDER는 내부 처리방식이 다르다. 
                
                <MOD, REMAINDER가 같은 동작을 하는 경우>
                MOD : n2 - n1 * FLOOR(n2/n1)
                    ex. MOD(13, 4) : 13 - 4 * FLOOR(13/4)
                                     13 - 4 * FLOOR(3.25)
                                     13 - 4 * 3
                                     13 - 12  => 1                            
                REMAINDER : n2 - n1 * ROUND(n2/n1)
                    ex. REMAINDER(13, 4) : 13 - 4 * ROUND(13/4)
                                           13 - 4 * ROUND(3.25)
                                           13 - 4 * 3
                                           13 - 12 => 1
                
                
                <MOD, REMAINDER가 다른 동작을 하는 경우>
                MOD : n2 - n1 * FLOOR(n2/n1)
                    ex. MOD(15, 4) : 15 - 4 * FLOOR(15/4)
                                     15 - 4 * FLOOR(3.75)
                                     15 - 4 * 3
                                     15 - 12  => 3                            
                REMAINDER : n2 - n1 * ROUND(n2/n1)
                    ex. REMAINDER(15, 4) : 15 - 4 * ROUND(15/4)
                                           15 - 4 * ROUND(3.75)
                                           15 - 4 * 4
                                           15 - 16 => -1
                          
                ex. SELECT MOD(13, 4),
                           REMAINDER(13, 4),
                           MOD(15, 4),
                           REMAINDER(15, 4),
                           MOD(17, 7),
                           REMAINDER(17, 7),
                           REMAINDER(18, 7)
                      FROM DUAL;
             
                    
                          
                          
                          