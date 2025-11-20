/*Author: Marie Choualeu Tiaha*/
/*Q1*/
USE ap;
SELECT 
      vendor_name,
      CONCAT('INV-' ,invoice_number) AS "invoice info",
      invoice_total, 
      invoice_date, 
      invoice_due_date 
FROM vendors
INNER JOIN invoices
ON vendors.vendor_id = invoices.vendor_id
WHERE invoice_date <= '2022-07-05'
ORDER BY vendor_name; 