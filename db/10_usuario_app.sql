-- =====================================================================
-- 10_usuario_app.sql · Usuario de MySQL con privilegio mínimo para la app (P4)
--
-- Idea (principio de mínimo privilegio): la aplicación NO necesita leer ni
-- escribir tablas directamente, porque todo lo hace con CALL sp_...
-- Entonces su usuario de MySQL solo recibe EXECUTE (ejecutar procedimientos
-- y funciones). Si alguien roba las credenciales del .env, o si hubiera una
-- inyección SQL, ese usuario NO puede hacer SELECT * FROM CLIENTE, ni
-- DELETE, ni DROP TABLE: MySQL lo rechaza.
--
-- ¿Cómo funcionan entonces los procedimientos? Se crean con
-- SQL SECURITY DEFINER (el valor por defecto): se ejecutan con los permisos
-- de quien los CREÓ (el usuario con el que se corrió npm run db:setup,
-- normalmente root), no con los de quien los llama.
--
-- NO está en 00_run_all.sql: crear usuarios exige permisos de administrador
-- y la contraseña no debe quedar en el repositorio. Uso (opcional):
--   1. npm run db:setup              (con root en el .env: crea la base)
--   2. Cambiar la contraseña de abajo y ejecutar este archivo con root:
--        mysql -u root -p < db/10_usuario_app.sql
--      (o abrirlo y ejecutarlo en MySQL Workbench)
--   3. En .env poner DB_USER=domicilios_app y DB_PASSWORD=<la clave elegida>
--   4. npm start   → la app funciona igual
--   npm run db:setup y npm test siguen necesitando root (crean bases).
--
-- Demostración para la sustentación (conectado como domicilios_app):
--   CALL sp_cliente_listar(NULL);   → funciona
--   SELECT * FROM CLIENTE;          → ERROR 1142: SELECT command denied
-- =====================================================================

DROP USER IF EXISTS 'domicilios_app'@'localhost';

-- CAMBIAR la contraseña antes de ejecutar
CREATE USER 'domicilios_app'@'localhost' IDENTIFIED BY 'Cambiar_esta_clave_1';

-- Solo ejecutar rutinas (procedimientos y funciones) de la base domicilios.
GRANT EXECUTE ON domicilios.* TO 'domicilios_app'@'localhost';

-- Para comprobar qué permisos quedaron
SHOW GRANTS FOR 'domicilios_app'@'localhost';
