-- L1. 조건에 맞는 도서 리스트 출력하기
SELECT 
    BOOK_ID,
    DATE_FORMAT(PUBLISHED_DATE, "%Y-%m-%d") AS PUBLISHED_DATE
FROM BOOK
WHERE CATEGORY = "인문"
    AND YEAR(PUBLISHED_DATE) = 2021
ORDER BY PUBLISHED_DATE ASC;


-- L1. 조건에 부합하는 중고거래 댓글 조회하기
SELECT
    B.TITLE,
    R.BOARD_ID,
    R.REPLY_ID,
    R.WRITER_ID,
    R.CONTENTS,
    DATE_FORMAT(R.CREATED_DATE, "%Y-%m-%d") AS CREATED_DATE
FROM USED_GOODS_BOARD AS B
INNER JOIN USED_GOODS_REPLY AS R
    ON B.BOARD_ID = R.BOARD_ID
WHERE B.CREATED_DATE BETWEEN "2022-10-01" AND "2022-10-30"
ORDER BY R.CREATED_DATE ASC, B.TITLE ASC;


-- L1. 흉부외과 또는 일반외과 의사 목록 출력하기
SELECT
    DR_NAME,
    DR_ID,
    MCDP_CD,
    DATE_FORMAT(HIRE_YMD, "%Y-%m-%d") AS HIRE_YMD
FROM DOCTOR
WHERE MCDP_CD IN ("CS", "GS")
ORDER BY HIRE_YMD DESC;


-- L1. 과일로 만든 아이스크림 고르기
SELECT A.FLAVOR
FROM ICECREAM_INFO A
INNER JOIN FIRST_HALF B 
    ON A.FLAVOR = B.FLAVOR
WHERE A.INGREDIENT_TYPE = "fruit_based"
    AND B.TOTAL_ORDER >= 3000
ORDER BY B.TOTAL_ORDER DESC;


-- L1. 평균 일일 대여 요금 구하기
SELECT ROUND(AVG(DAILY_FEE), 0) AS AVERAGE_FEE
FROM CAR_RENTAL_COMPANY_CAR
WHERE CAR_TYPE = "SUV";


-- L1. 인기있는 아이스크림
SELECT FLAVOR
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC;


-- L1. 강원도에 위치한 생산공장 목록 출력하기
SELECT
    FACTORY_ID,
    FACTORY_NAME,
    ADDRESS
FROM FOOD_FACTORY
WHERE SUBSTRING(ADDRESS, 1, 3) = "강원도"
ORDER BY FACTORY_ID ASC;


-- L1. 12세 이하인 여자 환자 목록 출력하기
SELECT
    PT_NAME,
    PT_NO,
    GEND_CD,
    AGE,
    CASE 
        WHEN TLNO IS NULL THEN 'NONE'
        ELSE TLNO 
    END AS TLNO
FROM PATIENT
WHERE AGE <= 12 
    AND GEND_CD = "W"
ORDER BY AGE DESC, PT_NAME ASC;


-- L1. 모든 레코드 조회하기
SELECT * 
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID;


-- L1. 역순 정렬하기
SELECT
    NAME,
    DATETIME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID DESC;


-- L1. 아픈 동물 찾기
SELECT
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION = "Sick"
ORDER BY ANIMAL_ID ASC;


-- L1. 어린 동물 찾기
SELECT
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION != "Aged"
ORDER BY ANIMAL_ID;


-- L1. 동물의 아이디와 이름
SELECT
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;


-- L1. 여러 기준으로 정렬하기
SELECT
    ANIMAL_ID,
    NAME,
    DATETIME
FROM ANIMAL_INS
ORDER BY NAME ASC, DATETIME DESC;


-- L1. 상위 n개 레코드
SELECT NAME
FROM ANIMAL_INS
ORDER BY DATETIME
LIMIT 1;


-- L1. 조건에 맞는 회원수 구하기
SELECT COUNT(*) AS USERS
FROM USER_INFO
WHERE YEAR(JOINED) = "2021" AND
    AGE >= "20" AND AGE <= "29";


-- L1. Python 개발자 찾기
SELECT
    ID,
    EMAIL,
    FIRST_NAME,
    LAST_NAME
FROM DEVELOPER_INFOS
WHERE SKILL_1 = "Python" OR
    SKILL_2 = "Python" OR
    SKILL_3 = "Python"
ORDER BY ID ASC;


-- L1. 잔챙이 잡은 수 구하기
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO
WHERE LENGTH IS NULL;


-- L1. 가장 큰 물고기 10마리 구하기
SELECT
    ID,
    LENGTH
FROM FISH_INFO
WHERE LENGTH IS NOT NULL
ORDER BY LENGTH DESC, ID ASC
LIMIT 10;


-- L1. 특정 형질을 가지는 대장균 찾기
SELECT COUNT(*) AS COUNT
FROM ECOLI_DATA
WHERE (GENOTYPE & 2) = 0 AND -- 0010
    (GENOTYPE & 5) > 0;      -- 0101


-- L2. 3월에 태어난 여성 회원 목록 출력하기
SELECT
    MEMBER_ID,
    MEMBER_NAME,
    GENDER,
    DATE_FORMAT(DATE_OF_BIRTH, "%Y-%m-%d") AS DATE_OF_BIRTH
FROM MEMBER_PROFILE
WHERE MONTH(DATE_OF_BIRTH) = 3 AND 
    TLNO IS NOT NULL AND
    GENDER = "W"
ORDER BY MEMBER_ID ASC;


-- L2. 재구매가 일어난 상품과 회원 리스트 구하기
SELECT
    USER_ID,
    PRODUCT_ID
FROM ONLINE_SALE
GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(USER_ID) >= 2
ORDER BY USER_ID ASC, PRODUCT_ID DESC;


-- L2. 업그레이드 된 아이템 구하기
SELECT
    IT.ITEM_ID,
    ITEM_NAME,
    RARITY
FROM ITEM_TREE AS IT 
LEFT JOIN ITEM_INFO AS II 
    ON IT.ITEM_ID = II.ITEM_ID
WHERE PARENT_ITEM_ID IN (
    SELECT ITEM_ID
    FROM ITEM_INFO
    WHERE RARITY = "RARE"
    )
ORDER BY IT.ITEM_ID DESC;


-- L2. 조건에 맞는 개발자 찾기
SELECT
    ID,
    EMAIL,
    FIRST_NAME,
    LAST_NAME
FROM DEVELOPERS
WHERE EXISTS (
    SELECT 1
    FROM SKILLCODES
    WHERE NAME IN ("Python", "C#") 
        AND SKILL_CODE & CODE = CODE
    )
ORDER BY ID ASC;


-- L2. 특정 물고기를 잡은 총 수 구하기
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO FI 
LEFT JOIN FISH_NAME_INFO NI 
    ON FI.FISH_TYPE = NI.FISH_TYPE
WHERE NI.FISH_NAME IN("BASS", "SNAPPER");


-- L2. 부모의 형질을 모두 가지는 대장균 찾기
SELECT
    E1.ID,
    E1.GENOTYPE,
    E2.GENOTYPE AS PARENT_GENOTYPE
FROM ECOLI_DATA E1
LEFT JOIN ECOLI_DATA E2 
    ON E1.PARENT_ID = E2.ID
WHERE E1.GENOTYPE & E2.GENOTYPE = E2.GENOTYPE
ORDER BY E1.ID


-- L3. 대장균들의 자식의 수 구하기
SELECT
    E1.ID,
    COUNT(E2.ID) AS CHILD_COUNT
FROM ECOLI_DATA E1 
LEFT JOIN ECOLI_DATA E2
    ON E1.ID = E2.PARENT_ID
GROUP BY E1.ID
ORDER BY E1.ID;


-- L3. 대장균의 크기에 따라 분류하기 1
SELECT
    ID,
    IF(SIZE_OF_COLONY <= 100, "LOW", 
       IF(SIZE_OF_COLONY <= 1000, "MEDIUM", "HIGH")) 
    AS SIZE
FROM ECOLI_DATA
ORDER BY ID ASC;


-- L3. 대장균의 크기에 따라 분류하기 2
SELECT
    E1.ID,
    CASE 
        WHEN E2.PER > 0.75 THEN "LOW"
        WHEN E2.PER > 0.5 THEN "MEDIUM"
        WHEN E2.PER > 0.25 THEN "HIGH"
        ELSE "CRITICAL"
    END AS COLONY_NAME
FROM ECOLI_DATA E1 
LEFT JOIN (
    SELECT
        ID,
        PERCENT_RANK() OVER (ORDER BY SIZE_OF_COLONY DESC) AS PER
    FROM ECOLI_DATA
) AS E2 
    ON E1.ID = E2.ID
ORDER BY
    ID ASC;


-- L4. 서울에 위치한 식당 목록 출력하기
SELECT
    I.REST_ID,
    I.REST_NAME,
    I.FOOD_TYPE,
    I.FAVORITES,
    I.ADDRESS,
    R.SCORE
FROM REST_INFO I
INNER JOIN (
    SELECT 
        REST_ID,
        ROUND(AVG(REVIEW_SCORE), 2) AS SCORE
    FROM REST_REVIEW
    WHERE REST_ID IS NOT NULL
    GROUP BY REST_ID
) AS R
    ON I.REST_ID = R.REST_ID
WHERE I.ADDRESS LIKE ("서울%")
ORDER BY R.SCORE DESC, I.FAVORITES DESC;


-- L4. 오프라인/온라인 판매 데이터 통합하기
SELECT
    DATE_FORMAT(SALES_DATE, "%Y-%m-%d") AS SALES_DATE,
    PRODUCT_ID,
    USER_ID,
    SALES_AMOUNT
FROM ONLINE_SALE
WHERE SALES_DATE BETWEEN "2022-03-01" AND "2022-03-31"
UNION ALL
SELECT
    DATE_FORMAT(SALES_DATE, "%Y-%m-%d") AS SALES_DATE,
    PRODUCT_ID,
    NULL,
    SALES_AMOUNT
FROM OFFLINE_SALE
WHERE SALES_DATE BETWEEN "2022-03-01" AND "2022-03-31"
ORDER BY SALES_DATE ASC, PRODUCT_ID ASC, USER_ID ASC;


-- L4. 특정 세대의 대장균 찾기
WITH RECURSIVE GENERATION AS (
    SELECT 
        ID, 
        PARENT_ID, 
        1 AS GEN
    FROM ECOLI_DATA
    WHERE PARENT_ID IS NULL
    UNION ALL
    SELECT
        E.ID,
        E.PARENT_ID,
        G.GEN + 1 AS GEN
    FROM ECOLI_DATA E 
    INNER JOIN GENERATION G 
        ON E.PARENT_ID = G.ID
)

SELECT ID
FROM GENERATION
WHERE GEN = 3
ORDER BY ID;


-- L5. 멸종위기의 대장균 찾기
WITH RECURSIVE CTE_GEN AS (
    SELECT
        ID,
        PARENT_ID,
        1 AS GENERATION
    FROM ECOLI_DATA
    WHERE PARENT_ID IS NULL
    UNION ALL
    SELECT
        E.ID,
        E.PARENT_ID,
        G.GENERATION + 1
    FROM ECOLI_DATA E
    INNER JOIN CTE_GEN G 
        ON G.ID = E.PARENT_ID
)

SELECT
    COUNT(*) AS COUNT,
    G1.GENERATION
FROM CTE_GEN G1
LEFT JOIN CTE_GEN G2 
    ON G1.ID = G2.PARENT_ID
WHERE G2.ID IS NULL
GROUP BY G1.GENERATION;