<2020-07-24-01>
 
    1. NUMBER 
        ������� : <�÷���> NUMBER [([���е� | * [,������]])]
            ������ �Ǽ� �ڷḦ ����
            ���� ���� : 1.0 X e130 ~ 9.99999 X e125 (9�� ������ 38��)
            (���е� > ������)�� ���
                ���е��� ��ü �ڸ���, �������� �Ҽ��� ������ �ڸ��� (���ܴ� ���� ����)
                    ex. NUMBER(5, 2) ��ü�ڸ��� 5�ڸ�, �Ҽ������� �ڸ��� 2�ڸ�, (���� �ڸ��� 5-3 = 2�ڸ�)
            ���е��� 1~38�� ������ ������.
            �������� (-84) ~ 127 ������ ���� ǥ���Ѵ�.
            '*'�� ��ü ��� ���������� ����ڰ� �Է��� �ڷῡ ���߾� �������� Ȯ��
                ex) <�÷���> NUMBER; --����, �Ǽ� ��� ����
                    <�÷���> NUMBER(���е�, ������); --�Ǽ� ����
                    <�÷���> NUMBER(���е�); -- ������ ���� (�Ҽ������� ����)
                    <�÷���> NUBMER(*,������); -- �Ǽ� ���� (�����ϱ��� �Ҽ����� ǥ���ϰ� ���ڸ��� �ݿø��ȴ�.)
                ex)
                        �Է°�           ����          ���Ǵ� ��
                    1,234,567.897      NUMBER       1,234,567.897
                    1,234,567.897      NUMBER(*,1)  1,234,567,9
                    1,234,567.897      NUMBER()     1,234,568 -- NUMBER() == NUMBER(*,0)
                    1,234,567.897      NUMBER(9,2)  1,234,567.90
                    1,234,567.897      NUMBER(6)    ERROR -- ������ 6�ڸ����� ��Ÿ���µ� �Է��� ���� �ڸ����� 7�ڸ�
                                                          -- NUMBER(6) == NUMBER(6, 0)
                    1,234,567.897      NUMBER(7,-2) 1,234,600        
                    /*
                        �Ҽ��� ���� �ε����� 1���� ���������� ������ �ε�����ȣ�� �ڿ������� -1�̴�.
                        ���� NUMBER(7, -2)�� ���� 7�ڸ��� ��Ÿ����, ������ �ڿ��� 2��° �ڸ����� �ݿø� �϶�� �ǹ��̴�.
                        �����κп��� �ݿø��� �߻��ϱ� ������ �Ҽ��� ���ϴ� �������.
                        �������� ���� ���� : �Ҽ��� ���° �ڸ����� ��Ÿ�� ������ �Է�
                        �������� ���� ���� : �����κп��� �ݿø��� �߻��ϱ� ������ �Ҽ��� ���ϴ� �������.
                    */            
                    
        (���е� < ������)�� ��� --���Ǵ� ��찡 ���� ��ɴ�.
            ���е��� 0�� �ƴ� ��ȿ������ ����(�Ҽ��� ����)
            (������ - ���е�) : �Ҽ������Ͽ� �� �տ� �����ؾ��ϴ� 0�� ����
                ex)
                        �Է°�           ����          ���Ǵ� ��
                        1.234          NUMBER(4,5)     ERROR 
                        1.23           NUMBER(3,5)     ERROR
                        0.0123         NUMBER(3,4)     0.0123
                        0.01234        NUMBER(4,5)     0.01234
                        0.001234       NUMBER(3,5)     0.00123 
        
        
        
        
        
        
        