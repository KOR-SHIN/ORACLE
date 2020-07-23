<2020-07-22-01>
    ���̺� ����
        �ܷ�Ű�� ���� ���̺���� �ۼ��Ѵ�.
        �ܷ�Ű�� ���� ���̺��� �ٽ� ����Ƽ, �ڸ� ����Ƽ, ��Ʈ�� ����Ƽ��� �θ���
        
    quiz) ����� ���̺��� �����Ͻÿ�.
        ���̺�� : SITE
        �Ӽ���           ������Ÿ��(ũ��)    NULL���    Ű
        ------------------------------------------------
        S_SITE_NO        CHAR(4)            N.N     P.K
        S_SITE_NAME      VARCHAR2(30)       N.N      
        S_SITE_ADDRESS   VARCHAR2(50)       N.N        
        S_SITE_TEL       VARCHAR2(15)
        S_SITE_AMT       NUMBER(8)          N.N
        S_INPUT_PER      NUMBER(4)
        S_SITE_REMARK    VARCHAR2(100)
    
    solv) 
        CREATE TABLE SITE (
        S_SITE_NO        CHAR(4),            
        S_SITE_NAME      VARCHAR2(30)       NOT NULL,      
        S_SITE_ADDRESS   VARCHAR2(50)       NOT NULL,        
        S_SITE_TEL       VARCHAR2(15),
        S_SITE_AMT       NUMBER(8)          NOT NULL,
        S_INPUT_PER      NUMBER(4),
        S_SITE_REMARK    VARCHAR2(100),
        
        CONSTRAINT pk_site PRIMARY KEY(S_SITE_NO));
        --S_SITE_NO�� �⺻Ű�̱� ������ NOT NULL�� �Ƚᵵ �������. (�⺻Ű�� ������ NOT NULL�̱⶧���̴�)
        
    quiz) ����� ���̺��� �����Ͻÿ�.
        ���̺�� : SITE_ITEM
        �Ӽ���           ������Ÿ��(ũ��)    NULL���    Ű
        ------------------------------------------------
        SI_ITEM_NO        CHAR(4)          N.N      P.K
        SI_ITEM_NAME      VARCHAR2(30)     N.N
        SI_AMOUNT         NUMBER(3)        N.N
        SI_PRICE          NUMBER(12)       N.N
        SI_BUY_DATE       DATE             N.N
        S_SITE_NO         CHAR(4)          N.N      F.K
        -- DATE�� ũ�⸦ ������������
   solv)     
        CREATE TABLE SITE_ITEM(
        SI_ITEM_NO        CHAR(4)          NOT NULL,
        SI_ITEM_NAME      VARCHAR2(30)     NOT NULL,
        SI_AMOUNT         NUMBER(3)        NOT NULL,
        SI_PRICE          NUMBER(12)       NOT NULL,
        SI_BUY_DATE       DATE             NOT NULL,
        S_SITE_NO         CHAR(4)          NOT NULL,
        
        CONSTRAINT pk_site_item PRIMARY KEY(SI_ITEM_NO),
        CONSTRAINT fk_site_item_site FOREIGN KEY(S_SITE_NO)
            REFERENCES SITE(S_SITE_NO));
            -- �ܷ�Ű�̸� fk_�������̺�_�ش����̺�
            
    quiz) ����� ���̺��� �����Ͻÿ�.
        ���̺�� : WORK
        �Ӽ���           ������Ÿ��(ũ��)    NULL���    Ű
        ------------------------------------------------
        E_EMP_NO           CHAR(4)         N.N      P.K/F.K
        S_SITE_NO          CHAR(4)         N.N      P.K/F.K
        ES_INSERT_DATE     DATE            N.N      
    
    solv)  
        CREATE TABLE WORK (    
        E_EMP_NO           CHAR(4)         NOT NULL,
        S_SITE_NO          CHAR(4)         NOT NULL,
        ES_INSERT_DATE     DATE            NOT NULL,
        
        CONSTRAINT pk_work PRIMARY KEY(E_EMP_NO, S_SITE_NO),
        CONSTRAINT fk_emp_work FOREIGN KEY(E_EMP_NO)
            REFERENCES EMP(E_EMP_NO),
        CONSTRAINT fk_site_work FOREIGN KEY(S_SITE_NO)
            REFERENCES SITE(S_SITE_NO));
            
    ���̺� ����
        DROP ��� ���
        ������� : DROP <���ü> <��ü�̸�> 
    
    quiz) EMP ���̺��� �����ϼ���.
        DROP TABLE WORK;
        DROP TABLE EMP; 
        -- EMP TABLE�� �����ϴ� WORK�� ���� �����ؾ� ������ �����ϴ�
        -- CONSTRAINT�� �����Ͽ� EMP�� WORK�� ���踦 �����ϰ� EMP�� �����Ѵ�.
        -- EMP TABLE(������ ���ϴ� TABLE)�� WORK TABLE(������ �ϴ� TABLE)�� �����Ǳ� ���� ������ �� ����.
        
                 
    