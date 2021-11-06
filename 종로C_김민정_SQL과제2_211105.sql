-- 1�� ����
--�μ����� �׷��Ͽ� �μ���ȣ, �ο���, �޿��� ���, �޿��� ���� ��ȸ�ϼ���.
SELECT DEPT_CODE AS �μ���ȣ, COUNT(*) AS �ο���, ROUND(AVG(SALARY)) AS �޿����, SUM(SALARY) AS �޿���
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- 2�� ����
-- �ڽ��� ���� ������ ��� �޿����� ���� �޴� ����� �̸�, ���޸�, �޿� ���� ��ȸ�ϼ���.
SELECT E.EMP_NAME AS �����, E.JOB_CODE AS ���޸�, E.SALARY AS �޿�
 FROM EMPLOYEE E
 WHERE SALARY > ( SELECT AVG(SALARY) 
                    FROM EMPLOYEE M
                      WHERE E.JOB_CODE=M.JOB_CODE
                      GROUP BY JOB_CODE);


-- 3�� ����
-- ȸ�翡�� �ް�ö�� �¾� �� ������� �ؿܿ����� �����ַ��� �մϴ�.
-- ������� �޿��� ���� �����ַ��� �Ͽ�
-- S1,S2 �� ������� �̱�, S3, S4�� ������� �߱�, S5, S6�� ������� �Ϻ��� ���������ؿ�.
-- ��, ���� �ٹ��ϰ� �ִ� ������ ������ �ؿܿ����� �����ַ��� ������ ���� ���, ���������� �����ָ�
-- ��ǥ�� �ް����� ����ؼ� �ٹ��� �ϱ�� �մϴ�.
-- EMPLOYEE ���̺��� �̿� ���� ���ǿ� �´�
-- ���, �����, �μ���, ���α�����(NATIONAL_NAME), �޿����, �ް������� �� ��� ������������ ��ȸ�ϼ���.

SELECT EMP_ID AS ���, EMP_NAME AS �����, DEPT_TITLE AS �μ���
    , NATIONAL_NAME AS ���α�����, E.SAL_LEVEL AS �޿����, 
    CASE WHEN JOB_NAME='��ǥ' THEN '�ٹ�'        
        ELSE ;
        
SELECT  (CASE WHEN NATIONAL_NAME=DECODE(E.SAL_LEVEL,'S1','�̱�','S2','�̱�'
                                      ,'S3','�߱�', 'S4','�߱�'
                                      ,'�Ϻ�') THEN '��������'
                 ELSE DECODE(E.SAL_LEVEL,'S1','�̱�','S2','�̱�'
                                      ,'S3','�߱�', 'S4','�߱�'
                                      ,'�Ϻ�')
            END)
--        END AS �ް�������
FROM EMPLOYEE E 
--JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL)
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE)
LEFT JOIN JOB USING(JOB_CODE)
ORDER BY EMP_ID;
SELECT SAL_LEVEL FROM EMPLOYEE;

SELECT CASE WHEN ������ �������� WHEN '��������'
    ELSE ���� ���� ����
FROM EMPLOYEE
�� �� �ڵ��...


-- 4�� ����
--��� ����� �޿��� ������ '��00,000,000'�������� ���ϼ���
SELECT TO_CHAR(SUM(SALARY), 'L99,999,999') AS �޿����� FROM EMPLOYEE;


-- 5�� ����
--�μ� �ڵ尡 D9�� ������� �޿� �� ���� �޿����� ���� �޿��� �޴� ����� �̸��� �޿��� ����ϼ���
SELECT EMP_NAME AS �����, SALARY AS �޿�
FROM EMPLOYEE
    WHERE SALARY >(SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE='D9');


-- 6�� ����
--'D6'�� �μ��� ��� �߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ����� �̸��� �޿��� ����غ�����.
SELECT EMP_NAME AS �����, SALARY AS �޿�
FROM EMPLOYEE
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE='D6');

-- 7�� ����
-- ȸ���� ���������� ���Ͽ� ���������� �Ұ����������ϴ�.
-- �켱 ���� ����� �ľ��ϱ� ���� (EMPLOYEE ���̺���) ��� ������ ���, �����, ����, �μ���, �ٹ�������
-- �����ڵ�� ����� ������������ ��ȸ�ϼ���.
SELECT EMP_ID AS ���, EMP_NAME AS �����, DEPT_TITLE AS �μ�, JOB_NAME AS �μ���, LOCAL_NAME AS �ٹ�����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
ORDER BY DEPT_CODE, EMP_ID;


-- 8�� ����
-- ��� ������ �ǹ̷� �Ѵ޿� �ѹ� �系 �̺�Ʈ�� ����˴ϴ�.
-- ���� ��÷�� ���� �̺�Ʈ ��÷�� ��ǥ�� ���� ������ ��ȸ�ϼ���. (��� ������ �ּ��Ѹ� ����ǰ� �ϱ� ���� ���� ������ �����ؾ� �մϴ�)
-- ��÷���� ���, �����(��� ���ڴ� '*'���� ǥ��), ���̵�(�̸��Ͽ��� ���̵� ����), ����ó(��� 4�ڸ��� '****'���� ǥ��)
-- �̹� �� ��÷�ڴ� �ֹι�ȣ ������ �ڸ��� '1'�� ������Դϴ�.
SELECT EMP_ID AS ���, SUBSTR(EMP_NAME,1,1)||'*'||SUBSTR(EMP_NAME,3,1) AS �����,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS ���̵�, SUBSTR(PHONE,1,3)||'****'||SUBSTR(PHONE,8,4) AS ����ó
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,-1,1)=1;


-- 9�� ����
-- ������, �μ���, �ο���, �޿��հ�, �޿������ ��ȸ�ϵ�,
-- ������� �μ��� ���� ��� ��ȸ�ϰ�,
-- ������ ������ ��������, �μ��� �������� ������ �����ϼ���.
SELECT NATIONAL_NAME AS ������, DEPT_TITLE AS �μ���, COUNT(*) AS �ο���, SUM(SALARY) AS �޿��հ�, ROUND(AVG(SALARY)) AS �޿����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE)
GROUP BY NATIONAL_NAME, DEPT_TITLE
ORDER BY NATIONAL_NAME DESC, DEPT_TITLE DESC;


-- 10�� ����
-- ��ǥ '������'�� �ֱ� �系���� �������� �ǽɵǴ� ��Ȳ�� ����� �Ǿ���.
-- ������ ã�Ƴ��� ���� �������� ���翡�� ��и��� ������� ������ �����ؿ���� ����ߴ�.
-- ���, �����, �μ���, ���޸�, �޿�, ���ʽ�, ����, ������� ��ȸ�ϰ�
-- ������ ����� ��������, �޿� �������� ������ �����Ѵ�.
-- ������� �ֹι�ȣ ���ڸ� 2��°���� 2�ڸ��� �������� ������ ����.
--���� 00~08 / �λ� 09~12 / ��õ 13~15 / ��� 16~25 / ���� 26~34 / ��� 35~39 / ���� 40 /
--�泲 41~47 / ���� 48~54 / ���� 55~64 / ���� 65~66 / �뱸 67~69, 76 /
--��� 70~75, 77~81 / �泲 82~84, 86~92 / ��� 85 / ���� 93~95 / �� �ܿ��� 'Ȯ�ο��'���� ǥ��
SELECT EMP_ID AS ���, EMP_NAME AS �����, DEPT_TITLE AS �μ���, JOB_NAME AS ���޸�, SALARY AS �޿�, BONUS AS ���ʽ�, DECODE(SUBSTR(EMP_NO,8,1),1,'����','����') AS ����,SUBSTR(EMP_NO,-2,2), 
    CASE 
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 00 AND 08 THEN '����' 
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 09 AND 12 THEN '�λ�'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 13 AND 15 THEN '��õ'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 16 AND 25 THEN '���'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 26 AND 34 THEN '����'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 35 AND 39 THEN '���'
        WHEN SUBSTR(EMP_NO,-2,2)=40 THEN '����'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 41 AND 47 THEN '�泲'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 48 AND 54 THEN '����'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 55 AND 64 THEN '����'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 65 AND 66 THEN '����'
        WHEN SUBSTR(EMP_NO,-2,2)=85 THEN '���'
        WHEN (SUBSTR(EMP_NO,-2,2) BETWEEN 67 AND 69) 
            OR SUBSTR(EMP_NO,-2,2)=76 THEN '�뱸'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 70 AND 81 THEN '���'
        
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 82 AND 92 THEN '�泲'
        WHEN SUBSTR(EMP_NO,-2,2)=85 THEN '���'
        WHEN SUBSTR(EMP_NO,-2,2) BETWEEN 93 AND 95 THEN '����'
    ELSE 'Ȯ�ο��' END AS ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
LEFT JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
ORDER BY LOCAL_NAME, SALARY DESC;