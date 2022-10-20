-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-20 10:47:47.805

-- tables
-- Table: Client
CREATE TABLE Client (
    client_id int  NOT NULL,
    name varchar(30)  NOT NULL,
    NIP char(10)  NOT NULL,
    address text  NOT NULL,
    CONSTRAINT Client_pk PRIMARY KEY (client_id)
);

-- Table: Date
CREATE TABLE Date (
    date_id int  NOT NULL,
    day int  NOT NULL,
    month int  NOT NULL,
    hour time  NOT NULL,
    CONSTRAINT Date_pk PRIMARY KEY (date_id)
);

-- Table: Fruit
CREATE TABLE Fruit (
    fruit_id int  NOT NULL,
    name varchar(30)  NOT NULL,
    price_kg money  NOT NULL,
    category varchar(30)  NOT NULL,
    CONSTRAINT Fruit_pk PRIMARY KEY (fruit_id)
);

-- Table: Order
CREATE TABLE "Order" (
    id int  NOT NULL,
    fruit_id int  NOT NULL,
    date_id int  NOT NULL,
    client_id int  NOT NULL,
    fruits_amount decimal(2,2)  NOT NULL,
    place_of_sale varchar(30)  NOT NULL,
    order_price money  NOT NULL,
    CONSTRAINT Order_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Order_Client (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Client
    FOREIGN KEY (client_id)
    REFERENCES Client (client_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Date (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Date
    FOREIGN KEY (date_id)
    REFERENCES Date (date_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Fruit (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Fruit
    FOREIGN KEY (fruit_id)
    REFERENCES Fruit (fruit_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

