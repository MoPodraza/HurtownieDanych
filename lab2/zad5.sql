-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-19 19:23:31.045

-- tables
-- Table: Employee
CREATE TABLE Employee (
    emplyee_id int  NOT NULL,
    PESEL char(11)  NOT NULL,
    address text  NOT NULL,
    salary money  NOT NULL,
    History_id int  NOT NULL,
    CONSTRAINT Employee_pk PRIMARY KEY (emplyee_id)
);

-- Table: History
CREATE TABLE History (
    id int  NOT NULL,
    grade int  NOT NULL,
    date date  NOT NULL,
    CONSTRAINT History_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Employee_History (table: Employee)
ALTER TABLE Employee ADD CONSTRAINT Employee_History
    FOREIGN KEY (History_id)
    REFERENCES History (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

