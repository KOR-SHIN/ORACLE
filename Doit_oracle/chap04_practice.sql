/*
EMP테이블에서 사원 이름이 S자로 끝나는 사원 데이터를 모두 출력하시오.
*/
SELECT *
  FROM EMP
 WHERE ENAME LIKE '%S';
 
/*
EMP 테이블을 사용하여 부서번호 30번부서에서 근무하고 있는 사원 중에 직책이
SALESMAN인 사원의 사원번호, 이름, 직책, 급여, 부서번호를 출력하시오.
*/
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 30
   AND JOB = 'SALESMAN';
   
/*
EMP 테이블을 사용하여 20번, 30번 부서에 근무하고 있는 사원 중
급여가 2000초과인 사원을 다음 두 가지 방식의 SELECT문을 사용하여
사원번호, 이름, 급여, 부서번호를 출력하시오.
1. 집합 연산자를 사용하지 않은 방식
2. 집합 연산자를 사용하는 방식
*/
--1
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO IN (20, 30)
   AND SAL > 2000;
   
--2
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO IN (20, 30)
 INTERSECT
 SELECT EMPNO, ENAME, SAL, DEPTNO
   FROM EMP
  WHERE SAL > 2000;

/*
NOT BETWEEN A AND B 연산자를 사용하지 않고, 급여 열 값이 2000이상 3000이하
범위 이외의 값을 가진 데이터만을 출력하시오.
*/
SELECT *
  FROM EMP
 WHERE NOT (SAL >= 2000 AND SAL <= 3000);

/*
사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가
아닌 사원이름, 사원번호, 급여부서 번호를 출력하시오.
*/
SELECT ENAME, EMPNO, SAL, DEPTNO
  FROM EMP
 WHERE ENAME LIKE '%E%'
   AND SAL NOT BETWEEN 1000 AND 2000
   AND DEPTNO = 30;

/*
추가 수당이 존재하지 않고 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서
사원 이름의 두 번째 글자가 `L`이 아닌 사원의 정보를 출력하시오.
*/
SELECT *
  FROM EMP 
 WHERE COMM IS NULL
   AND MGR IS NOT NULL
   AND JOB IN ('MANAGER', 'CLERK')
   AND ENAME NOT LIKE '_L%';




