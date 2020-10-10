/*
�޿�(SAL)�� 2000 �ʰ��� ������� �μ� ����, ��������� ����Ͻÿ�.
(�� SQL-99 ���� ��İ� SQL-99����� ���� ����Ͽ���)
*/
/* SQL-99 ���� ��� */
SELECT D.DEPTNO, DNAME, EMPNO, ENAME, SAL
  FROM DEPT D, EMP E
 WHERE D.DEPTNO = E.DEPTNO
   AND SAL > 2000
ORDER BY DEPTNO;

/* SQL-99 ��� */
SELECT DEPTNO, DNAME, EMPNO, ENAME, SAL
  FROM DEPT D NATURAL JOIN EMP E
 WHERE SAL > 2000
ORDER BY DEPTNO;

/*
�����ʰ� ���� �� �μ��� ��� �޿�, �ִ�޿�, �ּұ޿�, ������� ����Ͻÿ�.
(�� SQL-99 ���� ��İ� SQL-99����� ���� ����Ͽ���)
*/

/* SQL-99 ���� ��� */
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

/* SQL-99 ���� ��� */
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
��� �μ� ������ ��� ������ �����ʰ� ���� �μ� ��ȣ
��� �̸������� �����Ͽ� ����Ͻÿ�.
(�� SQL-99 ���� ��İ� SQL-99����� ���� ����Ͽ���)
*/

/* SQL-99 ���� ��� */
SELECT D.DEPTNO,
       D.DNAME,
       NVL(TO_CHAR(E.EMPNO), ' ') AS EMPNO,
       NVL(E.ENAME, ' ') AS ENAME,
       NVL(E.JOB, ' ') AS JOB,
       NVL(TO_CHAR(E.SAL), ' ') AS SAL
  FROM DEPT D, EMP E
 WHERE D.DEPTNO = E.DEPTNO(+);
 
 /* SQL-99 ���� ��� */
SELECT D.DEPTNO,
       D.DNAME,
       NVL(TO_CHAR(E.EMPNO), ' ') AS EMPNO,
       NVL(E.ENAME, ' ') AS ENAME,
       NVL(E.JOB, ' ') AS JOB,
       NVL(TO_CHAR(E.SAL), ' ') AS SAL
  FROM DEPT D LEFT OUTER JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
ORDER BY D.DEPTNO, E.ENAME;

/*
������ ���� ��� �μ� ����, ��� ����, �޵� ��� ����, �� ����� ���� �����
������ �μ� ��ȣ, ��� ��ȣ ������ �����Ͽ� ����Ͻÿ�.
(�� SQL-99 ���� ��İ� SQL-99����� ���� ����Ͽ���)
*/

/* SQL-99 ���� ��� */
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
