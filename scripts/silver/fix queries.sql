insert into silver.crm_cust_info(
cst_id      ,
cst_key     ,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date)
select 
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname,
trim(cst_lastname) as cst_lasttname,
case
  when trim(upper(cst_marital_status)) = 'S' then 'Single'
  when trim(upper(cst_marital_status)) = 'M' then 'Married'
else 'n/a'
end as cst_marital_status,
case
  when trim(upper(cst_gndr)) = 'M' then 'Male'
  when trim(upper(cst_gndr)) = 'F' then 'Female'
else 'n/a'
end as cst_gndr,
cst_create_date
from(select*,
row_number() over(
partition by cst_id
order by cst_create_date Desc) as flag_last
from bronze.crm_cust_info) as t
where flag_last = 1 and cst_id is not null;
