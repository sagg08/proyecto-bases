/**
 * vitest.config.js · Configuración de las pruebas (npm test).
 *
 * Las pruebas usan una base APARTE, "domicilios_test", que se crea desde cero
 * antes de correrlas. Así nunca borran ni ensucian tu base "domicilios".
 */
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globalSetup: './tests/preparar-bd.js',  // crea domicilios_test una vez, antes de todo
    env: { DB_NAME: 'domicilios_test' },     // la app se conecta a la base de prueba
    fileParallelism: false,                  // un archivo a la vez: comparten la misma base
    testTimeout: 15000,
  },
});
