/*
����̸��� JONES�� ������� ������ ���� ��������� ��ȸ�Ͻÿ�.
*/
SELECT *
  FROM EMP
 WHERE SAL > ( SELECT SAL
                 FROM EMP
                WHERE ENAME = 'JONES');
                
/*
SCOTT���� ���� ȸ�翡 �Ի��� ��������� ��ȸ�Ͻÿ�.
*/
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE
                     FROM EMP
                    WHERE ENAME = 'SCOTT');
                    
/*
20�� �μ��� ���� ��� �� ��ü ����� ��� �޿�����
���� �޿��� �޴� ��� ������ �Ҽ� �μ� ������ �Բ� ��ȸ�Ͻÿ�.
*/
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
       D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND D.DEPTNO = 20
   AND SAL > (SELECT AVG(SAL)
                FROM EMP);
                
/*
��ü ��� �� ALLEN�� ���� ��å(JOB)�� ������� �������, �μ������� ����Ͻÿ�.
*/
SELECT E.JOB, E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.JOB = (SELECT JOB
                  FROM EMP
                 WHERE ENAME = 'ALLEN'); 

/*
��ü ����� ��ձ޿�(SAL)���� ���� �޿��� �޴� ������� 
�������, �μ�����, �޿� ��������� ����Ͻÿ�.
(��, ����� �޿��� ���� ������ �����ϵ� �޿��� ���� ��쿡�� ��� ��ȣ�� �������� �������� �����Ͻÿ�.)
*/
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
  FROM EMP E, DEPT D, SALGRADE S
 WHERE E.DEPTNO = D.DEPTNO
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND E.SAL > (SELECT AVG(SAL) 
                  FROM EMP);
                  
/*
10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� �ʴ� ��å�� ���� ������� ��� ����,
�μ� ������ ������ ���� ����Ͻÿ�.
*/
-- ��°�� �ٸ��� ���� (�����ؾ���) --
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND D.DEPTNO = 10
   AND EXISTS(SELECT JOB
                FROM EMP
               WHERE DEPTNO <> 30);
               
/*
��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� �������, �޿����������
������ ���� ����Ͻÿ�.
(��, ���������� Ȱ���� �� ������ �Լ��� ����ϴ� ����� ������� �ʴ� ����� ����
�����ȣ�� �������� �������� �����Ͻÿ�.)
*/

/* ������ �Լ� ��� O */
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > ANY (SELECT MAX(SAL)
                    FROM EMP
                   WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

/* ������ �Լ� ��� X */
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL >  (SELECT MAX(SAL)
                 FROM EMP
                WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;