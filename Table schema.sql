

---creating mysql tables

create table titles(
title_id varchar(10) Not Null,
title varchar(30) Not Null,
primary key (title_id)
);

create table employees(
emp_no Int,
emp_titles_id varchar(30),
birth_date varchar(10),
first_name varchar(70),
last_name varchar(70),
sex varchar(20),
hire_date varchar(10),
no_of_projects Int,
Last_performance_rating varchar(40),
left_organisation boolean,
Last_date varchar(10),
primary key (emp_no)
);


create table departments(
dept_no varchar(10) Not Null,
dept_name varchar(30) Not Null,
primary key (dept_no)
);

create table dept_emp(
emp_no int Not Null,
dept_no varchar(10) Not Null
);


create table dept_managers(
dept_no varchar(10) Not Null,
emp_no int Not Null
);


create table salaries(
emp_no int Not Null,
salary int Not Null
);

--Loading data to tables 

LOAD DATA LOCAL INFILE '/home/anabig114235/titles.csv'
INTO TABLE titles
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/anabig114235/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/anabig114235/departments.csv'
INTO TABLE departments
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/anabig114235/dept_emp.csv'
INTO TABLE dept_emp
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/anabig114235/dept_manager.csv'
INTO TABLE dept_managers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS

LOAD DATA LOCAL INFILE '/home/anabig114235/salaries.csv'
INTO TABLE salaries
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


---Transfering files from mysql to hdfs

sqoop import-all-tables  --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114235 --username anabig114235 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --warehouse-dir=/user/anabig114235/hive/warehouse --m 1 --driver com.mysql.jdbc.Driver 

hdfs dfs -put /home/anabig114235/*avsc /user/anabig114235/employee_details

---creating Hive Tables

CREATE EXTERNAL TABLE employees 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
location "/user/anabig114235/hive/warehouse/employees" 
TBLPROPERTIES ('avro.schema.url'='/user/anabig114235/employee_details/employees.avsc');

CREATE EXTERNAL TABLE titles 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
location "/user/anabig114235/hive/warehouse/titles" 
TBLPROPERTIES ('avro.schema.url'='/user/anabig114235/employee_details/titles.avsc');

CREATE EXTERNAL TABLE departments 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
location "/user/anabig114235/hive/warehouse/departments" 
TBLPROPERTIES ('avro.schema.url'='/user/anabig114235/employee_details/departments.avsc');

CREATE EXTERNAL TABLE dept_emp 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
location "/user/anabig114235/hive/warehouse/dept_emp" 
TBLPROPERTIES ('avro.schema.url'='/user/anabig114235/employee_details/dept_emp.avsc');

CREATE EXTERNAL TABLE dept_managers 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
location "/user/anabig114235/hive/warehouse/dept_managers" 
TBLPROPERTIES ('avro.schema.url'='/user/anabig114235/employee_details/dept_managers.avsc');

CREATE EXTERNAL TABLE salaries 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
location "/user/anabig114235/hive/warehouse/salaries" 
TBLPROPERTIES ('avro.schema.url'='/user/anabig114235/employee_details/salaries.avsc');








