-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-19 19:39:57.402

-- tables
-- Table: Date
CREATE TABLE Date (
    date_id int  NOT NULL,
    date date  NOT NULL,
    CONSTRAINT Date_pk PRIMARY KEY (date_id)
);

-- Table: Product
CREATE TABLE Product (
    product_id int  NOT NULL,
    name varchar(30)  NOT NULL,
    quantity_available int  NOT NULL,
    brand varchar(30)  NOT NULL,
    CONSTRAINT Product_pk PRIMARY KEY (product_id)
);

-- Table: Warehouse
CREATE TABLE Warehouse (
    id int  NOT NULL,
    address text  NOT NULL,
    country varchar(30)  NOT NULL,
    CONSTRAINT Warehouse_pk PRIMARY KEY (id)
);

-- Table: WarehouseState
CREATE TABLE WarehouseState (
    state_id int  NOT NULL,
    Warehouse_id int  NOT NULL,
    Date_date_id int  NOT NULL,
    Product_product_id int  NOT NULL,
    CONSTRAINT WarehouseState_pk PRIMARY KEY (state_id)
);

-- foreign keys
-- Reference: WarehouseState_Date (table: WarehouseState)
ALTER TABLE WarehouseState ADD CONSTRAINT WarehouseState_Date
    FOREIGN KEY (Date_date_id)
    REFERENCES Date (date_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: WarehouseState_Product (table: WarehouseState)
ALTER TABLE WarehouseState ADD CONSTRAINT WarehouseState_Product
    FOREIGN KEY (Product_product_id)
    REFERENCES Product (product_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: WarehouseState_Warehouse (table: WarehouseState)
ALTER TABLE WarehouseState ADD CONSTRAINT WarehouseState_Warehouse
    FOREIGN KEY (Warehouse_id)
    REFERENCES Warehouse (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

