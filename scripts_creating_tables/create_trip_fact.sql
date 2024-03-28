
BEGIN 
    DROP TABLE trip_fact
End;

GO

CREATE TABLE trip_fact(
    trip_id VARCHAR(50),
    rideable_type VARCHAR(50),
    start_at DATE,
    ended_at DATE,
    start_station_id VARCHAR(255),
    end_station_id VARCHAR(255),
    rider_id INT
)

INSERT INTO trip_fact(trip_id, rideable_type, start_at, ended_at, start_station_id, end_station_id, rider_id)
SELECT 
    t.trip_id as trip_id, 
    t.rideable_type as rideable_type,
    Convert(Datetime, SUBSTRING(t.start_at,1,19),120) as start_at,
    Convert(Datetime, SUBSTRING(t.ended_at,1,19),120) as ended_at,
    t.start_station_id as start_station_id,
    t.end_station_id as end_station_id,
    t.rider_id as rider_id
FROM staging_trip as t 
JOIN staging_rider as r ON (t.rider_id = r.rider_id)

GO

Select top 10 * from trip_fact