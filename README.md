# **Final Project**

Este repositorio contiene todos los componentes de mi proyecto final, diseñado y construido como parte de curso data engineering en Cívica Software.

## **Descripción del Proyecto**

### Tecnologías usadas

1. **Fivetran:** para extracción e ingestas de los datos
2. **Snowflake:** como data Warehouse donde alojaremos nuestras bases de datos divididas en tres zonas o bases:
    - Bronze
    - Silver
    - Gold
3. **dbt:** para hacer las trasformaciones y modelado de nuestros datos, he utilizado su version 1.6 con los siguientes paquetes de dbt:
    - package: dbt-labs/dbt_utils version: 1.1.1
    - package: dbt-labs/codegen version: 0.11.0
    - package: calogica/dbt_expectations version: 0.10.1
    - package: dbt-labs/dbt_project_evaluator version: 0.8.0


### Objetivo principal

Los objetivos principales del proyecto son:

1. Documentar y añadir test a las tablas que existen en nuestra zona Bronze.
2. Generar una zona silver con modelos reutilizables y conceptos unificados. 
3. Documentar y añadir test a la zona Silver.
4. Generar una zona Gold basada en un modelo dimensional que sea explotable por herramientas analíticas. Este debe estar compuesto por al menos los siguientes modelos:
    - Users
    - Addresses
    - Promos
    - Orders
5. Documentar y añadir test a los modelos de la zona Gold.

### 2. Objetivos secundarios

Una vez se ha cumplido con el objetivo principal del proyecto, se valorará la creación de un sistema que sea capaz de generar o similar la ingesta incremental de datos y la aplicación de las transformaciones incrementales para alimentar la capa Gold.

Además, se valorará el uso de tablas adicionales a las que se han comentado en el objetivo principal y el enriquecimiento del modelo.

## Estructura del proyecto en dbt

- `seeds/` - Contiene un csv con nuevos productos que he añadido a modo de simulación de ingesta.
- `staging/` - Contiene la zona bronze y la zona silver, esta dividido en tres carpetas, cada carpeta indica con su nombre la fuente de donde se realizo la extracción de los datos y el nombre del esquema en Snowflake.
    - `bronze/` - Cada una de las tres carpetas contiene un source, los sources son los datos brutos con los que empezaré a construir los modelos de dbt. Los sources se definen en un archivo source.yml donde se define la base de datos y el esquema dónde dbt encontrará estas tablas de origen. Además del testing y la documentación.
- `gold/` - Alberga el modelo dimensional optimizado para herramientas analíticas.


