 <2020-07-29-03>
 
    2. WHERE 절
        조건을 기술하는 절 (FILTERING을 위해 사용한다)
        일반조건이나 조인조건을 기술하는 절
        관계연산자 사용 ( >, <, =, >=, <=, !=(<>) )
        논리연산자 사용 ( NOT, AND, OR )
        그 외 연산자 (IN, SOME, ANY, ALL, EXISTS)
        집계함수 자체에 조건이 부여되면 WHERE 절(일반조건)이 아닌 HAVING 절(집계함수 조건)을 사용한다.
        /* 집계함수 : SUM(), MAX(), MIN(), AVG(), COUNT() */