# **Final Project**

This repository contains all components of my final project, designed and built as part of the Data Engineering course at Cívica Software.

## **Project Description**

### **Technologies Used**

1. **Fivetran:** for data extraction and ingestion.
2. **Snowflake:** as the Data Warehouse where I will host our databases divided into three zones or layers:
    - Bronze
    - Silver
    - Gold
3. **dbt:** for data transformations and modeling, I used version 1.6 with the following dbt packages:
    - package: dbt-labs/dbt_utils version: 1.1.1
    - package: dbt-labs/codegen version: 0.11.0
    - package: calogica/dbt_expectations version: 0.10.1
    - package: dbt-labs/dbt_project_evaluator version: 0.8.0

### **Main Objective**

The main objectives of the project are:

1. Document and add tests to the tables existing in our Bronze zone.
2. Generate a Silver zone with reusable models and unified concepts.
3. Document and add tests to the Silver zone.
4. Generate a Gold zone based on a dimensional model that can be exploited by analytical tools. It should be composed of at least the following models:
    - Users
    - Addresses
    - Promos
    - Orders
5. Document and add tests to the models in the Gold zone.

### 2. **Secondary Objectives**

Once the main objective of the project is met, the creation of a system capable of generating or simulating incremental data ingestion and the application of incremental transformations to feed the Gold layer will be valued.

Additionally, the use of tables beyond those mentioned in the main objective and the enrichment of the model will be valued.

## **Project Structure in dbt**

- `seeds/` - Contains a CSV with new products that I have added as a simulation of ingestion.
- `models/` - Contains all .yml and .sql files equivalent to the Bronze, Silver, and Gold zones of Snowflake, divided into two folders.
    - `staging/` - Contains the Bronze and Silver zones of Snowflake, divided into three folders, each indicating the source of data extraction and the name of the schema in Snowflake.
        - `bronze/` - Each of the three folders contains a src_ or source, the raw data with which I will start building the dbt models. The sources are defined in a source.yml file where the database and schema where dbt will find these source tables are defined. It also includes testing and documentation.
        - `silver/` - Except for the seed_data folder, the other two folders contain one or several stg_ or stage, the goal of the stage models is to create data sources ready to be used by the rest of the models I will create. These perform very light transformations, such as casting, renaming, date conversion to the same timezone, unit conversion, filtering erroneous data or deleted records. The stage is also the place where we can apply any type of transformation to remove sensitive information. It also contains a stg.yml in the necessary folders with documentation and testing.
    - `marts/` - Contains the Gold zone of Snowflake, divided into 4 folders.
        - `gold/` - The core folder houses the dimensional model with its dim_ or dimensions and its fct_ or facts tables optimized for analytical tools, it also contains a .yml with documentation and testing and the other three are use cases for different departments with my already modeled data.


### Use Cases

#### Marketing:
- **User Purchase Analysis**: Develop a detailed query to provide the product team with an in-depth analysis of user purchases. This includes comprehensive user information, total number of orders, total expenditure, detailed shipping costs, discounts received, and specifics of products purchased.

#### Product:
- **User Session Analysis**: Offers insightful analysis into each user session for the product team, including session duration, number of pages viewed, and specific events such as 'add_to_cart', 'checkout', and 'package_shipped'.

#### Sales:
- **Sales Analysis by Product and Year**: Provides the sales team with crucial data on each product, encompassing total sales, units sold and returned, a detailed comparison with budgeted figures, and the ranking of top-selling products by year.


### **Contact**
Email: enriquehervasguerrero@gmail.com
LinkedIn: https://www.linkedin.com/in/enrique-hervas-guerrero/


### **Acknowledgements**
I would like to express my gratitude to Cívica Software for giving me the opportunity to participate in this course, and to all the teachers for their kindness, understanding, and the good humor they brought to the classes.
