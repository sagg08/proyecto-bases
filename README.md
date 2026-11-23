# Domicilios · Caso 7 (Bases de Datos, Ingeniería Informática)

Aplicación web para operar una plataforma de domicilios: clientes, restaurantes, productos y combos, repartidores, pedidos con su historial de estados, un flujo para pedir como cliente (tipo Rappi) y reportes del negocio. La aplicación no ejecuta SQL suelto: toda operación llama un **procedimiento almacenado** de MySQL.

Integrantes: Samuel Gerena · Samuel Hernández · Juan Andrés Galarza · Tomás Sarmiento.

| Pantalla | Ruta | Qué permite |
|---|---|---|
| Pedir a domicilio | `/pedir` | Elegir cliente → restaurante → menú → carrito → confirmar → seguir el pedido → calificar |
| Pedidos | `/pedidos` | Pestañas por estado, avanzar estado (asignando repartidor), cancelar |
| Repartidores, Clientes, Restaurantes, Categorías, Productos y combos | `/repartidores`, `/clientes`, ... | Crear, consultar, editar y eliminar |
| Reportes | `/reportes` | Ranking de restaurantes por ventas, repartidores mejor calificados, tiempos de entrega por zona, ventas por mes |

## Requisitos

| Programa | Versión | Comprobar |
|---|---|---|
| Node.js | 20 o superior | `node -v` |
| MySQL Server | 8.0.16 o superior (los `CHECK` se aplican desde esa versión) | `mysql --version` o MySQL Workbench → *Server Status* |

## Instalación paso a paso

Los comandos son para **PowerShell** en Windows; en macOS/Linux son iguales salvo el paso 2 (`cp .env.example .env`).

**1. Descargar el proyecto y entrar a la carpeta**
```powershell
git clone https://github.com/sagg08/proyecto-bases.git
cd proyecto-bases
```

**2. Crear el archivo de configuración**
```powershell
Copy-Item .env.example .env
notepad .env
```
Escribe el usuario y la contraseña de tu MySQL en `DB_USER` y `DB_PASSWORD` y guarda. El usuario necesita permiso para crear bases de datos, triggers y procedimientos (con `root` funciona). En macOS/Linux: `cp .env.example .env`.

**3. Instalar dependencias**
```powershell
npm install
```

**4. Crear la base de datos completa** (tablas, triggers, datos, funciones y procedimientos)
```powershell
npm run db:setup
```
Debe terminar con `Base de datos lista`. Este paso **borra y vuelve a crear** la base `domicilios`, así que se puede repetir cuando se quiera volver al estado inicial.

**5. Arrancar la aplicación**
```powershell
npm start
```
Abre **http://127.0.0.1:3000** en el navegador. Para detenerla: `Ctrl + C`.

## Pruebas automatizadas

```powershell
npm test
```
Crea una base **aparte**, `domicilios_test`, la llena con los mismos scripts y corre las 20 pruebas de `tests/`. No toca la base `domicilios` que usa la app. Requiere que MySQL esté encendido y el `.env` configurado. Debe terminar con `Tests 20 passed (20)`.

| Archivo | Qué prueba |
|---|---|
| `tests/clientes.test.js` | Validaciones, creación con teléfonos, mensajes de `SIGNAL`, 404 y ROLLBACK de clientes |
| `tests/pedidos.test.js` | Pedido válido por el flujo Pedir, producto de otro restaurante, **ROLLBACK a mitad de `sp_pedido_crear`**, transiciones de estado inválidas, flujo completo hasta calificar, vistas y reportes, y que las 39 consultas de `db/07_consultas.sql` corren sin cambiar los datos |

## Scripts SQL que se corren a mano

`npm run db:setup` crea todo. Estos archivos son para mostrar en la sustentación desde MySQL Workbench (abrir y ejecutar consulta por consulta con `Ctrl + Enter`) o la consola:

| Archivo | Para qué |
|---|---|
| `db/07_consultas.sql` | Banco de 39 consultas: 13 temas × 3 (WHERE/ORDER BY, UPDATE, DELETE, INNER JOIN, agregación, GROUP BY, HAVING, subconsulta en WHERE y en FROM, vistas, LEFT/RIGHT JOIN, self-join, UNION). Cada una con su pregunta de negocio y por qué usa esa herramienta. Los UPDATE y DELETE terminan en `ROLLBACK`: se puede correr las veces que quieran. |
| `db/08_transacciones.sql` | Demostración de COMMIT y ROLLBACK de `sp_pedido_crear`. |
| `db/10_usuario_app.sql` | (Opcional) Crea el usuario `domicilios_app` con **solo** permiso `EXECUTE`: la app funciona igual, pero ese usuario no puede hacer `SELECT` ni `DELETE` directo. Instrucciones dentro del archivo. |
| `npm run db:perf` | Agrega ~5.000 pedidos para medir rendimiento (`docs/indices.md`). Cambia los números de los reportes; `npm run db:setup` vuelve al estado inicial. |

Consola, desde la raíz del proyecto:
```powershell
cmd /c "mysql -u root -p --default-character-set=utf8mb4 domicilios < db\07_consultas.sql"
```

## Alternativa sin Node para la base de datos

Desde la raíz del proyecto, con el cliente de consola de MySQL:
```powershell
cmd /c "mysql -u root -p --default-character-set=utf8mb4 < db\00_run_all.sql"
```
`--default-character-set=utf8mb4` es necesario para que las tildes y la ñ se guarden bien. En MySQL Workbench se puede abrir y ejecutar cada archivo de `db/` en el orden que indica `db/00_run_all.sql`.

## Problemas frecuentes

| Mensaje | Causa y solución |
|---|---|
| `No hay conexión con MySQL` | El servicio está apagado. Windows: *Servicios* → `MySQL80` → Iniciar. Revisa `DB_HOST` y `DB_PORT`. |
| `MySQL rechazó el usuario o la contraseña` | Corrige `DB_USER` / `DB_PASSWORD` en `.env`. |
| `La base de datos no existe todavía` | Falta el paso 4: `npm run db:setup`. |
| `Falta un procedimiento almacenado` | La base es de una versión anterior del proyecto: repite `npm run db:setup`. |
| `EADDRINUSE` al arrancar | El puerto 3000 está ocupado: cambia `APP_PORT` en `.env`. |
| `Faltan variables en .env` | No existe el `.env`: repite el paso 2. |
| Workbench: `Error Code: 1175 ... safe update mode` | Workbench bloquea UPDATE/DELETE sin llave. `07_consultas.sql` ya lo desactiva al inicio (`SET SQL_SAFE_UPDATES = 0`); ejecuta esa línea primero. |

## Estructura

```
db/          scripts SQL en orden (00_run_all.sql es la lista maestra)
scripts/     db-setup.js: ejecuta los SQL desde Node
app/         servidor Express, rutas, validaciones y vistas EJS
tests/       pruebas automatizadas (npm test)
docs/        arquitectura.md (cómo está armado todo), indices.md (rendimiento), style-guide.html
```

La explicación completa de capas, validaciones, manejo de errores, seguridad y reportes está en **[docs/arquitectura.md](docs/arquitectura.md)**.

## Seguridad

- La app escucha solo en `127.0.0.1`: no queda expuesta a la red.
- Las credenciales viven en `.env`, que Git ignora.
- Los procedimientos se llaman con parámetros (`CALL sp_x(?, ?)`): no hay concatenación de SQL.
- Los datos se validan en la app antes de llegar a MySQL, y la base tiene sus propias restricciones (`CHECK`, `UNIQUE`, triggers) como última defensa.
- Opcional: la app puede conectarse con un usuario de MySQL que **solo** tiene permiso `EXECUTE` (`db/10_usuario_app.sql`).
- Limitaciones conocidas (no hay login real, cookies del carrito sin firmar): ver `docs/arquitectura.md`, sección 5.
