/*
급여(SAL)가 2000 초과인 사원들의 부서 정보, 사원정보를 출력하시오.
(단 SQL-99 이전 방식과 SQL-99방식을 각각 사용하여라)
*/
/* SQL-99 이전 방식 */
SELECT D.DEPTNO, DNAME, EMPNO, ENAME, SAL
  FROM DEPT D, EMP E
 WHERE D.DEPTNO = E.DEPTNO
   AND SAL > 2000
ORDER BY DEPTNO;

/* SQL-99 방식 */
SELECT DEPTNO, DNAME, EMPNO, ENAME, SAL
  FROM DEPT D NATURAL JOIN EMP E
 WHERE SAL > 2000
ORDER BY DEPTNO;

/*
오른쪽과 같이 각 부서별 평균 급여, 최대급여, 최소급여, 사원수를 출력하시오.
(단 SQL-99 이전 방식과 SQL-99방식을 각각 사용하여라)
*/

/* SQL-99 이전 방식 */
SELECT D.DEPTNO, 
       D.DNAME,
       ROUND(AVG(E.SAL)) AS AVG_SAL,
       MAX(E.SAL) AS MAX_SAL,
       MIN(E.SAL) AS MIN_SAL,
       COUNT(D.DEPTNO) AS CNT
  FROM DEPT D, EMP E
 WHERE D.DEPTNO = E.DEPTNO
   AND D.DEPTNO <> 40
GROUP BY D.DEPTNO, DNAME
ORDER BY DEPTNO;

/* SQL-99 이후 방식 */
SELECT DEPTNO, 
       DNAME,
       ROUND(AVG(E.SAL)) AS AVG_SAL,
       MAX(E.SAL) AS MAX_SAL,
       MIN(E.SAL) AS MIN_SAL,
       COUNT(DEPTNO) AS CNT
  FROM DEPT D JOIN EMP E USING (DEPTNO)
 WHERE DEPTNO <> 40
GROUP BY DEPTNO, DNAME
ORDER BY DEPTNO;

/*
모든 부서 정보와 사원 정보를 오른쪽과 같이 부서 번호
사원 이름순으로 정렬하여 출력하시오.
(단 SQL-99 이전 방식과 SQL-99방식을 각각 사용하여라)
*/

/* SQL-99 이전 방식 */
SELECT D.DEPTNO,
       D.DNAME,
       NVL(TO_CHAR(E.EMPNO), ' ') AS EMPNO,
       NVL(E.ENAME, ' ') AS ENAME,
       NVL(E.JOB, ' ') AS JOB,
       NVL(TO_CHAR(E.SAL), ' ') AS SAL
  FROM DEPT D, EMP E
 WHERE D.DEPTNO = E.DEPTNO(+);
 
 /* SQL-99 이후 방식 */
SELECT D.DEPTNO,
       D.DNAME,
       NVL(TO_CHAR(E.EMPNO), ' ') AS EMPNO,
       NVL(E.ENAME, ' ') AS ENAME,
       NVL(E.JOB, ' ') AS JOB,
       NVL(TO_CHAR(E.SAL), ' ') AS SAL
  FROM DEPT D LEFT OUTER JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
ORDER BY D.DEPTNO, E.ENAME;

/*
다음과 같이 모든 부서 정보, 사원 정보, 급뎌 등급 정보, 각 사원의 직속 상관의
정보를 부서 번호, 사원 번호 순서로 정렬하여 출력하시오.
(단 SQL-99 이전 방식과 SQL-99방식을 각각 사용하여라)
*/

/* SQL-99 이전 방식 */
SELECT D.DEPTNO,
       D.DNAME,
       E.EMPNO,
       E.ENAME,
       NVL(TO_CHAR(E.MGR), ' ') AS MGR,
       E.SAL,
       NVL(TO_CHAR(E.DEPTNO), ' ') AS DEPTNO_1,
       S.LOSAL,
       S.HISAL,
       S.GRADE,
       NVL(TO_CHAR(E1.EMPNO), ' ') AS MGR_EMPNO,
       NVL(E1.ENAME, ' ') AS MGR_NAME
  FROM EMP E, EMP E1, DEPT D, SALGRADE S
 WHERE E.MGR = E1.EMPNO(+)
   AND D.DEPTNO = E.DEPTNO
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY D.DEPTNO, E.EMPNO;
