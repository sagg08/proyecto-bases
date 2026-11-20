-- =====================================================================
-- 00_run_all.sql · Crea TODO desde una base vacía, en orden.
--
-- Opción A (recomendada):  npm run db:setup
--   (scripts/db-setup.js lee esta lista y ejecuta cada archivo)
-- Opción B, cliente mysql desde la raíz del repo:
--   mysql -u root -p < db/00_run_all.sql
--
-- Cada integrante agrega aquí la línea SOURCE de su archivo, en su lugar.
-- El orden importa: tablas → triggers → datos → funciones → procedimientos.
-- =====================================================================
SOURCE db/01_ddl.sql;
SOURCE db/02_triggers.sql;
SOURCE db/03_seed_clientes.sql;     -- P1: 50 clientes con teléfonos
-- SOURCE db/03_seed.sql;            -- P2: restaurantes, productos, repartidores, pedidos...
SOURCE db/04_funciones.sql;
SOURCE db/05_sp_clientes.sql;
-- SOURCE db/05_sp_catalogo.sql;     -- P2: restaurantes, categorías, productos, combos
-- SOURCE db/05_sp_pedidos.sql;      -- P3: repartidores, pedidos, transacciones
-- SOURCE db/06_vistas.sql;          -- P4
-- SOURCE db/05_sp_reportes.sql;     -- P4 (va después de las vistas)
