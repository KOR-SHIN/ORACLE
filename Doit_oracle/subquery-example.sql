/*
사원이름이 JONES인 사원보다 연봉이 높은 사원정보를 조회하시오.
*/
SELECT *
  FROM EMP
 WHERE SAL > ( SELECT SAL
                 FROM EMP
                WHERE ENAME = 'JONES');
                
/*
SCOTT보다 빨리 회사에 입사한 사원정보를 조회하시오.
*/
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE
                     FROM EMP
                    WHERE ENAME = 'SCOTT');
                    
/*
20번 부서에 속한 사원 중 전체 사원의 평균 급여보다
높은 급여를 받는 사원 정보와 소속 부서 정보를 함께 조회하시오.
*/
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
       D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND D.DEPTNO = 20
   AND SAL > (SELECT AVG(SAL)
                FROM EMP);
                
/*
전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원정보, 부서정보를 출력하시오.
*/
SELECT E.JOB, E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.JOB = (SELECT JOB
                  FROM EMP
                 WHERE ENAME = 'ALLEN'); 

/*
전체 사원의 평균급여(SAL)보다 높은 급여를 받는 사원들의 
사원정보, 부서정보, 급여 등급정보를 출력하시오.
(단, 출력할 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순 정렬하시오.)
*/
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
  FROM EMP E, DEPT D, SALGRADE S
 WHERE E.DEPTNO = D.DEPTNO
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND E.SAL > (SELECT AVG(SAL) 
                  FROM EMP);
                  
/*
10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원 정보,
부서 정보를 다음과 같이 출력하시오.
*/
-- 출력결과 다르게 나옴 (수정해야함) --
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND D.DEPTNO = 10
   AND EXISTS(SELECT JOB
                FROM EMP
               WHERE DEPTNO <> 30);
               
/*
직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여등급정보를
다음과 같이 출력하시오.
(단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해
사원번호를 기준으로 오름차순 정렬하시오.)
*/

/* 다중행 함수 사용 O */
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > ANY (SELECT MAX(SAL)
                    FROM EMP
                   WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

/* 다중행 함수 사용 X */
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL >  (SELECT MAX(SAL)
                 FROM EMP
                WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;