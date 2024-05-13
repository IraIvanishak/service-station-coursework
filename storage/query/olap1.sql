-- name: GetCubeServiceInventory :many
SELECT 
    sif.service_inventory_fact_id AS service_inventory_fact_id,
    sif.parts_cost AS parts_cost,
    sif.total_cost AS total_cost,
    sif.parts_cost_percentage AS parts_cost_percentage,
    sif.estimated_service_duration AS estimated_service_duration,
    sif.actual_service_duration AS actual_service_duration,
    sif.service_duration_deviation AS service_duration_deviation,
    sif.amount AS inventory_amount,
    srd.service_repair_dim_id AS service_repair_dim_id,
    srd.service_id AS service_id,
    srd.repair_id AS repair_id,
    srd.quantity AS service_quantity,
    srd.service_total_price AS service_total_price,
    sd.name AS service_name,    
    sd.description AS service_description,
    sd.price AS service_price,
    sd.estimated_duration AS service_estimated_duration,
    r.notes AS repair_notes,
    r.repair_number AS repair_number,
    id.inventory_dim_id AS inventory_dim_id,
    id.bk_detail_id AS inventory_bk_detail_id,
    id.description AS inventory_description,
    id.article AS inventory_article,
    id.price AS inventory_price,
    id.dimensions AS inventory_dimensions,
    id.weight AS inventory_weight
FROM 
    storage.service_inventory_fact sif
    JOIN storage.service_repair_dim srd ON sif.service_repair_dim_id = srd.service_repair_dim_id
    JOIN storage.service_dim sd ON srd.service_id = sd.service_dim_id 
    JOIN storage.repair_dim r ON srd.repair_id = r.repair_dim_id
    JOIN storage.inventory_dim id ON sif.inventory_dim_id = id.inventory_dim_id;