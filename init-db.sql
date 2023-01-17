CREATE TABLE employee (
   id serial primary key,
   fname VARCHAR(32),
   lname VARCHAR(64),
   salary FLOAT,
   bdate DATE,
   department_id INT
);

CREATE TABLE department (
   id serial primary key,
   name VARCHAR (50)
);