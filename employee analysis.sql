

--1.A list showing employee number, last name, first name, sex, and salary for each employee
	select distinct e.emp_no,last_name,first_name,sex,salary from employees e 
	left outer join salaries s on e.emp_no = s.emp_no limit 10;

--2. A list showing first name, last name, and hire date for employees who were hired in 1986.

	select  first_name,last_name,hire_date from employees
	where hire_date like '%1986'
	order by hire_date;
	
--3. A list showing the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
	select  dm.dept_no,dept_name,dm.emp_no,first_name,last_name 
	from dept_managers dm  left outer join departments d on dm.dept_no=d.dept_no 
	left outer join employees e on dm.emp_no = e.emp_no;

--4. A list showing the department of each employee with the following information: employee number, last name, first name, and department name.
	select e.emp_no,first_name,last_name,dept_name from employees e 
	join dept_emp de on e.emp_no=de.emp_no 
	join departments d on de.dept_no=d.dept_no;

--5. A list showing first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B.“ 

	select first_name,last_name,sex  from employees 
	where first_name like ‘Hercules’ and last_name like ’B%’;
	
--6. A list showing all employees in the Sales department, including their employee number, last name, first name, and department name. 
	select emp_no,first_name,last_name,dept_name from employees e join dept_emp de on e.emp_no=de.emp_no join departments d on de.dept_no=d.dept_no
	where dept_name = ‘Sales’;
	
--7. A list showing all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
	select emp_no,first_name,last_name,dept_name from employees e join dept_emp de on e.emp_no=de.emp_no join departments d on de.dept_no=d.dept_no
	where dept_name in  [‘Sales’,’development’];
	
--8. A list showing the frequency count of employee last names, in descending order. ( i.e., how many employees share each last name 
	Select emp_no,last_name, count(last_name) as frequency from employees
	group by emp_no,last_name 
	order by frequency desc;
	
--9.  Histogram to show the salary distribution among the employees
	select count(e.emp_no) as cnt,avg(salary) as average,min(salary) as min,max(salary) as max
	from employees e join salaries s on e.emp_no = s.emp_no;

--10. Bar graph to show the Average salary per title
	select title,avg(salary) as avg_salary from employees e 
	join titles t on e.emp_titles_id = t.title_id
	join salaries s on s.emp_no = e.emp_no
	group by title;
	
--11. list the salary distribution by gender
	select sex,salary from employees e join salaries s on e.emp_no = s.emp_noselect sex, count(salary)/sum(salary) as pct from employees e join salaries s on e.emp_no = s.emp_no
	by sex;
	
--12. list the salary distribution by departtments
	select dept_name,count(salary)/sum(salary) as pct from employees e join salaries s on e.emp_no = s.emp_no
	join dept_emp de on de.emp_no = e.emp_no 
	join departments d on d.dept_no = de.dept_no
	group by dept_name;
	
--13. Performance rating distribution
	select  e.emp_no,first_name,last_name,dept_name,
	case 
	when last_performance_rating = 'S' then 'Excellent'
	when last_performance_rating = 'PIP' then 'Poor'
	else 'Good'
	end as Employee_rating from employees e join dept_emp de on e.emp_no = de.emp_no
	join departments d on d.dept_no = de.dept_no
	order by Employee_rating;
	
--14. list the employee full name with employee number,job title,department name and salary
	select e.emp_no,concat(first_name,' ',last_name) as emp_name,dept_name,salary from employees e 
	join titles t on e.emp_titles_id = t.title_id
	join dept_emp de on de.emp_no = e.emp_no
	join salaries s on s.emp_no = e.emp_no
	join departments d on d.dept_no = de.dept_no;
	
--15. list the employees who left organisation
	select emp_no,first_name,last_name,left_organisation,last_date from employees
	where left_organisation = 1

--16. list the employees whose last_name starting with 'ANGEL'
	select emp_no,first_name,last_name,sex from employees 
    where last_name like 'Angel%'