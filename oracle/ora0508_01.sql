select * from employees;

select rownum,emp_name,manager_id from employees;

select rownum, a.* from employees a
order by emp_name
;

-- 테이블로 사용가능
(select * from employees order by emp_name)
select rownum, a.* from (select * from employees order by emp_name) a;

-이름에 a 들어가 있으면서 salary 4800 이상 manager_id 103
select * from (
select * from employees where emp_name like '%a%') where salary>=4800 and manager_id=103;


rownum 순차적인 번호를 매기는 함수
select rownum,a.* from member a order by id;

-- 순차적인 번호를 다시 매겨서 출력하시오.
select * from(select rownum rnum,a.* from (
select * from member order by id) a)
where rnum between 11 and 20
;


select * from (select rownum rnum, a.* from member a) where rnum between 11 and 20;


select row_number() over (order by id) rnum,a.*
from member a;

select rownum rnum,a.* from (select * from member order by id) a;



select * from stuscore;

-- dense_rank 
select rank() over (order by total desc),total from stuscore;
select dense_rank() over (order by total desc), total from stuscore;


select * from stuscore;

--alter table stuscore drop column grade;


--update stuscore set rank=0;


-- rank, sgrade 값에 맞게 입력하시오.
rank() over()
sgrade non-equi join을 해서 해당되는 값을 입력하시오.
- scoregrade 테이블 사용

update stuscore a
set rank = (select ranks from (select sno,rank() over (order by total desc) ranks from stuscore) b
where a.sno = b.sno);


select * from scoregrade;
select * from stuscore;


update stuscore a
set sgrade = (select grades
from (select sno,grade as grades from stuscore,scoregrade
where avg between minscore and maxscore) b
where a.sno = b.sno);

03~08월까지 출력하시오.
select mdate,substr(mdate,4,2) from member where substr(mdate,4,2) not between 03 and 08;
select mdate,substr(mdate,4,2) from member where substr(mdate,4,2) not in (3,4,5,6,7,8);

뒤에 있는 3글자를 출력하시오.
select substr(emp_name,1,3),substr(emp_name,-3) from employees;

공백 제거해 출력( replace 특정문자변경)
select replace(emp_name,' ','') from employees;

앞뒤공백제거
select trim('   aaa bbb ccc    ') from dual;


select rpad(phone,17,'*') from member;
desc member;



select rpad(substr(phone,1,8),12,'*') from member;

뒤에 1글자를 *로 표시해서 출력하시오.
select name from member;
select rpad(substr(name,1,length(name)-1),length(name),'*') from member;

select emp_name,rpad(substr(emp_name,1,length(emp_name)-2),length(emp_name),'*') from employees;
select id,rpad(substr(id,1,length(id)-2),length(id),'*') from member;

select id,pw from member;

select rpad('*',length(id),'*'), rpad(substr(pw,1,length(pw)-2),length(pw),'*') from member;


select substr(phone,1,4)||'***'||substr(phone,8) as phone from member;


select mdate,trunc(mdate,'mm'),last_day(mdate) from member;

select to_char(mdate,'yyyy-mm-dd hh24:mi:ss') from member;



select emp_name,department_id from employees;

select emp_name,department_id,
decode(department_id,
10,'총무기획부',
20,'마케팅',30,
'구매/생산부') 
as depart_name
from employees;



select mdate from member;
12,1,2 -> 겨울

select mdate,decode(substr(mdate,4,2),
01,'겨울',
02,'겨울',
03,'봄',
04,'봄',
05,'봄',
06,'여름',
07,'여름',
08,'여름',
09,'가을',
10,'가을',
11,'가을',
12,'겨울'
)as season from member;


select mdate,
case 
when substr(mdate,4,2) in('12','01','02') then '겨울'
when substr(mdate,4,2) in('03','04','05') then '봄'
when substr(mdate,4,2) in('06','07','08') then '여름'
when substr(mdate,4,2) in('09','10','11') then '가을'
end season 
from member;


select avg,
case
when avg>=90 then 'VVIP'
when avg>=80 then 'VIP'
when avg>=70 then 'Gold'
when avg>=60 then 'Silver'
when avg<60 then 'Bronze'
end P_Rank
from stuscore;

그룹함수의 조건문 입력하는 부분: having
select department_id,avg(salary) from employees
where department_id<=50
group by department_id
having avg(salary)>5000
;


부서이름을 출력하시오.
select emp_name,a.department_id,department_name,salary from employees a,departments b
where a.department_id = b.department_id and salary in (
select max(salary) from employees 
group by a.department_id
);

-- 부서별로 월급이 가장 높은 사원 출력(some,in 동일결과)
select employee_id,a.department_id,department_name,emp_name,salary from employees a, departments c
where salary = some (
select max(salary) from employees b
where a.department_id = b.department_id
group by department_id
) and a.department_id = c.department_id
;

select employee_id,a.department_id,department_name,emp_name,salary from employees a, departments c
where salary in (
select max(salary) from employees b
where a.department_id = b.department_id
group by department_id
) and a.department_id = c.department_id
;

select department_id,max(salary) from employees
group by department_id;

select * from stuscore;

alter table stuscore add sclass number(2) default 0;

-- 1-10 1반 / 11-20 2반 / ...
update stuscore 
set sclass = case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
when sno between 91 and 100 then 10
else 11
end
;


update stuscore set sclass = 1;

select * from stuscore2;

--
sclass 반별로 성적이 높은 학생들 출력
select sno,total,sclass from stuscore a
where total in (
select max(total) maxtotal from stuscore b
where a.sclass = b.sclass
group by sclass)
;


-- 각 반의 1등 출력


-- 각 반의 최하등수 출력

부서 12개
select distinct department_id from employees order by department_id;

select department_id from departments;

--employees 테이블에 없는 부서를 출력하시오.
select department_id,department_name from departments a
where not exists
(select department_id from employees b where a.department_id = b.department_id)

;

--member 테이블에 이름이 존재하는 stuscore 학생 성적을 출력

select * from stuscore a where exists (select name from member b where a.name=b.name) order by rank;


select * from employees where(department_id,salary) 
in (select department_id, max(salary) from employees  group by department_id);

-- 부서별 월급이 가장 높은 사원
select emp_name,salary,a.department_id from employees a,departments c
where salary in (
select max(salary) from employees b
where a.department_id = b.department_id
group by department_id)
and a.department_id = c.department_id
;






--alter table stuscore modify sclass number(3);


--update stuscore a set sclass = (select rnum from (select rownum rnum,sno from stuscore) b where a.sno = b.sno);

select sno,total,avg,sclass,
case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
when sno between 91 and 100 then 10
when sno between 100 and 110 then 11
end ssclass
from stuscore;

테이블 생성 및 데이터 복사
--create table stuscore3 as select * from stuscore;

테이블만 생성됨
--create table stuscore3 as select * from stuscore where 1=2;

--insert into stuscore3 (sno,kor) select sno,kor from stuscore;

select * from stuscore2;

drop table stuscore2;

drop table stuscore3;

create table stuscore2 as select * from stuscore;

update stuscore2 set sclass = 0;


select emp_name, department_id,max(salary) from employees
group by department_id order by department_id;
