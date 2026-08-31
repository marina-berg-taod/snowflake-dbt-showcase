-- ============================================================================
-- Schritt 2: Quelländerungen simulieren
-- ============================================================================
-- Führe dieses Skript aus, NACHDEM die Snapshots mindestens einmal gelaufen
-- sind (dbt snapshot). Anschließend erneut dbt snapshot ausführen, um die
-- Historisierung der Änderungen zu sehen.
-- ============================================================================

USE DATABASE tasty_bytes_dbt_db;
USE SCHEMA RAW;

-- -------------------------------------------------------------------------
-- 2.1 TIMESTAMP-STRATEGIE: Änderung an CUSTOMER_LOYALTY
--     Der Snapshot erkennt die Änderung anhand der neuen updated_at-Zeit.
-- -------------------------------------------------------------------------
UPDATE CUSTOMER_LOYALTY
SET
    favourite_brand = 'Tasty Bytes Vegan'
  , updated_at      = CURRENT_TIMESTAMP()
WHERE customer_id = 1;

-- -------------------------------------------------------------------------
-- 2.2 TIMESTAMP-STRATEGIE: Änderung an COUNTRY / CITY Population
-- -------------------------------------------------------------------------
UPDATE COUNTRY
SET
    city_population = city_population + 1000
  , updated_at      = CURRENT_TIMESTAMP()
WHERE country_id = 1;

-- -------------------------------------------------------------------------
-- 2.3 CHECK-STRATEGIE: Änderung an TRUCK (überwachte Spalten: primary_city,
--     region, ev_flag). Der Snapshot erkennt die Änderung auch ohne updated_at.
-- -------------------------------------------------------------------------
UPDATE TRUCK
SET primary_city = 'Updated City'
WHERE truck_id = 1;

-- -------------------------------------------------------------------------
-- 2.4 CHECK-STRATEGIE: Änderung an ORDER_HEADER (überwachte Spalten:
--     order_channel, order_amount, order_total)
-- -------------------------------------------------------------------------
UPDATE ORDER_HEADER
SET
    order_total  = order_total + 10
  , order_amount = order_amount + 10
WHERE order_id = 1;

-- -------------------------------------------------------------------------
-- 2.5 CHECK-STRATEGIE: Änderung an ORDER_DETAIL (check_cols: all)
-- -------------------------------------------------------------------------
UPDATE ORDER_DETAIL
SET quantity = quantity + 1
WHERE order_detail_id = 1;
