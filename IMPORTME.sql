-- esx
ALTER TABLE owned_vehicles ADD last_impounded TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp();
-- qb/qbx
ALTER TABLE player_vehicles ADD last_impounded TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp();