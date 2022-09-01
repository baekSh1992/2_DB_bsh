-- 함수 : 컬럼의 값을 읽어서 연산한 결과를 반환

-- 단일 행 함수 : N개의 값을 읽어 N개의 결과를 반환

-- 그룹 함수 : N개의 값을 읽어 1개의 결과를 반환(합계, 평균, 최대, 최소)

-- 함수는 SELECT 문의
-- SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절 사용 가능 (FROM절은 서브쿼리)

------------------------------ 단일 행 함수 -------------------------------------

-- LENGTH (컬럼명 | 문자열) : 길이 출력
SELECT EMAIL, LENGTH (EMAIL)
FROM EMPLOYEE;

-------------------------------------------------------------------------------

-- INSTR(이너스트링)
-- (컬럼명 | 문자열, '찾을 문자열' [, 찾기 시작할 위치 [,순번] ] ) 
-- 지정한 위치부터 지정한 순번째로 검색되는 문자의 위치를 출력

-- 문자열의 앞에서 부터 검색하여 첫 번째 B의 위치 조회
SELECT  INSTR('AABAACAABBAA', 'B') FROM DUAL ;  --3
-- 문자열의 5번째 문자 부터 검색하여 첫 번째 B의 위치 조회
SELECT  INSTR('AABAACAABBAA', 'B', 5 ) FROM DUAL ;  -- 9
-- 문자열의 5번째 문자 부터 검색하여 두 번째 B의 위치 조회
SELECT  INSTR('AABAACAABBAA', 'B', 5, 2) FROM DUAL ;  -- 10



-- EMPLOYEE 테이블에서 사원명, 이메일, 이메일 중 '@(at)' 위치 조회
SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

------------------------------------------------------------------------

-- SUBSTR('문자열' | 컬럼명, 잘라내기 시작할 위치 [, 잘라낼 길이]  )
-- 컬럼이나 문자열에서 지정한 위치부터 지정된 길이만큼 문자열을 잘라내서 반환
--> 잘라낼 길이 생략 시 끝까지 잘라냄


-- EMPLOYEE 테이블에서 사원명, 이메일 중 아이디만 조회
-- sun_di@ < 골뱅이 빼려면 뒤에 -1
SELECT EMP_NAME, SUBSTR( EMAIL,  1,   INSTR(EMAIL, '@') -1 )  아이디
FROM EMPLOYEE;

-------------------------------------------------------------------------

-- TRIM([[옵션] '문자열' | 컬럼명 FROM ]'문자열'|컬럼명  )
-- 주어진 컬럼이나 문자열의 앞, 뒤, 양쪽에 있는 지정된 문자를 제거
--> (보통 양쪽 공백 제거에 많이 사용)

-- 옵션 :  LEADING(앞쪽), TRAILING(뒤쪽), BOTH(양쪽, 기본값)

SELECT  TRIM('     H E L L O     ')
FROM DUAL; -- 앞뒤 공백 제거

SELECT TRIM(LEADING  '#' FROM '#####안녕#####')
FROM DUAL; -- 앞쪽 #만 사라짐 LEADING

SELECT TRIM( TRAILING '#' FROM '#####안녕#####')
FROM DUAL; -- 뒤쪽 #만 사라짐 TRAILING

SELECT TRIM( BOTH '#' FROM '#####안녕#####')
FROM DUAL; -- 앞뒤 #만 사라짐 BOTH

----------------------------------------------------------------------------

/* 숫자 관련 함수 */
SELECT ABS(10), ABS(-10) FROM DUAL;

-- ABS(숫자 | 컬럼명) : 절대 값
SELECT '절대값 같음'
FROM DUAL 
WHERE ABS(10) = ABS(-10); -- WHERE절 함수 작성 가능


-- MOD(숫자 | 컬럼명  ,  숫자 | 컬럼명) : 나머지 값 반환
-- EMPLOYEE 테이블에서 사원의 월급을 100만으로 나눴을 때 나머지 조회
SELECT EMP_NAME, SALARY, MOD(SALARY, 1000000)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사번이 짝수인 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 0;

-- EMPLOYEE 테이블에서 사번이 홀수인 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) <> 0; -- <> 는 같지않다 는뜻 (!=)


-- ROUND(숫자 | 컬럼명 [,소수점 위치]) : 반올림
SELECT  ROUND( 123.456 ) FROM DUAL;-- 123, 소수점 첫 번째 자리에서 반올림  
SELECT  ROUND( 123.456, 1 ) FROM DUAL; -- 123.5 , 소수점 두 번째 자리에서 반올림
																				--> 두 번째 자리에서 반올림해서
																				--> 소수점 한 자리만 표현 

SELECT  ROUND( 123.456, 0 ) FROM DUAL; -- 0이 기본 값 (표기안될뿐) 소수점 첫째 자리에서 반올림

SELECT  ROUND( 123.456, -1) FROM DUAL; -- 소수점 0번째 자리에서 반올림해서
																				-- 소수점 -1 자리 표현
																				-- == 1의 자리에서 반올림해서 10의자리부터 표현

SELECT  ROUND( 123.456, -2) FROM DUAL; -- 10의 자리에서 반올림해서 100의자리부터 표현
 																				 
-- CEIL(숫자 | 컬럼명) : 올림
-- FLOOR(숫자 | 컬럼명) : 내림
--> 둘다 소수점 첫째 자리에서 올림/내림 처리

SELECT CEIL(123.1), FLOOR(123.9) FROM DUAL;
--                      124                      123

-- TRUNC(숫자 | 컬럼명 [,위치]) : 특정 위치 아래를 버림(절삭)
SELECT TRUNC(123.456) FROM DUAL; -- 123, 소수점 아래를 버림
SELECT TRUNC(123.456, 1) FROM DUAL; -- 123.4, 소수점 첫째 자리 이후를 버림
SELECT TRUNC(123.456, -1) FROM DUAL; -- 120, 10의 자리 아래를 버림 ( 소수점 버리면 10임)
--                          12 아님 120임

/*  버림, 내림 차이점 */

SELECT FLOOR(-123.5), TRUNC(-123.5) FROM DUAL;
--                           -124                      -123
----------------------------------------------------------------------------------

/* 날짜(DATE) 관련 함수 */

-- SYSDATE : 시스템에 현재 시간(년,월,일,시,분,초)을 반환
SELECT  SYSDATE FROM DUAL;

-- SYSTIMESTAMP : SYSDATE + MS 단위 추가
SELECT SYSTIMESTAMP FROM DUAL;
-- SYSTIMESTAMP : 특정 시간을 나타내거나 기록하기 위한 문자열 초 뒤에 자리 까지 나옴

-- MONTHS_BETWEEN(날짜, 날짜) : 두 날짜의 개월 수 차이 반환
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, '2022-08-04'), 3 ) 수강기간
FROM DUAL; -- 지정 날짜로부터 경과한 '달' 수 계산 1이 한 달 3 = 셋째 자리까지


-- EMPLOYEE 테이블에서
-- 사원의 이름, 입사일, 근무한 개월 수, 근무한 햇수 조회
SELECT EMP_NAME ,HIRE_DATE , 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) " 근무한 개월 수 ", 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) ||'년차' " 근무 년차" 
FROM EMPLOYEE; 
																								 /* || : 연결 연산자(문자열 이어쓰기) */

-- ADD_MONTHS(날짜 , 숫자) : 날짜에 숫자만큼의 개월 수를 더함. (음수도 가능 = 몇달 전)
SELECT ADD_MONTHS(SYSDATE , 4) FROM DUAL; -- 4달 뒤

SELECT ADD_MONTHS(SYSDATE , -1) FROM DUAL; -- 1달 전

-- LAST_DAY(날짜) : 해당 달의 마지막 날짜를 구함.
SELECT LAST_DAY('2022-08-01') FROM DUAL;


-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 일만 추출

-- EMPLOYEE 테이플에서
-- 각 사원의 이름, 입사 년도, 월, 일 조회

SELECT EMP_NAME,
		EXTRACT(YEAR FROM HIRE_DATE) || '년' ||
		EXTRACT(MONTH FROM HIRE_DATE) || '월' ||
		EXTRACT(DAY FROM HIRE_DATE) || '일'  AS 입사일
FROM EMPLOYEE;
---------------------------------------------------------------------------------

/* 형변환 함수 */
-- 문자열(CHAR), 숫자(NUMBER), 날짜(DATE) 끼리 형변환 가능


/* 문자열로 변환 */
-- TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자형 데이터로 변경
-- TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자형 데이터로 변경

-- <숫자 변환 시 포맷 패턴>
-- 9 : 숫자 한칸을 의미, 여러 개 작성 시 오른쪽 정렬
-- 0 : 숫자 한칸을 의미, 여러 개 작성 시 오른쪽 정렬 + 빈칸 0 추가
-- L : 현재 DB에 설정된 나라의 화폐 기호

SELECT TO_CHAR(1234) FROM DUAL; -- 1,234 > 1234 콤마 사라짐 문자열로 바뀜

SELECT TO_CHAR(1234, '99999') FROM DUAL; -- '  1234'
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- '01234'

SELECT TO_CHAR(EXTRACT (MONTH FROM HIRE_DATE), '00')|| '월'
FROM EMPLOYEE;

SELECT TO_CHAR(1000000) || '원' FROM DUAL; -- '1000000' 

SELECT TO_CHAR(1000000, '9,999,999') || '원' FROM DUAL; -- '1,000,000' 

SELECT TO_CHAR(1000000, 'L9,999,999') FROM DUAL; -- 'W1,000,000'  L= 로컬 그나라 원화표시

-- <날짜 변환 시 포맷 패턴>
-- YYYY : 년도 / YY : 년도 (짧게)
-- RRRR : 년도 / RR : 년도 (짧게)
-- MM : 월  // DD : 일
-- AM 또는 PM : 오전/오후 표시
-- HH : 시간   /  HH24 : 24시간 표기법
-- MI : 분  /  SS : 초
-- DAY : 요일(월요일)  /  DY : 요일(월)

SELECT SYSDATE FROM DUAL; -- 2022-09-01-11:20:35.000

-- 2022/09/01 11:20:35 목요일
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH24:MI:SS (DY)') FROM DUAL; 

-- 09/01 (목)
SELECT TO_CHAR(SYSDATE, 'MM/DD (DY)') FROM DUAL; 

-- 2022년 09월 01일 (목)
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" (DY)') 날짜 FROM DUAL; 
-- 날짜 형식이 부적합합니다.
-- 년,월,일이 날짜를 나타내는 패턴으로 인식이 안됨 오류발생
-- "" 쌍따옴표를 이용해서 단순한 문자로 인식 시키면 해결

--------------------------------------------------------------------------------

/* 날짜로 변환 TO_DATE */
-- TO_DATE(문자형 데이터, [포맷]) : 문자형 데이터를 날짜로 변경
-- TO_DATE(숫자형 데이터, [포맷]) : 숫자형 데이터를 날짜로 변경
--> 지정된 포맷으로 날짜를 인식함

SELECT SYSDATE FROM DUAL;

SELECT TO_DATE('2022-09-02') FROM DUAL;
SELECT TO_DATE( 20220902 )FROM DUAL;

SELECT TO_DATE('220901 113255', 'YYMMDD HH24MISS') FROM DUAL;
--> 패턴( , 뒷부분(자바에서 프린트f문) )을 사용해서 작성된 문자열의 각 문자가 어떤 날짜 형식인지 인식 시킴


-- EMPLOYEE 테이블에서 각 지원이 태어난 생년월일(1990년 05월 13일) 조회
SELECT  EMP_NAME, 
		TO_CHAR( TO_DATE( SUBSTR( EMP_NO, 1, INSTR(EMP_NO,'-') -1), 'RRMMDD'),
			'YYYY"년"MM"월"DD"일"') AS 생년월일
FROM EMPLOYEE;

-- Y패턴 : 현재 세기(21세기 == 20XX년 == 2000년대)
-- R패턴 : 1세기를 기준으로 절반(50년) 이상인 경우 이전 세기(1900년대)
--										 절반(50년) 미만인 경우 현재 세기(2000년대)
SELECT TO_DATE('510505', 'YYDDMM') FROM DUAL; -- 2051-05-05 00:00:00.000
SELECT TO_DATE('510505', 'RRDDMM') FROM DUAL; -- 1951-05-05 00:00:00.000



---------------------------------------------------------------------------------

/* 숫자 형변환 */
-- TO_NUMBER(문자데이터, [포맷]) : 문자형데이터를 숫자 데이터로 변경 , (날짜 > 숫자는 불가)

SELECT '1,000,000' + 500000 FROM DUAL;
--  ORA-01722: 수치가 부적합합니다

SELECT TO_NUMBER('1,000,000','9,999,999') + 500000 FROM DUAL;
-- 문자열을 숫자라고 인식 시켜줌 = 150만

---------------------------------------------------------------------------------

/* NULL 처리 함수 */

-- NVL(컬럼명, 컬럼값이 NULL일때 바꿀 값) : NULL인 컬럼값을 다른 값으로 변경

/* NULL과 산술 연산을 진행하면 결과는 무조건 NULL */
SELECT EMP_NAME, SALARY, NVL(BONUS,0), SALARY *NVL( BONUS,0) 
FROM EMPLOYEE;


-- NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼의 값이 있으면 바꿀값1로 변경,
-- 해당 컬럼이 NULL이면 바꿀값2로 변경

-- EMPLOYEE 테이블에서 보너스를 받으면 'O' , 안받으면 'X' 조회 하기
SELECT EMP_NAME,NVL2( BONUS,  'O' , 'X')"보너스 수령"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/* 선택 함수 */
-- 여러 가지 경우에 따라 알맞은 결과를 선택할 수 있음.

-- DECODE(계산식 | 컬럼명, 조건값1, 선택값1, 조건값2, 선택값2....., 아무것도 일치하지 않을 때)
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
-- 일치하는 값을 확인(자바의 SWITCH와 비슷함)

-- 직원의 성별 구하기 (남:1 / 여:2 )
SELECT EMP_NAME,DECODE( SUBSTR( EMP_NO, 8,1) , '1', '남성' , 2 , '여성' )
FROM EMPLOYEE;


-- 직원의 급여를 인상하고자 한다.
-- 직급 코드가 J7인 직원은 20% 인상,
-- 직급 코드가 J6인 직원은 15% 인상,
-- 직급 코드가 J5인 직원은 10% 인상,
-- 그 외 직급은 5% 인상

SELECT EMP_NAME , JOB_CODE ,SALARY , 
			DECODE(JOB_CODE, 'J7', '20%' ,
													'J6' , '15%' , 
													'J5' , '10%',
													'5%') AS 인상률,
			DECODE(JOB_CODE, 'J7', SALARY * 1.2 ,
													'J6' , SALARY * 1.15 , 
													'J5' , SALARY * 1.1,
													SALARY * 1.05) "인상된 급여"
FROM EMPLOYEE;
--   (if)      (      )             {               }    
-- CASE WHEN 조건식 THEN 결과값
--    		   WHEN 조건식 THEN 결과값
--     	   ELSE 결과값
-- END

-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
-- 조건은 범위 값 가능

-- EMPLOYEE 테이블에서
-- 급여가 500만원 이상이면 '고' 
-- 급여가 300만원 이상 500만 미만이면 '중' 
-- 급여가 300만원 미만이면 '저'  으로 조회

SELECT EMP_NAME ,SALARY,
		CASE 
				WHEN SALARY >= 5000000 THEN '고'
				WHEN SALARY >= 3000000 THEN '중'
				ELSE '저'
		END "급여 등급"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/* 그룹 함수 */
-- 하나 이상의 행을 그룹으로 묶어 연산하여 총합, 평균 등의 하나의 결과 행으로 반환하는 함수


-- SUM(숫자가 기록된 컬럼명) : 합계
-- 모든 직원의 급여 합
SELECT SUM(SALARY) FROM EMPLOYEE; -- 70096240

-- AVG(숫자가 기록된 컬럼명)  : 평균
-- 전 직원 급여 평균
SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE; -- 3047663


-- 부서 코드가 'D9'인 사원들의 급여 합, 평균
/*마지막*/SELECT SUM(SALARY), ROUND(AVG(SALARY))
/*1*/      FROM EMPLOYEE;
/*2*/      WHERE DEPT_CODE = 'D9';

-- MIN(컬럼명) : 최소값
-- MAX(컬럼명) : 최대값
--> 타입 제한 없음 (숫자 : 대/소, 날짜 : 과거/미래, 문자열 : 문자 순서)

-- 급여 최소값, 가장 빠른 입사일, 이메일 알파벳 순서가 가장 빠른
SELECT MIN(SALARY), MIN(HIRE_DATE), MIN(EMAIL)
FROM EMPLOYEE;

-- 급여 최대값, 가장 느린 입사일, 이메일 알파벳 순서가 가장 느린
SELECT MAX(SALARY), MAX(HIRE_DATE), MAX(EMAIL)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 급여를 가장 많이 받는 사원의
-- 이름, 급여, 직급 코드 조회
SELECT EMP_NAME ,SALARY ,JOB_CODE 
FROM EMPLOYEE
WHERE  SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);
									-- 서브쿼리 + 그룹함수

-- * COUNT(* | 컬럼명) : 행 개수를 헤아려서 리턴
-- COUNT([DISTINCT] 컬럼명) : 중복을 제거한 행 개수를 헤아려서 리턴
-- COUNT(*) : NULL을 포함한 전체 행 개수를 리턴
-- COUNT(컬럼명) : NULL을 제외한 실제 값이 기록된 행 개수를 리턴함

SELECT COUNT(*) FROM EMPLOYEE; -- EMPLOYEE 테이블의 행의  갯수 (* = ALL)

-- BONUS를 받는 사원의 수
SELECT COUNT(*) FROM EMPLOYEE -- 9명
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS) FROM EMPLOYEE; -- 9명


SELECT DISTINCT  DEPT_CODE FROM EMPLOYEE; -- 7행
SELECT DISTINCT COUNT(DISTINCT  DEPT_CODE ) FROM EMPLOYEE; -- 6행
--> 왜 1행이 적지? NULL값이 포함되어 있었음.
-- CONUT(컬럼명)에 의해 NULL을 제외한 실제 값이 있는 행의 갯수만 조회


-- EMPLOYEE  테이블에서 성별이 남성인 사원의 수 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 , 1) = '1' 

SELECT SUM(  DECODE( SUBSTR(EMP_NO , 8 , 1), '1', 1,0 ) ) -- 남성의 수 주민뒷자리 '1' 
FROM EMPLOYEE


















