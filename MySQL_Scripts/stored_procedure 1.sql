CREATE DEFINER=`root`@`localhost` PROCEDURE `get_invoice`()
BEGIN
   SELECT *
   FROM invoices
   WHERE date > '2022-02-15';
END