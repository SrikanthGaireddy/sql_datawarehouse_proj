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
