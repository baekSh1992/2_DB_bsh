-- 부서명을 입력 받아 같은 부서에 있는 사원의
-- 사원명, 부서명, 급여 조회
SELECT EMP_NAME , NVL(DEPT_TITLE, '부서없음') AS DEPT_TITLE, SALARY 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE NVL(DEPT_TITLE, '부서없음') = '인사관리부';

/*
 '인사관리부' 문자형 리터럴
123 			  숫자형 리터럴
"이만큼이 한 문장 asd !@#"
가나다		 그냥문자는 컬럼명으로 인식됨
*/


	-- 입사일을 입력("2022-09-06") 받아 
	-- 입력 받은 값 보다 먼저 입사한 사람의 
	-- 이름, 입사일(1990년 01월 01일), 성별(M,F) 조회
SELECT EMP_NAME 이름,
			TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 입사일,
			DECODE(SUBSTR(EMP_NO,8,1),'1','M',2,'F' ) 성별
FROM EMPLOYEE
WHERE HIRE_DATE < TO_DATE('2022-09-06');
										-- TO_DATE 생략가능



SELECT EMP_ID, EMP_NAME, EMP_NO , EMAIL, PHONE,
				NVL(DEPT_TITLE, '부서없음') DEPT_TITLE,
				JOB_NAME, SALARY
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE);


SELECT EMP_ID, EMP_NAME, EMP_NO , EMAIL, PHONE,
				NVL(DEPT_TITLE, '부서없음') DEPT_TITLE,
				JOB_NAME, SALARY
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE EMP_NO = '621231-1985634'
;


















