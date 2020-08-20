<2020-08-20>

    1. ROLLUP�� CUBE
          
          1-1. ROLLUP
            �⺻�����Լ����� �������� �ʴ� �κк� �Ұ踦 �����Ѵ�.
            GROUP BY ������ ����Ѵ�.
            ������� : ROLLUP(c1, c2 ... )
            ��õ� �÷�(c1, c2 ... )�� ���� ����(������ -> ����)�� ���� ������ �������� ��ȯ�Ѵ�.
            ���� �÷��� ���� n���̸� n+1�������� ������������ �������� ������ ���踦 ��ȯ�Ѵ�.
            
                ex. KOR_LOAN_STATUS TABLE���� �Ⱓ�� ������ �����ܾ��հ踦 ��ȸ�Ͻÿ�.
                solution.
                    SELECT PERIOD,
                           REGION,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY ROLLUP(PERIOD, REGION)
                  ORDER BY 2;
            
            
                ex. ��ǰ���̺��� �з���, �ŷ�ó��, ���԰��� �հ�� ��ǰ�� ���� ��ȸ�Ͻÿ�.
                solution.
                    SELECT PROD_LGU AS �з�,
                           PROD_BUYER AS �ŷ�ó,
                           SUM(PROD_COST) AS ���԰���,
                           COUNT(*) AS ��ǰ����
                      FROM PROD
                  GROUP BY PROD_LGU, PROD_BUYER
                  ORDER BY 1

                /*
                P101	P10101	930000	3
                P101	P10102	6450000	3
                P102	P10201	2130000	3
                P102	P10202	4230000	4
                P201	P20101	561000	12
                P201	P20102	1158000	9
                P202	P20201	547500	12
                P202	P20202	1192000	9
                P301	P30101	87000	4
                P302	P30201	266000	6
                P302	P30202	332000	6
                P302	P30203	123500	3
                */
                
                solution2.
                    SELECT PROD_LGU AS �з�,
                           PROD_BUYER AS �ŷ�ó,
                           SUM(PROD_COST) AS ���԰���,
                           COUNT(*) AS ��ǰ����
                      FROM PROD
                  GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
                  ORDER BY 1
                  
                /*
                P101	P10101	930000	3 <- PROD_LGU ���� ����
                P101	P10102	6450000	3 <- PROD_BUYER ���� ����
                P101	NULL    7380000	6 <- ��ü����
                P102	P10201	2130000	3
                P102	P10202	4230000	4
                P102	NULL    6360000	7
                P201	P20101	561000	12
                P201	P20102	1158000	9
                P201	NULL    1719000	21
                P202	P20201	547500	12
                P202	P20202	1192000	9
                P202	NULL    1739500	21
                P301	P30101	87000	4
                P301	NULL    87000	4
                P302	P30201	266000	6
                P302	P30202	332000	6
                P302	P30203	123500	3
                P302	NULL    721500	15 <- ��ü �հ�
                NULL    NULL    18007000 74 <- ��ü �հ�
                */
                
                

          1-2. CUBE
            ROLLUP�� ����� ����
            CUBE�� ����� ��� �÷��� ������ �� �ִ� ��� ��������ŭ�� �հ踦 ��ȯ�Ѵ�.
            n���� �÷��� ���Ǹ� 2�� n�� ������ŭ�� �հ踦 ��ȯ�Ѵ�.
            
                ex. �����ܾ� ���̺��� �Ⱓ��, ������, ���к� �����ܾ��� �հ踦 ��ȸ�Ͻÿ�.
                solution 1. �⺻�����Լ��� ����ϴ� ���
                    SELECT PERIOD AS �Ⱓ,
                           REGION AS ����,
                           GUBUN AS ����,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY PERIOD, REGION, GUBUN
                  
                solution 2. ROLLUP�� ������ ���
                    SELECT PERIOD AS �Ⱓ,
                           REGION AS ����,
                           GUBUN AS ����,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY ROLLUP(PERIOD, REGION, GUBUN)
                  
                solution 3. CUBE�� ������ ���
                    SELECT PERIOD AS �Ⱓ,
                           REGION AS ����,
                           GUBUN AS ����,
                           SUM(LOAN_JAN_AMT)
                      FROM KOR_LOAN_STATUS
                  GROUP BY CUBE(PERIOD, REGION, GUBUN)