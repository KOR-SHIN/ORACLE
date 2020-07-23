<2020-07-21>

    ����� ����
        ����� ���� ���� -> ���Ѻο� -> ���Ӹ޴� �߰�

    ����� ��������
        ����� ������� ��ȣ(java) ����
    
    �������� �������
        CREATE USER <����� �̸�> IDENTIFIED BY <�н�����>;      
        
    ���Ѽ��� �������
        GRANT <���Ѹ�,���Ѹ�, ...> TO <����� �̸�>;
        
    1) ����
        - 1973 : SQUARE (Structured Queries As Relational Express)
        - 1974 : System R���� SEQUEL (Structured English Query Language)
        - 1980 : SQL (Structured Query Language)�� ��Ī ����
        - 1988 : ANSL ISO ����ǥ������ ���� 
        - 1989 : SQL-1 (SQL/89) ǥ�ؾ� ���� (������� ����ϴ� ����)
        - 1992 : SQL-2 ǥ�ؾ� ���� 
        - 1999 : SQL-3 ǥ�ؾ� ����

    2) SQL ����� �з�
        - DDL(DATA DEFINITION LANGUAGE)
            CREATE(����), DROP(����), ALTER(�������� OR ���̺� ����)
            DATA ���Ǿ�
        
        - DCL(DATA CONTROL LANGUAGE)
            GRANT, REVOKE, COMMIT, ROLLBACK
            DATA �����
            
        - DML(DATA MANIPULATION LANGUAGE)
            INSERT, UPDATE, DELETE
            DATA ���۾�
            
        - QUERY LANGUAGE
            SELECT
            ���Ǿ�
    
    3) SQL ����� Ư¡
        ����������̱� ������ ����/���, �񱳹�, �ݺ���, �б⹮�� ����.
    
    <ǥ����Ģ>
        �ѱ۷� �Ǿ��ִ� �κ��� ����� ���Ǿ�
        [ ] : ���û��� (��������)
        | : �� ���� �� ���� �����Ͽ� ����Ѵ�.
            ex) ident1 | ident2 : ident1 or ident2�� ����ؾ��Ѵ�. (���� �Ұ�, ���û�� �Ұ�)
        .... : ���� ��� ������ �ݺ� ���� �� �� ������ �ǹ��Ѵ�.
                    
    4) DDL
        ���̺� ���� ������� 
            CREATE TABLE <���̺��>(
                <�÷���> <������ Ÿ��>[(ũ��)] [NOT NULL | NULL] [DEFAULT ��],
                <�÷���> <������ Ÿ��>[(ũ��)] [NOT NULL | NULL] [DEFAULT ��],
                ....
                <�÷���> <������ Ÿ��>[(ũ��)] [NOT NULL | NULL] [DEFAULT ��],
                [CONSTRAINT <�⺻Ű������> PRIMARY KEY (�÷���[,�÷���...])],
                [CONSTRAINT <�ܷ�Ű������> FOREIGN KEY (�÷���[,�÷���...])
                    REFERENCES �ܺ����̺��(�÷���))]
            ---------------------------------------------------------------------------------------------
           | CREATE TABLE <���̺��> : ���̺���� �����̸����� �ۼ��ؾ� �Ѵ�.                                    
           | [NOT NULL | NULL] : �����ϸ� null�� �����ȴ�.
           | [DEFAULT ��] : �����ϸ� ������ Ÿ�Կ� ������� null�� �����ȴ�.
           | ',' : �չ���� �޹����� �����ϴ� ��
           | [CONSTRAINT <�⺻Ű������> PRIMARY KEY (�÷���[,�÷���...])] : �ܷ�Ű�� ������� ������� �ۼ������ϴ�.
           | (�÷���[,�÷���...]) : Ű ������ �÷��� �������� ����Ѵ�.
           | REFERENCES �ܺ����̺��(�÷���) : �ܷ�Ű�� ������ ���̺� �̸��� ����Ѵ�.. (�ܷ�Ű�� �������� ��� �����.)
           | <�ܷ�Ű������>, <�⺻Ű������> : ���������� �ۼ��Ǿ�� �Ѵ�. (�ٸ� ���̺� �������� ��������� ������ �ȴ�.)
             ---------------------------------------------------------------------------------------------
             
    quiz) ���� ���ǿ� �´� ���̺��� �����Ͻÿ�. 
        ���̺�� : EMP
        �÷���     ������Ÿ��(ũ��) NULLABLE   PK
        ---------------------------------
        E_EMP_NO   CHAR(4)         N.N     PK
        E_NAME     VARCHAR2(10)    N.N      
        E_ADDRESS  VARCHAR2(50)    N.N
        E_TEL_NO   VARCHAR2(15)       
        E_POSITION VARCHAR2(20)    N.N
        E_DEPT     VARCHAR2(20)    N.N
        ---------------------------------
        
    solv)
        CREATE TABLE EMP (
        E_EMP_NO CHAR(4) NOT NULL,
        E_NAME VARCHAR2(10) NOT NULL,      
        E_ADDRESS VARCHAR2(50) NOT NULL,
        E_TEL_NO VARCHAR2(15),       
        E_POSITION VARCHAR2(20) NOT NULL,
        E_DEPT VARCHAR2(20) NOT NULL,
        
        CONSTRAINT pk_emp PRIMARY KEY (E_EMP_NO));
        

CREATE USER SKJ IDENTIFIED BY java;  -- ����� ���� ����
GRANT CONNECT, RESOURCE, DBA TO SKJ; -- ���Ѻο�  
/*  
    CONNECT : �������  
    RESOURCE : �ڿ�������  
    DBA :������ �ο�
*/
