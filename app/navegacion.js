/**
 * app/navegacion.js · Menú lateral.
 * Cuando un integrante termine su módulo, cambia "listo" a true
 * y monta su router en server.js. Los no listos se muestran deshabilitados.
 */
export const navegacion = [
  { grupo: 'Operación', items: [
    { ruta: '/pedidos',      texto: 'Pedidos',            icono: 'pedido',   listo: false },  // P3
    { ruta: '/repartidores', texto: 'Repartidores',       icono: 'moto',     listo: false },  // P3
  ]},
  { grupo: 'Catálogo', items: [
    { ruta: '/clientes',     texto: 'Clientes',           icono: 'cliente',  listo: true  },  // P1
    { ruta: '/restaurantes', texto: 'Restaurantes',       icono: 'tienda',   listo: false },  // P2
    { ruta: '/productos',    texto: 'Productos y combos', icono: 'producto', listo: false },  // P2
  ]},
  { grupo: 'Análisis', items: [
    { ruta: '/reportes',     texto: 'Reportes',           icono: 'reporte',  listo: false },  // P4
  ]},
];
