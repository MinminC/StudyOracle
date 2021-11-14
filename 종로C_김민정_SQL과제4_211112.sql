--1번 문제 
--매니저 번호 별로 그룹화하여 
--해당 매니저의 사번, 사원명, 휘하 사원들의 급여합계를 조회하시오.

--1. 매니저가 존재하는 인원의 수(검산)
SELECT COUNT(MANAGER_ID) FROM EMPLOYEE;

--2. 자체조인(E의 MANAGER_ID와 M의 EMP_NAME이 일치하는 정보 조회)
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID=M.EMP_ID);

--3. 매니저로 그룹화+사원들의 급여 합계
SELECT M.EMP_ID AS 매니저사번, M.EMP_NAME AS 매니저이름, SUM(E.SALARY) AS 휘하급여합계
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID=M.EMP_ID)
GROUP BY M.EMP_ID, M.EMP_NAME;


--2번 문제
--부서별 근속년수가 가장 오래된 사원을 찾아 해당 사원의 사번, 사원명, 부서명, 직급명, 입사일을 조회하시오.

--구할 정보
SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, DEPT_TITLE AS 부서명, JOB_NAME AS 직급명, HIRE_DATE AS 입사일
FROM EMPLOYEE;

--부서별 근속년수 가장 오래된 사원
SELECT 사번, 사원명, 부서명, 직급명, 입사일
FROM (SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, DEPT_TITLE AS 부서명, JOB_NAME AS 직급명
    , HIRE_DATE AS 입사일, RANK() OVER(PARTITION BY DEPT_CODE ORDER BY HIRE_DATE) AS 순위
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
    LEFT JOIN JOB USING(JOB_CODE))
    WHERE 순위=1;--근무 제일 많이한 사람만 나옴!

SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, NVL(DEPT_TITLE,'부서없음') AS 부서명, JOB_NAME AS 직급명, HIRE_DATE AS 입사일
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
    LEFT JOIN JOB USING(JOB_CODE)
    WHERE (NVL(DEPT_CODE,'부서없음'), EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)) 
        IN (SELECT NVL(DEPT_CODE,'부서없음'), MAX(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE))
            FROM EMPLOYEE GROUP BY NVL(DEPT_CODE,'부서없음'));--총무부의 같은 년도인 노옹철, 송종기 같이 나옴!


--3번 문제
--사내 생일파티가 이벤트! 이번 생일파티는 3,4,5월생들만 진행한다.
--이번 생일파티 주인공들의 사번, 사원명, 주민번호, 부서명, 직급명, 근무지명을 조회하시오.
--단, 주민번호는 앞자리만 공개한다. 뒷자리는 모두 *처리.
SELECT EMP_ID, EMP_NAME, REPLACE(EMP_NO,SUBSTR(EMP_NO,8,14),'*******'), DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
WHERE SUBSTR(EMP_NO,3,2) IN ('03','04','05');

--4번 문제
--회사에서 직원들의 사기충전을 위해 작은 이벤트!
--곧 있을 회사창립 30주년을 기념하여 주민등록번호에 3과 0이 들어가는 직원에게 소정의 선물을 증정하기로했다.
--주민등록번호에 3과 0이 들어가는 직원의 정보를 조회하시오.
SELECT *
FROM EMPLOYEE
WHERE INSTR(EMP_NO,3) IN (1,2,3,4,5,6,8,9,10,11,12,13,14)
    AND INSTR(EMP_NO,0) IN (1,2,3,4,5,6,8,9,10,11,12,13,14);
SELECT * FROM EMPLOYEE 
WHERE EMP_NO LIKE '%3%' 
    AND EMP_NO LIKE '%0%';
SELECT * FROM EMPLOYEE 
WHERE SUBSTR(EMP_NO,1,14) LIKE '%3%' 
    AND SUBSTR(EMP_NO,1,14) LIKE '%0%';

--5번 문제
--각 사원별 시급을 계산하여 사원번호, 사원이름, 시급을 조회시오.
--조건 1. 한 달 근무일 수는 25일, 하루 근무시간은 9시간이다.
--조건 2. 소수점 자리는 없애고 맨 뒷 자리수가 0으로 나타나게끔!
--조건 3. 시급이 높은 순으로 정렬
SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, ROUND(SALARY/25/9,-1) AS 시급
FROM EMPLOYEE
ORDER BY 시급 DESC;