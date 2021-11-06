-- 1번 문제
--부서별로 그룹하여 부서번호, 인원수, 급여의 평균, 급여의 합을 조회하세요.
SELECT DEPT_CODE AS 부서번호, COUNT(*) AS 인원수, ROUND(AVG(SALARY)) AS 급여평균, SUM(SALARY) AS 급여합
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- 2번 문제
-- 자신이 속한 직급의 평균 급여보다 많이 받는 사원의 이름, 직급명, 급여 정보 조회하세요.
SELECT E.EMP_NAME AS 사원명, E.JOB_CODE AS 직급명, E.SALARY AS 급여
 FROM EMPLOYEE E
 WHERE SALARY > ( SELECT AVG(SALARY) 
                    FROM EMPLOYEE M
                      WHERE E.JOB_CODE=M.JOB_CODE
                      GROUP BY JOB_CODE);


-- 3번 문제
-- 회사에서 휴가철을 맞아 전 사원에게 해외여행을 보내주려고 합니다.
-- 사원들의 급여에 맞춰 보내주려고 하여
-- S1,S2 인 사원들은 미국, S3, S4인 사원들은 중국, S5, S6인 사원들은 일본에 보내려고해요.
-- 단, 현재 근무하고 있는 지부의 국가가 해외여행을 보내주려는 국가와 같을 경우, 국내여행을 보내주며
-- 대표는 휴가때도 계속해서 근무를 하기로 합니다.
-- EMPLOYEE 테이블에서 이와 같은 조건에 맞는
-- 사번, 사원명, 부서명, 지부국가명(NATIONAL_NAME), 급여등급, 휴가여행지 를 사번 오름차순으로 조회하세요.

SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, DEPT_TITLE AS 부서명
    , NATIONAL_NAME AS 지부국가명, E.SAL_LEVEL AS 급여등급, 
    CASE WHEN JOB_NAME='대표' THEN '근무'        
        ELSE ;
        
SELECT  (CASE WHEN NATIONAL_NAME=DECODE(E.SAL_LEVEL,'S1','미국','S2','미국'
                                      ,'S3','중국', 'S4','중국'
                                      ,'일본') THEN '국내여행'
                 ELSE DECODE(E.SAL_LEVEL,'S1','미국','S2','미국'
                                      ,'S3','중국', 'S4','중국'
                                      ,'일본')
            END)
--        END AS 휴가여행지
FROM EMPLOYEE E 
--JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL)
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE)
LEFT JOIN JOB USING(JOB_CODE)
ORDER BY EMP_ID;
SELECT SAL_LEVEL FROM EMPLOYEE;

SELECT CASE WHEN 같으면 국내여행 WHEN '국내여행'
    ELSE 각자 가는 나라
FROM EMPLOYEE
그 외 코드들...


-- 4번 문제
--모든 사원들 급여의 총합을 '￦00,000,000'형식으로 구하세요
SELECT TO_CHAR(SUM(SALARY), 'L99,999,999') AS 급여총합 FROM EMPLOYEE;


-- 5번 문제
--부서 코드가 D9인 사원들의 급여 중 최저 급여보다 높은 급여를 받는 사원의 이름과 급여를 출력하세요
SELECT EMP_NAME AS 사원명, SALARY AS 급여
FROM EMPLOYEE
    WHERE SALARY >(SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE='D9');


-- 6번 문제
--'D6'번 부서의 사원 중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사원의 이름과 급여를 출력해보세요.
SELECT EMP_NAME AS 사원명, SALARY AS 급여
FROM EMPLOYEE
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE='D6');

-- 7번 문제
-- 회사의 재정난으로 인하여 구조조정이 불가피해졌습니다.
-- 우선 현재 사원을 파악하기 위해 (EMPLOYEE 테이블의) 모든 직원의 사번, 사원명, 직급, 부서명, 근무지역을
-- 직급코드와 사번의 내림차순으로 조회하세요.
SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, DEPT_TITLE AS 부서, JOB_NAME AS 부서명, LOCAL_NAME AS 근무지역
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
ORDER BY DEPT_CODE, EMP_ID;


-- 8번 문제
-- 사기 충전의 의미로 한달에 한번 사내 이벤트가 진행됩니다.
-- 랜덤 추첨을 통한 이벤트 당첨자 발표를 위해 다음을 조회하세요. (사원 정보는 최소한만 노출되게 하기 위해 다음 조건을 만족해야 합니다)
-- 당첨자의 사번, 사원명(가운데 글자는 '*'으로 표시), 아이디(이메일에서 아이디만 추출), 연락처(가운데 4자리는 '****'으로 표시)
-- 이번 달 당첨자는 주민번호 마지막 자리가 '1'인 사원들입니다.
SELECT EMP_ID AS 사번, SUBSTR(EMP_NAME,1,1)||'*'||SUBSTR(EMP_NAME,3,1) AS 사원명,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS 아이디, SUBSTR(PHONE,1,3)||'****'||SUBSTR(PHONE,8,4) AS 연락처
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,-1,1)=1;


-- 9번 문제
-- 국가명, 부서명, 인원수, 급여합계, 급여평균을 조회하되,
-- 국가명과 부서명 별로 묶어서 조회하고,
-- 정렬은 국가명 내림차순, 부서명 내림차순 순서로 지정하세요.
SELECT NATIONAL_NAME AS 국가명, DEPT_TITLE AS 부서명, COUNT(*) AS 인원수, SUM(SALARY) AS 급여합계, ROUND(AVG(SALARY)) AS 급여평균
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE)
GROUP BY NATIONAL_NAME, DEPT_TITLE
ORDER BY NATIONAL_NAME DESC, DEPT_TITLE DESC;


-- 10번 문제
-- 대표 '선동일'은 최근 사내에서 지연으로 의심되는 상황을 엿듣게 되었다.
-- 누군지 찾아내기 위해 믿을만한 김기사에게 비밀리에 사원들의 정보를 정리해오라고 명령했다.
-- 사번, 사원명, 부서명, 직급명, 급여, 보너스, 성별, 출생지를 조회하고
-- 정렬은 출생지 오름차순, 급여 내림차순 순서로 정렬한다.
-- 출생지는 주민번호 뒷자리 2번째부터 2자리를 기준으로 다음과 같다.
--서울 00~08 / 부산 09~12 / 인천 13~15 / 경기 16~25 / 강원 26~34 / 충북 35~39 / 대전 40 /
--충남 41~47 / 전북 48~54 / 전남 55~64 / 광주 65~66 / 대구 67~69, 76 /
--경북 70~75, 77~81 / 경남 82~84, 86~92 / 울산 85 / 제주 93~95 / 그 외에는 '확인요망'으로 표시
SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, DEPT_TITLE AS 부서명, JOB_NAME AS 직급명, SALARY AS 급여, BONUS AS 보너스, DECODE(SUBSTR(EMP_NO,8,1),1,'남자','여자') AS 성별,SUBSTR(EMP_NO,-2,2), 
    CASE 
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 00 AND 08 THEN '서울' 
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 09 AND 12 THEN '부산'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 13 AND 15 THEN '인천'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 16 AND 25 THEN '경기'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 26 AND 34 THEN '강원'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 35 AND 39 THEN '충북'
        WHEN SUBSTR(EMP_NO,-2,2)=40 THEN '대전'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 41 AND 47 THEN '충남'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 48 AND 54 THEN '전북'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 55 AND 64 THEN '전남'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 65 AND 66 THEN '광주'
        WHEN SUBSTR(EMP_NO,-2,2)=85 THEN '울산'
        WHEN (SUBSTR(EMP_NO,-2,2) BETWEEN 67 AND 69) 
            OR SUBSTR(EMP_NO,-2,2)=76 THEN '대구'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 70 AND 81 THEN '경북'
        
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 82 AND 92 THEN '경남'
        WHEN SUBSTR(EMP_NO,-2,2)=85 THEN '울산'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 93 AND 95 THEN '제주'
    ELSE '확인요망' END AS 지역
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
LEFT JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
ORDER BY LOCAL_NAME, SALARY DESC;