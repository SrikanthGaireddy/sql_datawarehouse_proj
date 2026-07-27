-- Querys test cases silver.crm_cust_info

-- let checks the unwanted spaces for Firstname, lastname and gender

select cst_firstname from silver.crm_cust_info
where cst_firstname != trim(cst_firstname);

select cst_lastname from silver.crm_cust_info
where cst_lastname != trim(cst_lastname);

select cst_gndr from silver.crm_cust_info
where cst_gndr != trim(cst_gndr);


-- let check the values in gender columns
select distinct cst_gndr from silver.crm_cust_info;


-- marital_status replace names married or single
select distinct cst_marital_status from silver.crm_cust_info;




--- checking if prd_id has any null or duplicates
SELECT prd_id,
count(*) as prd_id_count from bronze.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null;


SELECT *,
REPLACE( SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,len(prd_key)) as cat_id
FROM bronze.crm_prd_info;


-- Check if prd_nm has any unwanted spaces
SELECT prd_nm
from bronze.crm_prd_info
where prd_nm != Trim(prd_nm);


--
select *, 
REPLACE( SUBSTRING(prd_key,1,5),'-','_') as cat_id, 
SUBSTRING(prd_key,7,len(prd_key)) as cat_id , 
ISNULL(prd_cost,0 ) as prd_cost_values, 
CASE when UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain' 
when UPPER(TRIM(prd_line)) = 'R' THEN 'Road' 
when UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales' 
when UPPER(TRIM(prd_line)) = 'T' THEN 'Touring' 
else 'n/a' end as prd_line from bronze.crm_prd_info;




-- Lets check if the start date is less than end date
SELECT * from bronze.crm_prd_info
where prd_end_dt < prd_start_dt ;


-- Replace PRD_COST with 0

SELECT prd_id,
prd_nm,
REPLACE( SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,len(prd_key)) as prd_id ,
ISNULL(prd_cost,0 ) as prd_cost_values,
CASE
 when UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
 when UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
 when UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
 when UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
 else 'n/a'
END AS prd_line,
cast(prd_start_dt as date) as prd_start_dt,
CAST(lead(prd_start_dt) OVER(PARTITION BY prd_key order by prd_start_dt) - 1 as DATE)
AS PRD_END_DATE
FROM bronze.crm_prd_info;

