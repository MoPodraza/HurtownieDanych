-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-20 09:34:12.215

-- tables
-- Table: Client
CREATE TABLE Client (
    client_id int  NOT NULL,
    name varchar(30)  NOT NULL,
    last_name varchar(30)  NOT NULL,
    address text  NOT NULL,
    phone_number char(10)  NOT NULL,
    CONSTRAINT Client_pk PRIMARY KEY (client_id)
);

-- Table: Order
CREATE TABLE "Order" (
    id int  NOT NULL,
    date date  NOT NULL,
    product_id int  NOT NULL,
    supplier_id int  NOT NULL,
    client_id int  NOT NULL,
    CONSTRAINT Order_pk PRIMARY KEY (id)
);

-- Table: Product
CREATE TABLE Product (
    product_id int  NOT NULL,
    ISBN bigint  NOT NULL,
    title varchar(30)  NOT NULL,
    author varchar(30)  NOT NULL,
    number_of_pages int  NOT NULL,
    publisher varchar(30)  NOT NULL,
    CONSTRAINT Product_pk PRIMARY KEY (product_id)
);

-- Table: Supplier
CREATE TABLE Supplier (
    supplier_id int  NOT NULL,
    NIP int  NOT NULL,
    address text  NOT NULL,
    name varchar(30)  NOT NULL,
    CONSTRAINT Supplier_pk PRIMARY KEY (supplier_id)
);

-- foreign keys
-- Reference: Order_Client (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Client
    FOREIGN KEY (client_id)
    REFERENCES Client (client_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Product (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Product
    FOREIGN KEY (product_id)
    REFERENCES Product (product_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Supplier (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Supplier
    FOREIGN KEY (supplier_id)
    REFERENCES Supplier (supplier_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

