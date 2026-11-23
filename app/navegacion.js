/**
 * app/navegacion.js · Menú lateral.
 * Cuando un integrante termine su módulo, cambia "listo" a true
 * y monta su router en server.js. Los no listos se muestran deshabilitados.
 */
export const navegacion = [
  { grupo: 'Pedir', items: [
    { ruta: '/pedir', texto: 'Pedir a domicilio', icono: 'tienda', listo: true },  // P3
  ]},
  { grupo: 'Operación', items: [
    { ruta: '/pedidos',      texto: 'Pedidos',            icono: 'pedido',   listo: true  },  // P3
    { ruta: '/repartidores', texto: 'Repartidores',       icono: 'moto',     listo: true  },  // P3
  ]},
  { grupo: 'Catálogo', items: [
    { ruta: '/clientes',     texto: 'Clientes',           icono: 'cliente',  listo: true  },  // P1
    { ruta: '/restaurantes', texto: 'Restaurantes',       icono: 'tienda',   listo: true  },  // P2
    { ruta: '/categorias',   texto: 'Categorías',         icono: 'producto', listo: true  },  // P2
    { ruta: '/productos',    texto: 'Productos y combos', icono: 'producto', listo: true  },  // P2
  ]},
  { grupo: 'Análisis', items: [
    { ruta: '/reportes',     texto: 'Reportes',           icono: 'reporte',  listo: true  },  // P4
  ]},
];
