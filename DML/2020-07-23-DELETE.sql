<2020-07-23-02>
    DELETE
        저장되어 있는 테이블내의 행(들)을 삭제하기 위해 사용한다.
        사용형식 : DELETE <테이블명>
                 [WHERE 조건];
                 /*
                    [WHERE 조건]절을 생략하면 테이블에 존재하는 모든 행을 삭제한다.
                     TABLE자체를 삭제하는 것이 아니라 행을 모두 삭제하기 때문에 TABLE자체는 남게된다.
                 */
    quiz) 장바구니테이블(CART) 내의 자료를 모두 삭제하고 장바구니테이블을 조회하시오.
    solv)
        DELETE CART;    
        SELECT * FROM CART;
    
    quiz) 장바구니테이블(CART) 내의 2005년 6월 이전 자료를 모두 삭제하시오.
    solv) 
        DELETE CART
        WHERE SUBSTR(CART_NO, 1,8) < '20060601'
                -- CART_NO값을 첫 번째 ~ 8번째까지만 남기고 20060601보다 작은값은 모두 삭제해라
                -- orcle은 index가 1부터 시작한다 (java와 혼동주의)
        