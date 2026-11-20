# Domicilios · Caso 7 (Bases de Datos, Ingeniería Informática)

Aplicación web para operar una plataforma de domicilios: clientes, restaurantes, productos y combos, repartidores y pedidos con su historial de estados. La aplicación no ejecuta SQL suelto: toda operación llama un **procedimiento almacenado** de MySQL.

Integrantes: Samuel Gerena · Samuel Hernández · Juan Andrés Galarza · Tomás Sarmiento.

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
Escribe el usuario y la contraseña de tu MySQL en `DB_USER` y `DB_PASSWORD` y guarda. El usuario necesita permiso para crear bases de datos, triggers y procedimientos (con `root` funciona).

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
Crea una base **aparte**, `domicilios_test`, la llena con los mismos scripts y corre las pruebas de `tests/` (validaciones, transacciones y el ROLLBACK). No toca la base `domicilios` que usa la app. Requiere que MySQL esté encendido y el `.env` configurado.

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

## Estructura

```
db/          scripts SQL en orden (00_run_all.sql es la lista maestra)
scripts/     db-setup.js: ejecuta los SQL desde Node
app/         servidor Express, rutas, validaciones y vistas EJS
tests/       pruebas automatizadas (npm test)
docs/        documentación y guía visual (style-guide.html)
```

## Seguridad

- La app escucha solo en `127.0.0.1`: no queda expuesta a la red.
- Las credenciales viven en `.env`, que Git ignora.
- Los procedimientos se llaman con parámetros (`CALL sp_x(?, ?)`): no hay concatenación de SQL.
- Los datos se validan en la app antes de llegar a MySQL, y la base tiene sus propias restricciones (`CHECK`, `UNIQUE`, triggers) como última defensa.
