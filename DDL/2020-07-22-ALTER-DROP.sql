<2020-07-22-02>
    ���̺� ����
        ALTER ������� ����
        �÷� �߰�, ����, ����
        ���̺�� ����
        ��������(�⺻Ű, �ܷ�Ű) �߰�, ����, ����
        
    1. ���̺�� ����
        ������� : ALTER TABLE <��� ���̺��> RENAME TO <���ο� ���̺��>
        ROLLBACK ����� �ƴ�
    
    quiz) EMP TABLE�̸��� EMPLOYEE�� �����ϼ���.
    solv) ALTER TABLE EMP RENAME TO EMPLOYEE;
    
    2. �÷��߰�
        ������� : ALTER TABLE ���̺��
                    ADD <�÷���> <������Ÿ��>[(ũ��)] [NOT NULL | NULL] [DEFAULT ��] --�ɼǼ����� �ٲ� �ȴ�.
                    
    quiz) ��������̺�(SITE)�� �ð����� �÷��� �߰��ϼ���.
    solv) ALTER TABLE SITE 
            ADD S_START_DATE DATE DEFAULT SYSDATE --�������� �÷��� �߰��� �� �ְ�, ADD�� �����ϰ� ','�� �����Ͽ� �ۼ��ϸ� �ȴ�.
            
    3. �÷�����
        ������ : �÷��� ������Ÿ��, ũ��, �⺻���� �����ϱ� ���� ����Ѵ�.
        -- ������Ÿ���� �����ϱ� ���ؼ��� �ش� �÷��� �����Ͱ� �����ϸ� �ȵȴ�
        -- �����Ͱ� �����ϴ� �÷��� ������ Ÿ���� �ٲٱ� ���ؼ��� ���� �ڷḦ �����ϰ� �����ؾ��Ѵ�.
        ������� : ALTER TABLE <���̺��> 
                    MODIFY <�÷���> <������Ÿ��>[(ũ��)] [NOT NULL | NULL] [DEFAULT ��] --�������� ��� ADD�� ������ ������� ��밡���ϴ�.
                    
    quiz) ��������� ���̺�(SITE_ITEM)���� �����̸�(SI_ITEM_NAME)�� ������ Ÿ���� CHAR(70)���� �����ϼ���.
    solv) ALTER TABLE SITE_ITEM
            MODIFY SI_ITEM_NAME CHAR(70)

    4. �÷��� ����
        ������ : �÷��� �̸��� �����ϱ� ���� ����Ѵ�.
        ������� : ALTER TABLE <���̺��>
                    RENAME COLUMN <��� �÷���> TO <���ο� �÷���>
        
    quiz) ������̺�(EMPLOYEE)���� ����� �ּ�(E_ADDRESS)�÷����� E_ADDR�� �����ϼ���.
    solv) ALTER TABLE EMPLOYEE
            RENAME COLUMN E_ADDRESS TO E_ADDR
            
    5. �÷� ����
        ������ : �ʿ���ٰ� �ǴܵǴ� �÷��� �����ϱ� ���� ����Ѵ�.
        ������� : ALTER TABLE <���̺��>
                    DROP COLUMN <�÷���>
                    
    quiz) ��������̺�(SITE)���� �ð������÷�(S_START_DATE)�� �����ϼ���.
    solv) ALTER TABLE SITE
            DROP COLUMN S_START_DATE
            
    6. �������� ����
        ������ : �⺻Ű �� �ܷ�Ű ���� �߰�, ����, ���� �ϱ����� ����Ѵ�.
        �߰� ������� : ALTER TABLE <���̺��>
                        ADD CONSTRAINT <�⺻Ű������> PRIMARY KEY(�÷���[, �÷���...]),
                        [CONSTRAINT <�ܷ�Ű������> FOREIGN KEY(�÷���[, �÷���...])
                             REFERENCES �ܺ����̺��(�÷���)];
                        
        ���� ������� : ALTER TABLE <���̺��>
                        MODIFY CONSTRAINT <�⺻Ű������> PRIMARY KEY(�÷���[, �÷���...]),
                        [CONSTRAINT <�ܷ�Ű������> FOREIGN KEY(�÷���[, �÷���...])
                                REFERENCES �ܺ����̺��(�÷���)];
        
        ���� ������� : DROP CONSTRAINT <�⺻Ű������>|<�ܷ�Ű������>;
                        