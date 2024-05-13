// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: test.sql

package dbs

import (
	"context"
	"database/sql"
)

const addServiceStation = `-- name: AddServiceStation :exec
INSERT INTO service_station (address, city_id) VALUES (
$1, $2
)
`

type AddServiceStationParams struct {
	Address string
	CityID  sql.NullInt32
}

func (q *Queries) AddServiceStation(ctx context.Context, arg AddServiceStationParams) error {
	_, err := q.db.ExecContext(ctx, addServiceStation, arg.Address, arg.CityID)
	return err
}

const deleteOrderCascade = `-- name: DeleteOrderCascade :exec
DELETE FROM repair_order WHERE repair_id = $1
`

func (q *Queries) DeleteOrderCascade(ctx context.Context, repairID int32) error {
	_, err := q.db.ExecContext(ctx, deleteOrderCascade, repairID)
	return err
}

const deleteServiceStation = `-- name: DeleteServiceStation :exec
DELETE FROM service_station WHERE station_id = $1
`

func (q *Queries) DeleteServiceStation(ctx context.Context, stationID int32) error {
	_, err := q.db.ExecContext(ctx, deleteServiceStation, stationID)
	return err
}

const getInventoryByDetailId = `-- name: GetInventoryByDetailId :one
SELECT inventory_id, detail_id, quantity, service_station_id, created_at, updated_at FROM inventory WHERE detail_id = $1
`

func (q *Queries) GetInventoryByDetailId(ctx context.Context, detailID sql.NullInt32) (Inventory, error) {
	row := q.db.QueryRowContext(ctx, getInventoryByDetailId, detailID)
	var i Inventory
	err := row.Scan(
		&i.InventoryID,
		&i.DetailID,
		&i.Quantity,
		&i.ServiceStationID,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const getServicePriceById = `-- name: GetServicePriceById :one
SELECT price FROM service WHERE service_id = $1
`

func (q *Queries) GetServicePriceById(ctx context.Context, serviceID int32) (sql.NullString, error) {
	row := q.db.QueryRowContext(ctx, getServicePriceById, serviceID)
	var price sql.NullString
	err := row.Scan(&price)
	return price, err
}

const getServiceRepairByRepairIdAndServiceName = `-- name: GetServiceRepairByRepairIdAndServiceName :one
SELECT 
    sr.service_repairs_id
FROM
    public.service_repairs sr
LEFT JOIN public.service s ON sr.service_id = s.service_id
WHERE
    sr.repair_id = $1
    AND s.name = $2
ORDER BY
    sr.service_repairs_id
`

type GetServiceRepairByRepairIdAndServiceNameParams struct {
	RepairID    sql.NullInt32
	ServiceName string
}

func (q *Queries) GetServiceRepairByRepairIdAndServiceName(ctx context.Context, arg GetServiceRepairByRepairIdAndServiceNameParams) (int32, error) {
	row := q.db.QueryRowContext(ctx, getServiceRepairByRepairIdAndServiceName, arg.RepairID, arg.ServiceName)
	var service_repairs_id int32
	err := row.Scan(&service_repairs_id)
	return service_repairs_id, err
}

const getWorkersWithRoleAndStation = `-- name: GetWorkersWithRoleAndStation :many
SELECT
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    er.name AS role,
    ss.address AS service_station,
    ss.station_id AS service_station_id
FROM
    public.employee emp
LEFT JOIN public.employee_role er ON emp.role_id = er.role_id   
LEFT JOIN public.service_station ss ON emp.service_station_id = ss.station_id
WHERE
    er.name = $1
    AND ss.station_id = $2
ORDER BY
    emp.employee_id
`

type GetWorkersWithRoleAndStationParams struct {
	Role      string
	StationID int32
}

type GetWorkersWithRoleAndStationRow struct {
	EmployeeID       int32
	FirstName        string
	LastName         string
	Role             sql.NullString
	ServiceStation   sql.NullString
	ServiceStationID sql.NullInt32
}

func (q *Queries) GetWorkersWithRoleAndStation(ctx context.Context, arg GetWorkersWithRoleAndStationParams) ([]GetWorkersWithRoleAndStationRow, error) {
	rows, err := q.db.QueryContext(ctx, getWorkersWithRoleAndStation, arg.Role, arg.StationID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []GetWorkersWithRoleAndStationRow
	for rows.Next() {
		var i GetWorkersWithRoleAndStationRow
		if err := rows.Scan(
			&i.EmployeeID,
			&i.FirstName,
			&i.LastName,
			&i.Role,
			&i.ServiceStation,
			&i.ServiceStationID,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listCarClients = `-- name: ListCarClients :many
SELECT 
    cc.car_client_id,
    cc.car_id,
    cc.client_id,
    cc.description,
    cc.registration_number,
    cc.vin,
    cc.color,
    c.model,
    c.year,
    c.body_type,
    c.brand_id,
    b.name AS brand_name
FROM
    public.car_client cc
LEFT JOIN public.car c ON cc.car_id = c.car_id
LEFT JOIN public.brand b ON c.brand_id = b.brand_id
ORDER BY
    cc.car_client_id
`

type ListCarClientsRow struct {
	CarClientID        int32
	CarID              int32
	ClientID           int32
	Description        sql.NullString
	RegistrationNumber sql.NullString
	Vin                sql.NullString
	Color              sql.NullString
	Model              sql.NullString
	Year               sql.NullInt32
	BodyType           sql.NullString
	BrandID            sql.NullInt32
	BrandName          sql.NullString
}

func (q *Queries) ListCarClients(ctx context.Context) ([]ListCarClientsRow, error) {
	rows, err := q.db.QueryContext(ctx, listCarClients)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []ListCarClientsRow
	for rows.Next() {
		var i ListCarClientsRow
		if err := rows.Scan(
			&i.CarClientID,
			&i.CarID,
			&i.ClientID,
			&i.Description,
			&i.RegistrationNumber,
			&i.Vin,
			&i.Color,
			&i.Model,
			&i.Year,
			&i.BodyType,
			&i.BrandID,
			&i.BrandName,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listCars = `-- name: ListCars :many
SELECT 
    car.car_id,
    car.model,
    car.year,
    car.body_type,
    car.brand_id,
    br.name AS brand_name
FROM
    public.car car
LEFT JOIN public.brand br ON car.brand_id = br.brand_id
ORDER BY
    car.car_id
`

type ListCarsRow struct {
	CarID     int32
	Model     sql.NullString
	Year      sql.NullInt32
	BodyType  sql.NullString
	BrandID   sql.NullInt32
	BrandName sql.NullString
}

func (q *Queries) ListCars(ctx context.Context) ([]ListCarsRow, error) {
	rows, err := q.db.QueryContext(ctx, listCars)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []ListCarsRow
	for rows.Next() {
		var i ListCarsRow
		if err := rows.Scan(
			&i.CarID,
			&i.Model,
			&i.Year,
			&i.BodyType,
			&i.BrandID,
			&i.BrandName,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listCities = `-- name: ListCities :many
SELECT city_id, name, country_id, created_at, updated_at FROM city
`

func (q *Queries) ListCities(ctx context.Context) ([]City, error) {
	rows, err := q.db.QueryContext(ctx, listCities)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []City
	for rows.Next() {
		var i City
		if err := rows.Scan(
			&i.CityID,
			&i.Name,
			&i.CountryID,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listClients = `-- name: ListClients :many
SELECT client_id, first_name, last_name, phone_number, created_at, updated_at FROM client
`

func (q *Queries) ListClients(ctx context.Context) ([]Client, error) {
	rows, err := q.db.QueryContext(ctx, listClients)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Client
	for rows.Next() {
		var i Client
		if err := rows.Scan(
			&i.ClientID,
			&i.FirstName,
			&i.LastName,
			&i.PhoneNumber,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listDetails = `-- name: ListDetails :many
SELECT detail_id, description, manufacturer_id, detail_type_id, article, price, dimensions, weight, created_at, updated_at FROM detail
`

func (q *Queries) ListDetails(ctx context.Context) ([]Detail, error) {
	rows, err := q.db.QueryContext(ctx, listDetails)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Detail
	for rows.Next() {
		var i Detail
		if err := rows.Scan(
			&i.DetailID,
			&i.Description,
			&i.ManufacturerID,
			&i.DetailTypeID,
			&i.Article,
			&i.Price,
			&i.Dimensions,
			&i.Weight,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listEmployees = `-- name: ListEmployees :many
SELECT 
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    er.name AS role,
    ss.address AS service_station,
    ss.station_id AS service_station_id
FROM
    public.employee emp
LEFT JOIN public.employee_role er ON emp.role_id = er.role_id
LEFT JOIN public.service_station ss ON emp.service_station_id = ss.station_id

ORDER BY
    emp.employee_id
`

type ListEmployeesRow struct {
	EmployeeID       int32
	FirstName        string
	LastName         string
	Role             sql.NullString
	ServiceStation   sql.NullString
	ServiceStationID sql.NullInt32
}

func (q *Queries) ListEmployees(ctx context.Context) ([]ListEmployeesRow, error) {
	rows, err := q.db.QueryContext(ctx, listEmployees)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []ListEmployeesRow
	for rows.Next() {
		var i ListEmployeesRow
		if err := rows.Scan(
			&i.EmployeeID,
			&i.FirstName,
			&i.LastName,
			&i.Role,
			&i.ServiceStation,
			&i.ServiceStationID,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listEmployeesRoles = `-- name: ListEmployeesRoles :many
SELECT role_id, name, created_at, updated_at FROM employee_role
`

func (q *Queries) ListEmployeesRoles(ctx context.Context) ([]EmployeeRole, error) {
	rows, err := q.db.QueryContext(ctx, listEmployeesRoles)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []EmployeeRole
	for rows.Next() {
		var i EmployeeRole
		if err := rows.Scan(
			&i.RoleID,
			&i.Name,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listServiceStations = `-- name: ListServiceStations :many

SELECT station_id, address, service_station.city_id, service_station.created_at, service_station.updated_at, city.city_id, city.name, city.country_id, city.created_at, city.updated_at, country.country_id, country.name, country.created_at, country.updated_at FROM service_station
JOIN city ON service_station.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
`

type ListServiceStationsRow struct {
	StationID   int32
	Address     string
	CityID      sql.NullInt32
	CreatedAt   sql.NullTime
	UpdatedAt   sql.NullTime
	CityID_2    int32
	Name        string
	CountryID   sql.NullInt32
	CreatedAt_2 sql.NullTime
	UpdatedAt_2 sql.NullTime
	CountryID_2 int32
	Name_2      string
	CreatedAt_3 sql.NullTime
	UpdatedAt_3 sql.NullTime
}

// incclude sity and country
func (q *Queries) ListServiceStations(ctx context.Context) ([]ListServiceStationsRow, error) {
	rows, err := q.db.QueryContext(ctx, listServiceStations)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []ListServiceStationsRow
	for rows.Next() {
		var i ListServiceStationsRow
		if err := rows.Scan(
			&i.StationID,
			&i.Address,
			&i.CityID,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.CityID_2,
			&i.Name,
			&i.CountryID,
			&i.CreatedAt_2,
			&i.UpdatedAt_2,
			&i.CountryID_2,
			&i.Name_2,
			&i.CreatedAt_3,
			&i.UpdatedAt_3,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listServices = `-- name: ListServices :many
SELECT service_id, name, description, price, estimated_duration, created_at, updated_at FROM service
`

func (q *Queries) ListServices(ctx context.Context) ([]Service, error) {
	rows, err := q.db.QueryContext(ctx, listServices)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Service
	for rows.Next() {
		var i Service
		if err := rows.Scan(
			&i.ServiceID,
			&i.Name,
			&i.Description,
			&i.Price,
			&i.EstimatedDuration,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const listSuppliers = `-- name: ListSuppliers :many
SELECT supplier_id, name, city_id, phone_number, address, created_at, updated_at FROM supplier
`

func (q *Queries) ListSuppliers(ctx context.Context) ([]Supplier, error) {
	rows, err := q.db.QueryContext(ctx, listSuppliers)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Supplier
	for rows.Next() {
		var i Supplier
		if err := rows.Scan(
			&i.SupplierID,
			&i.Name,
			&i.CityID,
			&i.PhoneNumber,
			&i.Address,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const metaData = `-- name: MetaData :many
SELECT data_load_history_id, load_datetime, load_time, load_rows, affected_table_count, source_table_count from meta.dataloadhistory
`

func (q *Queries) MetaData(ctx context.Context) ([]MetaDataloadhistory, error) {
	rows, err := q.db.QueryContext(ctx, metaData)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []MetaDataloadhistory
	for rows.Next() {
		var i MetaDataloadhistory
		if err := rows.Scan(
			&i.DataLoadHistoryID,
			&i.LoadDatetime,
			&i.LoadTime,
			&i.LoadRows,
			&i.AffectedTableCount,
			&i.SourceTableCount,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const soreClient = `-- name: SoreClient :exec
INSERT INTO client (first_name, last_name, phone_number) VALUES (
    $1, $2, $3
)
`

type SoreClientParams struct {
	FirstName   string
	LastName    string
	PhoneNumber sql.NullString
}

func (q *Queries) SoreClient(ctx context.Context, arg SoreClientParams) error {
	_, err := q.db.ExecContext(ctx, soreClient, arg.FirstName, arg.LastName, arg.PhoneNumber)
	return err
}

const storeCarClient = `-- name: StoreCarClient :one
INSERT INTO car_client (car_id, client_id, description, registration_number, vin, color) VALUES (
    $1, $2, $3, $4, $5, $6
) RETURNING car_client_id
`

type StoreCarClientParams struct {
	CarID              int32
	ClientID           int32
	Description        sql.NullString
	RegistrationNumber sql.NullString
	Vin                sql.NullString
	Color              sql.NullString
}

func (q *Queries) StoreCarClient(ctx context.Context, arg StoreCarClientParams) (int32, error) {
	row := q.db.QueryRowContext(ctx, storeCarClient,
		arg.CarID,
		arg.ClientID,
		arg.Description,
		arg.RegistrationNumber,
		arg.Vin,
		arg.Color,
	)
	var car_client_id int32
	err := row.Scan(&car_client_id)
	return car_client_id, err
}

const storeOrder = `-- name: StoreOrder :exec
INSERT INTO repair_order (employee_id, start_date, repair_status_id, notes, repair_number, payment_status_id, car_client_id, total_sum) VALUES (
    $1, $2, $3, $4, $5, $6, $7, $8
)
`

type StoreOrderParams struct {
	EmployeeID      sql.NullInt32
	StartDate       sql.NullTime
	RepairStatusID  sql.NullInt32
	Notes           sql.NullString
	RepairNumber    sql.NullString
	PaymentStatusID sql.NullInt32
	CarClientID     sql.NullInt32
	TotalSum        sql.NullString
}

func (q *Queries) StoreOrder(ctx context.Context, arg StoreOrderParams) error {
	_, err := q.db.ExecContext(ctx, storeOrder,
		arg.EmployeeID,
		arg.StartDate,
		arg.RepairStatusID,
		arg.Notes,
		arg.RepairNumber,
		arg.PaymentStatusID,
		arg.CarClientID,
		arg.TotalSum,
	)
	return err
}

const storeServiceInventory = `-- name: StoreServiceInventory :exec
INSERT INTO service_inventory (service_repair_id, inventory_id, amount) VALUES (
    $1, $2, $3
)
`

type StoreServiceInventoryParams struct {
	ServiceRepairID sql.NullInt32
	InventoryID     sql.NullInt32
	Amount          sql.NullString
}

func (q *Queries) StoreServiceInventory(ctx context.Context, arg StoreServiceInventoryParams) error {
	_, err := q.db.ExecContext(ctx, storeServiceInventory, arg.ServiceRepairID, arg.InventoryID, arg.Amount)
	return err
}

const storeServiceRepair = `-- name: StoreServiceRepair :exec
INSERT INTO service_repairs (service_id, repair_id, quantity, completion_date, service_total_price) VALUES (
    $1, $2, $3, $4, $5
)
`

type StoreServiceRepairParams struct {
	ServiceID         sql.NullInt32
	RepairID          sql.NullInt32
	Quantity          sql.NullInt32
	CompletionDate    sql.NullTime
	ServiceTotalPrice sql.NullString
}

func (q *Queries) StoreServiceRepair(ctx context.Context, arg StoreServiceRepairParams) error {
	_, err := q.db.ExecContext(ctx, storeServiceRepair,
		arg.ServiceID,
		arg.RepairID,
		arg.Quantity,
		arg.CompletionDate,
		arg.ServiceTotalPrice,
	)
	return err
}

const updateServiceStation = `-- name: UpdateServiceStation :exec
UPDATE service_station SET address = $1, city_id = $2 WHERE station_id = $3
`

type UpdateServiceStationParams struct {
	Address   string
	CityID    sql.NullInt32
	StationID int32
}

func (q *Queries) UpdateServiceStation(ctx context.Context, arg UpdateServiceStationParams) error {
	_, err := q.db.ExecContext(ctx, updateServiceStation, arg.Address, arg.CityID, arg.StationID)
	return err
}