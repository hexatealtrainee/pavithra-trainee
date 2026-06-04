SELECT sale_id, patient_id, drug_name, drug_category, quantity, unit_price, total_amount, sale_date, payment_mode, pharmacist_id, branch
FROM public.pharmacy_sales;

--total revenue
select sum(total_amount) as total_revenue from pharmacy_sales;

--revenue by category and branch
select drug_category as category,branch as branch_name, sum(total_amount) as total_revenue from pharmacy_sales
group by drug_category, branch order by total_revenue desc;

--top payment mode
select payment_mode,count(*) as total_count from pharmacy_sales group by payment_mode order by total_count desc;



-- Overall Pharmacy Summary
-- total revenue and top paymode with count

select(
select sum(total_amount)from pharmacy_sales
) as total_revenue,
(
select payment_mode from pharmacy_sales group by payment_mode order by count(*) desc limit 1
)as top_payment_mode,
(
select count(*) from pharmacy_sales group by payment_mode order by count(*) desc limit 1
)as top_payment_count;

-- Revenue by category and branch

select drug_category as category,branch as branch_name, sum(total_amount) as total_revenue from pharmacy_sales
group by drug_category, branch order by total_revenue desc;

