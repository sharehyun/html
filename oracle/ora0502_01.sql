select sysdate from dual;

현재 날짜에서 이달의 최초일과 이달의 마지막일을 출력하시오.
select sysdate,trunc(sysdate,'month'),last_day(sysdate) from dual;


select * from stuscore;

select * from stuscore 
where avg>=80 
and rownum<=5
order by avg desc
;

rownum 검색된 것에 일련번호를 다시 붙이는 것을 말함

select rownum,stuscore.* from stuscore where kor>=80;

select rownum,stuscore.* from stuscore where name like'%s%';

국어점수와 영어점수 편차가 큰 10명 학생을 rownum을 붙여 출력하시오. -- 이중쿼리 필요
select rownum,a.* 
from (select kor,eng,abs(kor-eng) ke from stuscore order by ke desc) a
where rownum<=10
;

select kor,eng,abs(kor-eng) ke from stuscore order by ke desc;

시퀀스 : 순차적인 번호 생성
nextval, currval


select to_char(sysdate,'yyyy-mm-dd am hh:mi:ss day') from dual;

select next_day(sysdate,'금요일') from dual;

select min(salary),max(salary),avg(salary),count(salary),sum(salary) from employees;


select sysdate-3,add_months(sysdate,-3) from dual;

ABC좋은나라DEF
좋은나라만 출력하시오.
select substr('ABC좋은나라DEF',4,4) from dual;

select mdate from member;

월만 분리해서 출력하고, 05,06,07인 회원만 출력
select member.*, to_char(mdate,'mm') from member where to_char(mdate,'mm') in (05,06,07) order by mdate;
select member.*, substr(mdate,4,2) from member where substr(mdate,4,2) in (05,06,07) order by mdate;

desc stuscore;

--create table stuscore5(
--sno number(4),
--NAME VARCHAR2(100),
--KOR NUMBER(3),
--ENG NUMBER(3),
--MATH NUMBER(3)
);

select * from stuscore3;

테이블과 함께 데이터를 모두 복사
--insert into stuscore3 select * from stuscore;

테이블과 함께 데이터를 모두 복사
--create table stuscore4 as select * from stuscore;

컬럼이 다른 경우 컬럼을 부여한 후 데이터 모두 복사
--insert into stuscore5 (sno,name,kor,eng,math) select sno,name,kor,eng,math from stuscore;
컬럼 추가
--alter table stuscore5 add total number(3);
컬럼 삭제
--alter table stuscore5 drop column total;


--alter table stuscore5 add total number(2);  -- tot 으로 컬럼명 변경
컬럼 변경 - 타입변경 (modify)
--alter table stuscore5 modify total number(3);
기존에 들어가 있는 3자리 데이터가 있는데ㅐ 2자리로 자릿수 변경을 하려고 하면 변경되지 않음
기존에 문자가 들어가 있는데 숫자형으로 변경하려면 변경되지 않음

컬럼 변경 - 이름변경 (rename)
--alter table stuscore5 rename column total to tot;

테이블명 변경
alter table stuscore2 rename to stu2;
alter table stu2 rename to stuscore2;

desc stuscore5;

컬럼 순서 변경
alter table stuscore5 modify name invisible;
alter table stuscore5 modify kor invisible;
alter table stuscore5 modify eng invisible;
alter table stuscore5 modify math invisible;

alter table stuscore5 modify name visible;
alter table stuscore5 modify kor visible;
alter table stuscore5 modify eng visible;
alter table stuscore5 modify math visible;


select * from stuscore5;


--drop table stuscore3;
--drop table stuscore4;
--drop table stuscore5;


--create table mem(
    id varchar2(30) primary key, -- 중복 X, null O
    name varchar2(100) not null, -- 중복 O, null X
    phone varchar2(20) unique,  -- 중복 X, null O
    gender nchar(2) check(gender in ('남성','여성')),
    kor number(3) check(kor between 0 and 100)
);

--insert into mem values(
'aaa','홍길동','010-1111','남성',100
);

--insert into mem values(
'bbb','유관순',null,'여성',99
);

--insert into mem values(
'ccc','유관순',null,'여성',99
);

--insert into mem values(
'ddd','이순신',null,'남성',100
);

--insert into mem values(
'eee','이순신','010-2222','남성',100
);

--constraint 별칭(fk_score_id) foreign key(현재테이블의 컬럼) references pk테이블(컬럼)

-- ### 기본키 설정
sno number(4) primary key

기본키 삭제
alter table score drop constraint SYS_C008356;

기본키 설정
alter table score add constraint pk_score_sno primary key(sno);



기본키 : 중복X, null X
외래키 : 기본키에 없는 데이터를 입력하면 입력이 되지 않게 함.
-- ### 외래키 설정


--create table score(
--    sno number(4) primary key,
--    id varchar2(30),
--    kor number(3),
--    constraint fk_score_id foreign key(id) references mem(id)
--);

-- 외래키 조건 등록
alter table score add constraint fk_score_id foreign key(id) references mem(id);

--외래키 조건 삭제
alter table score drop constraint fk_score_id;


select * from mem;
select * from score;

--delete mem where id='bbb'; 하면 score에 id bbb로 등록 불가

-- delete score where sno=2;
--insert into score values (1,'aaa',100);
--insert into score values (2,'bbb',90);
--insert into score values (3,'bb2',90); --등록 불가


desc member;


-- join조인
select * from employees;
select department_id from employees;
--cross join 특별한 키워드 없이 테이블 두개를 선택해서 출력 (13+6 ) = 48개
select * from employees,departments;
컬럼 수 (13+6) = 19개
데이터 개수 107*27 = 2889개


select * from departments;

desc employees;  -- 컬럼 13
desc departments; -- 컬럼 6

--equi join : 두 개의 테이블에서 같은 컬럼을 가지고 조인 (cross join 중)
select emp_name,a.department_id,department_name,salary 
from employees a,departments b
where a.department_id = b.department_id
;

select * from member;
select * from stuscore;

select sno,id,gender,a.name,phone,total,avg,rank 
from member a, stuscore b
where a.name = b.name;


select emp_name,salary,job_id from employees;
select min_salary,max_salary,job_id from jobs;


select emp_name,c.department_id,department_name,salary,a.job_id,min_salary,max_salary
from jobs a, employees b,departments c
where a.job_id = b.job_id and b.department_id = c.department_id;

select * from jobs;
select * from employees;
select * from departments;

select * from board;
--alter table board add bfile3 varchar2(100);

--alter table board modify bdate invisible;
--alter table board modify bdate visible;


--create table bfile(
bno number(4),
bfile varchar2(100)
);




--insert into bfile values(
1,'1.jpg'
);

--insert into bfile values(
4,'d1.jpg'
);

select * from bfile;

select * from board a,bfile b
where a.bno=b.bno
;

--alter table board drop column bfile;

select count(*);
select * from board a, bfile b where a.bno=b.bno and a.bno = 1;

select * from board where bno = 1;
select * from bfile where bno = 1;

select * from board;
--bno,btitle,bcontent,id,bgroup,bstep,bindent,bhit,bdate
bno : board_seq.nextval
bgroup : board_seq.curral
bdate : sysdate

insert into board values (
    board_seq.nextval,'2번째 게시글','파이썬에서 글쓰기 테스트','aaa',board_seq.currval,0,0,0,sysdate
);


desc board;
select * from stuscore;

--insert into stuscore(
 stuscore_seq.nextval,'윤소호',100,100,100,300,100.00,0
);

select board_seq.nextval from dual;


select * from board;
select * from bfile;





--join : equi,non-equi,inner,outer
--equi join : 두 개의 테이블에서 같은 컬럼을 가지고 조인 (cross join 중)
--non-equi join : 두 개의 테이블에 같은 컬럼 없이 조인 
create table scoreGrade(
grade char(1),
minscore number(3),
maxscore number(3)

);
insert into scoregrade values('F',0,59);
insert into scoregrade values('D',60,69);
insert into scoregrade values('C',70,79);
insert into scoregrade values('B',80,89);
insert into scoregrade values('A',90,100);

select * from scoregrade;
select * from stuscore;
--stuscore 테이블 avg 가지고 scoregrade테이블의 grade를 출력할 수 있게 구성


select sno,name,avg,grade 
from stuscore,scoregrade
where avg between minscore and maxscore
order by avg desc
;

select department_id,sum(salary) from employees
group by department_id;


생일
select trunc(to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy'),-1) tyear,count(*) 
from employees
group by trunc(to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy'),-1);


-- 부서별 평균월급을 출력하시오.

select department_id;

select * from departments;

select * from employees;


select a.department_id, department_name,round(avg(salary),2) from employees a, departments b
where a.department_id = b.department_id
group by a.department_id,department_name;


trunc() 로 버림해서 구함
28,17,15,30,45,49,37,35,32,12,19,27
10-19 10대
20-29 20대
30-39 30대
40-49 40대
50-59 50대


--inner join
--outer join