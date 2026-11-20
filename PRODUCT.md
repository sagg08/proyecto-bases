---
register: product
---
# PRODUCT · Domicilios (Caso 7, Bases de Datos)

## Propósito
Panel de operación de una plataforma de domicilios: registrar clientes, restaurantes, productos, combos y repartidores; crear pedidos, avanzarlos por sus estados (recibido → en preparación → en camino → entregado, o cancelado) y consultar su historial y calificaciones. Por dentro todo pasa por procedimientos almacenados de MySQL.

## Usuarios
- **Principal: el profesor en la sustentación.** Nunca ha visto la app, la levanta siguiendo el README y la opera solo en un portátil, de día, con el grupo mirando. Debe crear, consultar, editar y borrar sin escribir SQL y sin preguntar dónde está cada cosa.
- Secundario: el propio grupo, demostrando transacciones, errores y reportes en vivo.

## Tono
Claro, sobrio, operativo. Como una comanda bien impresa: cada dato en su lugar, números legibles, estados imposibles de confundir. Nada de marketing.

## Principios
1. **El pedido es el centro.** Su estado y su historial siempre visibles.
2. **Los errores enseñan.** Cada rechazo (de la app o de un `SIGNAL` de MySQL) dice qué pasó y cómo arreglarlo, junto al campo.
3. **Nada se borra por accidente.** Acciones destructivas separadas y con confirmación en la misma página.
4. **Datos tabulares de verdad.** Precios en COP con separador de miles, IDs y horas en monoespaciada.

## Anti-referencias
- Rojo/naranja de app de comida (Rappi, iFood): reflejo del rubro.
- Dashboard SaaS con métricas gigantes y degradados.
- Plantillas Bootstrap sin personalizar.
