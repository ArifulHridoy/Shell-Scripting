set serveroutput on;
declare

cursor emp is
select emp_id from employee where dept_id =3;

v_total number := 0;
v_id employee.emp_id%type;

begin

open emp;

loop
fetch emp into v_id;
exit when emp%notfound;
v_total := v_total + 1;
end loop;

dbms_output.put_line('Total Employees : ' || v_total);

close emp;
  end;
  /



  set serveroutput on;
  create or replace function getBudget(femp_id in employee.emp_id%type) return project.budget%type is
  v_budget project.budget%type;
  begin
    select budget into v_budget from project where emp_id = femp_id;
    return v_budget;
  end;
  /

  begin
    dbms_output.put_line('Budget of Employee 101: ' || getBudget(101));
  end;
  /


  set serveroutput on;
  create or replace procedure incSalary(femp_id in employee.emp_id%type, finc in number) is
  begin
    update employee set salary = (salary + finc) where emp_id = femp_id;
    commit;
  end;
  /

  declare
  v_before_salary employee.salary%type;
  v_after_salary employee.salary%type;

begin
  select salary into v_before_salary from employee where emp_id = 101;
  dbms_output.put_line('Salary before increment: ' || v_before_salary);
  incSalary(101, 5000);

  select salary into v_after_salary from employee where emp_id = 101;
  dbms_output.put_line('Salary after increment: ' || v_after_salary);
  end;
  /
  

  set serveroutput on;

  create or replace trigger updateEmp after update on employee
  for each row
  begin
  insert into EmployeeLog (log_id, emp_id, old_salary, new_salary, date_changed) values (:new.emp_id, :new.emp_id, :old.salary, :new.salary, sysdate);
  end;
  /
  

  set serveroutput on;

  declare

  type marks is varray(5) of number;
  v_marks marks := marks(85, 90, 78, 92, 88);

  v_max number;
  v_min number;
  v_sum number :=0;
  v_avg number;

  begin

    v_max := v_marks(1);
    v_min := v_marks(1);

  for i in 2..v_marks.count loop
    if (v_marks(i)>v_max) then
    v_max := v_marks(i);
    end if;

    if (v_marks(i)<v_min) then
    v_min := v_marks(i);
    end if;

    v_sum := v_sum+v_marks(i);
    end loop;
    dbms_output.put_line('Max marks : ' || v_max);
    dbms_output.put_line('Min marks : ' || v_min);
    dbms_output.put_line('Avg marks : ' || v_sum/v_marks.count);

end;
/


set serveroutput on;

create or replace type demo_Type as object
(
    fullname varchar2(100),
    bookcount number
);

create or replace function fun(f1 in authors.first_name%type) return demo_Type is
fullname varchar2(100);
famname varchar2(20);
bookcount number :=0;

begin
select family_name into famname from authors where first_name=f1;

fullname := f1 || ' ' || famname;

select count(*) into bookcount from books where
author1=(select id from authors where first_name=f1) or
author2=(select id from authors where first_name=f1) or
author3=(select id from authors where first_name=f1);

return demo_Type(fullname, bookcount);
end;
/

declare
result demo_Type;
begin
result := fun('Robert');
dbms_output.put_line('Full name : ' || result.fullname);
dbms_output.put_line('Total book : ' || result.bookcount);
end;
/

declare
type myarray is varray(5) of varchar2(25);
cursor mycursor is select pname from products;
name varchar(25);
arr myarray := myarray();

begin
open mycursor;

loop
fetch mycursor into name;
exit when mycursor%notfound;
arr.extend;
arr(arr.count) := name;
end loop;
close mycursor;
for i in 1..arr.count loop
dbms_output.put_line(arr(i));
end loop;
end;
/

DECLARE
    TYPE product_table IS TABLE OF VARCHAR2(25);
    products product_table := product_table('Mouse', 'Keyboard', 'Knife', 'Lays');
BEGIN
    products.DELETE(2);
    products.EXTEND;
    products(products.last) := 'Emni';
    FOR i IN 1..products.LAST LOOP
        IF products.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE(products(i));
        END IF;
    END LOOP;
END;
/
