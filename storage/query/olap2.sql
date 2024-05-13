-- name: GetCubeSupply :many
select
sd.supply_details_fact_id,
  sd.detail_dim_id AS "Detail ID",
  sd.detail_quantity AS "Detail Quantity",
  sd.detail_total_cost AS "Detail Total Cost",
  sd.start_date_dim_id AS "Start Date ID",
  sd.end_date_dim_id AS "End Date ID",
  inv.inventory_dim_id AS "Inventory Detail ID",
  inv.description AS "Inventory Description",
  inv.article AS "Article",
  inv.price AS "Price",
  inv.dimensions AS "Dimensions",
  inv.weight AS "Weight",
  supp.supplier_dim_id AS "Supplier ID",
  supp.name AS "Supplier Name",
  supp.phone_number AS "Supplier Phone Number",
  supp.address AS "Supplier Address",
  d.date_id AS "Date Start ID",
  dd.date_id as "Sate End ID",
  d.year AS "Start Year",
  d.month AS "Start Month",
  d.day AS "Start Day",
  dd."day" as "End Day",
  dd."month" as "End Month",
  dd."year" as "End Year"
FROM 
  storage.supply_details_fact sd
JOIN storage.inventory_dim inv
  ON sd.detail_dim_id = inv.inventory_dim_id
JOIN storage.supplier_dim supp
  ON sd.supplier_id = supp.supplier_dim_id
JOIN storage.date_dim d
  ON sd.start_date_dim_id = d.date_id
 JOIN storage.date_dim dd
  ON sd.end_date_dim_id  = dd.date_id
ORDER BY sd.detail_dim_id;
