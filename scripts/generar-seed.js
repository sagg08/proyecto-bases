import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const raiz = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const rng = mulberry32(2026);

function mulberry32(seed) {
  let estado = seed >>> 0;
  return () => {
    estado += 0x6D2B79F5;
    let valor = estado;
    valor = Math.imul(valor ^ (valor >>> 15), valor | 1);
    valor ^= valor + Math.imul(valor ^ (valor >>> 7), valor | 61);
    return ((valor ^ (valor >>> 14)) >>> 0) / 4294967296;
  };
}

const entero = (min, max) => min + Math.floor(rng() * (max - min + 1));
const elegir = (elementos) => elementos[entero(0, elementos.length - 1)];
const prefijosCelular = [...Array.from({ length: 25 }, (_, i) => String(300 + i)), '350', '351'];

function mezclar(elementos) {
  const resultado = [...elementos];
  for (let i = resultado.length - 1; i > 0; i -= 1) {
    const j = entero(0, i);
    [resultado[i], resultado[j]] = [resultado[j], resultado[i]];
  }
  return resultado;
}

function fechaSql(fecha) {
  return fecha.toISOString().slice(0, 10);
}

function fechaHoraSql(fecha) {
  return fecha.toISOString().slice(0, 19).replace('T', ' ');
}

function fechaAleatoria(desde, hasta) {
  const inicio = Date.parse(`${desde}T00:00:00Z`);
  const fin = Date.parse(`${hasta}T00:00:00Z`);
  return fechaSql(new Date(inicio + entero(0, Math.floor((fin - inicio) / 86400000)) * 86400000));
}

function fechaHoraAleatoria() {
  const inicio = Date.parse('2026-08-01T08:00:00Z');
  const fin = Date.parse('2026-11-20T17:00:00Z');
  const minutos = Math.floor((fin - inicio) / 60000);
  return new Date(inicio + entero(0, minutos) * 60000);
}

function nitConDigitoVerificacion(base) {
  const pesos = [41, 37, 29, 23, 19, 17, 13, 7, 3];
  const suma = [...base].reduce((total, digito, i) => total + Number(digito) * pesos[i], 0);
  const residuo = suma % 11;
  const verificacion = residuo === 0 ? 0 : residuo === 1 ? 1 : 11 - residuo;
  return `${base}-${verificacion}`;
}

function nitUnico(usados) {
  let base;
  do {
    base = `${elegir(['800', '900'])}${String(entero(0, 999999)).padStart(6, '0')}`;
  } while (usados.has(base));
  usados.add(base);
  return nitConDigitoVerificacion(base);
}

function telefonoUnico(usados, ciudad = null, fijo = false) {
  let telefono;
  do {
    const prefijo = fijo ? (ciudad === 'Villavicencio' ? '608' : '601') : elegir(prefijosCelular);
    telefono = `${prefijo}${String(entero(0, 9999999)).padStart(7, '0')}`;
  } while (usados.has(telefono));
  usados.add(telefono);
  return telefono;
}

function documentoUnico(usados) {
  let documento;
  do {
    const largo = entero(8, 10);
    documento = String(entero(10 ** (largo - 1), (10 ** largo) - 1));
  } while (usados.has(documento));
  usados.add(documento);
  return documento;
}

const categorias = [
  'Hamburguesas', 'Pizzas', 'Pollo', 'Comida llanera', 'Asados', 'Comida china',
  'Sushi', 'Mexicana', 'Saludable', 'Postres', 'Bebidas', 'Combos',
].map((nombre, i) => ({ id: i + 1, nombre }));

const barrios = {
  Villavicencio: ['Barzal', 'Centro', 'La Esperanza', 'El Buque', 'Siete de Agosto', 'Caudal', 'La Grama', 'La Rosita', 'Villa María', 'Porfía'],
  Bogotá: ['Chapinero', 'Usaquén', 'Teusaquillo', 'Suba', 'Cedritos', 'Fontibón', 'Modelia', 'La Soledad', 'Restrepo', 'Normandía'],
};

const terminosNombre = [
  'Yarumo', 'Lumbre', 'Cauce', 'Niebla', 'Trigal', 'Savia', 'Bruma', 'Albor',
  'Guayacán', 'Cumbre', 'Mangle', 'Aldea', 'Junco', 'Tamarindo', 'Arrayán', 'Lucero',
];
const segundosNombre = [
  'Dorado', 'Sereno', 'Criollo', 'Andino', 'Verde', 'Claro', 'Alegre', 'Mestizo',
  'del Caudal', 'del Llano', 'de la Huerta', 'de la Sabana',
];
const nombresRestauranteUsados = new Set();

function nombreRestaurante(tipo) {
  let nombre;
  do {
    const primero = elegir(terminosNombre);
    const segundo = elegir(segundosNombre);
    if (tipo === 1) nombre = `Hamburguesería ${primero} ${segundo}`;
    else if (tipo === 2) nombre = `Pizzería ${primero} ${segundo}`;
    else if (tipo === 3) nombre = `Pollo Asado ${primero} ${segundo}`;
    else if (tipo === 4) nombre = `Asadero El ${primero} Llanero`;
    else if (tipo === 5) nombre = `Asadero ${primero} ${segundo}`;
    else if (tipo === 6) nombre = `Wok Oriental ${primero} ${segundo}`;
    else if (tipo === 7) nombre = `Sushi ${primero} ${segundo}`;
    else if (tipo === 8) nombre = `Taquería ${primero} ${segundo}`;
    else nombre = `Cocina Saludable ${primero} ${segundo}`;
  } while (nombresRestauranteUsados.has(nombre));
  nombresRestauranteUsados.add(nombre);
  return nombre;
}

const menus = {
  1: {
    nombres: ['Clásica', 'Doble carne', 'Hawaiana', 'BBQ', 'Pollo crispy', 'Tocineta y queso', 'Champiñones', 'Vegetariana', 'Criolla'],
    precio: [24, 54],
  },
  2: {
    nombres: ['Margarita', 'Pepperoni', 'Hawaiana', 'Cuatro quesos', 'Vegetariana', 'Pollo BBQ', 'Napolitana', 'Champiñones', 'Jamón y maíz'],
    precio: [34, 86],
  },
  3: {
    nombres: ['Pollo asado', 'Pollo apanado', 'Pechuga a la plancha', 'Alitas BBQ', 'Arroz con pollo', 'Pollo a la naranja', 'Nuggets de pollo', 'Sándwich de pollo', 'Pollo al ajillo'],
    precio: [26, 64],
  },
  4: {
    nombres: ['Mamona', 'Pisillo', 'Hayaca', 'Carne a la llanera', 'Tungos', 'Cachama asada', 'Sancocho de gallina', 'Ternera a la llanera', 'Arepa de cuajada'],
    precio: [36, 96],
  },
  5: {
    nombres: ['Costillas BBQ', 'Churrasco', 'Punta de anca', 'Carne asada', 'Chorizo a la parrilla', 'Lomo de cerdo', 'Pollo a la parrilla', 'Parrillada mixta', 'Morcilla'],
    precio: [34, 90],
  },
  6: {
    nombres: ['Arroz chino', 'Chow mein', 'Pollo agridulce', 'Cerdo agridulce', 'Rollitos primavera', 'Pollo con verduras', 'Carne con brócoli', 'Arroz tres delicias', 'Fideos con pollo'],
    precio: [28, 62],
  },
  7: {
    nombres: ['California roll', 'Roll de salmón y queso', 'Nigiri de salmón', 'Maki de aguacate', 'Tempura roll', 'Sashimi de atún', 'Roll vegetariano', 'Nigiri de camarón', 'Maki de pepino'],
    precio: [36, 86],
  },
  8: {
    nombres: ['Tacos al pastor', 'Burrito de carne', 'Quesadilla de pollo', 'Enchiladas', 'Nachos con guacamole', 'Fajitas mixtas', 'Tostadas de tinga', 'Burrito vegetariano', 'Tamales de pollo'],
    precio: [26, 60],
  },
  9: {
    nombres: ['Bowl de quinoa', 'Ensalada César', 'Ensalada de quinoa', 'Wrap de pollo', 'Bowl de garbanzos', 'Sopa de verduras', 'Tostada de aguacate', 'Lentejas con vegetales', 'Pechuga con vegetales'],
    precio: [26, 58],
  },
};

const productosBebida = ['Gaseosa', 'Limonada natural', 'Jugo de mango', 'Jugo de maracuyá', 'Aguapanela fría', 'Agua en botella', 'Té frío', 'Jugo de mora'];
const productosPostre = ['Flan de caramelo', 'Arroz con leche', 'Torta de chocolate', 'Tres leches', 'Brownie', 'Cuajada con melao', 'Tarta de limón', 'Brevas con arequipe'];
const descripciones = {
  1: ['Pan tostado, vegetales frescos y salsa de la casa.', 'Preparada al momento con ingredientes locales.', 'Acompañada de una porción de papas doradas.'],
  2: ['Masa delgada horneada al momento.', 'Quesos y vegetales sobre masa artesanal.', 'Preparada en horno con ingredientes frescos.'],
  3: ['Pollo sazonado y preparado al horno.', 'Acompañado de guarnición del día.', 'Receta casera con hierbas frescas.'],
  4: ['Receta del llano con ingredientes de la región.', 'Preparado a fuego lento y servido caliente.', 'Acompañado de arepa y guarnición.'],
  5: ['Corte preparado a la brasa.', 'Acompañado de papa y ensalada fresca.', 'Sellado al carbón con especias suaves.'],
  6: ['Salteado al wok con verduras frescas.', 'Preparación casera con arroz y salsa ligera.', 'Servido caliente con ingredientes del día.'],
  7: ['Arroz sazonado y vegetales frescos.', 'Preparado al momento en porciones pequeñas.', 'Acompañado de salsa de la casa.'],
  8: ['Maíz, frijoles y vegetales de temporada.', 'Receta casera con salsa suave.', 'Acompañado de guacamole fresco.'],
  9: ['Ingredientes frescos y aderezo ligero.', 'Preparado con granos y vegetales de temporada.', 'Opción balanceada servida al momento.'],
  10: ['Preparado en casa con ingredientes frescos.', 'Porción individual elaborada al horno.', 'Dulce suave para terminar la comida.'],
  11: ['Bebida fría preparada al momento.', 'Fruta natural con hielo y un toque cítrico.', 'Servida fría en tamaño personal.'],
  12: ['Una combinación de productos seleccionados del menú.', 'Ideal para compartir, preparado al momento.', 'Incluye productos frescos de la casa.'],
};

function precioProducto(categoria) {
  const rango = categoria === 10 ? [10, 24] : categoria === 11 ? [6, 18] : menus[categoria].precio;
  return entero(rango[0], rango[1]) * 500;
}

function direccion(ciudad) {
  const barrio = elegir(barrios[ciudad]);
  return `Calle ${entero(3, 82)} # ${entero(1, 90)}-${String(entero(1, 99)).padStart(2, '0')}, ${barrio}`;
}

const ciudadesRestaurante = mezclar([
  ...Array(42).fill('Villavicencio'),
  ...Array(18).fill('Bogotá'),
]);
const tiposRestaurante = mezclar(Array.from({ length: 60 }, (_, i) => (i % 9) + 1));
const restaurantesConFijo = new Set(mezclar(Array.from({ length: 60 }, (_, i) => i + 1)).slice(0, 12));
const telefonosUsados = new Set();
const nitUsados = new Set();
const restaurantes = ciudadesRestaurante.map((ciudad, i) => {
  const id = i + 1;
  return {
    id,
    nit: nitUnico(nitUsados),
    nombre: nombreRestaurante(tiposRestaurante[i]),
    ciudad,
    direccion: direccion(ciudad),
    telefono: telefonoUnico(telefonosUsados, ciudad, restaurantesConFijo.has(id)),
    fecha_afiliacion: fechaAleatoria('2023-01-01', '2026-09-30'),
    tipo: tiposRestaurante[i],
  };
});

const productos = [];
const combosComponentes = [];
let siguienteIdProducto = 1;
const cantidadesComida = mezclar([
  ...Array(15).fill(5),
  ...Array(27).fill(4),
  ...Array(18).fill(3),
]);
const cantidadComidaPorRestaurante = new Map(
  restaurantes.map((restaurante, i) => [restaurante.id, cantidadesComida[i]]),
);
const restaurantesConSegundoCombo = new Set(
  mezclar(restaurantes.map((restaurante) => restaurante.id)).slice(0, 25),
);
const restauranteSinPostreEnCombo = elegir(restaurantes).id;
for (const restaurante of restaurantes) {
  const comidas = mezclar(menus[restaurante.tipo].nombres)
    .slice(0, cantidadComidaPorRestaurante.get(restaurante.id));
  const productosBase = [
    ...comidas.map((nombre) => ({ nombre, id_categoria: restaurante.tipo })),
    { nombre: elegir(productosBebida), id_categoria: 11 },
    { nombre: elegir(productosPostre), id_categoria: 10 },
  ];
  const locales = productosBase.map((producto) => ({
    id_producto: siguienteIdProducto++,
    id_restaurante: restaurante.id,
    id_categoria: producto.id_categoria,
    nombre: producto.nombre,
    descripcion: null,
    precio: precioProducto(producto.id_categoria),
    disponible: true,
    es_combo: false,
  }));
  productos.push(...locales);

  const bebida = locales.find((producto) => producto.id_categoria === 11);
  const postre = locales.find((producto) => producto.id_categoria === 10);
  const cantidadCombos = restaurantesConSegundoCombo.has(restaurante.id) ? 2 : 1;
  const principales = mezclar(locales.filter((producto) => producto.id_categoria === restaurante.tipo))
    .slice(0, cantidadCombos);
  for (let i = 0; i < cantidadCombos; i += 1) {
    const compartir = i === 1;
    const principal = principales[i];
    const incluirPostre = !compartir && restaurante.id !== restauranteSinPostreEnCombo;
    const componentes = [
      { producto: principal, cantidad: compartir ? 2 : 1 },
      { producto: bebida, cantidad: 1 },
      ...(incluirPostre ? [{ producto: postre, cantidad: 1 }] : []),
    ];
    const suma = componentes.reduce((total, item) => total + (item.producto.precio * item.cantidad), 0);
    const combo = {
      id_producto: siguienteIdProducto++,
      id_restaurante: restaurante.id,
      id_categoria: 12,
      nombre: `${compartir ? 'Combo para compartir' : 'Combo'} ${principal.nombre} + ${bebida.nombre.toLocaleLowerCase('es-CO')}${incluirPostre ? ` + ${postre.nombre.toLocaleLowerCase('es-CO')}` : ''}`,
      descripcion: null,
      precio: Math.max(500, Math.floor((suma * 0.9) / 500) * 500),
      disponible: true,
      es_combo: true,
    };
    productos.push(combo);
    componentes.forEach(({ producto, cantidad }) => combosComponentes.push([
      combo.id_producto, producto.id_producto, cantidad,
    ]));
  }
}

const componentesEnCombo = new Set(combosComponentes.map(([, idComponente]) => idComponente));
const productosNoDisponibles = mezclar(productos.filter((producto) => !componentesEnCombo.has(producto.id_producto)))
  .slice(0, Math.round(productos.length * 0.05));
productosNoDisponibles.forEach((producto) => { producto.disponible = false; });

const conDescripcion = new Set(mezclar(productos).slice(0, Math.floor(productos.length / 2)).map((producto) => producto.id_producto));
for (const producto of productos) {
  if (conDescripcion.has(producto.id_producto)) {
    producto.descripcion = elegir(descripciones[producto.id_categoria]);
  }
}

const repartidores = [];
const documentosUsados = new Set();
const placasUsadas = new Set();
const nombres = ['Camila', 'Samuel', 'Mariana', 'Andrés', 'Lucía', 'Mateo', 'Diana', 'Felipe', 'Valentina', 'Tomás', 'Sara', 'Julián', 'Natalia', 'Emilio', 'Isabela', 'Nicolás', 'Manuela', 'Santiago', 'Laura', 'Gabriel'];
const apellidos = ['Rincón', 'Mendoza', 'Cárdenas', 'Beltrán', 'Quiroga', 'Bustos', 'Zárate', 'Pardo', 'Cifuentes', 'Benítez', 'Laverde', 'Parra', 'Cabrera', 'Ocampo', 'Nieto', 'Téllez', 'Bermúdez', 'Arango', 'Rojas', 'Peña'];

function placaUnica(tipo) {
  let placa;
  do {
    const letras = () => String.fromCharCode(65 + entero(0, 25));
    const digitos = (cantidad) => String(entero(0, (10 ** cantidad) - 1)).padStart(cantidad, '0');
    placa = tipo === 'moto'
      ? `${letras()}${letras()}${letras()}${digitos(2)}${letras()}`
      : `${letras()}${letras()}${letras()}${digitos(3)}`;
  } while (placasUsadas.has(placa));
  placasUsadas.add(placa);
  return placa;
}

for (let i = 0; i < 60; i += 1) {
  const tipo = i < 36 ? 'moto' : i < 45 ? 'carro' : 'bicicleta';
  repartidores.push({
    id_repartidor: i + 1,
    documento: documentoUnico(documentosUsados),
    nombres: elegir(nombres),
    primer_apellido: elegir(apellidos),
    segundo_apellido: rng() < 0.25 ? null : elegir(apellidos),
    telefono: telefonoUnico(telefonosUsados),
    tipo_vehiculo: tipo,
    placa: tipo === 'bicicleta' ? null : placaUnica(tipo),
    fecha_ingreso: fechaAleatoria('2023-01-01', '2026-12-31'),
  });
}

const planesEstado = mezclar([
  ...Array(200).fill('entregado'),
  ...Array(10).fill('cancelado_recibido'),
  ...Array(10).fill('cancelado_preparacion'),
  ...Array(10).fill('recibido'),
  ...Array(10).fill('preparacion'),
  ...Array(10).fill('en_camino'),
]);
const cantidadesDetalle = mezclar([
  ...Array(138).fill(2),
  ...Array(112).fill(3),
]);
const detallesPedido = [];
const historiales = [];
const pedidos = [];
const entregados = [];
const productosPorRestaurante = new Map();
for (const producto of productos) {
  if (!productosPorRestaurante.has(producto.id_restaurante)) productosPorRestaurante.set(producto.id_restaurante, []);
  productosPorRestaurante.get(producto.id_restaurante).push(producto);
}

function agregarHistorial(idPedido, secuencia, idEstado, fecha, observacion) {
  historiales.push([idPedido, secuencia, idEstado, fechaHoraSql(fecha), observacion]);
}

for (let i = 0; i < 250; i += 1) {
  const idPedido = i + 1;
  const restaurante = elegir(restaurantes);
  const plan = planesEstado[i];
  const necesitaRepartidor = plan === 'en_camino' || plan === 'entregado';
  const repartidor = necesitaRepartidor ? elegir(repartidores) : null;
  const fechaInicio = fechaHoraAleatoria();
  const pedido = {
    id_pedido: idPedido,
    id_cliente: entero(1, 50),
    id_restaurante: restaurante.id,
    id_repartidor: repartidor?.id_repartidor ?? null,
    calle: `Calle ${entero(2, 80)}`,
    numero: `# ${entero(1, 90)}-${String(entero(1, 99)).padStart(2, '0')}`,
    barrio: elegir(barrios[restaurante.ciudad]),
    ciudad: restaurante.ciudad,
    costo_envio: entero(4, 16) * 500,
    metodo_pago: elegir(['efectivo', 'tarjeta', 'transferencia']),
    plan,
  };
  pedidos.push(pedido);

  const disponibles = productosPorRestaurante.get(restaurante.id).filter((producto) => producto.disponible);
  const cantidadProductos = cantidadesDetalle[i];
  if (disponibles.length < cantidadProductos) {
    throw new Error(`El restaurante ${restaurante.id} no tiene productos disponibles suficientes para el pedido.`);
  }
  const seleccionados = mezclar(disponibles).slice(0, cantidadProductos);
  seleccionados.forEach((producto) => detallesPedido.push([
    idPedido, producto.id_producto, entero(1, 3), producto.precio,
  ]));

  let fechaActual = fechaInicio;
  let secuencia = 1;
  agregarHistorial(idPedido, secuencia, 1, fechaActual, 'Pedido recibido');
  if (plan === 'preparacion' || plan === 'en_camino' || plan === 'entregado' || plan === 'cancelado_preparacion') {
    fechaActual = new Date(fechaActual.getTime() + entero(3, 10) * 60000);
    agregarHistorial(idPedido, ++secuencia, 2, fechaActual, 'Preparación iniciada');
  }
  if (plan === 'en_camino' || plan === 'entregado') {
    fechaActual = new Date(fechaActual.getTime() + entero(15, 35) * 60000);
    agregarHistorial(idPedido, ++secuencia, 3, fechaActual, 'Pedido despachado');
  }
  if (plan === 'entregado') {
    fechaActual = new Date(fechaActual.getTime() + entero(15, 40) * 60000);
    agregarHistorial(idPedido, ++secuencia, 4, fechaActual, 'Pedido entregado');
    entregados.push({ id_pedido: idPedido, fecha_entrega: fechaActual });
  }
  if (plan === 'cancelado_recibido' || plan === 'cancelado_preparacion') {
    fechaActual = new Date(fechaActual.getTime() + entero(3, 10) * 60000);
    agregarHistorial(idPedido, ++secuencia, 5, fechaActual, 'Pedido cancelado');
  }
}

const pedidosCalificados = mezclar(entregados).slice(0, 185);
const conComentario = new Set(mezclar(pedidosCalificados).slice(0, 93).map((pedido) => pedido.id_pedido));
const comentarios = [
  'Llegó caliente y muy bien empacado.',
  'El sabor estuvo excelente.',
  'Buena porción y entrega puntual.',
  'Todo llegó fresco y en buen estado.',
  'La preparación estuvo muy rica.',
  'Muy buena atención durante el pedido.',
  'La comida llegó como la pedí.',
  'Una opción agradable para compartir.',
];

function notaSesgada() {
  const valor = entero(1, 100);
  if (valor <= 3) return 1;
  if (valor <= 8) return 2;
  if (valor <= 23) return 3;
  if (valor <= 60) return 4;
  return 5;
}

const calificaciones = pedidosCalificados.map((pedido) => {
  const fecha = new Date(pedido.fecha_entrega.getTime() + entero(10, 120) * 60000);
  return [
    pedido.id_pedido,
    notaSesgada(),
    notaSesgada(),
    conComentario.has(pedido.id_pedido) ? elegir(comentarios) : null,
    fechaHoraSql(fecha),
  ];
});

const filas = {
  CATEGORIA: categorias.map((categoria) => [categoria.id, categoria.nombre]),
  RESTAURANTE: restaurantes.map((restaurante) => [
    restaurante.id, restaurante.nit, restaurante.nombre, restaurante.direccion,
    restaurante.telefono, restaurante.fecha_afiliacion,
  ]),
  PRODUCTO: productos.map((producto) => [
    producto.id_producto, producto.id_restaurante, producto.id_categoria,
    producto.nombre, producto.descripcion, producto.precio, producto.disponible,
  ]),
  COMBO_COMPONENTE: combosComponentes,
  REPARTIDOR: repartidores.map((repartidor) => [
    repartidor.id_repartidor, repartidor.documento, repartidor.nombres,
    repartidor.primer_apellido, repartidor.segundo_apellido, repartidor.telefono,
    repartidor.tipo_vehiculo, repartidor.placa, repartidor.fecha_ingreso,
  ]),
  PEDIDO: pedidos.map((pedido) => [
    pedido.id_pedido, pedido.id_cliente, pedido.id_restaurante, pedido.id_repartidor,
    pedido.calle, pedido.numero, pedido.barrio, pedido.ciudad, pedido.costo_envio, pedido.metodo_pago,
  ]),
  DETALLE_PEDIDO: detallesPedido,
  HISTORIAL_ESTADO: historiales,
  CALIFICACION: calificaciones,
};

function validarDatos() {
  const prefijosCelularRegex = new RegExp(`^(?:${prefijosCelular.join('|')})\\d{7}$`);
  if (productos.length !== 442 || combosComponentes.length !== 229 || detallesPedido.length !== 612) {
    throw new Error('Las cantidades de productos, componentes o detalles no coinciden con lo requerido.');
  }
  if (restaurantes.length !== 60
    || restaurantes.filter((r) => r.ciudad === 'Villavicencio').length !== 42
    || restaurantes.filter((r) => r.ciudad === 'Bogotá').length !== 18) {
    throw new Error('La distribución de restaurantes por ciudad no coincide con lo requerido.');
  }
  if (restaurantes.filter((restaurante) => /^60[18]\d{7}$/.test(restaurante.telefono)).length !== 12) {
    throw new Error('La cantidad de teléfonos fijos de restaurantes no coincide con lo requerido.');
  }
  if (repartidores.filter((r) => r.tipo_vehiculo === 'moto').length !== 36
    || repartidores.filter((r) => r.tipo_vehiculo === 'carro').length !== 9
    || repartidores.filter((r) => r.tipo_vehiculo === 'bicicleta').length !== 15) {
    throw new Error('La distribución de vehículos no coincide con lo requerido.');
  }
  const cantidadPlanes = (plan) => pedidos.filter((pedido) => pedido.plan === plan).length;
  if (cantidadPlanes('entregado') !== 200 || cantidadPlanes('cancelado_recibido') !== 10
    || cantidadPlanes('cancelado_preparacion') !== 10 || cantidadPlanes('recibido') !== 10
    || cantidadPlanes('preparacion') !== 10 || cantidadPlanes('en_camino') !== 10
    || calificaciones.length !== 185) {
    throw new Error('Los estados finales o las calificaciones no coinciden con lo requerido.');
  }
  for (const restaurante of restaurantes) {
    const menu = productosPorRestaurante.get(restaurante.id);
    const combos = menu.filter((producto) => producto.es_combo);
    if (menu.length < 6 || menu.length > 9 || combos.length < 1 || combos.length > 2
      || menu.filter((producto) => producto.id_categoria === restaurante.tipo).length < 3
      || menu.filter((producto) => producto.id_categoria === 11).length !== 1
      || menu.filter((producto) => producto.id_categoria === 10).length !== 1) {
      throw new Error(`El menú del restaurante ${restaurante.id} no cumple las cantidades requeridas.`);
    }
    const [baseNit] = restaurante.nit.split('-');
    const fijoValido = restaurante.ciudad === 'Villavicencio'
      ? /^608\d{7}$/.test(restaurante.telefono)
      : /^601\d{7}$/.test(restaurante.telefono);
    if (!/^(800|900)\d{6}$/.test(baseNit)
      || restaurante.nit !== nitConDigitoVerificacion(baseNit)
      || (!fijoValido && !prefijosCelularRegex.test(restaurante.telefono))) {
      throw new Error(`El formato del NIT o teléfono del restaurante ${restaurante.id} no es válido.`);
    }
    const nombresMenu = menu.map((producto) => producto.nombre);
    if (new Set(nombresMenu).size !== nombresMenu.length) {
      throw new Error(`El restaurante ${restaurante.id} tiene nombres de producto repetidos.`);
    }
  }
  const productosPorId = new Map(productos.map((producto) => [producto.id_producto, producto]));
  const combosPorId = new Set(productos.filter((producto) => producto.es_combo).map((producto) => producto.id_producto));
  const componentesPorCombo = new Map();
  if (productos.filter((producto) => !producto.disponible).length !== Math.round(productos.length * 0.05)) {
    throw new Error('La cantidad de productos no disponibles no se acerca al 5 % requerido.');
  }
  for (const [idCombo, idComponente, cantidad] of combosComponentes) {
    const combo = productosPorId.get(idCombo);
    const componente = productosPorId.get(idComponente);
    if (!combo?.es_combo || !componente || componente.es_combo
      || !componente.disponible || combo.id_restaurante !== componente.id_restaurante
      || (cantidad !== 1 && cantidad !== 2)) {
      throw new Error(`El componente ${idComponente} no es válido para el combo ${idCombo}.`);
    }
    componentesPorCombo.set(idCombo, [...(componentesPorCombo.get(idCombo) ?? []), [componente, cantidad]]);
  }
  for (const idCombo of combosPorId) {
    const combo = productosPorId.get(idCombo);
    const componentes = componentesPorCombo.get(idCombo) ?? [];
    const total = componentes.reduce((suma, [componente, cantidad]) => suma + componente.precio * cantidad, 0);
    const compartir = combo.nombre.startsWith('Combo para compartir ');
    const cantidades = componentes.map(([, cantidad]) => cantidad);
    const categoriasComponente = componentes.map(([producto]) => producto.id_categoria);
    const tipoRestaurante = restaurantes.find((restaurante) => restaurante.id === combo.id_restaurante).tipo;
    if (componentes.length < 2 || componentes.length > 3
      || categoriasComponente.filter((categoria) => categoria === 12).length !== 0
      || categoriasComponente.filter((categoria) => categoria === tipoRestaurante).length !== 1
      || categoriasComponente.filter((categoria) => categoria === 11).length !== 1
      || categoriasComponente.filter((categoria) => categoria === 10).length !== componentes.length - 2
      || cantidades.filter((cantidad) => cantidad === 2).length !== Number(compartir)
      || cantidades.some((cantidad) => cantidad !== 1 && cantidad !== 2)
      || combo.precio >= total || combo.precio > total * 0.9) {
      throw new Error(`El combo ${idCombo} no cumple la cantidad o el descuento requeridos.`);
    }
  }
  if (historiales.length !== 910 || detallesPedido.some((fila) => fila[2] < 1 || fila[2] > 3)) {
    throw new Error('El historial o el detalle de pedidos no cumple las cantidades requeridas.');
  }
}

function validarTexto(texto) {
  if (texto.includes(';') || texto.includes('--')) {
    throw new Error(`El texto contiene un delimitador no permitido: ${texto}`);
  }
  return texto;
}

function sqlValor(valor) {
  if (valor === null) return 'NULL';
  if (typeof valor === 'string') return `'${validarTexto(valor).replaceAll("'", "''")}'`;
  if (typeof valor === 'boolean') return valor ? 'TRUE' : 'FALSE';
  if (Number.isSafeInteger(valor)) return String(valor);
  throw new TypeError(`Valor SQL no admitido: ${valor}`);
}

function insertMany(tabla, columnas, valores) {
  const lista = valores.map((fila) => `  (${fila.map(sqlValor).join(', ')})`).join(',\n');
  return `INSERT INTO ${tabla} (${columnas.join(', ')}) VALUES\n${lista};`;
}

validarDatos();

const especificaciones = [
  ['CATEGORIA', ['id_categoria', 'nombre']],
  ['RESTAURANTE', ['id_restaurante', 'nit', 'nombre', 'direccion', 'telefono', 'fecha_afiliacion']],
  ['PRODUCTO', ['id_producto', 'id_restaurante', 'id_categoria', 'nombre', 'descripcion', 'precio', 'disponible']],
  ['COMBO_COMPONENTE', ['id_combo', 'id_componente', 'cantidad']],
  ['REPARTIDOR', ['id_repartidor', 'documento', 'nombres', 'primer_apellido', 'segundo_apellido', 'telefono', 'tipo_vehiculo', 'placa', 'fecha_ingreso']],
  ['PEDIDO', ['id_pedido', 'id_cliente', 'id_restaurante', 'id_repartidor', 'calle', 'numero', 'barrio', 'ciudad', 'costo_envio', 'metodo_pago']],
  ['DETALLE_PEDIDO', ['id_pedido', 'id_producto', 'cantidad', 'precio_unitario']],
  ['HISTORIAL_ESTADO', ['id_pedido', 'secuencia', 'id_estado', 'fecha_hora', 'observacion']],
  ['CALIFICACION', ['id_pedido', 'nota_restaurante', 'nota_repartidor', 'comentario', 'fecha']],
];
const conteos = Object.fromEntries(especificaciones.map(([tabla]) => [tabla, filas[tabla].length]));
const encabezado = [
  '-- Generado por scripts/generar-seed.js. No editar a mano.',
  `-- Filas: ${especificaciones.map(([tabla]) => `${tabla}=${conteos[tabla]}`).join(', ')}`,
];
const instrucciones = especificaciones.flatMap(([tabla, columnas]) => {
  if (tabla !== 'HISTORIAL_ESTADO') return [insertMany(tabla, columnas, filas[tabla])];
  return historiales.map((historial) => insertMany(tabla, columnas, [historial]));
});
const contenido = ['USE domicilios;', ...encabezado, '', ...instrucciones, ''].join('\n');

await fs.writeFile(path.join(raiz, 'db', '03_seed.sql'), contenido, 'utf8');
console.log('Seed determinista generado. Filas por tabla:');
for (const [tabla, cantidad] of Object.entries(conteos)) console.log(`  ${tabla}: ${cantidad}`);
