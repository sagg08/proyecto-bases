USE domicilios;
-- Generado por scripts/generar-seed.js. No editar a mano.
-- Filas: CATEGORIA=12, RESTAURANTE=60, PRODUCTO=442, COMBO_COMPONENTE=229, REPARTIDOR=60, PEDIDO=250, DETALLE_PEDIDO=612, HISTORIAL_ESTADO=910, CALIFICACION=185

INSERT INTO CATEGORIA (id_categoria, nombre) VALUES
  (1, 'Hamburguesas'),
  (2, 'Pizzas'),
  (3, 'Pollo'),
  (4, 'Comida llanera'),
  (5, 'Asados'),
  (6, 'Comida china'),
  (7, 'Sushi'),
  (8, 'Mexicana'),
  (9, 'Saludable'),
  (10, 'Postres'),
  (11, 'Bebidas'),
  (12, 'Combos');
INSERT INTO RESTAURANTE (id_restaurante, nit, nombre, direccion, telefono, fecha_afiliacion) VALUES
  (1, '900935703-7', 'Hamburguesería Arrayán del Caudal', 'Calle 26 # 36-99, Usaquén', '6015608856', '2024-02-28'),
  (2, '900490685-0', 'Sushi Bruma Alegre', 'Calle 63 # 18-97, La Rosita', '3040986732', '2024-04-13'),
  (3, '800130076-9', 'Wok Oriental Yarumo Andino', 'Calle 57 # 39-06, Barzal', '3150604269', '2024-06-03'),
  (4, '800408605-0', 'Asadero El Savia Llanero', 'Calle 47 # 77-40, Caudal', '3111352110', '2025-10-19'),
  (5, '900809380-2', 'Wok Oriental Mangle Andino', 'Calle 61 # 12-71, La Soledad', '3185038702', '2023-06-20'),
  (6, '900506826-4', 'Taquería Guayacán Alegre', 'Calle 59 # 86-39, Fontibón', '3107432815', '2026-04-24'),
  (7, '800999456-4', 'Wok Oriental Guayacán Criollo', 'Calle 77 # 53-83, El Buque', '3239471114', '2026-06-10'),
  (8, '800350427-4', 'Asadero Aldea Sereno', 'Calle 56 # 39-84, El Buque', '3081819100', '2025-07-21'),
  (9, '900771787-1', 'Cocina Saludable Niebla Alegre', 'Calle 43 # 12-81, Barzal', '3146315398', '2024-11-26'),
  (10, '900353643-5', 'Sushi Bruma de la Sabana', 'Calle 74 # 46-86, Porfía', '3519433938', '2023-02-14'),
  (11, '800559806-1', 'Pollo Asado Niebla Sereno', 'Calle 12 # 50-11, Cedritos', '3225692534', '2024-06-09'),
  (12, '900181724-4', 'Pizzería Cauce Mestizo', 'Calle 73 # 74-39, Caudal', '3109238693', '2024-01-19'),
  (13, '800382117-3', 'Taquería Albor Criollo', 'Calle 31 # 6-09, Modelia', '6015400282', '2024-11-29'),
  (14, '800258430-4', 'Sushi Lucero Mestizo', 'Calle 6 # 57-65, La Rosita', '3051084261', '2024-09-06'),
  (15, '900702512-7', 'Hamburguesería Albor Dorado', 'Calle 62 # 80-73, La Soledad', '3227471856', '2023-08-07'),
  (16, '800223164-9', 'Asadero Cauce del Caudal', 'Calle 24 # 54-50, Porfía', '3110541790', '2026-04-23'),
  (17, '800403752-2', 'Taquería Bruma Verde', 'Calle 46 # 38-64, La Esperanza', '3044287492', '2026-02-24'),
  (18, '900422149-4', 'Pizzería Cauce de la Sabana', 'Calle 30 # 57-49, Villa María', '3004241657', '2025-09-08'),
  (19, '900726740-3', 'Pizzería Savia de la Sabana', 'Calle 30 # 29-15, Suba', '3154761865', '2026-03-09'),
  (20, '900704529-0', 'Asadero El Trigal Llanero', 'Calle 36 # 30-52, Siete de Agosto', '3200950218', '2024-11-09'),
  (21, '800852880-2', 'Taquería Trigal Verde', 'Calle 9 # 20-10, Barzal', '3198610807', '2023-06-06'),
  (22, '900941556-5', 'Pizzería Lumbre Verde', 'Calle 16 # 67-71, Barzal', '3200872962', '2026-09-29'),
  (23, '800022931-9', 'Cocina Saludable Albor del Llano', 'Calle 49 # 42-85, Normandía', '3117519145', '2024-07-29'),
  (24, '900574867-6', 'Wok Oriental Bruma Sereno', 'Calle 74 # 36-52, Modelia', '6018927762', '2024-05-31'),
  (25, '800841315-5', 'Pollo Asado Bruma Sereno', 'Calle 35 # 1-71, Barzal', '6082136207', '2026-04-24'),
  (26, '900926897-9', 'Pollo Asado Aldea Andino', 'Calle 62 # 53-79, Suba', '6013286255', '2026-07-12'),
  (27, '900219402-4', 'Cocina Saludable Bruma Andino', 'Calle 79 # 28-31, Porfía', '3029352384', '2026-02-28'),
  (28, '800275977-2', 'Cocina Saludable Cauce Claro', 'Calle 31 # 37-43, Cedritos', '6012423406', '2026-01-23'),
  (29, '900402363-9', 'Asadero Savia Criollo', 'Calle 61 # 54-93, La Grama', '3245312712', '2023-07-25'),
  (30, '900214865-8', 'Sushi Lumbre de la Sabana', 'Calle 36 # 18-89, Barzal', '3031011345', '2026-05-03'),
  (31, '900408277-0', 'Asadero Bruma del Llano', 'Calle 41 # 68-74, Modelia', '3116267214', '2024-12-06'),
  (32, '900447609-9', 'Asadero El Mangle Llanero', 'Calle 79 # 71-43, La Rosita', '3197108247', '2025-08-06'),
  (33, '800583885-4', 'Pizzería Niebla Mestizo', 'Calle 33 # 61-07, Normandía', '3103179063', '2023-03-31'),
  (34, '800841070-6', 'Asadero El Cumbre Llanero', 'Calle 71 # 87-28, Siete de Agosto', '3105089168', '2026-07-16'),
  (35, '900402473-0', 'Taquería Lumbre Andino', 'Calle 58 # 76-89, Siete de Agosto', '3507223023', '2023-08-19'),
  (36, '900456969-3', 'Pizzería Lucero Criollo', 'Calle 25 # 82-54, El Buque', '3505002857', '2024-06-06'),
  (37, '800087915-1', 'Asadero Cumbre Andino', 'Calle 79 # 13-96, Normandía', '3183472557', '2023-07-29'),
  (38, '900951705-9', 'Wok Oriental Niebla Dorado', 'Calle 29 # 38-13, Siete de Agosto', '3052846186', '2025-10-21'),
  (39, '800846624-9', 'Taquería Lucero del Caudal', 'Calle 59 # 70-99, El Buque', '3052272648', '2026-06-30'),
  (40, '900187246-2', 'Sushi Bruma Claro', 'Calle 49 # 66-29, Teusaquillo', '3076226561', '2023-04-14'),
  (41, '900722554-1', 'Asadero El Niebla Llanero', 'Calle 18 # 7-13, La Grama', '3241357102', '2023-04-11'),
  (42, '900069046-0', 'Cocina Saludable Lucero Claro', 'Calle 37 # 75-95, La Rosita', '3173535834', '2025-04-12'),
  (43, '800067090-3', 'Pollo Asado Savia del Caudal', 'Calle 81 # 55-59, La Grama', '6086841116', '2024-12-24'),
  (44, '800831803-5', 'Wok Oriental Guayacán de la Huerta', 'Calle 37 # 55-97, Caudal', '3001382615', '2024-08-24'),
  (45, '900218818-1', 'Asadero El Lucero Llanero', 'Calle 30 # 28-92, Caudal', '3192822405', '2026-07-27'),
  (46, '900245141-7', 'Hamburguesería Aldea Sereno', 'Calle 63 # 27-93, Suba', '3023652455', '2026-02-12'),
  (47, '800775785-0', 'Asadero Niebla Dorado', 'Calle 18 # 50-51, Barzal', '6080511639', '2024-06-30'),
  (48, '800387011-4', 'Wok Oriental Cauce Verde', 'Calle 16 # 59-79, Fontibón', '3057149160', '2023-01-10'),
  (49, '800953507-3', 'Cocina Saludable Lumbre Verde', 'Calle 29 # 48-85, La Rosita', '3509514888', '2023-11-20'),
  (50, '800806983-7', 'Pizzería Aldea Claro', 'Calle 50 # 20-06, La Esperanza', '3511861101', '2024-06-27'),
  (51, '900813311-1', 'Asadero El Arrayán Llanero', 'Calle 5 # 22-91, Villa María', '6084333622', '2023-07-09'),
  (52, '900022747-2', 'Asadero Albor Andino', 'Calle 27 # 58-53, La Rosita', '3149057727', '2024-11-17'),
  (53, '800731589-4', 'Hamburguesería Arrayán Dorado', 'Calle 17 # 19-37, Usaquén', '3199944158', '2024-07-26'),
  (54, '900215670-3', 'Hamburguesería Guayacán Mestizo', 'Calle 57 # 83-39, Barzal', '6081477633', '2025-12-05'),
  (55, '900678645-5', 'Pollo Asado Aldea del Caudal', 'Calle 69 # 63-60, Caudal', '3201106375', '2023-11-08'),
  (56, '900982335-1', 'Hamburguesería Cumbre Criollo', 'Calle 77 # 21-44, Villa María', '6082564653', '2023-10-04'),
  (57, '800914597-1', 'Pollo Asado Albor Andino', 'Calle 19 # 86-41, Siete de Agosto', '6086242601', '2024-06-21'),
  (58, '900013928-0', 'Sushi Bruma Dorado', 'Calle 8 # 18-47, La Rosita', '3216425223', '2025-03-20'),
  (59, '800686876-0', 'Hamburguesería Guayacán de la Huerta', 'Calle 20 # 76-40, Barzal', '3006002961', '2024-06-21'),
  (60, '900003742-5', 'Pollo Asado Cumbre Criollo', 'Calle 4 # 40-61, Caudal', '3144175398', '2025-01-10');
INSERT INTO PRODUCTO (id_producto, id_restaurante, id_categoria, nombre, descripcion, precio, disponible) VALUES
  (1, 1, 1, 'Champiñones', 'Preparada al momento con ingredientes locales.', 18000, TRUE),
  (2, 1, 1, 'Tocineta y queso', NULL, 14500, TRUE),
  (3, 1, 1, 'Criolla', 'Acompañada de una porción de papas doradas.', 16500, TRUE),
  (4, 1, 1, 'Hawaiana', NULL, 24000, TRUE),
  (5, 1, 11, 'Agua en botella', NULL, 9000, TRUE),
  (6, 1, 10, 'Arroz con leche', NULL, 7000, TRUE),
  (7, 1, 12, 'Combo Tocineta y queso + agua en botella + arroz con leche', 'Incluye productos frescos de la casa.', 27000, TRUE),
  (8, 1, 12, 'Combo para compartir Champiñones + agua en botella', NULL, 40500, FALSE),
  (9, 2, 7, 'Tempura roll', 'Arroz sazonado y vegetales frescos.', 30500, TRUE),
  (10, 2, 7, 'California roll', NULL, 38500, TRUE),
  (11, 2, 7, 'Nigiri de salmón', 'Arroz sazonado y vegetales frescos.', 41500, TRUE),
  (12, 2, 7, 'Nigiri de camarón', 'Acompañado de salsa de la casa.', 22500, TRUE),
  (13, 2, 11, 'Limonada natural', 'Fruta natural con hielo y un toque cítrico.', 3000, TRUE),
  (14, 2, 10, 'Tres leches', 'Dulce suave para terminar la comida.', 5000, TRUE),
  (15, 2, 12, 'Combo Nigiri de camarón + limonada natural + tres leches', NULL, 27000, TRUE),
  (16, 3, 6, 'Arroz chino', NULL, 18500, TRUE),
  (17, 3, 6, 'Pollo con verduras', NULL, 20500, TRUE),
  (18, 3, 6, 'Rollitos primavera', NULL, 18000, TRUE),
  (19, 3, 11, 'Jugo de mora', 'Bebida fría preparada al momento.', 3000, TRUE),
  (20, 3, 10, 'Cuajada con melao', NULL, 8500, TRUE),
  (21, 3, 12, 'Combo Pollo con verduras + jugo de mora + cuajada con melao', 'Ideal para compartir, preparado al momento.', 28500, TRUE),
  (22, 3, 12, 'Combo para compartir Arroz chino + jugo de mora', 'Incluye productos frescos de la casa.', 36000, TRUE),
  (23, 4, 4, 'Cachama asada', 'Acompañado de arepa y guarnición.', 46000, TRUE),
  (24, 4, 4, 'Carne a la llanera', NULL, 27000, TRUE),
  (25, 4, 4, 'Tungos', 'Receta del llano con ingredientes de la región.', 25000, TRUE),
  (26, 4, 4, 'Sancocho de gallina', NULL, 23000, TRUE),
  (27, 4, 4, 'Hayaca', 'Acompañado de arepa y guarnición.', 41500, TRUE),
  (28, 4, 11, 'Gaseosa', 'Servida fría en tamaño personal.', 5000, TRUE),
  (29, 4, 10, 'Cuajada con melao', NULL, 6500, TRUE),
  (30, 4, 12, 'Combo Hayaca + gaseosa + cuajada con melao', 'Una combinación de productos seleccionados del menú.', 47500, TRUE),
  (31, 4, 12, 'Combo para compartir Carne a la llanera + gaseosa', NULL, 53000, TRUE),
  (32, 5, 6, 'Arroz tres delicias', NULL, 15000, TRUE),
  (33, 5, 6, 'Carne con brócoli', 'Salteado al wok con verduras frescas.', 25500, TRUE),
  (34, 5, 6, 'Arroz chino', NULL, 28000, FALSE),
  (35, 5, 6, 'Pollo agridulce', 'Salteado al wok con verduras frescas.', 19500, TRUE),
  (36, 5, 11, 'Limonada natural', NULL, 8000, TRUE),
  (37, 5, 10, 'Flan de caramelo', NULL, 11500, TRUE),
  (38, 5, 12, 'Combo Carne con brócoli + limonada natural + flan de caramelo', 'Ideal para compartir, preparado al momento.', 40500, TRUE),
  (39, 6, 8, 'Tamales de pollo', NULL, 21500, TRUE),
  (40, 6, 8, 'Quesadilla de pollo', NULL, 19000, TRUE),
  (41, 6, 8, 'Nachos con guacamole', NULL, 20500, TRUE),
  (42, 6, 8, 'Tacos al pastor', NULL, 13500, TRUE),
  (43, 6, 8, 'Enchiladas', NULL, 14000, FALSE),
  (44, 6, 11, 'Limonada natural', NULL, 6500, TRUE),
  (45, 6, 10, 'Torta de chocolate', NULL, 11000, TRUE),
  (46, 6, 12, 'Combo Tacos al pastor + limonada natural + torta de chocolate', NULL, 27500, TRUE),
  (47, 7, 6, 'Pollo con verduras', NULL, 25500, TRUE),
  (48, 7, 6, 'Cerdo agridulce', NULL, 17500, TRUE),
  (49, 7, 6, 'Rollitos primavera', 'Salteado al wok con verduras frescas.', 23500, TRUE),
  (50, 7, 6, 'Chow mein', NULL, 20000, TRUE),
  (51, 7, 11, 'Jugo de maracuyá', 'Bebida fría preparada al momento.', 4000, TRUE),
  (52, 7, 10, 'Flan de caramelo', NULL, 6000, TRUE),
  (53, 7, 12, 'Combo Pollo con verduras + jugo de maracuyá', 'Incluye productos frescos de la casa.', 26500, TRUE),
  (54, 8, 5, 'Parrillada mixta', NULL, 38000, TRUE),
  (55, 8, 5, 'Churrasco', 'Sellado al carbón con especias suaves.', 19000, TRUE),
  (56, 8, 5, 'Lomo de cerdo', NULL, 32000, TRUE),
  (57, 8, 5, 'Morcilla', NULL, 25000, TRUE),
  (58, 8, 11, 'Limonada natural', 'Servida fría en tamaño personal.', 8000, TRUE),
  (59, 8, 10, 'Arroz con leche', 'Porción individual elaborada al horno.', 10000, TRUE),
  (60, 8, 12, 'Combo Morcilla + limonada natural + arroz con leche', NULL, 38500, TRUE),
  (61, 8, 12, 'Combo para compartir Churrasco + limonada natural', 'Incluye productos frescos de la casa.', 41000, TRUE),
  (62, 9, 9, 'Ensalada de quinoa', 'Opción balanceada servida al momento.', 28500, TRUE),
  (63, 9, 9, 'Ensalada César', NULL, 14500, TRUE),
  (64, 9, 9, 'Wrap de pollo', NULL, 14500, TRUE),
  (65, 9, 11, 'Té frío', NULL, 6500, TRUE),
  (66, 9, 10, 'Torta de chocolate', 'Preparado en casa con ingredientes frescos.', 8000, TRUE),
  (67, 9, 12, 'Combo Wrap de pollo + té frío + torta de chocolate', NULL, 26000, TRUE),
  (68, 10, 7, 'Roll de salmón y queso', 'Arroz sazonado y vegetales frescos.', 23500, TRUE),
  (69, 10, 7, 'Sashimi de atún', 'Acompañado de salsa de la casa.', 22500, TRUE),
  (70, 10, 7, 'Tempura roll', NULL, 41500, TRUE),
  (71, 10, 7, 'Maki de aguacate', NULL, 24000, TRUE),
  (72, 10, 11, 'Té frío', NULL, 8500, TRUE),
  (73, 10, 10, 'Tarta de limón', 'Preparado en casa con ingredientes frescos.', 6500, TRUE),
  (74, 10, 12, 'Combo Maki de aguacate + té frío + tarta de limón', 'Incluye productos frescos de la casa.', 35000, TRUE),
  (75, 10, 12, 'Combo para compartir Tempura roll + té frío', NULL, 82000, TRUE),
  (76, 11, 3, 'Pechuga a la plancha', 'Receta casera con hierbas frescas.', 30500, TRUE),
  (77, 11, 3, 'Pollo apanado', NULL, 24000, TRUE),
  (78, 11, 3, 'Arroz con pollo', 'Acompañado de guarnición del día.', 25500, TRUE),
  (79, 11, 11, 'Limonada natural', 'Servida fría en tamaño personal.', 3000, TRUE),
  (80, 11, 10, 'Arroz con leche', 'Porción individual elaborada al horno.', 7000, TRUE),
  (81, 11, 12, 'Combo Pechuga a la plancha + limonada natural + arroz con leche', NULL, 36000, TRUE),
  (82, 11, 12, 'Combo para compartir Pollo apanado + limonada natural', NULL, 45500, TRUE),
  (83, 12, 2, 'Napolitana', NULL, 36500, TRUE),
  (84, 12, 2, 'Vegetariana', NULL, 34000, TRUE),
  (85, 12, 2, 'Hawaiana', 'Masa delgada horneada al momento.', 36000, TRUE),
  (86, 12, 2, 'Champiñones', NULL, 20000, TRUE),
  (87, 12, 2, 'Margarita', 'Quesos y vegetales sobre masa artesanal.', 35000, TRUE),
  (88, 12, 11, 'Jugo de mora', NULL, 3500, TRUE),
  (89, 12, 10, 'Flan de caramelo', 'Dulce suave para terminar la comida.', 5500, TRUE),
  (90, 12, 12, 'Combo Champiñones + jugo de mora + flan de caramelo', 'Incluye productos frescos de la casa.', 26000, TRUE),
  (91, 13, 8, 'Burrito vegetariano', 'Acompañado de guacamole fresco.', 17000, TRUE),
  (92, 13, 8, 'Tacos al pastor', NULL, 27500, TRUE),
  (93, 13, 8, 'Nachos con guacamole', 'Acompañado de guacamole fresco.', 20000, TRUE),
  (94, 13, 8, 'Tamales de pollo', NULL, 27500, TRUE),
  (95, 13, 8, 'Enchiladas', 'Acompañado de guacamole fresco.', 22500, TRUE),
  (96, 13, 11, 'Limonada natural', NULL, 3500, TRUE),
  (97, 13, 10, 'Tres leches', NULL, 6500, TRUE),
  (98, 13, 12, 'Combo Nachos con guacamole + limonada natural + tres leches', NULL, 27000, FALSE),
  (99, 13, 12, 'Combo para compartir Burrito vegetariano + limonada natural', 'Ideal para compartir, preparado al momento.', 33500, TRUE),
  (100, 14, 7, 'Tempura roll', 'Acompañado de salsa de la casa.', 25000, TRUE),
  (101, 14, 7, 'Roll de salmón y queso', 'Arroz sazonado y vegetales frescos.', 29000, TRUE),
  (102, 14, 7, 'California roll', NULL, 31000, TRUE),
  (103, 14, 7, 'Nigiri de camarón', 'Acompañado de salsa de la casa.', 36000, TRUE),
  (104, 14, 7, 'Maki de aguacate', 'Preparado al momento en porciones pequeñas.', 32000, TRUE),
  (105, 14, 11, 'Aguapanela fría', 'Fruta natural con hielo y un toque cítrico.', 8500, TRUE),
  (106, 14, 10, 'Flan de caramelo', NULL, 5500, TRUE),
  (107, 14, 12, 'Combo Tempura roll + aguapanela fría + flan de caramelo', 'Incluye productos frescos de la casa.', 35000, TRUE),
  (108, 15, 1, 'Criolla', 'Preparada al momento con ingredientes locales.', 23000, TRUE),
  (109, 15, 1, 'Clásica', NULL, 15000, TRUE),
  (110, 15, 1, 'Tocineta y queso', 'Preparada al momento con ingredientes locales.', 18500, FALSE),
  (111, 15, 1, 'Doble carne', 'Preparada al momento con ingredientes locales.', 20500, TRUE),
  (112, 15, 11, 'Jugo de mango', NULL, 6500, TRUE),
  (113, 15, 10, 'Torta de chocolate', NULL, 5500, TRUE),
  (114, 15, 12, 'Combo Doble carne + jugo de mango + torta de chocolate', NULL, 29000, FALSE),
  (115, 16, 5, 'Parrillada mixta', 'Acompañado de papa y ensalada fresca.', 33500, TRUE),
  (116, 16, 5, 'Churrasco', NULL, 45000, TRUE),
  (117, 16, 5, 'Morcilla', 'Corte preparado a la brasa.', 31500, TRUE),
  (118, 16, 5, 'Punta de anca', 'Sellado al carbón con especias suaves.', 30500, FALSE),
  (119, 16, 5, 'Lomo de cerdo', NULL, 36000, TRUE),
  (120, 16, 11, 'Té frío', NULL, 4500, TRUE),
  (121, 16, 10, 'Tarta de limón', NULL, 8500, TRUE),
  (122, 16, 12, 'Combo Morcilla + té frío + tarta de limón', 'Una combinación de productos seleccionados del menú.', 40000, TRUE),
  (123, 17, 8, 'Burrito de carne', 'Receta casera con salsa suave.', 29500, FALSE),
  (124, 17, 8, 'Fajitas mixtas', NULL, 28000, TRUE),
  (125, 17, 8, 'Burrito vegetariano', 'Maíz, frijoles y vegetales de temporada.', 27500, TRUE),
  (126, 17, 8, 'Tostadas de tinga', NULL, 14000, TRUE),
  (127, 17, 8, 'Enchiladas', NULL, 15000, TRUE),
  (128, 17, 11, 'Gaseosa', 'Bebida fría preparada al momento.', 3000, TRUE),
  (129, 17, 10, 'Tres leches', NULL, 8000, TRUE),
  (130, 17, 12, 'Combo Burrito vegetariano + gaseosa + tres leches', 'Incluye productos frescos de la casa.', 34500, TRUE),
  (131, 18, 2, 'Pepperoni', 'Preparada en horno con ingredientes frescos.', 42500, TRUE),
  (132, 18, 2, 'Jamón y maíz', NULL, 36500, TRUE),
  (133, 18, 2, 'Champiñones', 'Quesos y vegetales sobre masa artesanal.', 40000, TRUE),
  (134, 18, 11, 'Limonada natural', NULL, 6000, TRUE),
  (135, 18, 10, 'Tres leches', 'Preparado en casa con ingredientes frescos.', 7500, TRUE),
  (136, 18, 12, 'Combo Pepperoni + limonada natural + tres leches', NULL, 50000, TRUE),
  (137, 18, 12, 'Combo para compartir Jamón y maíz + limonada natural', NULL, 71000, TRUE),
  (138, 19, 2, 'Vegetariana', NULL, 21000, FALSE),
  (139, 19, 2, 'Pollo BBQ', NULL, 38500, TRUE),
  (140, 19, 2, 'Cuatro quesos', 'Preparada en horno con ingredientes frescos.', 29000, TRUE),
  (141, 19, 11, 'Jugo de maracuyá', NULL, 3000, TRUE),
  (142, 19, 10, 'Torta de chocolate', NULL, 5000, TRUE),
  (143, 19, 12, 'Combo Pollo BBQ + jugo de maracuyá + torta de chocolate', 'Ideal para compartir, preparado al momento.', 41500, TRUE),
  (144, 19, 12, 'Combo para compartir Cuatro quesos + jugo de maracuyá', NULL, 54500, TRUE),
  (145, 20, 4, 'Pisillo', 'Acompañado de arepa y guarnición.', 38500, TRUE),
  (146, 20, 4, 'Mamona', NULL, 34000, TRUE),
  (147, 20, 4, 'Cachama asada', 'Acompañado de arepa y guarnición.', 30500, TRUE),
  (148, 20, 4, 'Ternera a la llanera', NULL, 29000, TRUE),
  (149, 20, 11, 'Jugo de maracuyá', 'Servida fría en tamaño personal.', 9000, TRUE),
  (150, 20, 10, 'Cuajada con melao', NULL, 5000, TRUE),
  (151, 20, 12, 'Combo Pisillo + jugo de maracuyá + cuajada con melao', NULL, 47000, TRUE),
  (152, 20, 12, 'Combo para compartir Ternera a la llanera + jugo de maracuyá', 'Una combinación de productos seleccionados del menú.', 60000, TRUE),
  (153, 21, 8, 'Burrito de carne', 'Maíz, frijoles y vegetales de temporada.', 18000, TRUE),
  (154, 21, 8, 'Fajitas mixtas', 'Acompañado de guacamole fresco.', 13000, TRUE),
  (155, 21, 8, 'Quesadilla de pollo', NULL, 30000, TRUE),
  (156, 21, 8, 'Tamales de pollo', 'Maíz, frijoles y vegetales de temporada.', 15000, TRUE),
  (157, 21, 11, 'Jugo de mango', NULL, 8500, TRUE),
  (158, 21, 10, 'Torta de chocolate', NULL, 6000, TRUE),
  (159, 21, 12, 'Combo Fajitas mixtas + jugo de mango + torta de chocolate', 'Incluye productos frescos de la casa.', 24500, TRUE),
  (160, 21, 12, 'Combo para compartir Tamales de pollo + jugo de mango', 'Una combinación de productos seleccionados del menú.', 34500, FALSE),
  (161, 22, 2, 'Vegetariana', 'Quesos y vegetales sobre masa artesanal.', 20500, TRUE),
  (162, 22, 2, 'Pollo BBQ', NULL, 35500, TRUE),
  (163, 22, 2, 'Cuatro quesos', 'Preparada en horno con ingredientes frescos.', 33500, TRUE),
  (164, 22, 2, 'Margarita', 'Masa delgada horneada al momento.', 30000, TRUE),
  (165, 22, 2, 'Pepperoni', 'Quesos y vegetales sobre masa artesanal.', 35500, TRUE),
  (166, 22, 11, 'Jugo de mango', 'Fruta natural con hielo y un toque cítrico.', 6000, TRUE),
  (167, 22, 10, 'Brevas con arequipe', NULL, 8000, TRUE),
  (168, 22, 12, 'Combo Pepperoni + jugo de mango + brevas con arequipe', 'Incluye productos frescos de la casa.', 44500, TRUE),
  (169, 22, 12, 'Combo para compartir Margarita + jugo de mango', 'Una combinación de productos seleccionados del menú.', 59000, TRUE),
  (170, 23, 9, 'Tostada de aguacate', 'Opción balanceada servida al momento.', 26000, TRUE),
  (171, 23, 9, 'Lentejas con vegetales', 'Opción balanceada servida al momento.', 29000, TRUE),
  (172, 23, 9, 'Sopa de verduras', NULL, 22500, TRUE),
  (173, 23, 11, 'Jugo de maracuyá', NULL, 7000, TRUE),
  (174, 23, 10, 'Tarta de limón', 'Preparado en casa con ingredientes frescos.', 5000, TRUE),
  (175, 23, 12, 'Combo Tostada de aguacate + jugo de maracuyá + tarta de limón', 'Ideal para compartir, preparado al momento.', 34000, TRUE),
  (176, 23, 12, 'Combo para compartir Sopa de verduras + jugo de maracuyá', 'Incluye productos frescos de la casa.', 46500, TRUE),
  (177, 24, 6, 'Arroz chino', 'Preparación casera con arroz y salsa ligera.', 21500, TRUE),
  (178, 24, 6, 'Carne con brócoli', 'Servido caliente con ingredientes del día.', 18000, TRUE),
  (179, 24, 6, 'Fideos con pollo', NULL, 16500, TRUE),
  (180, 24, 11, 'Jugo de mango', 'Servida fría en tamaño personal.', 5500, TRUE),
  (181, 24, 10, 'Cuajada con melao', NULL, 5000, TRUE),
  (182, 24, 12, 'Combo Carne con brócoli + jugo de mango + cuajada con melao', 'Ideal para compartir, preparado al momento.', 25500, TRUE),
  (183, 24, 12, 'Combo para compartir Fideos con pollo + jugo de mango', NULL, 34500, TRUE),
  (184, 25, 3, 'Sándwich de pollo', 'Acompañado de guarnición del día.', 16000, TRUE),
  (185, 25, 3, 'Pechuga a la plancha', 'Pollo sazonado y preparado al horno.', 29500, TRUE),
  (186, 25, 3, 'Nuggets de pollo', 'Receta casera con hierbas frescas.', 29500, TRUE),
  (187, 25, 3, 'Pollo asado', 'Receta casera con hierbas frescas.', 14500, TRUE),
  (188, 25, 11, 'Agua en botella', 'Fruta natural con hielo y un toque cítrico.', 6500, TRUE),
  (189, 25, 10, 'Tarta de limón', 'Dulce suave para terminar la comida.', 5500, TRUE),
  (190, 25, 12, 'Combo Pollo asado + agua en botella + tarta de limón', NULL, 23500, TRUE),
  (191, 25, 12, 'Combo para compartir Nuggets de pollo + agua en botella', 'Ideal para compartir, preparado al momento.', 58500, TRUE),
  (192, 26, 3, 'Sándwich de pollo', 'Pollo sazonado y preparado al horno.', 28500, TRUE),
  (193, 26, 3, 'Nuggets de pollo', NULL, 20500, TRUE),
  (194, 26, 3, 'Pollo al ajillo', NULL, 20500, TRUE),
  (195, 26, 3, 'Arroz con pollo', 'Acompañado de guarnición del día.', 27500, TRUE),
  (196, 26, 3, 'Alitas BBQ', NULL, 27500, TRUE),
  (197, 26, 11, 'Gaseosa', 'Servida fría en tamaño personal.', 7500, TRUE),
  (198, 26, 10, 'Tres leches', 'Preparado en casa con ingredientes frescos.', 11500, TRUE),
  (199, 26, 12, 'Combo Arroz con pollo + gaseosa + tres leches', NULL, 41500, FALSE),
  (200, 27, 9, 'Ensalada César', NULL, 19000, TRUE),
  (201, 27, 9, 'Sopa de verduras', NULL, 16500, TRUE),
  (202, 27, 9, 'Wrap de pollo', NULL, 18500, TRUE),
  (203, 27, 9, 'Pechuga con vegetales', NULL, 20500, TRUE),
  (204, 27, 11, 'Aguapanela fría', NULL, 6000, TRUE),
  (205, 27, 10, 'Tarta de limón', 'Dulce suave para terminar la comida.', 11500, TRUE),
  (206, 27, 12, 'Combo Ensalada César + aguapanela fría + tarta de limón', NULL, 32500, TRUE),
  (207, 27, 12, 'Combo para compartir Pechuga con vegetales + aguapanela fría', NULL, 42000, TRUE),
  (208, 28, 9, 'Bowl de quinoa', NULL, 24500, TRUE),
  (209, 28, 9, 'Bowl de garbanzos', NULL, 20000, TRUE),
  (210, 28, 9, 'Wrap de pollo', 'Ingredientes frescos y aderezo ligero.', 14500, TRUE),
  (211, 28, 9, 'Ensalada César', NULL, 23000, TRUE),
  (212, 28, 11, 'Té frío', NULL, 8000, TRUE),
  (213, 28, 10, 'Tarta de limón', NULL, 5500, TRUE),
  (214, 28, 12, 'Combo Bowl de garbanzos + té frío + tarta de limón', 'Incluye productos frescos de la casa.', 30000, TRUE),
  (215, 29, 5, 'Lomo de cerdo', 'Sellado al carbón con especias suaves.', 17500, TRUE),
  (216, 29, 5, 'Morcilla', 'Corte preparado a la brasa.', 35500, TRUE),
  (217, 29, 5, 'Punta de anca', 'Sellado al carbón con especias suaves.', 21000, TRUE),
  (218, 29, 11, 'Limonada natural', 'Bebida fría preparada al momento.', 3000, TRUE),
  (219, 29, 10, 'Tarta de limón', 'Porción individual elaborada al horno.', 10000, TRUE),
  (220, 29, 12, 'Combo Lomo de cerdo + limonada natural + tarta de limón', 'Ideal para compartir, preparado al momento.', 27000, TRUE),
  (221, 30, 7, 'Tempura roll', 'Acompañado de salsa de la casa.', 34500, FALSE),
  (222, 30, 7, 'Nigiri de salmón', NULL, 32000, TRUE),
  (223, 30, 7, 'Sashimi de atún', NULL, 22500, TRUE),
  (224, 30, 7, 'Maki de aguacate', 'Acompañado de salsa de la casa.', 31000, TRUE),
  (225, 30, 7, 'Roll de salmón y queso', NULL, 34000, TRUE),
  (226, 30, 11, 'Jugo de maracuyá', 'Servida fría en tamaño personal.', 5500, TRUE),
  (227, 30, 10, 'Brevas con arequipe', NULL, 6000, TRUE),
  (228, 30, 12, 'Combo Maki de aguacate + jugo de maracuyá + brevas con arequipe', 'Incluye productos frescos de la casa.', 38000, TRUE),
  (229, 31, 5, 'Chorizo a la parrilla', 'Sellado al carbón con especias suaves.', 43500, TRUE),
  (230, 31, 5, 'Lomo de cerdo', NULL, 38500, TRUE),
  (231, 31, 5, 'Pollo a la parrilla', 'Corte preparado a la brasa.', 34500, TRUE),
  (232, 31, 5, 'Parrillada mixta', NULL, 42000, TRUE),
  (233, 31, 11, 'Limonada natural', NULL, 5500, TRUE),
  (234, 31, 10, 'Arroz con leche', 'Porción individual elaborada al horno.', 11500, TRUE),
  (235, 31, 12, 'Combo Parrillada mixta + limonada natural + arroz con leche', NULL, 53000, TRUE),
  (236, 31, 12, 'Combo para compartir Pollo a la parrilla + limonada natural', NULL, 67000, TRUE),
  (237, 32, 4, 'Hayaca', NULL, 48000, TRUE),
  (238, 32, 4, 'Pisillo', NULL, 35500, TRUE),
  (239, 32, 4, 'Mamona', 'Acompañado de arepa y guarnición.', 41000, TRUE),
  (240, 32, 4, 'Tungos', NULL, 27000, TRUE),
  (241, 32, 4, 'Sancocho de gallina', 'Preparado a fuego lento y servido caliente.', 34500, TRUE),
  (242, 32, 11, 'Jugo de mora', NULL, 3500, TRUE),
  (243, 32, 10, 'Torta de chocolate', NULL, 5500, TRUE),
  (244, 32, 12, 'Combo Hayaca + jugo de mora + torta de chocolate', NULL, 51000, TRUE),
  (245, 33, 2, 'Vegetariana', 'Masa delgada horneada al momento.', 30000, TRUE),
  (246, 33, 2, 'Hawaiana', 'Quesos y vegetales sobre masa artesanal.', 17000, TRUE),
  (247, 33, 2, 'Pollo BBQ', 'Preparada en horno con ingredientes frescos.', 29000, TRUE),
  (248, 33, 2, 'Margarita', 'Masa delgada horneada al momento.', 34000, TRUE),
  (249, 33, 11, 'Jugo de mango', NULL, 4500, TRUE),
  (250, 33, 10, 'Brevas con arequipe', 'Preparado en casa con ingredientes frescos.', 8500, TRUE),
  (251, 33, 12, 'Combo Vegetariana + jugo de mango + brevas con arequipe', NULL, 38500, TRUE),
  (252, 34, 4, 'Arepa de cuajada', NULL, 41500, TRUE),
  (253, 34, 4, 'Cachama asada', NULL, 19000, TRUE),
  (254, 34, 4, 'Carne a la llanera', 'Receta del llano con ingredientes de la región.', 36500, TRUE),
  (255, 34, 4, 'Mamona', 'Acompañado de arepa y guarnición.', 41000, TRUE),
  (256, 34, 4, 'Pisillo', 'Acompañado de arepa y guarnición.', 41500, TRUE),
  (257, 34, 11, 'Jugo de mora', NULL, 3500, TRUE),
  (258, 34, 10, 'Cuajada con melao', 'Preparado en casa con ingredientes frescos.', 9000, TRUE),
  (259, 34, 12, 'Combo Cachama asada + jugo de mora + cuajada con melao', NULL, 28000, TRUE),
  (260, 34, 12, 'Combo para compartir Mamona + jugo de mora', 'Ideal para compartir, preparado al momento.', 76500, TRUE),
  (261, 35, 8, 'Burrito de carne', NULL, 29500, TRUE),
  (262, 35, 8, 'Tacos al pastor', 'Maíz, frijoles y vegetales de temporada.', 15500, TRUE),
  (263, 35, 8, 'Tostadas de tinga', NULL, 16500, TRUE),
  (264, 35, 8, 'Enchiladas', NULL, 13500, TRUE),
  (265, 35, 11, 'Té frío', NULL, 7500, TRUE),
  (266, 35, 10, 'Tres leches', NULL, 12000, TRUE),
  (267, 35, 12, 'Combo Tacos al pastor + té frío + tres leches', 'Incluye productos frescos de la casa.', 31500, TRUE),
  (268, 35, 12, 'Combo para compartir Burrito de carne + té frío', 'Ideal para compartir, preparado al momento.', 59500, TRUE),
  (269, 36, 2, 'Margarita', NULL, 34500, TRUE),
  (270, 36, 2, 'Jamón y maíz', NULL, 18000, TRUE),
  (271, 36, 2, 'Pepperoni', 'Quesos y vegetales sobre masa artesanal.', 24500, TRUE),
  (272, 36, 2, 'Cuatro quesos', NULL, 24000, TRUE),
  (273, 36, 11, 'Jugo de maracuyá', NULL, 8500, TRUE),
  (274, 36, 10, 'Brownie', 'Dulce suave para terminar la comida.', 10500, TRUE),
  (275, 36, 12, 'Combo Margarita + jugo de maracuyá + brownie', NULL, 48000, TRUE),
  (276, 36, 12, 'Combo para compartir Cuatro quesos + jugo de maracuyá', 'Una combinación de productos seleccionados del menú.', 50500, TRUE),
  (277, 37, 5, 'Morcilla', 'Corte preparado a la brasa.', 36000, TRUE),
  (278, 37, 5, 'Carne asada', 'Acompañado de papa y ensalada fresca.', 25000, TRUE),
  (279, 37, 5, 'Punta de anca', NULL, 38500, TRUE),
  (280, 37, 5, 'Chorizo a la parrilla', NULL, 37000, TRUE),
  (281, 37, 11, 'Jugo de mora', NULL, 3500, TRUE),
  (282, 37, 10, 'Arroz con leche', NULL, 10000, TRUE),
  (283, 37, 12, 'Combo Chorizo a la parrilla + jugo de mora + arroz con leche', NULL, 45000, TRUE),
  (284, 38, 6, 'Rollitos primavera', NULL, 28000, TRUE),
  (285, 38, 6, 'Arroz tres delicias', 'Servido caliente con ingredientes del día.', 19500, TRUE),
  (286, 38, 6, 'Pollo agridulce', NULL, 25000, TRUE),
  (287, 38, 6, 'Carne con brócoli', NULL, 25000, TRUE),
  (288, 38, 11, 'Jugo de maracuyá', NULL, 4000, TRUE),
  (289, 38, 10, 'Arroz con leche', NULL, 5000, TRUE),
  (290, 38, 12, 'Combo Arroz tres delicias + jugo de maracuyá + arroz con leche', NULL, 25500, TRUE),
  (291, 38, 12, 'Combo para compartir Carne con brócoli + jugo de maracuyá', NULL, 48500, TRUE),
  (292, 39, 8, 'Enchiladas', 'Maíz, frijoles y vegetales de temporada.', 23500, TRUE),
  (293, 39, 8, 'Tacos al pastor', 'Receta casera con salsa suave.', 15500, FALSE),
  (294, 39, 8, 'Quesadilla de pollo', NULL, 15500, FALSE),
  (295, 39, 8, 'Tamales de pollo', NULL, 23500, TRUE),
  (296, 39, 11, 'Aguapanela fría', NULL, 8000, TRUE),
  (297, 39, 10, 'Brevas con arequipe', NULL, 9000, TRUE),
  (298, 39, 12, 'Combo Enchiladas + aguapanela fría + brevas con arequipe', NULL, 36000, TRUE),
  (299, 40, 7, 'Nigiri de salmón', 'Acompañado de salsa de la casa.', 33000, TRUE),
  (300, 40, 7, 'Tempura roll', 'Arroz sazonado y vegetales frescos.', 37000, TRUE),
  (301, 40, 7, 'Roll vegetariano', 'Arroz sazonado y vegetales frescos.', 33000, TRUE),
  (302, 40, 7, 'Nigiri de camarón', NULL, 24000, TRUE),
  (303, 40, 11, 'Té frío', 'Fruta natural con hielo y un toque cítrico.', 8500, TRUE),
  (304, 40, 10, 'Arroz con leche', NULL, 10500, TRUE),
  (305, 40, 12, 'Combo Nigiri de salmón + té frío + arroz con leche', 'Incluye productos frescos de la casa.', 46500, FALSE),
  (306, 41, 4, 'Carne a la llanera', 'Preparado a fuego lento y servido caliente.', 42500, TRUE),
  (307, 41, 4, 'Cachama asada', 'Preparado a fuego lento y servido caliente.', 36000, TRUE),
  (308, 41, 4, 'Arepa de cuajada', NULL, 41500, TRUE),
  (309, 41, 4, 'Hayaca', NULL, 29000, TRUE),
  (310, 41, 11, 'Limonada natural', 'Servida fría en tamaño personal.', 4500, TRUE),
  (311, 41, 10, 'Tarta de limón', 'Preparado en casa con ingredientes frescos.', 10000, TRUE),
  (312, 41, 12, 'Combo Hayaca + limonada natural + tarta de limón', 'Ideal para compartir, preparado al momento.', 39000, TRUE),
  (313, 42, 9, 'Lentejas con vegetales', NULL, 26500, TRUE),
  (314, 42, 9, 'Tostada de aguacate', NULL, 19500, TRUE),
  (315, 42, 9, 'Sopa de verduras', 'Ingredientes frescos y aderezo ligero.', 13500, TRUE),
  (316, 42, 9, 'Ensalada de quinoa', 'Opción balanceada servida al momento.', 19000, TRUE),
  (317, 42, 11, 'Té frío', 'Servida fría en tamaño personal.', 8500, TRUE),
  (318, 42, 10, 'Arroz con leche', 'Dulce suave para terminar la comida.', 7000, TRUE),
  (319, 42, 12, 'Combo Lentejas con vegetales + té frío + arroz con leche', NULL, 37500, TRUE),
  (320, 43, 3, 'Alitas BBQ', 'Receta casera con hierbas frescas.', 13500, TRUE),
  (321, 43, 3, 'Pollo apanado', 'Acompañado de guarnición del día.', 19000, TRUE),
  (322, 43, 3, 'Nuggets de pollo', NULL, 31500, TRUE),
  (323, 43, 3, 'Pollo al ajillo', 'Pollo sazonado y preparado al horno.', 18000, TRUE),
  (324, 43, 11, 'Jugo de mora', NULL, 7500, TRUE),
  (325, 43, 10, 'Tres leches', NULL, 8000, TRUE),
  (326, 43, 12, 'Combo Alitas BBQ + jugo de mora + tres leches', NULL, 26000, TRUE),
  (327, 44, 6, 'Chow mein', 'Preparación casera con arroz y salsa ligera.', 26500, TRUE),
  (328, 44, 6, 'Arroz tres delicias', NULL, 30000, TRUE),
  (329, 44, 6, 'Carne con brócoli', NULL, 27000, TRUE),
  (330, 44, 6, 'Fideos con pollo', 'Servido caliente con ingredientes del día.', 22000, TRUE),
  (331, 44, 11, 'Jugo de maracuyá', 'Servida fría en tamaño personal.', 6500, TRUE),
  (332, 44, 10, 'Brownie', 'Dulce suave para terminar la comida.', 7000, TRUE),
  (333, 44, 12, 'Combo Arroz tres delicias + jugo de maracuyá + brownie', 'Una combinación de productos seleccionados del menú.', 39000, TRUE),
  (334, 45, 4, 'Ternera a la llanera', NULL, 23000, TRUE),
  (335, 45, 4, 'Mamona', 'Receta del llano con ingredientes de la región.', 42500, FALSE),
  (336, 45, 4, 'Tungos', 'Preparado a fuego lento y servido caliente.', 45500, TRUE),
  (337, 45, 11, 'Gaseosa', 'Servida fría en tamaño personal.', 3000, TRUE),
  (338, 45, 10, 'Torta de chocolate', NULL, 7000, TRUE),
  (339, 45, 12, 'Combo Tungos + gaseosa + torta de chocolate', 'Una combinación de productos seleccionados del menú.', 49500, TRUE),
  (340, 46, 1, 'Criolla', 'Acompañada de una porción de papas doradas.', 24500, TRUE),
  (341, 46, 1, 'Tocineta y queso', 'Acompañada de una porción de papas doradas.', 15500, TRUE),
  (342, 46, 1, 'Doble carne', 'Preparada al momento con ingredientes locales.', 24000, TRUE),
  (343, 46, 11, 'Jugo de mora', NULL, 9000, TRUE),
  (344, 46, 10, 'Brownie', 'Preparado en casa con ingredientes frescos.', 6500, TRUE),
  (345, 46, 12, 'Combo Doble carne + jugo de mora + brownie', NULL, 35500, TRUE),
  (346, 46, 12, 'Combo para compartir Tocineta y queso + jugo de mora', NULL, 36000, TRUE),
  (347, 47, 5, 'Parrillada mixta', 'Corte preparado a la brasa.', 37000, TRUE),
  (348, 47, 5, 'Carne asada', 'Sellado al carbón con especias suaves.', 21500, TRUE),
  (349, 47, 5, 'Pollo a la parrilla', 'Sellado al carbón con especias suaves.', 34500, TRUE),
  (350, 47, 11, 'Jugo de mango', 'Fruta natural con hielo y un toque cítrico.', 8500, TRUE),
  (351, 47, 10, 'Flan de caramelo', NULL, 7500, TRUE),
  (352, 47, 12, 'Combo Parrillada mixta + jugo de mango + flan de caramelo', 'Incluye productos frescos de la casa.', 47500, TRUE),
  (353, 47, 12, 'Combo para compartir Pollo a la parrilla + jugo de mango', 'Ideal para compartir, preparado al momento.', 69500, TRUE),
  (354, 48, 6, 'Pollo con verduras', NULL, 20000, TRUE),
  (355, 48, 6, 'Arroz chino', NULL, 26000, TRUE),
  (356, 48, 6, 'Pollo agridulce', NULL, 23500, TRUE),
  (357, 48, 6, 'Cerdo agridulce', NULL, 18500, TRUE),
  (358, 48, 6, 'Carne con brócoli', NULL, 28500, TRUE),
  (359, 48, 11, 'Limonada natural', NULL, 7000, TRUE),
  (360, 48, 10, 'Brevas con arequipe', NULL, 6000, TRUE),
  (361, 48, 12, 'Combo Carne con brócoli + limonada natural + brevas con arequipe', 'Incluye productos frescos de la casa.', 37000, TRUE),
  (362, 49, 9, 'Sopa de verduras', 'Opción balanceada servida al momento.', 25000, TRUE),
  (363, 49, 9, 'Ensalada César', NULL, 24000, TRUE),
  (364, 49, 9, 'Tostada de aguacate', 'Ingredientes frescos y aderezo ligero.', 29000, TRUE),
  (365, 49, 9, 'Lentejas con vegetales', 'Preparado con granos y vegetales de temporada.', 25500, TRUE),
  (366, 49, 11, 'Limonada natural', 'Fruta natural con hielo y un toque cítrico.', 9000, TRUE),
  (367, 49, 10, 'Flan de caramelo', 'Dulce suave para terminar la comida.', 5000, TRUE),
  (368, 49, 12, 'Combo Tostada de aguacate + limonada natural + flan de caramelo', NULL, 38500, TRUE),
  (369, 50, 2, 'Cuatro quesos', 'Masa delgada horneada al momento.', 40500, TRUE),
  (370, 50, 2, 'Jamón y maíz', 'Masa delgada horneada al momento.', 39000, TRUE),
  (371, 50, 2, 'Napolitana', NULL, 39500, TRUE),
  (372, 50, 11, 'Té frío', 'Fruta natural con hielo y un toque cítrico.', 5500, TRUE),
  (373, 50, 10, 'Arroz con leche', NULL, 9500, TRUE),
  (374, 50, 12, 'Combo Jamón y maíz + té frío + arroz con leche', NULL, 48500, TRUE),
  (375, 50, 12, 'Combo para compartir Napolitana + té frío', NULL, 76000, TRUE),
  (376, 51, 4, 'Tungos', 'Receta del llano con ingredientes de la región.', 36500, TRUE),
  (377, 51, 4, 'Pisillo', 'Preparado a fuego lento y servido caliente.', 37000, TRUE),
  (378, 51, 4, 'Carne a la llanera', 'Preparado a fuego lento y servido caliente.', 43000, TRUE),
  (379, 51, 11, 'Jugo de mora', NULL, 4500, TRUE),
  (380, 51, 10, 'Tres leches', 'Porción individual elaborada al horno.', 6000, TRUE),
  (381, 51, 12, 'Combo Pisillo + jugo de mora + tres leches', NULL, 42500, FALSE),
  (382, 52, 5, 'Carne asada', NULL, 45000, TRUE),
  (383, 52, 5, 'Churrasco', NULL, 21000, TRUE),
  (384, 52, 5, 'Costillas BBQ', NULL, 20000, TRUE),
  (385, 52, 5, 'Parrillada mixta', NULL, 44000, TRUE),
  (386, 52, 5, 'Pollo a la parrilla', 'Sellado al carbón con especias suaves.', 32000, TRUE),
  (387, 52, 11, 'Jugo de maracuyá', 'Fruta natural con hielo y un toque cítrico.', 4500, TRUE),
  (388, 52, 10, 'Tres leches', 'Dulce suave para terminar la comida.', 10500, TRUE),
  (389, 52, 12, 'Combo Costillas BBQ + jugo de maracuyá + tres leches', 'Ideal para compartir, preparado al momento.', 31500, TRUE),
  (390, 53, 1, 'Pollo crispy', 'Pan tostado, vegetales frescos y salsa de la casa.', 25000, TRUE),
  (391, 53, 1, 'Clásica', 'Acompañada de una porción de papas doradas.', 22000, FALSE),
  (392, 53, 1, 'BBQ', NULL, 22500, TRUE),
  (393, 53, 1, 'Tocineta y queso', 'Pan tostado, vegetales frescos y salsa de la casa.', 23500, TRUE),
  (394, 53, 1, 'Champiñones', NULL, 19000, TRUE),
  (395, 53, 11, 'Jugo de mango', NULL, 9000, TRUE),
  (396, 53, 10, 'Tres leches', NULL, 10000, TRUE),
  (397, 53, 12, 'Combo Champiñones + jugo de mango + tres leches', 'Ideal para compartir, preparado al momento.', 34000, TRUE),
  (398, 54, 1, 'Doble carne', NULL, 14500, TRUE),
  (399, 54, 1, 'Hawaiana', NULL, 25000, TRUE),
  (400, 54, 1, 'Champiñones', 'Preparada al momento con ingredientes locales.', 17500, TRUE),
  (401, 54, 11, 'Gaseosa', NULL, 9000, TRUE),
  (402, 54, 10, 'Tres leches', 'Preparado en casa con ingredientes frescos.', 5000, TRUE),
  (403, 54, 12, 'Combo Doble carne + gaseosa + tres leches', 'Incluye productos frescos de la casa.', 25500, TRUE),
  (404, 55, 3, 'Arroz con pollo', 'Pollo sazonado y preparado al horno.', 30000, TRUE),
  (405, 55, 3, 'Pollo asado', 'Pollo sazonado y preparado al horno.', 19500, TRUE),
  (406, 55, 3, 'Pollo a la naranja', 'Receta casera con hierbas frescas.', 23000, FALSE),
  (407, 55, 11, 'Té frío', 'Fruta natural con hielo y un toque cítrico.', 8500, TRUE),
  (408, 55, 10, 'Tres leches', NULL, 5500, TRUE),
  (409, 55, 12, 'Combo Arroz con pollo + té frío + tres leches', 'Ideal para compartir, preparado al momento.', 39500, TRUE),
  (410, 56, 1, 'Criolla', 'Acompañada de una porción de papas doradas.', 25500, TRUE),
  (411, 56, 1, 'Doble carne', NULL, 16000, TRUE),
  (412, 56, 1, 'Clásica', NULL, 18500, TRUE),
  (413, 56, 11, 'Aguapanela fría', 'Servida fría en tamaño personal.', 5500, TRUE),
  (414, 56, 10, 'Torta de chocolate', NULL, 6500, TRUE),
  (415, 56, 12, 'Combo Clásica + aguapanela fría + torta de chocolate', NULL, 27000, TRUE),
  (416, 57, 3, 'Sándwich de pollo', 'Acompañado de guarnición del día.', 17000, TRUE),
  (417, 57, 3, 'Nuggets de pollo', 'Pollo sazonado y preparado al horno.', 16000, FALSE),
  (418, 57, 3, 'Pollo a la naranja', NULL, 15500, TRUE),
  (419, 57, 11, 'Gaseosa', 'Bebida fría preparada al momento.', 3000, TRUE),
  (420, 57, 10, 'Cuajada con melao', NULL, 10500, TRUE),
  (421, 57, 12, 'Combo Pollo a la naranja + gaseosa + cuajada con melao', 'Incluye productos frescos de la casa.', 26000, TRUE),
  (422, 58, 7, 'Maki de aguacate', NULL, 24000, TRUE),
  (423, 58, 7, 'Maki de pepino', NULL, 25500, TRUE),
  (424, 58, 7, 'California roll', NULL, 32500, TRUE),
  (425, 58, 11, 'Jugo de mango', NULL, 8500, TRUE),
  (426, 58, 10, 'Arroz con leche', NULL, 6000, TRUE),
  (427, 58, 12, 'Combo Maki de pepino + jugo de mango + arroz con leche', NULL, 36000, TRUE),
  (428, 59, 1, 'Criolla', 'Acompañada de una porción de papas doradas.', 25000, TRUE),
  (429, 59, 1, 'Pollo crispy', 'Preparada al momento con ingredientes locales.', 16000, FALSE),
  (430, 59, 1, 'Doble carne', NULL, 17000, TRUE),
  (431, 59, 1, 'Tocineta y queso', NULL, 16000, TRUE),
  (432, 59, 11, 'Té frío', 'Servida fría en tamaño personal.', 4500, TRUE),
  (433, 59, 10, 'Torta de chocolate', NULL, 7000, TRUE),
  (434, 59, 12, 'Combo Criolla + té frío + torta de chocolate', 'Una combinación de productos seleccionados del menú.', 32500, TRUE),
  (435, 59, 12, 'Combo para compartir Tocineta y queso + té frío', NULL, 32500, FALSE),
  (436, 60, 3, 'Pollo al ajillo', NULL, 23000, TRUE),
  (437, 60, 3, 'Arroz con pollo', 'Receta casera con hierbas frescas.', 15500, TRUE),
  (438, 60, 3, 'Nuggets de pollo', 'Acompañado de guarnición del día.', 16000, TRUE),
  (439, 60, 3, 'Alitas BBQ', 'Receta casera con hierbas frescas.', 26500, TRUE),
  (440, 60, 11, 'Gaseosa', NULL, 6500, TRUE),
  (441, 60, 10, 'Brevas con arequipe', 'Porción individual elaborada al horno.', 5000, TRUE),
  (442, 60, 12, 'Combo Nuggets de pollo + gaseosa + brevas con arequipe', 'Ideal para compartir, preparado al momento.', 24500, TRUE);
INSERT INTO COMBO_COMPONENTE (id_combo, id_componente, cantidad) VALUES
  (7, 2, 1),
  (7, 5, 1),
  (7, 6, 1),
  (8, 1, 2),
  (8, 5, 1),
  (15, 12, 1),
  (15, 13, 1),
  (15, 14, 1),
  (21, 17, 1),
  (21, 19, 1),
  (21, 20, 1),
  (22, 16, 2),
  (22, 19, 1),
  (30, 27, 1),
  (30, 28, 1),
  (30, 29, 1),
  (31, 24, 2),
  (31, 28, 1),
  (38, 33, 1),
  (38, 36, 1),
  (38, 37, 1),
  (46, 42, 1),
  (46, 44, 1),
  (46, 45, 1),
  (53, 47, 1),
  (53, 51, 1),
  (60, 57, 1),
  (60, 58, 1),
  (60, 59, 1),
  (61, 55, 2),
  (61, 58, 1),
  (67, 64, 1),
  (67, 65, 1),
  (67, 66, 1),
  (74, 71, 1),
  (74, 72, 1),
  (74, 73, 1),
  (75, 70, 2),
  (75, 72, 1),
  (81, 76, 1),
  (81, 79, 1),
  (81, 80, 1),
  (82, 77, 2),
  (82, 79, 1),
  (90, 86, 1),
  (90, 88, 1),
  (90, 89, 1),
  (98, 93, 1),
  (98, 96, 1),
  (98, 97, 1),
  (99, 91, 2),
  (99, 96, 1),
  (107, 100, 1),
  (107, 105, 1),
  (107, 106, 1),
  (114, 111, 1),
  (114, 112, 1),
  (114, 113, 1),
  (122, 117, 1),
  (122, 120, 1),
  (122, 121, 1),
  (130, 125, 1),
  (130, 128, 1),
  (130, 129, 1),
  (136, 131, 1),
  (136, 134, 1),
  (136, 135, 1),
  (137, 132, 2),
  (137, 134, 1),
  (143, 139, 1),
  (143, 141, 1),
  (143, 142, 1),
  (144, 140, 2),
  (144, 141, 1),
  (151, 145, 1),
  (151, 149, 1),
  (151, 150, 1),
  (152, 148, 2),
  (152, 149, 1),
  (159, 154, 1),
  (159, 157, 1),
  (159, 158, 1),
  (160, 156, 2),
  (160, 157, 1),
  (168, 165, 1),
  (168, 166, 1),
  (168, 167, 1),
  (169, 164, 2),
  (169, 166, 1),
  (175, 170, 1),
  (175, 173, 1),
  (175, 174, 1),
  (176, 172, 2),
  (176, 173, 1),
  (182, 178, 1),
  (182, 180, 1),
  (182, 181, 1),
  (183, 179, 2),
  (183, 180, 1),
  (190, 187, 1),
  (190, 188, 1),
  (190, 189, 1),
  (191, 186, 2),
  (191, 188, 1),
  (199, 195, 1),
  (199, 197, 1),
  (199, 198, 1),
  (206, 200, 1),
  (206, 204, 1),
  (206, 205, 1),
  (207, 203, 2),
  (207, 204, 1),
  (214, 209, 1),
  (214, 212, 1),
  (214, 213, 1),
  (220, 215, 1),
  (220, 218, 1),
  (220, 219, 1),
  (228, 224, 1),
  (228, 226, 1),
  (228, 227, 1),
  (235, 232, 1),
  (235, 233, 1),
  (235, 234, 1),
  (236, 231, 2),
  (236, 233, 1),
  (244, 237, 1),
  (244, 242, 1),
  (244, 243, 1),
  (251, 245, 1),
  (251, 249, 1),
  (251, 250, 1),
  (259, 253, 1),
  (259, 257, 1),
  (259, 258, 1),
  (260, 255, 2),
  (260, 257, 1),
  (267, 262, 1),
  (267, 265, 1),
  (267, 266, 1),
  (268, 261, 2),
  (268, 265, 1),
  (275, 269, 1),
  (275, 273, 1),
  (275, 274, 1),
  (276, 272, 2),
  (276, 273, 1),
  (283, 280, 1),
  (283, 281, 1),
  (283, 282, 1),
  (290, 285, 1),
  (290, 288, 1),
  (290, 289, 1),
  (291, 287, 2),
  (291, 288, 1),
  (298, 292, 1),
  (298, 296, 1),
  (298, 297, 1),
  (305, 299, 1),
  (305, 303, 1),
  (305, 304, 1),
  (312, 309, 1),
  (312, 310, 1),
  (312, 311, 1),
  (319, 313, 1),
  (319, 317, 1),
  (319, 318, 1),
  (326, 320, 1),
  (326, 324, 1),
  (326, 325, 1),
  (333, 328, 1),
  (333, 331, 1),
  (333, 332, 1),
  (339, 336, 1),
  (339, 337, 1),
  (339, 338, 1),
  (345, 342, 1),
  (345, 343, 1),
  (345, 344, 1),
  (346, 341, 2),
  (346, 343, 1),
  (352, 347, 1),
  (352, 350, 1),
  (352, 351, 1),
  (353, 349, 2),
  (353, 350, 1),
  (361, 358, 1),
  (361, 359, 1),
  (361, 360, 1),
  (368, 364, 1),
  (368, 366, 1),
  (368, 367, 1),
  (374, 370, 1),
  (374, 372, 1),
  (374, 373, 1),
  (375, 371, 2),
  (375, 372, 1),
  (381, 377, 1),
  (381, 379, 1),
  (381, 380, 1),
  (389, 384, 1),
  (389, 387, 1),
  (389, 388, 1),
  (397, 394, 1),
  (397, 395, 1),
  (397, 396, 1),
  (403, 398, 1),
  (403, 401, 1),
  (403, 402, 1),
  (409, 404, 1),
  (409, 407, 1),
  (409, 408, 1),
  (415, 412, 1),
  (415, 413, 1),
  (415, 414, 1),
  (421, 418, 1),
  (421, 419, 1),
  (421, 420, 1),
  (427, 423, 1),
  (427, 425, 1),
  (427, 426, 1),
  (434, 428, 1),
  (434, 432, 1),
  (434, 433, 1),
  (435, 431, 2),
  (435, 432, 1),
  (442, 438, 1),
  (442, 440, 1),
  (442, 441, 1);
INSERT INTO REPARTIDOR (id_repartidor, documento, nombres, primer_apellido, segundo_apellido, telefono, tipo_vehiculo, placa, fecha_ingreso) VALUES
  (1, '36234622', 'Tomás', 'Quiroga', 'Cabrera', '3170959819', 'moto', 'LYC79K', '2025-02-28'),
  (2, '68704129', 'Julián', 'Benítez', 'Rincón', '3190449810', 'moto', 'SPS52I', '2025-04-08'),
  (3, '39053758', 'Isabela', 'Cabrera', 'Mendoza', '3035839934', 'moto', 'MZE60G', '2025-07-24'),
  (4, '42573571', 'Samuel', 'Bustos', 'Pardo', '3139470507', 'moto', 'DYQ92U', '2023-02-28'),
  (5, '768530434', 'Mariana', 'Mendoza', NULL, '3515387839', 'moto', 'FPY38P', '2025-08-07'),
  (6, '7151292368', 'Julián', 'Bermúdez', NULL, '3197331729', 'moto', 'LAU56Y', '2024-03-17'),
  (7, '1147929696', 'Santiago', 'Cabrera', 'Bermúdez', '3202454941', 'moto', 'FTS07G', '2023-12-26'),
  (8, '744052141', 'Natalia', 'Téllez', 'Pardo', '3512174193', 'moto', 'BSM27F', '2023-04-18'),
  (9, '7259961603', 'Isabela', 'Rincón', 'Zárate', '3115639494', 'moto', 'ZIS02S', '2023-08-11'),
  (10, '3506024285', 'Lucía', 'Nieto', 'Ocampo', '3187306298', 'moto', 'KDQ87O', '2026-08-12'),
  (11, '7557058089', 'Sara', 'Cabrera', 'Bustos', '3039685069', 'moto', 'EOF36P', '2026-07-13'),
  (12, '693822620', 'Isabela', 'Ocampo', 'Pardo', '3211035101', 'moto', 'XBV30B', '2023-01-25'),
  (13, '40956475', 'Sara', 'Rincón', 'Téllez', '3182795995', 'moto', 'KYT76I', '2023-12-28'),
  (14, '1575061451', 'Laura', 'Rojas', NULL, '3147250154', 'moto', 'CVC05N', '2025-03-10'),
  (15, '652966194', 'Natalia', 'Laverde', 'Mendoza', '3511726052', 'moto', 'VAM54T', '2026-12-08'),
  (16, '39705636', 'Lucía', 'Téllez', NULL, '3033151583', 'moto', 'YBM21P', '2024-10-03'),
  (17, '518354378', 'Tomás', 'Mendoza', 'Mendoza', '3003890216', 'moto', 'TXV04P', '2025-08-02'),
  (18, '566743063', 'Diana', 'Nieto', 'Parra', '3056075924', 'moto', 'ZAW12F', '2023-09-20'),
  (19, '837314762', 'Camila', 'Pardo', NULL, '3143718615', 'moto', 'XYJ41X', '2023-01-14'),
  (20, '209018843', 'Andrés', 'Ocampo', 'Mendoza', '3501645674', 'moto', 'YIA61H', '2026-07-23'),
  (21, '484038710', 'Laura', 'Nieto', 'Nieto', '3068838200', 'moto', 'RXI25A', '2023-02-10'),
  (22, '8231224159', 'Andrés', 'Cabrera', 'Bustos', '3239664868', 'moto', 'CGK48T', '2026-12-04'),
  (23, '2527244316', 'Nicolás', 'Benítez', 'Parra', '3212957854', 'moto', 'GZU01D', '2024-12-31'),
  (24, '4181129213', 'Emilio', 'Téllez', 'Cárdenas', '3182751241', 'moto', 'RAF20A', '2023-03-10'),
  (25, '14141806', 'Sara', 'Mendoza', NULL, '3219709808', 'moto', 'GKX80S', '2026-05-27'),
  (26, '1461661400', 'Santiago', 'Nieto', 'Cabrera', '3166027134', 'moto', 'ZUD54I', '2025-04-07'),
  (27, '3827764881', 'Laura', 'Bermúdez', NULL, '3226165212', 'moto', 'QGF71N', '2025-09-07'),
  (28, '998169694', 'Diana', 'Bermúdez', NULL, '3088439211', 'moto', 'DQO76F', '2025-04-29'),
  (29, '495387738', 'Samuel', 'Benítez', 'Quiroga', '3223855668', 'moto', 'KVH44K', '2026-07-08'),
  (30, '693932241', 'Felipe', 'Cabrera', 'Ocampo', '3088373007', 'moto', 'RHA93I', '2026-07-26'),
  (31, '152500005', 'Natalia', 'Cabrera', NULL, '3081337765', 'moto', 'KFR95V', '2024-01-18'),
  (32, '5545423865', 'Emilio', 'Parra', 'Rojas', '3200410891', 'moto', 'FFH69C', '2024-10-14'),
  (33, '8710184959', 'Isabela', 'Ocampo', NULL, '3157501712', 'moto', 'IHW82W', '2024-11-05'),
  (34, '339604042', 'Emilio', 'Beltrán', 'Bustos', '3053212440', 'moto', 'PKQ02S', '2025-08-19'),
  (35, '5473387264', 'Mateo', 'Cabrera', 'Ocampo', '3064876797', 'moto', 'YEM24G', '2026-01-18'),
  (36, '11479169', 'Tomás', 'Bustos', 'Nieto', '3116354498', 'moto', 'HEV59Y', '2026-08-03'),
  (37, '20390436', 'Samuel', 'Beltrán', NULL, '3507896783', 'carro', 'FIM203', '2026-10-17'),
  (38, '18663554', 'Sara', 'Rojas', 'Pardo', '3119758312', 'carro', 'NPZ469', '2025-05-31'),
  (39, '59051060', 'Mateo', 'Cabrera', 'Arango', '3165580710', 'carro', 'AUA192', '2025-01-20'),
  (40, '49797462', 'Mariana', 'Cárdenas', 'Nieto', '3241168401', 'carro', 'QAC001', '2026-04-12'),
  (41, '9893701382', 'Julián', 'Laverde', NULL, '3100435613', 'carro', 'MNG699', '2025-07-22'),
  (42, '340689745', 'Julián', 'Nieto', NULL, '3041071681', 'carro', 'QAD569', '2026-12-05'),
  (43, '632678426', 'Andrés', 'Ocampo', 'Pardo', '3507789669', 'carro', 'JGY982', '2025-07-22'),
  (44, '33991602', 'Tomás', 'Peña', NULL, '3059934755', 'carro', 'NZG107', '2023-12-27'),
  (45, '408275277', 'Santiago', 'Rincón', 'Cárdenas', '3064464591', 'carro', 'LJC782', '2023-04-10'),
  (46, '6188925333', 'Camila', 'Bermúdez', 'Zárate', '3159490554', 'bicicleta', NULL, '2023-04-24'),
  (47, '7101551076', 'Manuela', 'Cifuentes', NULL, '3096330016', 'bicicleta', NULL, '2024-09-23'),
  (48, '6398905380', 'Nicolás', 'Quiroga', 'Arango', '3503993479', 'bicicleta', NULL, '2026-07-21'),
  (49, '85681955', 'Emilio', 'Rojas', 'Rojas', '3059551783', 'bicicleta', NULL, '2023-01-15'),
  (50, '47667862', 'Gabriel', 'Téllez', 'Rojas', '3070255891', 'bicicleta', NULL, '2025-02-06'),
  (51, '12949102', 'Natalia', 'Ocampo', 'Beltrán', '3006503590', 'bicicleta', NULL, '2026-05-15'),
  (52, '6075842064', 'Emilio', 'Parra', 'Pardo', '3012570613', 'bicicleta', NULL, '2023-12-26'),
  (53, '23810931', 'Samuel', 'Pardo', 'Mendoza', '3014753293', 'bicicleta', NULL, '2024-12-22'),
  (54, '17057658', 'Tomás', 'Zárate', NULL, '3237705413', 'bicicleta', NULL, '2025-08-30'),
  (55, '20793297', 'Santiago', 'Pardo', 'Quiroga', '3150940529', 'bicicleta', NULL, '2026-05-27'),
  (56, '2626790011', 'Felipe', 'Rojas', 'Beltrán', '3051129491', 'bicicleta', NULL, '2025-09-18'),
  (57, '112688400', 'Andrés', 'Ocampo', 'Quiroga', '3513083531', 'bicicleta', NULL, '2023-09-03'),
  (58, '29275293', 'Natalia', 'Zárate', 'Bustos', '3091931680', 'bicicleta', NULL, '2025-11-06'),
  (59, '625495927', 'Laura', 'Parra', 'Cabrera', '3510266717', 'bicicleta', NULL, '2023-07-08'),
  (60, '4568410751', 'Diana', 'Nieto', 'Arango', '3054813315', 'bicicleta', NULL, '2026-01-01');
INSERT INTO PEDIDO (id_pedido, id_cliente, id_restaurante, id_repartidor, calle, numero, barrio, ciudad, costo_envio, metodo_pago) VALUES
  (1, 21, 47, 14, 'Calle 51', '# 32-64', 'La Grama', 'Villavicencio', 7000, 'efectivo'),
  (2, 43, 46, 38, 'Calle 10', '# 76-02', 'Suba', 'Bogotá', 4000, 'tarjeta'),
  (3, 20, 44, 17, 'Calle 46', '# 23-19', 'La Esperanza', 'Villavicencio', 5500, 'tarjeta'),
  (4, 7, 32, 60, 'Calle 62', '# 11-85', 'Centro', 'Villavicencio', 4000, 'transferencia'),
  (5, 5, 29, NULL, 'Calle 13', '# 56-16', 'Barzal', 'Villavicencio', 5500, 'transferencia'),
  (6, 47, 6, 24, 'Calle 35', '# 88-26', 'Chapinero', 'Bogotá', 5000, 'transferencia'),
  (7, 45, 9, 46, 'Calle 61', '# 79-90', 'La Esperanza', 'Villavicencio', 8000, 'tarjeta'),
  (8, 33, 29, 17, 'Calle 2', '# 75-29', 'Barzal', 'Villavicencio', 2500, 'transferencia'),
  (9, 46, 35, NULL, 'Calle 43', '# 60-85', 'Siete de Agosto', 'Villavicencio', 5500, 'tarjeta'),
  (10, 6, 15, 23, 'Calle 12', '# 60-83', 'Chapinero', 'Bogotá', 3500, 'efectivo'),
  (11, 19, 43, 3, 'Calle 38', '# 57-43', 'Villa María', 'Villavicencio', 5500, 'tarjeta'),
  (12, 13, 18, 32, 'Calle 32', '# 46-01', 'Siete de Agosto', 'Villavicencio', 6000, 'transferencia'),
  (13, 38, 53, 24, 'Calle 16', '# 62-85', 'Modelia', 'Bogotá', 6000, 'efectivo'),
  (14, 1, 60, 44, 'Calle 73', '# 89-11', 'La Grama', 'Villavicencio', 2500, 'tarjeta'),
  (15, 19, 40, 48, 'Calle 18', '# 8-11', 'Fontibón', 'Bogotá', 8000, 'efectivo'),
  (16, 42, 18, 33, 'Calle 37', '# 3-97', 'Caudal', 'Villavicencio', 6000, 'transferencia'),
  (17, 11, 52, 2, 'Calle 14', '# 42-19', 'Centro', 'Villavicencio', 7000, 'transferencia'),
  (18, 3, 59, 48, 'Calle 28', '# 51-80', 'La Grama', 'Villavicencio', 4000, 'transferencia'),
  (19, 8, 51, 5, 'Calle 49', '# 18-11', 'Porfía', 'Villavicencio', 7500, 'efectivo'),
  (20, 48, 30, 8, 'Calle 14', '# 24-37', 'La Rosita', 'Villavicencio', 6000, 'tarjeta'),
  (21, 25, 22, 23, 'Calle 59', '# 45-68', 'Barzal', 'Villavicencio', 3500, 'transferencia'),
  (22, 12, 30, 48, 'Calle 33', '# 87-74', 'Villa María', 'Villavicencio', 6000, 'transferencia'),
  (23, 9, 19, 38, 'Calle 27', '# 18-88', 'Suba', 'Bogotá', 4000, 'transferencia'),
  (24, 45, 40, NULL, 'Calle 74', '# 38-90', 'Cedritos', 'Bogotá', 7000, 'efectivo'),
  (25, 9, 24, 33, 'Calle 35', '# 34-21', 'La Soledad', 'Bogotá', 7000, 'transferencia'),
  (26, 28, 12, 42, 'Calle 67', '# 41-67', 'La Grama', 'Villavicencio', 5000, 'efectivo'),
  (27, 32, 11, 50, 'Calle 74', '# 73-41', 'Restrepo', 'Bogotá', 3000, 'tarjeta'),
  (28, 14, 24, 16, 'Calle 36', '# 41-07', 'Fontibón', 'Bogotá', 6500, 'efectivo'),
  (29, 25, 7, NULL, 'Calle 16', '# 78-54', 'Barzal', 'Villavicencio', 5500, 'transferencia'),
  (30, 17, 29, 35, 'Calle 9', '# 49-12', 'Barzal', 'Villavicencio', 3500, 'efectivo'),
  (31, 44, 30, 2, 'Calle 32', '# 52-56', 'Caudal', 'Villavicencio', 8000, 'efectivo'),
  (32, 13, 56, 2, 'Calle 76', '# 58-79', 'La Esperanza', 'Villavicencio', 7000, 'tarjeta'),
  (33, 45, 39, 1, 'Calle 65', '# 30-95', 'La Rosita', 'Villavicencio', 2500, 'tarjeta'),
  (34, 33, 22, 33, 'Calle 59', '# 78-86', 'Centro', 'Villavicencio', 8000, 'tarjeta'),
  (35, 21, 43, 14, 'Calle 79', '# 84-76', 'Centro', 'Villavicencio', 6000, 'transferencia'),
  (36, 28, 6, NULL, 'Calle 54', '# 71-64', 'Restrepo', 'Bogotá', 6500, 'tarjeta'),
  (37, 47, 52, 35, 'Calle 50', '# 77-23', 'Porfía', 'Villavicencio', 6500, 'efectivo'),
  (38, 3, 20, NULL, 'Calle 61', '# 84-03', 'La Rosita', 'Villavicencio', 2000, 'transferencia'),
  (39, 50, 45, NULL, 'Calle 67', '# 50-54', 'Barzal', 'Villavicencio', 6500, 'transferencia'),
  (40, 19, 56, 32, 'Calle 33', '# 19-22', 'Centro', 'Villavicencio', 6500, 'tarjeta'),
  (41, 34, 36, 40, 'Calle 49', '# 45-97', 'Porfía', 'Villavicencio', 8000, 'transferencia'),
  (42, 10, 42, 41, 'Calle 30', '# 67-41', 'Siete de Agosto', 'Villavicencio', 8000, 'efectivo'),
  (43, 10, 4, 25, 'Calle 52', '# 87-32', 'La Esperanza', 'Villavicencio', 6000, 'efectivo'),
  (44, 43, 31, 1, 'Calle 76', '# 37-22', 'Fontibón', 'Bogotá', 2500, 'transferencia'),
  (45, 38, 4, 29, 'Calle 37', '# 54-08', 'Porfía', 'Villavicencio', 3500, 'tarjeta'),
  (46, 18, 29, 17, 'Calle 43', '# 78-56', 'Villa María', 'Villavicencio', 3000, 'transferencia'),
  (47, 37, 12, 14, 'Calle 15', '# 74-80', 'Barzal', 'Villavicencio', 5500, 'tarjeta'),
  (48, 20, 1, 51, 'Calle 10', '# 63-54', 'Suba', 'Bogotá', 6000, 'efectivo'),
  (49, 14, 57, 41, 'Calle 68', '# 59-10', 'La Rosita', 'Villavicencio', 2500, 'transferencia'),
  (50, 1, 16, NULL, 'Calle 80', '# 8-83', 'Barzal', 'Villavicencio', 3000, 'tarjeta'),
  (51, 20, 28, 54, 'Calle 49', '# 37-44', 'Fontibón', 'Bogotá', 6000, 'efectivo'),
  (52, 45, 2, 42, 'Calle 43', '# 6-09', 'Barzal', 'Villavicencio', 5500, 'transferencia'),
  (53, 12, 60, NULL, 'Calle 40', '# 62-35', 'Villa María', 'Villavicencio', 7500, 'efectivo'),
  (54, 42, 49, 31, 'Calle 40', '# 71-47', 'La Rosita', 'Villavicencio', 6000, 'efectivo'),
  (55, 22, 44, NULL, 'Calle 35', '# 58-87', 'Porfía', 'Villavicencio', 7500, 'transferencia'),
  (56, 3, 27, 46, 'Calle 10', '# 21-90', 'Centro', 'Villavicencio', 4500, 'transferencia'),
  (57, 46, 56, 2, 'Calle 66', '# 42-69', 'La Rosita', 'Villavicencio', 3000, 'efectivo'),
  (58, 40, 26, 15, 'Calle 21', '# 52-97', 'Chapinero', 'Bogotá', 5500, 'tarjeta'),
  (59, 29, 30, 36, 'Calle 77', '# 63-65', 'Caudal', 'Villavicencio', 5500, 'efectivo'),
  (60, 36, 47, 4, 'Calle 80', '# 41-72', 'El Buque', 'Villavicencio', 7000, 'tarjeta'),
  (61, 24, 58, 7, 'Calle 36', '# 37-01', 'Barzal', 'Villavicencio', 5500, 'efectivo'),
  (62, 19, 36, 26, 'Calle 35', '# 89-54', 'Caudal', 'Villavicencio', 8000, 'efectivo'),
  (63, 35, 28, 40, 'Calle 53', '# 33-67', 'Suba', 'Bogotá', 2000, 'tarjeta'),
  (64, 16, 18, NULL, 'Calle 80', '# 7-67', 'La Esperanza', 'Villavicencio', 6500, 'transferencia'),
  (65, 9, 31, 22, 'Calle 60', '# 66-55', 'La Soledad', 'Bogotá', 2000, 'tarjeta'),
  (66, 37, 54, 22, 'Calle 3', '# 12-85', 'La Grama', 'Villavicencio', 2000, 'efectivo'),
  (67, 29, 4, 24, 'Calle 35', '# 55-84', 'Centro', 'Villavicencio', 5000, 'tarjeta'),
  (68, 40, 44, 3, 'Calle 62', '# 11-77', 'Villa María', 'Villavicencio', 7500, 'transferencia'),
  (69, 47, 59, 57, 'Calle 9', '# 88-59', 'La Esperanza', 'Villavicencio', 3000, 'tarjeta'),
  (70, 29, 50, 5, 'Calle 64', '# 6-92', 'La Rosita', 'Villavicencio', 5500, 'transferencia'),
  (71, 19, 18, NULL, 'Calle 64', '# 84-32', 'El Buque', 'Villavicencio', 4000, 'efectivo'),
  (72, 38, 59, 55, 'Calle 72', '# 13-58', 'Centro', 'Villavicencio', 2000, 'efectivo'),
  (73, 29, 3, 10, 'Calle 69', '# 66-44', 'El Buque', 'Villavicencio', 6000, 'tarjeta'),
  (74, 29, 32, 1, 'Calle 31', '# 57-43', 'Villa María', 'Villavicencio', 3000, 'transferencia'),
  (75, 30, 19, 46, 'Calle 23', '# 79-16', 'Fontibón', 'Bogotá', 8000, 'transferencia'),
  (76, 46, 19, 36, 'Calle 44', '# 86-14', 'La Soledad', 'Bogotá', 6000, 'efectivo'),
  (77, 37, 6, NULL, 'Calle 26', '# 5-16', 'Fontibón', 'Bogotá', 6000, 'transferencia'),
  (78, 42, 32, 60, 'Calle 11', '# 59-58', 'El Buque', 'Villavicencio', 4500, 'tarjeta'),
  (79, 44, 25, 31, 'Calle 46', '# 74-48', 'La Esperanza', 'Villavicencio', 3500, 'tarjeta'),
  (80, 16, 22, 7, 'Calle 8', '# 17-12', 'Barzal', 'Villavicencio', 6000, 'efectivo'),
  (81, 28, 55, NULL, 'Calle 52', '# 20-26', 'Caudal', 'Villavicencio', 5000, 'efectivo'),
  (82, 16, 45, 40, 'Calle 61', '# 51-59', 'Porfía', 'Villavicencio', 4500, 'efectivo'),
  (83, 7, 21, 1, 'Calle 33', '# 49-22', 'Villa María', 'Villavicencio', 5000, 'transferencia'),
  (84, 36, 44, 17, 'Calle 63', '# 5-75', 'Villa María', 'Villavicencio', 4500, 'efectivo'),
  (85, 22, 37, 47, 'Calle 64', '# 25-64', 'Fontibón', 'Bogotá', 8000, 'transferencia'),
  (86, 24, 29, NULL, 'Calle 51', '# 59-73', 'Centro', 'Villavicencio', 3000, 'tarjeta'),
  (87, 33, 12, 53, 'Calle 62', '# 46-92', 'El Buque', 'Villavicencio', 3500, 'tarjeta'),
  (88, 10, 47, NULL, 'Calle 3', '# 32-66', 'La Grama', 'Villavicencio', 6000, 'efectivo'),
  (89, 8, 15, 8, 'Calle 10', '# 47-77', 'Restrepo', 'Bogotá', 2000, 'tarjeta'),
  (90, 41, 7, 56, 'Calle 61', '# 26-44', 'Centro', 'Villavicencio', 4500, 'efectivo'),
  (91, 32, 18, 24, 'Calle 8', '# 15-12', 'Villa María', 'Villavicencio', 3000, 'tarjeta'),
  (92, 16, 43, NULL, 'Calle 72', '# 51-40', 'La Rosita', 'Villavicencio', 2000, 'efectivo'),
  (93, 43, 58, 10, 'Calle 72', '# 86-30', 'Centro', 'Villavicencio', 4500, 'tarjeta'),
  (94, 17, 33, 42, 'Calle 2', '# 6-85', 'Normandía', 'Bogotá', 5500, 'tarjeta'),
  (95, 46, 26, NULL, 'Calle 27', '# 38-67', 'Chapinero', 'Bogotá', 4500, 'efectivo'),
  (96, 2, 25, 45, 'Calle 67', '# 75-87', 'Villa María', 'Villavicencio', 4000, 'tarjeta'),
  (97, 11, 57, 15, 'Calle 53', '# 88-53', 'Barzal', 'Villavicencio', 6500, 'efectivo'),
  (98, 25, 3, 52, 'Calle 78', '# 28-40', 'Caudal', 'Villavicencio', 5000, 'efectivo'),
  (99, 21, 6, 9, 'Calle 61', '# 38-13', 'Chapinero', 'Bogotá', 5500, 'efectivo'),
  (100, 17, 26, NULL, 'Calle 6', '# 72-14', 'Cedritos', 'Bogotá', 6000, 'tarjeta'),
  (101, 10, 43, 60, 'Calle 67', '# 90-71', 'Villa María', 'Villavicencio', 3500, 'transferencia'),
  (102, 11, 47, 59, 'Calle 23', '# 65-74', 'Siete de Agosto', 'Villavicencio', 5500, 'tarjeta'),
  (103, 5, 37, 6, 'Calle 64', '# 48-47', 'Modelia', 'Bogotá', 2000, 'efectivo'),
  (104, 16, 4, 35, 'Calle 12', '# 25-70', 'La Esperanza', 'Villavicencio', 6000, 'tarjeta'),
  (105, 9, 11, 38, 'Calle 23', '# 23-57', 'Usaquén', 'Bogotá', 5000, 'tarjeta'),
  (106, 37, 2, 39, 'Calle 19', '# 69-07', 'Barzal', 'Villavicencio', 8000, 'transferencia'),
  (107, 28, 30, 27, 'Calle 79', '# 21-59', 'Centro', 'Villavicencio', 6000, 'transferencia'),
  (108, 4, 4, 16, 'Calle 73', '# 45-25', 'Centro', 'Villavicencio', 4500, 'tarjeta'),
  (109, 18, 2, 19, 'Calle 22', '# 68-38', 'Centro', 'Villavicencio', 4000, 'tarjeta'),
  (110, 2, 5, 47, 'Calle 13', '# 54-66', 'Modelia', 'Bogotá', 6000, 'tarjeta'),
  (111, 23, 46, 44, 'Calle 72', '# 85-11', 'Normandía', 'Bogotá', 4000, 'transferencia'),
  (112, 50, 11, 33, 'Calle 61', '# 22-38', 'Restrepo', 'Bogotá', 7500, 'transferencia'),
  (113, 21, 3, 30, 'Calle 56', '# 41-93', 'Villa María', 'Villavicencio', 5500, 'tarjeta'),
  (114, 31, 52, NULL, 'Calle 18', '# 70-35', 'Barzal', 'Villavicencio', 4500, 'efectivo'),
  (115, 18, 39, 12, 'Calle 45', '# 10-95', 'Centro', 'Villavicencio', 2000, 'tarjeta'),
  (116, 18, 55, 9, 'Calle 8', '# 17-85', 'Barzal', 'Villavicencio', 7000, 'transferencia'),
  (117, 36, 17, 54, 'Calle 63', '# 80-95', 'Caudal', 'Villavicencio', 7500, 'transferencia'),
  (118, 22, 31, 43, 'Calle 16', '# 65-66', 'Normandía', 'Bogotá', 2000, 'transferencia'),
  (119, 40, 13, 56, 'Calle 50', '# 3-30', 'Normandía', 'Bogotá', 8000, 'transferencia'),
  (120, 17, 28, 8, 'Calle 43', '# 10-14', 'Restrepo', 'Bogotá', 7500, 'tarjeta'),
  (121, 6, 40, NULL, 'Calle 5', '# 34-74', 'La Soledad', 'Bogotá', 6500, 'transferencia'),
  (122, 27, 5, 55, 'Calle 47', '# 51-35', 'Modelia', 'Bogotá', 8000, 'transferencia'),
  (123, 14, 5, 53, 'Calle 47', '# 25-19', 'La Soledad', 'Bogotá', 6000, 'transferencia'),
  (124, 20, 45, 36, 'Calle 67', '# 23-38', 'Siete de Agosto', 'Villavicencio', 6000, 'efectivo'),
  (125, 25, 54, 44, 'Calle 10', '# 22-33', 'Siete de Agosto', 'Villavicencio', 7000, 'transferencia'),
  (126, 47, 46, 4, 'Calle 63', '# 83-65', 'Normandía', 'Bogotá', 8000, 'efectivo'),
  (127, 37, 50, 18, 'Calle 70', '# 57-93', 'El Buque', 'Villavicencio', 5500, 'efectivo'),
  (128, 18, 18, NULL, 'Calle 15', '# 27-72', 'Centro', 'Villavicencio', 5000, 'transferencia'),
  (129, 18, 40, 41, 'Calle 42', '# 84-98', 'Normandía', 'Bogotá', 4000, 'efectivo'),
  (130, 32, 28, 15, 'Calle 64', '# 78-10', 'Restrepo', 'Bogotá', 8000, 'efectivo'),
  (131, 47, 29, 42, 'Calle 57', '# 15-13', 'Caudal', 'Villavicencio', 2500, 'tarjeta'),
  (132, 32, 20, 27, 'Calle 2', '# 25-09', 'La Rosita', 'Villavicencio', 7500, 'tarjeta'),
  (133, 30, 21, NULL, 'Calle 21', '# 1-94', 'Centro', 'Villavicencio', 2500, 'efectivo'),
  (134, 8, 46, NULL, 'Calle 31', '# 51-36', 'Teusaquillo', 'Bogotá', 2000, 'transferencia'),
  (135, 1, 25, NULL, 'Calle 44', '# 63-24', 'La Esperanza', 'Villavicencio', 3000, 'tarjeta'),
  (136, 33, 49, 30, 'Calle 24', '# 48-14', 'Villa María', 'Villavicencio', 2500, 'efectivo'),
  (137, 25, 24, 41, 'Calle 18', '# 4-91', 'La Soledad', 'Bogotá', 7500, 'efectivo'),
  (138, 9, 52, 15, 'Calle 9', '# 6-71', 'Caudal', 'Villavicencio', 8000, 'transferencia'),
  (139, 13, 36, 3, 'Calle 56', '# 36-34', 'Porfía', 'Villavicencio', 7000, 'efectivo'),
  (140, 13, 13, 35, 'Calle 18', '# 11-83', 'La Soledad', 'Bogotá', 5500, 'efectivo'),
  (141, 16, 58, 2, 'Calle 46', '# 73-67', 'Siete de Agosto', 'Villavicencio', 5000, 'efectivo'),
  (142, 32, 52, 20, 'Calle 25', '# 10-54', 'Centro', 'Villavicencio', 7000, 'transferencia'),
  (143, 6, 17, 33, 'Calle 13', '# 85-41', 'Porfía', 'Villavicencio', 6000, 'tarjeta'),
  (144, 4, 50, 8, 'Calle 24', '# 58-14', 'Barzal', 'Villavicencio', 4000, 'transferencia'),
  (145, 13, 41, 13, 'Calle 33', '# 29-56', 'La Grama', 'Villavicencio', 5500, 'transferencia'),
  (146, 47, 14, 11, 'Calle 22', '# 69-71', 'Siete de Agosto', 'Villavicencio', 3500, 'efectivo'),
  (147, 17, 37, 7, 'Calle 64', '# 56-68', 'Fontibón', 'Bogotá', 7500, 'transferencia'),
  (148, 26, 8, 14, 'Calle 30', '# 88-51', 'El Buque', 'Villavicencio', 7500, 'transferencia'),
  (149, 6, 11, 41, 'Calle 41', '# 44-54', 'Teusaquillo', 'Bogotá', 3500, 'tarjeta'),
  (150, 31, 33, 35, 'Calle 68', '# 2-97', 'Chapinero', 'Bogotá', 7000, 'tarjeta'),
  (151, 20, 59, 9, 'Calle 67', '# 70-32', 'La Esperanza', 'Villavicencio', 6000, 'tarjeta'),
  (152, 12, 36, 13, 'Calle 19', '# 64-68', 'Siete de Agosto', 'Villavicencio', 5500, 'tarjeta'),
  (153, 4, 17, 36, 'Calle 48', '# 41-20', 'Barzal', 'Villavicencio', 8000, 'transferencia'),
  (154, 34, 5, 4, 'Calle 65', '# 58-16', 'Cedritos', 'Bogotá', 2000, 'tarjeta'),
  (155, 16, 55, 12, 'Calle 30', '# 51-08', 'El Buque', 'Villavicencio', 2000, 'efectivo'),
  (156, 31, 58, 4, 'Calle 68', '# 38-06', 'La Grama', 'Villavicencio', 5500, 'transferencia'),
  (157, 17, 32, 42, 'Calle 78', '# 79-31', 'Porfía', 'Villavicencio', 7500, 'tarjeta'),
  (158, 33, 28, 36, 'Calle 75', '# 50-95', 'La Soledad', 'Bogotá', 5000, 'tarjeta'),
  (159, 3, 54, 34, 'Calle 58', '# 15-94', 'La Esperanza', 'Villavicencio', 3000, 'transferencia'),
  (160, 22, 44, 51, 'Calle 72', '# 89-86', 'Porfía', 'Villavicencio', 8000, 'transferencia'),
  (161, 17, 55, NULL, 'Calle 55', '# 27-05', 'El Buque', 'Villavicencio', 3500, 'tarjeta'),
  (162, 4, 8, 44, 'Calle 69', '# 70-87', 'Caudal', 'Villavicencio', 5000, 'tarjeta'),
  (163, 18, 21, 28, 'Calle 65', '# 27-19', 'La Grama', 'Villavicencio', 3500, 'efectivo'),
  (164, 11, 53, NULL, 'Calle 34', '# 13-89', 'Normandía', 'Bogotá', 6500, 'efectivo'),
  (165, 6, 27, 4, 'Calle 49', '# 73-43', 'Porfía', 'Villavicencio', 6500, 'transferencia'),
  (166, 48, 48, 50, 'Calle 71', '# 26-86', 'Modelia', 'Bogotá', 7500, 'transferencia'),
  (167, 11, 28, 1, 'Calle 51', '# 38-43', 'Suba', 'Bogotá', 2000, 'efectivo'),
  (168, 24, 45, 33, 'Calle 6', '# 31-37', 'Centro', 'Villavicencio', 6500, 'tarjeta'),
  (169, 29, 36, 42, 'Calle 75', '# 79-89', 'Siete de Agosto', 'Villavicencio', 4000, 'tarjeta'),
  (170, 24, 42, 21, 'Calle 23', '# 65-03', 'Barzal', 'Villavicencio', 5000, 'transferencia'),
  (171, 43, 59, NULL, 'Calle 9', '# 74-90', 'Villa María', 'Villavicencio', 5500, 'transferencia'),
  (172, 31, 41, 51, 'Calle 76', '# 64-93', 'Centro', 'Villavicencio', 7000, 'efectivo'),
  (173, 36, 58, 14, 'Calle 64', '# 49-07', 'Barzal', 'Villavicencio', 5500, 'tarjeta'),
  (174, 38, 15, 41, 'Calle 80', '# 34-85', 'Fontibón', 'Bogotá', 6500, 'transferencia'),
  (175, 42, 3, 8, 'Calle 7', '# 16-63', 'El Buque', 'Villavicencio', 7000, 'transferencia'),
  (176, 43, 17, 32, 'Calle 41', '# 37-48', 'La Rosita', 'Villavicencio', 6500, 'transferencia'),
  (177, 1, 46, NULL, 'Calle 48', '# 44-88', 'Cedritos', 'Bogotá', 7500, 'tarjeta'),
  (178, 19, 31, NULL, 'Calle 52', '# 18-28', 'Usaquén', 'Bogotá', 7000, 'transferencia'),
  (179, 33, 48, 3, 'Calle 36', '# 3-47', 'Fontibón', 'Bogotá', 7500, 'transferencia'),
  (180, 29, 38, 25, 'Calle 12', '# 73-85', 'La Esperanza', 'Villavicencio', 4000, 'transferencia'),
  (181, 25, 29, 7, 'Calle 40', '# 43-94', 'Caudal', 'Villavicencio', 4500, 'tarjeta'),
  (182, 4, 53, 48, 'Calle 64', '# 14-85', 'Usaquén', 'Bogotá', 5000, 'efectivo'),
  (183, 21, 24, NULL, 'Calle 34', '# 85-41', 'Modelia', 'Bogotá', 3000, 'tarjeta'),
  (184, 7, 35, 9, 'Calle 33', '# 68-32', 'Villa María', 'Villavicencio', 5500, 'efectivo'),
  (185, 43, 26, 33, 'Calle 15', '# 52-90', 'Fontibón', 'Bogotá', 5500, 'efectivo'),
  (186, 48, 11, NULL, 'Calle 42', '# 9-05', 'Normandía', 'Bogotá', 3000, 'tarjeta'),
  (187, 18, 21, 8, 'Calle 44', '# 71-14', 'La Rosita', 'Villavicencio', 7500, 'efectivo'),
  (188, 26, 39, 51, 'Calle 6', '# 39-55', 'La Grama', 'Villavicencio', 5500, 'transferencia'),
  (189, 32, 43, 23, 'Calle 49', '# 16-99', 'Siete de Agosto', 'Villavicencio', 8000, 'tarjeta'),
  (190, 1, 38, 31, 'Calle 8', '# 24-34', 'Caudal', 'Villavicencio', 4500, 'transferencia'),
  (191, 48, 10, 35, 'Calle 80', '# 12-92', 'La Grama', 'Villavicencio', 7000, 'efectivo'),
  (192, 12, 50, 11, 'Calle 70', '# 28-63', 'Porfía', 'Villavicencio', 2500, 'transferencia'),
  (193, 21, 49, 21, 'Calle 34', '# 88-97', 'Porfía', 'Villavicencio', 2500, 'tarjeta'),
  (194, 16, 14, 42, 'Calle 37', '# 19-02', 'Siete de Agosto', 'Villavicencio', 7000, 'tarjeta'),
  (195, 16, 45, 39, 'Calle 37', '# 31-76', 'Villa María', 'Villavicencio', 2500, 'transferencia'),
  (196, 8, 5, 45, 'Calle 78', '# 80-97', 'Normandía', 'Bogotá', 7000, 'efectivo'),
  (197, 48, 42, 59, 'Calle 77', '# 8-26', 'La Grama', 'Villavicencio', 5000, 'tarjeta'),
  (198, 33, 1, 41, 'Calle 54', '# 55-45', 'Modelia', 'Bogotá', 5500, 'transferencia'),
  (199, 19, 46, 60, 'Calle 21', '# 12-89', 'Suba', 'Bogotá', 5500, 'tarjeta'),
  (200, 36, 8, 8, 'Calle 9', '# 75-28', 'Porfía', 'Villavicencio', 6500, 'efectivo'),
  (201, 45, 9, 19, 'Calle 61', '# 7-15', 'La Esperanza', 'Villavicencio', 5500, 'transferencia'),
  (202, 29, 40, 52, 'Calle 54', '# 26-53', 'Teusaquillo', 'Bogotá', 2500, 'transferencia'),
  (203, 27, 60, NULL, 'Calle 54', '# 8-61', 'El Buque', 'Villavicencio', 5000, 'transferencia'),
  (204, 14, 40, 50, 'Calle 64', '# 20-10', 'Teusaquillo', 'Bogotá', 4500, 'transferencia'),
  (205, 41, 11, 51, 'Calle 80', '# 83-29', 'Usaquén', 'Bogotá', 3500, 'efectivo'),
  (206, 39, 13, 58, 'Calle 77', '# 37-54', 'Fontibón', 'Bogotá', 7500, 'efectivo'),
  (207, 2, 30, 2, 'Calle 76', '# 81-52', 'Barzal', 'Villavicencio', 5000, 'transferencia'),
  (208, 44, 9, 37, 'Calle 3', '# 11-40', 'La Rosita', 'Villavicencio', 6000, 'efectivo'),
  (209, 38, 19, 1, 'Calle 24', '# 45-31', 'Fontibón', 'Bogotá', 6000, 'efectivo'),
  (210, 1, 24, 21, 'Calle 28', '# 36-51', 'Chapinero', 'Bogotá', 2500, 'efectivo'),
  (211, 11, 17, 55, 'Calle 16', '# 63-73', 'Porfía', 'Villavicencio', 5500, 'tarjeta'),
  (212, 11, 17, 37, 'Calle 47', '# 49-42', 'La Rosita', 'Villavicencio', 5500, 'tarjeta'),
  (213, 17, 10, 59, 'Calle 80', '# 42-48', 'Centro', 'Villavicencio', 2000, 'efectivo'),
  (214, 1, 31, 36, 'Calle 63', '# 3-04', 'Usaquén', 'Bogotá', 3000, 'tarjeta'),
  (215, 42, 27, 2, 'Calle 53', '# 30-80', 'Porfía', 'Villavicencio', 3000, 'efectivo'),
  (216, 21, 25, 16, 'Calle 23', '# 7-36', 'Barzal', 'Villavicencio', 4000, 'tarjeta'),
  (217, 46, 18, NULL, 'Calle 78', '# 65-37', 'Barzal', 'Villavicencio', 5500, 'tarjeta'),
  (218, 48, 13, 29, 'Calle 24', '# 3-40', 'Teusaquillo', 'Bogotá', 4500, 'transferencia'),
  (219, 31, 53, 31, 'Calle 15', '# 71-49', 'Usaquén', 'Bogotá', 6500, 'efectivo'),
  (220, 19, 47, 11, 'Calle 76', '# 16-95', 'La Esperanza', 'Villavicencio', 3500, 'efectivo'),
  (221, 14, 14, 25, 'Calle 3', '# 66-30', 'Porfía', 'Villavicencio', 6500, 'efectivo'),
  (222, 12, 56, 22, 'Calle 39', '# 5-50', 'Villa María', 'Villavicencio', 4000, 'tarjeta'),
  (223, 26, 55, 45, 'Calle 69', '# 6-87', 'Barzal', 'Villavicencio', 2500, 'efectivo'),
  (224, 16, 10, 47, 'Calle 60', '# 57-42', 'La Esperanza', 'Villavicencio', 4000, 'efectivo'),
  (225, 35, 13, 42, 'Calle 53', '# 47-87', 'Normandía', 'Bogotá', 7000, 'efectivo'),
  (226, 49, 15, 6, 'Calle 10', '# 20-86', 'Usaquén', 'Bogotá', 2500, 'transferencia'),
  (227, 10, 36, NULL, 'Calle 17', '# 7-59', 'La Rosita', 'Villavicencio', 3000, 'efectivo'),
  (228, 32, 52, 7, 'Calle 61', '# 48-01', 'Centro', 'Villavicencio', 8000, 'tarjeta'),
  (229, 9, 10, 14, 'Calle 68', '# 51-72', 'La Esperanza', 'Villavicencio', 4000, 'tarjeta'),
  (230, 19, 56, 24, 'Calle 50', '# 8-26', 'Barzal', 'Villavicencio', 6500, 'transferencia'),
  (231, 39, 48, 40, 'Calle 50', '# 58-93', 'La Soledad', 'Bogotá', 7500, 'transferencia'),
  (232, 45, 6, 54, 'Calle 18', '# 12-17', 'Normandía', 'Bogotá', 4000, 'efectivo'),
  (233, 25, 41, 35, 'Calle 35', '# 2-81', 'La Esperanza', 'Villavicencio', 4500, 'efectivo'),
  (234, 48, 51, 36, 'Calle 54', '# 43-97', 'Porfía', 'Villavicencio', 7500, 'tarjeta'),
  (235, 31, 39, 25, 'Calle 25', '# 3-75', 'Barzal', 'Villavicencio', 3000, 'efectivo'),
  (236, 15, 54, NULL, 'Calle 11', '# 55-05', 'Villa María', 'Villavicencio', 7000, 'transferencia'),
  (237, 13, 39, NULL, 'Calle 45', '# 54-63', 'La Grama', 'Villavicencio', 4500, 'transferencia'),
  (238, 2, 33, 50, 'Calle 80', '# 59-22', 'Teusaquillo', 'Bogotá', 5500, 'transferencia'),
  (239, 44, 13, 48, 'Calle 62', '# 20-75', 'Chapinero', 'Bogotá', 3000, 'tarjeta'),
  (240, 38, 49, NULL, 'Calle 66', '# 32-16', 'Centro', 'Villavicencio', 4000, 'transferencia'),
  (241, 27, 40, NULL, 'Calle 10', '# 35-66', 'Chapinero', 'Bogotá', 7000, 'transferencia'),
  (242, 4, 3, 31, 'Calle 39', '# 32-83', 'La Rosita', 'Villavicencio', 2500, 'efectivo'),
  (243, 8, 51, 7, 'Calle 7', '# 68-46', 'Centro', 'Villavicencio', 8000, 'tarjeta'),
  (244, 2, 59, 44, 'Calle 41', '# 49-99', 'La Esperanza', 'Villavicencio', 3500, 'transferencia'),
  (245, 41, 21, NULL, 'Calle 44', '# 22-11', 'Barzal', 'Villavicencio', 8000, 'transferencia'),
  (246, 15, 14, 26, 'Calle 67', '# 6-04', 'Caudal', 'Villavicencio', 3500, 'efectivo'),
  (247, 25, 24, 1, 'Calle 24', '# 66-72', 'Restrepo', 'Bogotá', 6000, 'transferencia'),
  (248, 44, 31, 50, 'Calle 44', '# 50-07', 'Normandía', 'Bogotá', 2500, 'efectivo'),
  (249, 13, 2, 14, 'Calle 50', '# 28-30', 'Barzal', 'Villavicencio', 6500, 'efectivo'),
  (250, 37, 16, 47, 'Calle 43', '# 46-35', 'Siete de Agosto', 'Villavicencio', 3000, 'efectivo');
INSERT INTO DETALLE_PEDIDO (id_pedido, id_producto, cantidad, precio_unitario) VALUES
  (1, 351, 3, 7500),
  (1, 352, 3, 47500),
  (2, 340, 2, 24500),
  (2, 345, 3, 35500),
  (3, 330, 1, 22000),
  (3, 333, 1, 39000),
  (4, 240, 3, 27000),
  (4, 244, 2, 51000),
  (4, 241, 2, 34500),
  (5, 218, 1, 3000),
  (5, 220, 3, 27000),
  (6, 46, 3, 27500),
  (6, 39, 2, 21500),
  (6, 44, 3, 6500),
  (7, 63, 2, 14500),
  (7, 67, 1, 26000),
  (7, 64, 1, 14500),
  (8, 218, 2, 3000),
  (8, 217, 2, 21000),
  (9, 267, 3, 31500),
  (9, 264, 1, 13500),
  (10, 108, 3, 23000),
  (10, 111, 1, 20500),
  (11, 323, 2, 18000),
  (11, 322, 3, 31500),
  (11, 320, 1, 13500),
  (12, 134, 3, 6000),
  (12, 131, 1, 42500),
  (12, 136, 3, 50000),
  (13, 395, 3, 9000),
  (13, 393, 3, 23500),
  (13, 390, 2, 25000),
  (14, 441, 2, 5000),
  (14, 440, 2, 6500),
  (14, 439, 3, 26500),
  (15, 302, 2, 24000),
  (15, 299, 2, 33000),
  (16, 133, 1, 40000),
  (16, 135, 1, 7500),
  (16, 134, 1, 6000),
  (17, 385, 3, 44000),
  (17, 389, 3, 31500),
  (18, 433, 1, 7000),
  (18, 430, 1, 17000),
  (19, 380, 1, 6000),
  (19, 377, 3, 37000),
  (20, 227, 3, 6000),
  (20, 228, 3, 38000),
  (20, 223, 3, 22500),
  (21, 166, 1, 6000),
  (21, 167, 2, 8000),
  (22, 228, 2, 38000),
  (22, 223, 2, 22500),
  (23, 139, 1, 38500),
  (23, 140, 3, 29000),
  (24, 302, 2, 24000),
  (24, 304, 3, 10500),
  (24, 300, 1, 37000),
  (25, 178, 2, 18000),
  (25, 182, 2, 25500),
  (25, 177, 3, 21500),
  (26, 89, 3, 5500),
  (26, 87, 3, 35000),
  (27, 81, 2, 36000),
  (27, 78, 2, 25500),
  (28, 181, 1, 5000),
  (28, 182, 1, 25500),
  (28, 180, 2, 5500),
  (29, 53, 1, 26500),
  (29, 49, 1, 23500),
  (29, 51, 2, 4000),
  (30, 220, 2, 27000),
  (30, 217, 2, 21000),
  (30, 218, 2, 3000),
  (31, 225, 2, 34000),
  (31, 228, 2, 38000),
  (32, 410, 3, 25500),
  (32, 413, 2, 5500),
  (32, 412, 1, 18500),
  (33, 292, 2, 23500),
  (33, 295, 3, 23500),
  (33, 298, 1, 36000),
  (34, 168, 3, 44500),
  (34, 169, 2, 59000),
  (34, 167, 2, 8000),
  (35, 322, 3, 31500),
  (35, 323, 1, 18000),
  (36, 41, 2, 20500),
  (36, 45, 3, 11000),
  (37, 386, 1, 32000),
  (37, 384, 2, 20000),
  (38, 151, 3, 47000),
  (38, 150, 2, 5000),
  (38, 147, 1, 30500),
  (39, 337, 3, 3000),
  (39, 336, 3, 45500),
  (40, 414, 2, 6500),
  (40, 415, 3, 27000),
  (41, 274, 1, 10500),
  (41, 272, 2, 24000),
  (42, 319, 2, 37500),
  (42, 317, 2, 8500),
  (43, 30, 2, 47500),
  (43, 23, 2, 46000),
  (43, 28, 1, 5000),
  (44, 229, 1, 43500),
  (44, 230, 2, 38500),
  (45, 24, 3, 27000),
  (45, 26, 2, 23000),
  (46, 215, 1, 17500),
  (46, 220, 3, 27000),
  (47, 84, 1, 34000),
  (47, 88, 2, 3500),
  (48, 4, 1, 24000),
  (48, 1, 2, 18000),
  (49, 418, 1, 15500),
  (49, 416, 3, 17000),
  (50, 120, 2, 4500),
  (50, 119, 2, 36000),
  (50, 115, 1, 33500),
  (51, 208, 1, 24500),
  (51, 210, 3, 14500),
  (51, 209, 2, 20000),
  (52, 12, 2, 22500),
  (52, 13, 2, 3000),
  (53, 441, 1, 5000),
  (53, 437, 1, 15500),
  (54, 368, 3, 38500),
  (54, 367, 3, 5000),
  (55, 330, 3, 22000),
  (55, 333, 1, 39000),
  (55, 332, 1, 7000),
  (56, 201, 1, 16500),
  (56, 207, 1, 42000),
  (57, 415, 3, 27000),
  (57, 413, 1, 5500),
  (58, 196, 3, 27500),
  (58, 195, 3, 27500),
  (59, 224, 3, 31000),
  (59, 228, 3, 38000),
  (59, 222, 3, 32000),
  (60, 350, 3, 8500),
  (60, 347, 3, 37000),
  (60, 349, 2, 34500),
  (61, 423, 1, 25500),
  (61, 425, 2, 8500),
  (61, 427, 3, 36000),
  (62, 270, 1, 18000),
  (62, 271, 1, 24500),
  (62, 272, 1, 24000),
  (63, 211, 1, 23000),
  (63, 213, 3, 5500),
  (64, 133, 1, 40000),
  (64, 132, 3, 36500),
  (65, 230, 1, 38500),
  (65, 231, 3, 34500),
  (65, 236, 2, 67000),
  (66, 398, 1, 14500),
  (66, 400, 1, 17500),
  (66, 401, 3, 9000),
  (67, 25, 3, 25000),
  (67, 30, 3, 47500),
  (68, 327, 1, 26500),
  (68, 328, 1, 30000),
  (68, 332, 1, 7000),
  (69, 431, 2, 16000),
  (69, 430, 2, 17000),
  (70, 372, 1, 5500),
  (70, 373, 1, 9500),
  (70, 369, 3, 40500),
  (71, 137, 3, 71000),
  (71, 134, 1, 6000),
  (71, 135, 2, 7500),
  (72, 432, 2, 4500),
  (72, 428, 2, 25000),
  (73, 19, 1, 3000),
  (73, 21, 1, 28500),
  (74, 238, 1, 35500),
  (74, 240, 2, 27000),
  (75, 144, 3, 54500),
  (75, 142, 3, 5000),
  (76, 139, 1, 38500),
  (76, 143, 2, 41500),
  (76, 141, 3, 3000),
  (77, 42, 2, 13500),
  (77, 41, 1, 20500),
  (78, 242, 1, 3500),
  (78, 238, 2, 35500),
  (78, 244, 3, 51000),
  (79, 188, 3, 6500),
  (79, 191, 1, 58500),
  (79, 190, 2, 23500),
  (80, 165, 1, 35500),
  (80, 168, 2, 44500),
  (81, 409, 3, 39500),
  (81, 408, 1, 5500),
  (82, 336, 3, 45500),
  (82, 339, 2, 49500),
  (82, 338, 3, 7000),
  (83, 159, 1, 24500),
  (83, 154, 2, 13000),
  (84, 332, 3, 7000),
  (84, 333, 1, 39000),
  (85, 279, 1, 38500),
  (85, 280, 3, 37000),
  (85, 283, 2, 45000),
  (86, 217, 2, 21000),
  (86, 219, 1, 10000),
  (87, 83, 3, 36500),
  (87, 88, 3, 3500),
  (88, 349, 3, 34500),
  (88, 352, 2, 47500),
  (88, 353, 3, 69500),
  (89, 111, 1, 20500),
  (89, 113, 2, 5500),
  (89, 112, 2, 6500),
  (90, 53, 1, 26500),
  (90, 47, 3, 25500),
  (90, 48, 3, 17500),
  (91, 135, 3, 7500),
  (91, 134, 1, 6000),
  (92, 324, 1, 7500),
  (92, 321, 1, 19000),
  (93, 425, 1, 8500),
  (93, 424, 2, 32500),
  (93, 423, 3, 25500),
  (94, 245, 1, 30000),
  (94, 251, 3, 38500),
  (95, 194, 3, 20500),
  (95, 196, 2, 27500),
  (96, 186, 2, 29500),
  (96, 190, 1, 23500),
  (97, 419, 2, 3000),
  (97, 418, 3, 15500),
  (98, 16, 3, 18500),
  (98, 22, 2, 36000),
  (98, 21, 3, 28500),
  (99, 41, 3, 20500),
  (99, 42, 1, 13500),
  (100, 192, 2, 28500),
  (100, 194, 1, 20500),
  (101, 326, 1, 26000),
  (101, 322, 3, 31500),
  (102, 347, 2, 37000),
  (102, 348, 3, 21500),
  (103, 280, 2, 37000),
  (103, 283, 1, 45000),
  (103, 277, 3, 36000),
  (104, 25, 3, 25000),
  (104, 23, 2, 46000),
  (104, 28, 1, 5000),
  (105, 77, 2, 24000),
  (105, 82, 1, 45500),
  (105, 79, 3, 3000),
  (106, 14, 1, 5000),
  (106, 15, 3, 27000),
  (106, 13, 2, 3000),
  (107, 223, 2, 22500),
  (107, 226, 3, 5500),
  (108, 26, 3, 23000),
  (108, 25, 3, 25000),
  (109, 12, 1, 22500),
  (109, 13, 1, 3000),
  (109, 10, 3, 38500),
  (110, 32, 1, 15000),
  (110, 37, 3, 11500),
  (111, 346, 3, 36000),
  (111, 340, 3, 24500),
  (111, 344, 3, 6500),
  (112, 77, 3, 24000),
  (112, 81, 3, 36000),
  (112, 78, 1, 25500),
  (113, 18, 3, 18000),
  (113, 19, 2, 3000),
  (114, 388, 3, 10500),
  (114, 386, 3, 32000),
  (115, 297, 2, 9000),
  (115, 298, 2, 36000),
  (116, 409, 3, 39500),
  (116, 405, 2, 19500),
  (117, 129, 3, 8000),
  (117, 126, 1, 14000),
  (117, 128, 2, 3000),
  (118, 236, 3, 67000),
  (118, 235, 1, 53000),
  (118, 234, 1, 11500),
  (119, 99, 2, 33500),
  (119, 96, 2, 3500),
  (120, 208, 3, 24500),
  (120, 211, 3, 23000),
  (121, 299, 3, 33000),
  (121, 300, 1, 37000),
  (121, 304, 2, 10500),
  (122, 33, 1, 25500),
  (122, 32, 2, 15000),
  (123, 32, 2, 15000),
  (123, 37, 1, 11500),
  (123, 35, 2, 19500),
  (124, 338, 2, 7000),
  (124, 339, 1, 49500),
  (125, 403, 3, 25500),
  (125, 399, 1, 25000),
  (125, 398, 3, 14500),
  (126, 341, 3, 15500),
  (126, 340, 1, 24500),
  (126, 343, 1, 9000),
  (127, 372, 1, 5500),
  (127, 371, 3, 39500),
  (128, 137, 2, 71000),
  (128, 134, 2, 6000),
  (128, 135, 1, 7500),
  (129, 301, 1, 33000),
  (129, 302, 1, 24000),
  (130, 208, 1, 24500),
  (130, 213, 3, 5500),
  (131, 220, 1, 27000),
  (131, 215, 2, 17500),
  (131, 217, 1, 21000),
  (132, 152, 3, 60000),
  (132, 147, 1, 30500),
  (133, 158, 3, 6000),
  (133, 154, 3, 13000),
  (134, 343, 2, 9000),
  (134, 341, 3, 15500),
  (135, 190, 2, 23500),
  (135, 189, 3, 5500),
  (136, 364, 3, 29000),
  (136, 368, 2, 38500),
  (137, 181, 3, 5000),
  (137, 177, 3, 21500),
  (137, 182, 3, 25500),
  (138, 387, 3, 4500),
  (138, 388, 2, 10500),
  (138, 382, 3, 45000),
  (139, 273, 1, 8500),
  (139, 274, 2, 10500),
  (139, 271, 3, 24500),
  (140, 95, 1, 22500),
  (140, 94, 3, 27500),
  (141, 426, 3, 6000),
  (141, 422, 2, 24000),
  (141, 424, 1, 32500),
  (142, 387, 1, 4500),
  (142, 384, 2, 20000),
  (142, 383, 2, 21000),
  (143, 127, 2, 15000),
  (143, 130, 2, 34500),
  (143, 129, 2, 8000),
  (144, 373, 1, 9500),
  (144, 375, 3, 76000),
  (145, 307, 3, 36000),
  (145, 309, 3, 29000),
  (146, 102, 3, 31000),
  (146, 101, 1, 29000),
  (147, 281, 1, 3500),
  (147, 283, 1, 45000),
  (147, 280, 2, 37000),
  (148, 59, 3, 10000),
  (148, 54, 1, 38000),
  (148, 57, 1, 25000),
  (149, 81, 1, 36000),
  (149, 78, 3, 25500),
  (150, 247, 1, 29000),
  (150, 251, 1, 38500),
  (151, 430, 3, 17000),
  (151, 432, 2, 4500),
  (152, 271, 1, 24500),
  (152, 272, 2, 24000),
  (153, 128, 2, 3000),
  (153, 125, 1, 27500),
  (153, 129, 1, 8000),
  (154, 37, 1, 11500),
  (154, 35, 3, 19500),
  (155, 408, 1, 5500),
  (155, 407, 1, 8500),
  (155, 405, 2, 19500),
  (156, 427, 1, 36000),
  (156, 423, 2, 25500),
  (157, 239, 2, 41000),
  (157, 242, 1, 3500),
  (158, 213, 3, 5500),
  (158, 208, 2, 24500),
  (159, 403, 1, 25500),
  (159, 398, 1, 14500),
  (159, 401, 2, 9000),
  (160, 332, 3, 7000),
  (160, 333, 3, 39000),
  (160, 330, 1, 22000),
  (161, 404, 2, 30000),
  (161, 407, 3, 8500),
  (162, 57, 3, 25000),
  (162, 55, 3, 19000),
  (162, 54, 1, 38000),
  (163, 158, 1, 6000),
  (163, 155, 3, 30000),
  (163, 159, 2, 24500),
  (164, 397, 3, 34000),
  (164, 394, 2, 19000),
  (165, 204, 2, 6000),
  (165, 203, 1, 20500),
  (165, 205, 3, 11500),
  (166, 360, 1, 6000),
  (166, 359, 2, 7000),
  (167, 212, 1, 8000),
  (167, 214, 2, 30000),
  (167, 208, 2, 24500),
  (168, 339, 3, 49500),
  (168, 337, 3, 3000),
  (168, 338, 2, 7000),
  (169, 274, 1, 10500),
  (169, 270, 3, 18000),
  (170, 319, 3, 37500),
  (170, 316, 2, 19000),
  (171, 434, 1, 32500),
  (171, 432, 3, 4500),
  (171, 431, 2, 16000),
  (172, 312, 2, 39000),
  (172, 310, 3, 4500),
  (173, 425, 2, 8500),
  (173, 422, 3, 24000),
  (173, 427, 1, 36000),
  (174, 112, 3, 6500),
  (174, 111, 3, 20500),
  (175, 21, 3, 28500),
  (175, 19, 3, 3000),
  (176, 128, 1, 3000),
  (176, 126, 3, 14000),
  (177, 345, 2, 35500),
  (177, 342, 1, 24000),
  (177, 341, 2, 15500),
  (178, 230, 3, 38500),
  (178, 232, 2, 42000),
  (178, 236, 3, 67000),
  (179, 360, 2, 6000),
  (179, 357, 2, 18500),
  (180, 287, 2, 25000),
  (180, 291, 1, 48500),
  (180, 289, 3, 5000),
  (181, 220, 2, 27000),
  (181, 217, 2, 21000),
  (181, 218, 2, 3000),
  (182, 397, 3, 34000),
  (182, 393, 1, 23500),
  (182, 395, 3, 9000),
  (183, 178, 3, 18000),
  (183, 183, 2, 34500),
  (184, 264, 2, 13500),
  (184, 265, 1, 7500),
  (184, 263, 1, 16500),
  (185, 195, 1, 27500),
  (185, 196, 2, 27500),
  (185, 198, 1, 11500),
  (186, 78, 2, 25500),
  (186, 77, 3, 24000),
  (186, 81, 2, 36000),
  (187, 154, 3, 13000),
  (187, 158, 3, 6000),
  (187, 153, 2, 18000),
  (188, 295, 3, 23500),
  (188, 297, 3, 9000),
  (189, 325, 2, 8000),
  (189, 326, 1, 26000),
  (190, 288, 2, 4000),
  (190, 284, 3, 28000),
  (191, 68, 1, 23500),
  (191, 74, 2, 35000),
  (191, 72, 2, 8500),
  (192, 374, 2, 48500),
  (192, 372, 1, 5500),
  (192, 371, 2, 39500),
  (193, 367, 1, 5000),
  (193, 363, 2, 24000),
  (194, 107, 2, 35000),
  (194, 102, 3, 31000),
  (194, 106, 1, 5500),
  (195, 337, 1, 3000),
  (195, 339, 2, 49500),
  (196, 37, 1, 11500),
  (196, 36, 1, 8000),
  (196, 33, 2, 25500),
  (197, 314, 1, 19500),
  (197, 318, 3, 7000),
  (198, 6, 1, 7000),
  (198, 7, 2, 27000),
  (198, 1, 2, 18000),
  (199, 344, 1, 6500),
  (199, 342, 1, 24000),
  (200, 56, 1, 32000),
  (200, 54, 1, 38000),
  (201, 67, 2, 26000),
  (201, 65, 1, 6500),
  (201, 62, 3, 28500),
  (202, 301, 3, 33000),
  (202, 304, 1, 10500),
  (203, 441, 1, 5000),
  (203, 439, 1, 26500),
  (204, 301, 2, 33000),
  (204, 302, 2, 24000),
  (204, 300, 1, 37000),
  (205, 79, 1, 3000),
  (205, 78, 2, 25500),
  (206, 94, 1, 27500),
  (206, 95, 1, 22500),
  (207, 228, 1, 38000),
  (207, 226, 2, 5500),
  (207, 223, 3, 22500),
  (208, 65, 1, 6500),
  (208, 62, 1, 28500),
  (208, 67, 3, 26000),
  (209, 144, 1, 54500),
  (209, 139, 3, 38500),
  (210, 177, 1, 21500),
  (210, 182, 3, 25500),
  (211, 125, 2, 27500),
  (211, 129, 3, 8000),
  (211, 127, 3, 15000),
  (212, 124, 2, 28000),
  (212, 126, 1, 14000),
  (213, 75, 1, 82000),
  (213, 70, 1, 41500),
  (214, 232, 3, 42000),
  (214, 230, 2, 38500),
  (215, 206, 2, 32500),
  (215, 203, 2, 20500),
  (216, 187, 1, 14500),
  (216, 189, 2, 5500),
  (217, 135, 2, 7500),
  (217, 131, 1, 42500),
  (218, 91, 3, 17000),
  (218, 99, 3, 33500),
  (218, 94, 2, 27500),
  (219, 392, 1, 22500),
  (219, 393, 1, 23500),
  (220, 349, 1, 34500),
  (220, 350, 3, 8500),
  (220, 348, 3, 21500),
  (221, 103, 1, 36000),
  (221, 106, 3, 5500),
  (221, 104, 1, 32000),
  (222, 411, 2, 16000),
  (222, 412, 1, 18500),
  (222, 415, 2, 27000),
  (223, 408, 2, 5500),
  (223, 409, 3, 39500),
  (224, 70, 3, 41500),
  (224, 75, 2, 82000),
  (224, 68, 1, 23500),
  (225, 93, 3, 20000),
  (225, 97, 1, 6500),
  (225, 91, 1, 17000),
  (226, 112, 3, 6500),
  (226, 113, 3, 5500),
  (227, 270, 1, 18000),
  (227, 271, 3, 24500),
  (228, 385, 3, 44000),
  (228, 384, 2, 20000),
  (229, 75, 2, 82000),
  (229, 72, 2, 8500),
  (229, 69, 3, 22500),
  (230, 413, 3, 5500),
  (230, 414, 3, 6500),
  (231, 361, 1, 37000),
  (231, 357, 2, 18500),
  (231, 358, 3, 28500),
  (232, 39, 1, 21500),
  (232, 45, 1, 11000),
  (232, 40, 1, 19000),
  (233, 309, 2, 29000),
  (233, 312, 3, 39000),
  (234, 376, 3, 36500),
  (234, 378, 3, 43000),
  (234, 380, 2, 6000),
  (235, 295, 1, 23500),
  (235, 296, 2, 8000),
  (236, 401, 3, 9000),
  (236, 402, 2, 5000),
  (236, 400, 2, 17500),
  (237, 292, 3, 23500),
  (237, 298, 1, 36000),
  (238, 251, 3, 38500),
  (238, 246, 1, 17000),
  (238, 249, 1, 4500),
  (239, 99, 1, 33500),
  (239, 95, 3, 22500),
  (239, 97, 3, 6500),
  (240, 368, 3, 38500),
  (240, 366, 1, 9000),
  (241, 299, 1, 33000),
  (241, 302, 2, 24000),
  (241, 304, 2, 10500),
  (242, 16, 3, 18500),
  (242, 18, 3, 18000),
  (242, 19, 2, 3000),
  (243, 380, 2, 6000),
  (243, 376, 3, 36500),
  (243, 378, 1, 43000),
  (244, 431, 1, 16000),
  (244, 428, 2, 25000),
  (244, 430, 1, 17000),
  (245, 154, 2, 13000),
  (245, 156, 3, 15000),
  (246, 105, 1, 8500),
  (246, 107, 1, 35000),
  (247, 181, 2, 5000),
  (247, 178, 3, 18000),
  (248, 229, 1, 43500),
  (248, 235, 2, 53000),
  (249, 11, 3, 41500),
  (249, 13, 1, 3000),
  (250, 120, 3, 4500),
  (250, 121, 3, 8500),
  (250, 115, 1, 33500);
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (1, 1, 1, '2026-09-18 01:43:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (1, 2, 2, '2026-09-18 01:53:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (1, 3, 3, '2026-09-18 02:16:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (1, 4, 4, '2026-09-18 02:36:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (2, 1, 1, '2026-09-28 08:08:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (2, 2, 2, '2026-09-28 08:11:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (2, 3, 3, '2026-09-28 08:39:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (2, 4, 4, '2026-09-28 09:02:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (3, 1, 1, '2026-10-24 12:44:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (3, 2, 2, '2026-10-24 12:49:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (3, 3, 3, '2026-10-24 13:13:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (3, 4, 4, '2026-10-24 13:31:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (4, 1, 1, '2026-09-17 18:20:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (4, 2, 2, '2026-09-17 18:25:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (4, 3, 3, '2026-09-17 18:56:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (4, 4, 4, '2026-09-17 19:14:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (5, 1, 1, '2026-11-17 22:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (5, 2, 5, '2026-11-17 22:45:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (6, 1, 1, '2026-08-28 16:06:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (6, 2, 2, '2026-08-28 16:14:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (6, 3, 3, '2026-08-28 16:38:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (6, 4, 4, '2026-08-28 16:56:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (7, 1, 1, '2026-09-28 04:01:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (7, 2, 2, '2026-09-28 04:11:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (7, 3, 3, '2026-09-28 04:41:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (7, 4, 4, '2026-09-28 05:07:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (8, 1, 1, '2026-10-18 22:58:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (8, 2, 2, '2026-10-18 23:05:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (8, 3, 3, '2026-10-18 23:36:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (8, 4, 4, '2026-10-18 23:51:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (9, 1, 1, '2026-08-12 15:16:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (9, 2, 5, '2026-08-12 15:26:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (10, 1, 1, '2026-10-14 18:16:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (10, 2, 2, '2026-10-14 18:23:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (10, 3, 3, '2026-10-14 18:51:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (10, 4, 4, '2026-10-14 19:22:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (11, 1, 1, '2026-09-27 01:56:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (11, 2, 2, '2026-09-27 02:03:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (11, 3, 3, '2026-09-27 02:37:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (11, 4, 4, '2026-09-27 03:03:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (12, 1, 1, '2026-08-09 22:18:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (12, 2, 2, '2026-08-09 22:22:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (12, 3, 3, '2026-08-09 22:56:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (12, 4, 4, '2026-08-09 23:11:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (13, 1, 1, '2026-08-27 07:43:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (13, 2, 2, '2026-08-27 07:50:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (13, 3, 3, '2026-08-27 08:19:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (13, 4, 4, '2026-08-27 08:58:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (14, 1, 1, '2026-08-26 02:45:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (14, 2, 2, '2026-08-26 02:49:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (14, 3, 3, '2026-08-26 03:11:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (14, 4, 4, '2026-08-26 03:28:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (15, 1, 1, '2026-11-17 08:37:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (15, 2, 2, '2026-11-17 08:45:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (15, 3, 3, '2026-11-17 09:07:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (15, 4, 4, '2026-11-17 09:31:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (16, 1, 1, '2026-08-24 02:04:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (16, 2, 2, '2026-08-24 02:08:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (16, 3, 3, '2026-08-24 02:43:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (16, 4, 4, '2026-08-24 03:04:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (17, 1, 1, '2026-10-30 18:56:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (17, 2, 2, '2026-10-30 19:04:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (17, 3, 3, '2026-10-30 19:19:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (17, 4, 4, '2026-10-30 19:38:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (18, 1, 1, '2026-09-22 14:42:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (18, 2, 2, '2026-09-22 14:52:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (18, 3, 3, '2026-09-22 15:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (18, 4, 4, '2026-09-22 15:48:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (19, 1, 1, '2026-10-05 09:52:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (19, 2, 2, '2026-10-05 09:55:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (19, 3, 3, '2026-10-05 10:24:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (19, 4, 4, '2026-10-05 11:03:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (20, 1, 1, '2026-08-13 03:57:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (20, 2, 2, '2026-08-13 04:06:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (20, 3, 3, '2026-08-13 04:36:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (20, 4, 4, '2026-08-13 04:57:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (21, 1, 1, '2026-08-19 18:24:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (21, 2, 2, '2026-08-19 18:33:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (21, 3, 3, '2026-08-19 18:57:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (21, 4, 4, '2026-08-19 19:34:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (22, 1, 1, '2026-10-31 06:33:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (22, 2, 2, '2026-10-31 06:37:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (22, 3, 3, '2026-10-31 07:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (23, 1, 1, '2026-10-15 09:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (23, 2, 2, '2026-10-15 09:50:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (23, 3, 3, '2026-10-15 10:07:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (23, 4, 4, '2026-10-15 10:25:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (24, 1, 1, '2026-08-20 03:21:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (24, 2, 2, '2026-08-20 03:30:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (24, 3, 5, '2026-08-20 03:40:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (25, 1, 1, '2026-08-02 22:47:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (25, 2, 2, '2026-08-02 22:57:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (25, 3, 3, '2026-08-02 23:17:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (25, 4, 4, '2026-08-02 23:54:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (26, 1, 1, '2026-09-01 01:42:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (26, 2, 2, '2026-09-01 01:49:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (26, 3, 3, '2026-09-01 02:24:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (26, 4, 4, '2026-09-01 02:42:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (27, 1, 1, '2026-08-14 03:33:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (27, 2, 2, '2026-08-14 03:37:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (27, 3, 3, '2026-08-14 04:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (27, 4, 4, '2026-08-14 04:38:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (28, 1, 1, '2026-08-27 05:25:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (28, 2, 2, '2026-08-27 05:35:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (28, 3, 3, '2026-08-27 05:54:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (28, 4, 4, '2026-08-27 06:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (29, 1, 1, '2026-09-17 20:09:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (29, 2, 2, '2026-09-17 20:19:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (29, 3, 5, '2026-09-17 20:27:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (30, 1, 1, '2026-09-27 19:06:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (30, 2, 2, '2026-09-27 19:13:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (30, 3, 3, '2026-09-27 19:34:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (30, 4, 4, '2026-09-27 20:04:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (31, 1, 1, '2026-10-26 00:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (31, 2, 2, '2026-10-26 00:17:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (31, 3, 3, '2026-10-26 00:32:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (31, 4, 4, '2026-10-26 00:57:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (32, 1, 1, '2026-10-05 15:32:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (32, 2, 2, '2026-10-05 15:41:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (32, 3, 3, '2026-10-05 16:06:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (32, 4, 4, '2026-10-05 16:40:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (33, 1, 1, '2026-08-04 02:09:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (33, 2, 2, '2026-08-04 02:12:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (33, 3, 3, '2026-08-04 02:43:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (33, 4, 4, '2026-08-04 03:18:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (34, 1, 1, '2026-08-19 10:25:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (34, 2, 2, '2026-08-19 10:35:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (34, 3, 3, '2026-08-19 10:50:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (34, 4, 4, '2026-08-19 11:11:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (35, 1, 1, '2026-10-16 22:24:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (35, 2, 2, '2026-10-16 22:28:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (35, 3, 3, '2026-10-16 22:44:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (35, 4, 4, '2026-10-16 23:13:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (36, 1, 1, '2026-10-21 19:13:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (36, 2, 2, '2026-10-21 19:19:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (36, 3, 5, '2026-10-21 19:29:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (37, 1, 1, '2026-09-19 04:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (37, 2, 2, '2026-09-19 04:14:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (37, 3, 3, '2026-09-19 04:47:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (37, 4, 4, '2026-09-19 05:24:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (38, 1, 1, '2026-09-30 15:13:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (38, 2, 5, '2026-09-30 15:23:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (39, 1, 1, '2026-10-27 20:27:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (39, 2, 2, '2026-10-27 20:37:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (39, 3, 5, '2026-10-27 20:44:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (40, 1, 1, '2026-11-07 19:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (40, 2, 2, '2026-11-07 19:21:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (40, 3, 3, '2026-11-07 19:44:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (40, 4, 4, '2026-11-07 20:16:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (41, 1, 1, '2026-09-01 20:08:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (41, 2, 2, '2026-09-01 20:14:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (41, 3, 3, '2026-09-01 20:33:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (41, 4, 4, '2026-09-01 21:09:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (42, 1, 1, '2026-08-25 16:52:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (42, 2, 2, '2026-08-25 17:01:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (42, 3, 3, '2026-08-25 17:30:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (42, 4, 4, '2026-08-25 17:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (43, 1, 1, '2026-09-11 02:14:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (43, 2, 2, '2026-09-11 02:17:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (43, 3, 3, '2026-09-11 02:48:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (43, 4, 4, '2026-09-11 03:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (44, 1, 1, '2026-08-23 18:10:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (44, 2, 2, '2026-08-23 18:18:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (44, 3, 3, '2026-08-23 18:33:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (44, 4, 4, '2026-08-23 19:02:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (45, 1, 1, '2026-11-03 21:38:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (45, 2, 2, '2026-11-03 21:42:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (45, 3, 3, '2026-11-03 22:16:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (45, 4, 4, '2026-11-03 22:47:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (46, 1, 1, '2026-10-04 17:41:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (46, 2, 2, '2026-10-04 17:47:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (46, 3, 3, '2026-10-04 18:21:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (46, 4, 4, '2026-10-04 18:48:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (47, 1, 1, '2026-08-11 14:37:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (47, 2, 2, '2026-08-11 14:45:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (47, 3, 3, '2026-08-11 15:00:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (47, 4, 4, '2026-08-11 15:39:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (48, 1, 1, '2026-10-13 05:21:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (48, 2, 2, '2026-10-13 05:30:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (48, 3, 3, '2026-10-13 05:54:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (48, 4, 4, '2026-10-13 06:17:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (49, 1, 1, '2026-10-21 18:25:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (49, 2, 2, '2026-10-21 18:30:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (49, 3, 3, '2026-10-21 18:47:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (49, 4, 4, '2026-10-21 19:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (50, 1, 1, '2026-11-14 04:30:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (50, 2, 2, '2026-11-14 04:39:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (51, 1, 1, '2026-10-03 11:31:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (51, 2, 2, '2026-10-03 11:41:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (51, 3, 3, '2026-10-03 12:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (51, 4, 4, '2026-10-03 12:38:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (52, 1, 1, '2026-11-02 06:25:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (52, 2, 2, '2026-11-02 06:32:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (52, 3, 3, '2026-11-02 07:01:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (52, 4, 4, '2026-11-02 07:30:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (53, 1, 1, '2026-09-03 21:01:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (53, 2, 5, '2026-09-03 21:08:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (54, 1, 1, '2026-09-30 03:36:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (54, 2, 2, '2026-09-30 03:39:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (54, 3, 3, '2026-09-30 04:12:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (54, 4, 4, '2026-09-30 04:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (55, 1, 1, '2026-10-02 08:31:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (56, 1, 1, '2026-11-17 13:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (56, 2, 2, '2026-11-17 13:15:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (56, 3, 3, '2026-11-17 13:48:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (56, 4, 4, '2026-11-17 14:24:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (57, 1, 1, '2026-10-28 01:24:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (57, 2, 2, '2026-10-28 01:29:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (57, 3, 3, '2026-10-28 01:55:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (57, 4, 4, '2026-10-28 02:26:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (58, 1, 1, '2026-10-16 12:21:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (58, 2, 2, '2026-10-16 12:29:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (58, 3, 3, '2026-10-16 12:54:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (58, 4, 4, '2026-10-16 13:30:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (59, 1, 1, '2026-09-05 04:45:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (59, 2, 2, '2026-09-05 04:50:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (59, 3, 3, '2026-09-05 05:05:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (59, 4, 4, '2026-09-05 05:44:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (60, 1, 1, '2026-10-14 14:26:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (60, 2, 2, '2026-10-14 14:30:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (60, 3, 3, '2026-10-14 14:54:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (60, 4, 4, '2026-10-14 15:21:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (61, 1, 1, '2026-11-01 10:02:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (61, 2, 2, '2026-11-01 10:06:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (61, 3, 3, '2026-11-01 10:25:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (61, 4, 4, '2026-11-01 10:47:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (62, 1, 1, '2026-09-12 21:24:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (62, 2, 2, '2026-09-12 21:29:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (62, 3, 3, '2026-09-12 22:04:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (62, 4, 4, '2026-09-12 22:23:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (63, 1, 1, '2026-11-07 11:47:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (63, 2, 2, '2026-11-07 11:53:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (63, 3, 3, '2026-11-07 12:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (63, 4, 4, '2026-11-07 12:48:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (64, 1, 1, '2026-11-07 18:39:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (64, 2, 2, '2026-11-07 18:46:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (65, 1, 1, '2026-09-09 11:30:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (65, 2, 2, '2026-09-09 11:34:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (65, 3, 3, '2026-09-09 11:58:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (65, 4, 4, '2026-09-09 12:24:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (66, 1, 1, '2026-09-09 13:02:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (66, 2, 2, '2026-09-09 13:11:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (66, 3, 3, '2026-09-09 13:40:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (66, 4, 4, '2026-09-09 13:58:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (67, 1, 1, '2026-08-21 03:50:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (67, 2, 2, '2026-08-21 03:57:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (67, 3, 3, '2026-08-21 04:32:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (67, 4, 4, '2026-08-21 04:48:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (68, 1, 1, '2026-10-24 02:49:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (68, 2, 2, '2026-10-24 02:59:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (68, 3, 3, '2026-10-24 03:26:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (68, 4, 4, '2026-10-24 03:41:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (69, 1, 1, '2026-11-03 00:44:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (69, 2, 2, '2026-11-03 00:50:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (69, 3, 3, '2026-11-03 01:12:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (69, 4, 4, '2026-11-03 01:31:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (70, 1, 1, '2026-09-23 07:07:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (70, 2, 2, '2026-09-23 07:15:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (70, 3, 3, '2026-09-23 07:31:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (70, 4, 4, '2026-09-23 07:52:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (71, 1, 1, '2026-11-08 03:00:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (71, 2, 2, '2026-11-08 03:06:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (71, 3, 5, '2026-11-08 03:16:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (72, 1, 1, '2026-09-12 10:12:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (72, 2, 2, '2026-09-12 10:22:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (72, 3, 3, '2026-09-12 10:40:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (72, 4, 4, '2026-09-12 11:13:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (73, 1, 1, '2026-09-08 00:46:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (73, 2, 2, '2026-09-08 00:56:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (73, 3, 3, '2026-09-08 01:28:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (73, 4, 4, '2026-09-08 01:43:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (74, 1, 1, '2026-08-04 07:44:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (74, 2, 2, '2026-08-04 07:53:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (74, 3, 3, '2026-08-04 08:26:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (74, 4, 4, '2026-08-04 09:01:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (75, 1, 1, '2026-08-25 08:52:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (75, 2, 2, '2026-08-25 08:57:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (75, 3, 3, '2026-08-25 09:28:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (75, 4, 4, '2026-08-25 10:06:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (76, 1, 1, '2026-09-03 22:33:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (76, 2, 2, '2026-09-03 22:38:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (76, 3, 3, '2026-09-03 22:57:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (76, 4, 4, '2026-09-03 23:23:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (77, 1, 1, '2026-11-17 00:38:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (78, 1, 1, '2026-08-29 17:12:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (78, 2, 2, '2026-08-29 17:20:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (78, 3, 3, '2026-08-29 17:42:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (78, 4, 4, '2026-08-29 18:18:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (79, 1, 1, '2026-08-24 05:22:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (79, 2, 2, '2026-08-24 05:29:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (79, 3, 3, '2026-08-24 05:48:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (79, 4, 4, '2026-08-24 06:22:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (80, 1, 1, '2026-10-31 09:00:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (80, 2, 2, '2026-10-31 09:09:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (80, 3, 3, '2026-10-31 09:34:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (80, 4, 4, '2026-10-31 10:01:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (81, 1, 1, '2026-08-05 21:52:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (82, 1, 1, '2026-10-30 06:17:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (82, 2, 2, '2026-10-30 06:22:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (82, 3, 3, '2026-10-30 06:51:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (83, 1, 1, '2026-10-01 16:20:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (83, 2, 2, '2026-10-01 16:29:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (83, 3, 3, '2026-10-01 16:57:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (83, 4, 4, '2026-10-01 17:16:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (84, 1, 1, '2026-10-14 10:56:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (84, 2, 2, '2026-10-14 11:04:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (84, 3, 3, '2026-10-14 11:27:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (84, 4, 4, '2026-10-14 11:44:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (85, 1, 1, '2026-10-28 09:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (85, 2, 2, '2026-10-28 09:49:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (85, 3, 3, '2026-10-28 10:05:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (85, 4, 4, '2026-10-28 10:43:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (86, 1, 1, '2026-08-06 12:37:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (86, 2, 2, '2026-08-06 12:47:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (87, 1, 1, '2026-10-11 00:24:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (87, 2, 2, '2026-10-11 00:34:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (87, 3, 3, '2026-10-11 00:55:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (87, 4, 4, '2026-10-11 01:35:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (88, 1, 1, '2026-10-24 00:34:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (89, 1, 1, '2026-10-02 06:32:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (89, 2, 2, '2026-10-02 06:41:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (89, 3, 3, '2026-10-02 07:16:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (89, 4, 4, '2026-10-02 07:32:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (90, 1, 1, '2026-09-10 08:44:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (90, 2, 2, '2026-09-10 08:51:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (90, 3, 3, '2026-09-10 09:07:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (90, 4, 4, '2026-09-10 09:47:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (91, 1, 1, '2026-09-25 17:13:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (91, 2, 2, '2026-09-25 17:18:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (91, 3, 3, '2026-09-25 17:35:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (91, 4, 4, '2026-09-25 17:53:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (92, 1, 1, '2026-08-30 00:16:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (93, 1, 1, '2026-09-25 02:22:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (93, 2, 2, '2026-09-25 02:27:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (93, 3, 3, '2026-09-25 02:44:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (93, 4, 4, '2026-09-25 03:16:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (94, 1, 1, '2026-08-15 05:30:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (94, 2, 2, '2026-08-15 05:39:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (94, 3, 3, '2026-08-15 05:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (94, 4, 4, '2026-08-15 06:24:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (95, 1, 1, '2026-10-18 18:54:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (96, 1, 1, '2026-09-26 09:28:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (96, 2, 2, '2026-09-26 09:34:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (96, 3, 3, '2026-09-26 09:51:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (96, 4, 4, '2026-09-26 10:17:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (97, 1, 1, '2026-10-19 17:44:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (97, 2, 2, '2026-10-19 17:54:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (97, 3, 3, '2026-10-19 18:22:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (97, 4, 4, '2026-10-19 18:50:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (98, 1, 1, '2026-09-07 12:46:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (98, 2, 2, '2026-09-07 12:55:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (98, 3, 3, '2026-09-07 13:29:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (98, 4, 4, '2026-09-07 13:51:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (99, 1, 1, '2026-10-01 12:26:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (99, 2, 2, '2026-10-01 12:35:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (99, 3, 3, '2026-10-01 12:56:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (99, 4, 4, '2026-10-01 13:23:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (100, 1, 1, '2026-10-28 10:15:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (100, 2, 2, '2026-10-28 10:24:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (101, 1, 1, '2026-11-02 08:59:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (101, 2, 2, '2026-11-02 09:03:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (101, 3, 3, '2026-11-02 09:26:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (101, 4, 4, '2026-11-02 09:58:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (102, 1, 1, '2026-08-10 18:59:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (102, 2, 2, '2026-08-10 19:04:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (102, 3, 3, '2026-08-10 19:28:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (102, 4, 4, '2026-08-10 20:08:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (103, 1, 1, '2026-08-03 04:57:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (103, 2, 2, '2026-08-03 05:04:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (103, 3, 3, '2026-08-03 05:23:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (103, 4, 4, '2026-08-03 05:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (104, 1, 1, '2026-10-09 06:20:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (104, 2, 2, '2026-10-09 06:24:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (104, 3, 3, '2026-10-09 06:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (104, 4, 4, '2026-10-09 07:17:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (105, 1, 1, '2026-09-09 02:13:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (105, 2, 2, '2026-09-09 02:22:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (105, 3, 3, '2026-09-09 02:40:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (105, 4, 4, '2026-09-09 03:09:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (106, 1, 1, '2026-10-05 00:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (106, 2, 2, '2026-10-05 00:44:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (106, 3, 3, '2026-10-05 01:15:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (106, 4, 4, '2026-10-05 01:55:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (107, 1, 1, '2026-10-20 06:22:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (107, 2, 2, '2026-10-20 06:31:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (107, 3, 3, '2026-10-20 07:04:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (107, 4, 4, '2026-10-20 07:20:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (108, 1, 1, '2026-10-01 07:08:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (108, 2, 2, '2026-10-01 07:16:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (108, 3, 3, '2026-10-01 07:34:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (108, 4, 4, '2026-10-01 08:07:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (109, 1, 1, '2026-10-23 15:34:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (109, 2, 2, '2026-10-23 15:40:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (109, 3, 3, '2026-10-23 16:00:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (109, 4, 4, '2026-10-23 16:30:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (110, 1, 1, '2026-09-23 12:03:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (110, 2, 2, '2026-09-23 12:07:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (110, 3, 3, '2026-09-23 12:23:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (110, 4, 4, '2026-09-23 13:00:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (111, 1, 1, '2026-09-14 14:56:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (111, 2, 2, '2026-09-14 15:04:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (111, 3, 3, '2026-09-14 15:27:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (111, 4, 4, '2026-09-14 15:43:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (112, 1, 1, '2026-08-17 22:19:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (112, 2, 2, '2026-08-17 22:28:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (112, 3, 3, '2026-08-17 22:48:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (112, 4, 4, '2026-08-17 23:13:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (113, 1, 1, '2026-10-03 09:13:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (113, 2, 2, '2026-10-03 09:18:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (113, 3, 3, '2026-10-03 09:49:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (114, 1, 1, '2026-11-19 12:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (115, 1, 1, '2026-11-20 03:23:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (115, 2, 2, '2026-11-20 03:32:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (115, 3, 3, '2026-11-20 04:06:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (115, 4, 4, '2026-11-20 04:29:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (116, 1, 1, '2026-09-08 01:47:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (116, 2, 2, '2026-09-08 01:51:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (116, 3, 3, '2026-09-08 02:07:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (116, 4, 4, '2026-09-08 02:42:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (117, 1, 1, '2026-09-03 13:07:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (117, 2, 2, '2026-09-03 13:16:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (117, 3, 3, '2026-09-03 13:33:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (117, 4, 4, '2026-09-03 14:03:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (118, 1, 1, '2026-09-29 02:31:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (118, 2, 2, '2026-09-29 02:35:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (118, 3, 3, '2026-09-29 02:52:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (118, 4, 4, '2026-09-29 03:15:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (119, 1, 1, '2026-09-12 21:20:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (119, 2, 2, '2026-09-12 21:28:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (119, 3, 3, '2026-09-12 21:51:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (120, 1, 1, '2026-08-11 00:30:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (120, 2, 2, '2026-08-11 00:37:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (120, 3, 3, '2026-08-11 01:04:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (120, 4, 4, '2026-08-11 01:36:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (121, 1, 1, '2026-08-28 06:56:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (121, 2, 2, '2026-08-28 06:59:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (121, 3, 5, '2026-08-28 07:06:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (122, 1, 1, '2026-08-12 09:04:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (122, 2, 2, '2026-08-12 09:09:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (122, 3, 3, '2026-08-12 09:27:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (122, 4, 4, '2026-08-12 10:05:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (123, 1, 1, '2026-09-13 12:09:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (123, 2, 2, '2026-09-13 12:14:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (123, 3, 3, '2026-09-13 12:32:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (123, 4, 4, '2026-09-13 12:55:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (124, 1, 1, '2026-08-10 20:12:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (124, 2, 2, '2026-08-10 20:18:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (124, 3, 3, '2026-08-10 20:51:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (124, 4, 4, '2026-08-10 21:30:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (125, 1, 1, '2026-08-02 08:05:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (125, 2, 2, '2026-08-02 08:12:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (125, 3, 3, '2026-08-02 08:46:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (125, 4, 4, '2026-08-02 09:01:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (126, 1, 1, '2026-10-28 07:05:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (126, 2, 2, '2026-10-28 07:11:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (126, 3, 3, '2026-10-28 07:44:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (126, 4, 4, '2026-10-28 08:02:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (127, 1, 1, '2026-09-19 14:14:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (127, 2, 2, '2026-09-19 14:20:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (127, 3, 3, '2026-09-19 14:52:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (127, 4, 4, '2026-09-19 15:13:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (128, 1, 1, '2026-11-03 12:37:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (128, 2, 5, '2026-11-03 12:40:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (129, 1, 1, '2026-09-23 15:43:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (129, 2, 2, '2026-09-23 15:51:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (129, 3, 3, '2026-09-23 16:16:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (129, 4, 4, '2026-09-23 16:31:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (130, 1, 1, '2026-08-19 07:50:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (130, 2, 2, '2026-08-19 07:54:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (130, 3, 3, '2026-08-19 08:29:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (130, 4, 4, '2026-08-19 09:04:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (131, 1, 1, '2026-08-09 23:01:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (131, 2, 2, '2026-08-09 23:05:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (131, 3, 3, '2026-08-09 23:37:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (131, 4, 4, '2026-08-10 00:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (132, 1, 1, '2026-10-21 01:08:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (132, 2, 2, '2026-10-21 01:15:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (132, 3, 3, '2026-10-21 01:41:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (132, 4, 4, '2026-10-21 01:58:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (133, 1, 1, '2026-11-06 05:56:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (133, 2, 5, '2026-11-06 06:01:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (134, 1, 1, '2026-08-17 01:09:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (135, 1, 1, '2026-09-28 23:43:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (135, 2, 2, '2026-09-28 23:50:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (136, 1, 1, '2026-11-01 21:14:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (136, 2, 2, '2026-11-01 21:19:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (136, 3, 3, '2026-11-01 21:49:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (136, 4, 4, '2026-11-01 22:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (137, 1, 1, '2026-08-19 16:59:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (137, 2, 2, '2026-08-19 17:07:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (137, 3, 3, '2026-08-19 17:37:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (137, 4, 4, '2026-08-19 17:56:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (138, 1, 1, '2026-09-22 00:44:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (138, 2, 2, '2026-09-22 00:51:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (138, 3, 3, '2026-09-22 01:12:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (138, 4, 4, '2026-09-22 01:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (139, 1, 1, '2026-08-12 12:01:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (139, 2, 2, '2026-08-12 12:07:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (139, 3, 3, '2026-08-12 12:41:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (139, 4, 4, '2026-08-12 13:09:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (140, 1, 1, '2026-09-05 14:54:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (140, 2, 2, '2026-09-05 15:02:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (140, 3, 3, '2026-09-05 15:18:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (140, 4, 4, '2026-09-05 15:41:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (141, 1, 1, '2026-11-17 10:52:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (141, 2, 2, '2026-11-17 10:58:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (141, 3, 3, '2026-11-17 11:13:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (141, 4, 4, '2026-11-17 11:45:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (142, 1, 1, '2026-08-01 21:10:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (142, 2, 2, '2026-08-01 21:15:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (142, 3, 3, '2026-08-01 21:33:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (142, 4, 4, '2026-08-01 22:06:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (143, 1, 1, '2026-08-03 07:36:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (143, 2, 2, '2026-08-03 07:41:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (143, 3, 3, '2026-08-03 08:06:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (143, 4, 4, '2026-08-03 08:29:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (144, 1, 1, '2026-10-04 00:24:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (144, 2, 2, '2026-10-04 00:32:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (144, 3, 3, '2026-10-04 01:03:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (144, 4, 4, '2026-10-04 01:42:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (145, 1, 1, '2026-09-11 21:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (145, 2, 2, '2026-09-11 21:46:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (145, 3, 3, '2026-09-11 22:03:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (145, 4, 4, '2026-09-11 22:42:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (146, 1, 1, '2026-10-02 05:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (146, 2, 2, '2026-10-02 05:16:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (146, 3, 3, '2026-10-02 05:35:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (146, 4, 4, '2026-10-02 05:50:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (147, 1, 1, '2026-11-09 12:12:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (147, 2, 2, '2026-11-09 12:19:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (147, 3, 3, '2026-11-09 12:52:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (147, 4, 4, '2026-11-09 13:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (148, 1, 1, '2026-09-07 07:52:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (148, 2, 2, '2026-09-07 07:55:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (148, 3, 3, '2026-09-07 08:17:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (148, 4, 4, '2026-09-07 08:35:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (149, 1, 1, '2026-09-04 13:22:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (149, 2, 2, '2026-09-04 13:29:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (149, 3, 3, '2026-09-04 14:02:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (149, 4, 4, '2026-09-04 14:21:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (150, 1, 1, '2026-08-05 07:17:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (150, 2, 2, '2026-08-05 07:20:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (150, 3, 3, '2026-08-05 07:44:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (150, 4, 4, '2026-08-05 08:20:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (151, 1, 1, '2026-10-06 07:43:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (151, 2, 2, '2026-10-06 07:47:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (151, 3, 3, '2026-10-06 08:15:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (151, 4, 4, '2026-10-06 08:43:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (152, 1, 1, '2026-09-13 13:41:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (152, 2, 2, '2026-09-13 13:46:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (152, 3, 3, '2026-09-13 14:03:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (152, 4, 4, '2026-09-13 14:28:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (153, 1, 1, '2026-08-14 20:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (153, 2, 2, '2026-08-14 20:46:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (153, 3, 3, '2026-08-14 21:09:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (153, 4, 4, '2026-08-14 21:42:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (154, 1, 1, '2026-09-01 09:38:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (154, 2, 2, '2026-09-01 09:46:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (154, 3, 3, '2026-09-01 10:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (154, 4, 4, '2026-09-01 10:37:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (155, 1, 1, '2026-09-07 05:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (155, 2, 2, '2026-09-07 05:17:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (155, 3, 3, '2026-09-07 05:47:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (155, 4, 4, '2026-09-07 06:18:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (156, 1, 1, '2026-08-02 06:13:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (156, 2, 2, '2026-08-02 06:22:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (156, 3, 3, '2026-08-02 06:55:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (156, 4, 4, '2026-08-02 07:11:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (157, 1, 1, '2026-10-24 15:58:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (157, 2, 2, '2026-10-24 16:01:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (157, 3, 3, '2026-10-24 16:31:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (157, 4, 4, '2026-10-24 16:58:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (158, 1, 1, '2026-09-29 00:09:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (158, 2, 2, '2026-09-29 00:15:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (158, 3, 3, '2026-09-29 00:50:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (158, 4, 4, '2026-09-29 01:23:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (159, 1, 1, '2026-09-20 00:00:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (159, 2, 2, '2026-09-20 00:04:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (159, 3, 3, '2026-09-20 00:32:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (159, 4, 4, '2026-09-20 00:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (160, 1, 1, '2026-09-23 14:53:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (160, 2, 2, '2026-09-23 14:58:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (160, 3, 3, '2026-09-23 15:33:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (160, 4, 4, '2026-09-23 15:53:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (161, 1, 1, '2026-11-06 16:43:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (162, 1, 1, '2026-08-09 04:47:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (162, 2, 2, '2026-08-09 04:57:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (162, 3, 3, '2026-08-09 05:13:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (162, 4, 4, '2026-08-09 05:47:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (163, 1, 1, '2026-09-05 15:52:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (163, 2, 2, '2026-09-05 16:00:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (163, 3, 3, '2026-09-05 16:27:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (163, 4, 4, '2026-09-05 16:52:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (164, 1, 1, '2026-11-05 15:15:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (164, 2, 5, '2026-11-05 15:21:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (165, 1, 1, '2026-08-15 00:20:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (165, 2, 2, '2026-08-15 00:28:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (165, 3, 3, '2026-08-15 00:51:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (165, 4, 4, '2026-08-15 01:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (166, 1, 1, '2026-09-04 13:41:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (166, 2, 2, '2026-09-04 13:45:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (166, 3, 3, '2026-09-04 14:00:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (166, 4, 4, '2026-09-04 14:30:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (167, 1, 1, '2026-10-11 01:17:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (167, 2, 2, '2026-10-11 01:21:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (167, 3, 3, '2026-10-11 01:42:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (167, 4, 4, '2026-10-11 02:21:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (168, 1, 1, '2026-09-20 04:00:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (168, 2, 2, '2026-09-20 04:09:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (168, 3, 3, '2026-09-20 04:43:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (168, 4, 4, '2026-09-20 05:11:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (169, 1, 1, '2026-10-24 13:01:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (169, 2, 2, '2026-10-24 13:06:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (169, 3, 3, '2026-10-24 13:21:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (169, 4, 4, '2026-10-24 13:41:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (170, 1, 1, '2026-10-11 19:42:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (170, 2, 2, '2026-10-11 19:47:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (170, 3, 3, '2026-10-11 20:22:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (170, 4, 4, '2026-10-11 20:56:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (171, 1, 1, '2026-09-12 12:12:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (171, 2, 2, '2026-09-12 12:19:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (172, 1, 1, '2026-11-20 01:21:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (172, 2, 2, '2026-11-20 01:25:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (172, 3, 3, '2026-11-20 01:56:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (172, 4, 4, '2026-11-20 02:22:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (173, 1, 1, '2026-09-19 10:33:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (173, 2, 2, '2026-09-19 10:41:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (173, 3, 3, '2026-09-19 10:58:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (173, 4, 4, '2026-09-19 11:15:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (174, 1, 1, '2026-10-25 15:27:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (174, 2, 2, '2026-10-25 15:33:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (174, 3, 3, '2026-10-25 15:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (174, 4, 4, '2026-10-25 16:37:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (175, 1, 1, '2026-10-23 20:25:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (175, 2, 2, '2026-10-23 20:34:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (175, 3, 3, '2026-10-23 21:07:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (175, 4, 4, '2026-10-23 21:37:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (176, 1, 1, '2026-08-18 03:12:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (176, 2, 2, '2026-08-18 03:16:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (176, 3, 3, '2026-08-18 03:46:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (176, 4, 4, '2026-08-18 04:23:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (177, 1, 1, '2026-08-29 07:50:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (177, 2, 5, '2026-08-29 07:53:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (178, 1, 1, '2026-10-28 11:19:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (178, 2, 2, '2026-10-28 11:27:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (179, 1, 1, '2026-09-04 19:07:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (179, 2, 2, '2026-09-04 19:13:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (179, 3, 3, '2026-09-04 19:31:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (179, 4, 4, '2026-09-04 20:01:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (180, 1, 1, '2026-11-09 13:32:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (180, 2, 2, '2026-11-09 13:37:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (180, 3, 3, '2026-11-09 14:11:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (180, 4, 4, '2026-11-09 14:51:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (181, 1, 1, '2026-10-25 20:34:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (181, 2, 2, '2026-10-25 20:44:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (181, 3, 3, '2026-10-25 21:07:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (181, 4, 4, '2026-10-25 21:26:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (182, 1, 1, '2026-11-13 01:41:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (182, 2, 2, '2026-11-13 01:50:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (182, 3, 3, '2026-11-13 02:16:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (182, 4, 4, '2026-11-13 02:46:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (183, 1, 1, '2026-11-14 04:50:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (183, 2, 5, '2026-11-14 04:56:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (184, 1, 1, '2026-09-18 10:51:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (184, 2, 2, '2026-09-18 10:56:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (184, 3, 3, '2026-09-18 11:31:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (185, 1, 1, '2026-11-13 04:03:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (185, 2, 2, '2026-11-13 04:09:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (185, 3, 3, '2026-11-13 04:43:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (185, 4, 4, '2026-11-13 05:08:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (186, 1, 1, '2026-10-08 15:04:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (186, 2, 2, '2026-10-08 15:10:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (186, 3, 5, '2026-10-08 15:14:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (187, 1, 1, '2026-09-18 18:38:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (187, 2, 2, '2026-09-18 18:41:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (187, 3, 3, '2026-09-18 19:16:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (187, 4, 4, '2026-09-18 19:38:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (188, 1, 1, '2026-09-12 10:58:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (188, 2, 2, '2026-09-12 11:02:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (188, 3, 3, '2026-09-12 11:31:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (189, 1, 1, '2026-10-31 07:01:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (189, 2, 2, '2026-10-31 07:08:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (189, 3, 3, '2026-10-31 07:27:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (189, 4, 4, '2026-10-31 07:47:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (190, 1, 1, '2026-08-03 17:38:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (190, 2, 2, '2026-08-03 17:43:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (190, 3, 3, '2026-08-03 18:14:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (190, 4, 4, '2026-08-03 18:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (191, 1, 1, '2026-08-06 16:56:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (191, 2, 2, '2026-08-06 17:02:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (191, 3, 3, '2026-08-06 17:24:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (191, 4, 4, '2026-08-06 17:58:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (192, 1, 1, '2026-11-04 19:36:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (192, 2, 2, '2026-11-04 19:42:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (192, 3, 3, '2026-11-04 20:13:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (192, 4, 4, '2026-11-04 20:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (193, 1, 1, '2026-10-06 19:29:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (193, 2, 2, '2026-10-06 19:39:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (193, 3, 3, '2026-10-06 20:05:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (194, 1, 1, '2026-09-18 15:10:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (194, 2, 2, '2026-09-18 15:15:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (194, 3, 3, '2026-09-18 15:49:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (194, 4, 4, '2026-09-18 16:12:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (195, 1, 1, '2026-08-10 19:34:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (195, 2, 2, '2026-08-10 19:38:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (195, 3, 3, '2026-08-10 20:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (195, 4, 4, '2026-08-10 20:34:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (196, 1, 1, '2026-09-06 19:44:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (196, 2, 2, '2026-09-06 19:47:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (196, 3, 3, '2026-09-06 20:08:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (196, 4, 4, '2026-09-06 20:48:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (197, 1, 1, '2026-09-26 10:01:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (197, 2, 2, '2026-09-26 10:09:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (197, 3, 3, '2026-09-26 10:42:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (197, 4, 4, '2026-09-26 11:17:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (198, 1, 1, '2026-09-15 23:41:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (198, 2, 2, '2026-09-15 23:44:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (198, 3, 3, '2026-09-16 00:10:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (198, 4, 4, '2026-09-16 00:39:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (199, 1, 1, '2026-08-08 23:47:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (199, 2, 2, '2026-08-08 23:57:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (199, 3, 3, '2026-08-09 00:16:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (199, 4, 4, '2026-08-09 00:47:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (200, 1, 1, '2026-10-05 05:32:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (200, 2, 2, '2026-10-05 05:36:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (200, 3, 3, '2026-10-05 06:02:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (200, 4, 4, '2026-10-05 06:26:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (201, 1, 1, '2026-10-24 08:22:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (201, 2, 2, '2026-10-24 08:25:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (201, 3, 3, '2026-10-24 08:50:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (201, 4, 4, '2026-10-24 09:10:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (202, 1, 1, '2026-09-30 14:19:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (202, 2, 2, '2026-09-30 14:27:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (202, 3, 3, '2026-09-30 14:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (202, 4, 4, '2026-09-30 15:15:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (203, 1, 1, '2026-09-14 07:55:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (204, 1, 1, '2026-10-31 01:23:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (204, 2, 2, '2026-10-31 01:27:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (204, 3, 3, '2026-10-31 01:52:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (204, 4, 4, '2026-10-31 02:16:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (205, 1, 1, '2026-08-26 23:58:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (205, 2, 2, '2026-08-27 00:03:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (205, 3, 3, '2026-08-27 00:33:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (205, 4, 4, '2026-08-27 00:48:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (206, 1, 1, '2026-09-14 21:50:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (206, 2, 2, '2026-09-14 22:00:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (206, 3, 3, '2026-09-14 22:20:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (206, 4, 4, '2026-09-14 22:45:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (207, 1, 1, '2026-09-29 08:16:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (207, 2, 2, '2026-09-29 08:24:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (207, 3, 3, '2026-09-29 08:57:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (207, 4, 4, '2026-09-29 09:33:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (208, 1, 1, '2026-08-26 00:20:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (208, 2, 2, '2026-08-26 00:30:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (208, 3, 3, '2026-08-26 00:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (208, 4, 4, '2026-08-26 01:20:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (209, 1, 1, '2026-09-30 12:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (209, 2, 2, '2026-09-30 12:21:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (209, 3, 3, '2026-09-30 12:42:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (209, 4, 4, '2026-09-30 13:16:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (210, 1, 1, '2026-11-01 15:53:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (210, 2, 2, '2026-11-01 15:58:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (210, 3, 3, '2026-11-01 16:23:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (210, 4, 4, '2026-11-01 16:43:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (211, 1, 1, '2026-08-08 11:17:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (211, 2, 2, '2026-08-08 11:21:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (211, 3, 3, '2026-08-08 11:52:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (211, 4, 4, '2026-08-08 12:11:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (212, 1, 1, '2026-11-12 21:15:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (212, 2, 2, '2026-11-12 21:23:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (212, 3, 3, '2026-11-12 21:53:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (212, 4, 4, '2026-11-12 22:20:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (213, 1, 1, '2026-09-15 09:58:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (213, 2, 2, '2026-09-15 10:02:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (213, 3, 3, '2026-09-15 10:29:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (213, 4, 4, '2026-09-15 10:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (214, 1, 1, '2026-10-04 12:25:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (214, 2, 2, '2026-10-04 12:30:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (214, 3, 3, '2026-10-04 12:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (214, 4, 4, '2026-10-04 13:25:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (215, 1, 1, '2026-11-17 02:09:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (215, 2, 2, '2026-11-17 02:13:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (215, 3, 3, '2026-11-17 02:30:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (215, 4, 4, '2026-11-17 03:08:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (216, 1, 1, '2026-09-19 00:11:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (216, 2, 2, '2026-09-19 00:18:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (216, 3, 3, '2026-09-19 00:42:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (216, 4, 4, '2026-09-19 01:06:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (217, 1, 1, '2026-09-05 10:40:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (217, 2, 2, '2026-09-05 10:48:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (218, 1, 1, '2026-10-19 22:41:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (218, 2, 2, '2026-10-19 22:46:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (218, 3, 3, '2026-10-19 23:02:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (218, 4, 4, '2026-10-19 23:24:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (219, 1, 1, '2026-09-11 07:05:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (219, 2, 2, '2026-09-11 07:12:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (219, 3, 3, '2026-09-11 07:43:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (219, 4, 4, '2026-09-11 08:17:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (220, 1, 1, '2026-08-21 01:37:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (220, 2, 2, '2026-08-21 01:40:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (220, 3, 3, '2026-08-21 02:12:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (220, 4, 4, '2026-08-21 02:42:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (221, 1, 1, '2026-09-26 23:20:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (221, 2, 2, '2026-09-26 23:26:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (221, 3, 3, '2026-09-26 23:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (221, 4, 4, '2026-09-27 00:29:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (222, 1, 1, '2026-10-08 11:12:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (222, 2, 2, '2026-10-08 11:15:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (222, 3, 3, '2026-10-08 11:50:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (222, 4, 4, '2026-10-08 12:21:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (223, 1, 1, '2026-10-13 16:55:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (223, 2, 2, '2026-10-13 16:59:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (223, 3, 3, '2026-10-13 17:31:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (224, 1, 1, '2026-10-08 18:00:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (224, 2, 2, '2026-10-08 18:06:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (224, 3, 3, '2026-10-08 18:35:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (224, 4, 4, '2026-10-08 18:51:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (225, 1, 1, '2026-09-17 00:28:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (225, 2, 2, '2026-09-17 00:31:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (225, 3, 3, '2026-09-17 01:05:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (225, 4, 4, '2026-09-17 01:31:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (226, 1, 1, '2026-08-23 08:48:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (226, 2, 2, '2026-08-23 08:57:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (226, 3, 3, '2026-08-23 09:27:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (226, 4, 4, '2026-08-23 10:05:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (227, 1, 1, '2026-09-01 01:04:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (227, 2, 2, '2026-09-01 01:09:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (227, 3, 5, '2026-09-01 01:18:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (228, 1, 1, '2026-09-25 09:35:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (228, 2, 2, '2026-09-25 09:44:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (228, 3, 3, '2026-09-25 10:05:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (228, 4, 4, '2026-09-25 10:36:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (229, 1, 1, '2026-10-21 00:59:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (229, 2, 2, '2026-10-21 01:04:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (229, 3, 3, '2026-10-21 01:37:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (229, 4, 4, '2026-10-21 02:06:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (230, 1, 1, '2026-10-16 01:33:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (230, 2, 2, '2026-10-16 01:36:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (230, 3, 3, '2026-10-16 01:55:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (230, 4, 4, '2026-10-16 02:33:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (231, 1, 1, '2026-11-12 07:02:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (231, 2, 2, '2026-11-12 07:12:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (231, 3, 3, '2026-11-12 07:31:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (231, 4, 4, '2026-11-12 08:02:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (232, 1, 1, '2026-09-24 16:02:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (232, 2, 2, '2026-09-24 16:09:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (232, 3, 3, '2026-09-24 16:29:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (232, 4, 4, '2026-09-24 16:50:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (233, 1, 1, '2026-09-26 01:39:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (233, 2, 2, '2026-09-26 01:44:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (233, 3, 3, '2026-09-26 01:59:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (233, 4, 4, '2026-09-26 02:35:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (234, 1, 1, '2026-11-18 04:07:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (234, 2, 2, '2026-11-18 04:17:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (234, 3, 3, '2026-11-18 04:48:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (234, 4, 4, '2026-11-18 05:13:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (235, 1, 1, '2026-08-19 14:10:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (235, 2, 2, '2026-08-19 14:17:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (235, 3, 3, '2026-08-19 14:47:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (235, 4, 4, '2026-08-19 15:05:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (236, 1, 1, '2026-08-26 01:10:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (236, 2, 2, '2026-08-26 01:17:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (236, 3, 5, '2026-08-26 01:23:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (237, 1, 1, '2026-10-16 14:39:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (237, 2, 2, '2026-10-16 14:48:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (237, 3, 5, '2026-10-16 14:57:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (238, 1, 1, '2026-08-05 07:47:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (238, 2, 2, '2026-08-05 07:50:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (238, 3, 3, '2026-08-05 08:13:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (238, 4, 4, '2026-08-05 08:52:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (239, 1, 1, '2026-09-26 09:35:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (239, 2, 2, '2026-09-26 09:41:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (239, 3, 3, '2026-09-26 10:02:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (239, 4, 4, '2026-09-26 10:32:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (240, 1, 1, '2026-09-04 10:57:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (240, 2, 2, '2026-09-04 11:05:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (241, 1, 1, '2026-10-21 13:35:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (241, 2, 2, '2026-10-21 13:40:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (242, 1, 1, '2026-08-11 19:29:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (242, 2, 2, '2026-08-11 19:35:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (242, 3, 3, '2026-08-11 19:51:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (243, 1, 1, '2026-10-20 17:58:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (243, 2, 2, '2026-10-20 18:08:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (243, 3, 3, '2026-10-20 18:23:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (243, 4, 4, '2026-10-20 18:41:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (244, 1, 1, '2026-09-04 10:28:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (244, 2, 2, '2026-09-04 10:38:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (244, 3, 3, '2026-09-04 11:04:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (244, 4, 4, '2026-09-04 11:40:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (245, 1, 1, '2026-09-10 03:59:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (245, 2, 5, '2026-09-10 04:08:00', 'Pedido cancelado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (246, 1, 1, '2026-10-23 00:50:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (246, 2, 2, '2026-10-23 00:53:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (246, 3, 3, '2026-10-23 01:22:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (246, 4, 4, '2026-10-23 01:56:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (247, 1, 1, '2026-11-09 00:00:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (247, 2, 2, '2026-11-09 00:05:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (247, 3, 3, '2026-11-09 00:20:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (247, 4, 4, '2026-11-09 00:53:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (248, 1, 1, '2026-08-29 10:24:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (248, 2, 2, '2026-08-29 10:30:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (248, 3, 3, '2026-08-29 10:56:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (249, 1, 1, '2026-09-30 00:09:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (249, 2, 2, '2026-09-30 00:17:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (249, 3, 3, '2026-09-30 00:32:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (249, 4, 4, '2026-09-30 00:49:00', 'Pedido entregado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (250, 1, 1, '2026-09-16 16:25:00', 'Pedido recibido');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (250, 2, 2, '2026-09-16 16:32:00', 'Preparación iniciada');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (250, 3, 3, '2026-09-16 17:05:00', 'Pedido despachado');
INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion) VALUES
  (250, 4, 4, '2026-09-16 17:42:00', 'Pedido entregado');
INSERT INTO CALIFICACION (id_pedido, nota_restaurante, nota_repartidor, comentario, fecha) VALUES
  (14, 4, 4, NULL, '2026-08-26 03:49:00'),
  (141, 3, 4, NULL, '2026-11-17 12:30:00'),
  (131, 4, 2, NULL, '2026-08-10 01:41:00'),
  (198, 5, 3, 'Todo llegó fresco y en buen estado.', '2026-09-16 02:29:00'),
  (207, 5, 3, NULL, '2026-09-29 11:03:00'),
  (221, 4, 4, NULL, '2026-09-27 02:08:00'),
  (235, 3, 4, NULL, '2026-08-19 15:38:00'),
  (170, 3, 5, NULL, '2026-10-11 22:53:00'),
  (31, 3, 3, 'La preparación estuvo muy rica.', '2026-10-26 01:53:00'),
  (212, 4, 5, 'La comida llegó como la pedí.', '2026-11-12 23:00:00'),
  (67, 4, 4, 'Una opción agradable para compartir.', '2026-08-21 05:09:00'),
  (57, 3, 1, 'Una opción agradable para compartir.', '2026-10-28 03:36:00'),
  (142, 5, 5, NULL, '2026-08-01 22:38:00'),
  (218, 5, 4, 'Buena porción y entrega puntual.', '2026-10-19 23:56:00'),
  (180, 4, 5, 'Llegó caliente y muy bien empacado.', '2026-11-09 15:36:00'),
  (247, 3, 5, 'Todo llegó fresco y en buen estado.', '2026-11-09 01:45:00'),
  (150, 5, 5, 'La comida llegó como la pedí.', '2026-08-05 09:59:00'),
  (115, 3, 1, NULL, '2026-11-20 05:25:00'),
  (51, 4, 5, 'Llegó caliente y muy bien empacado.', '2026-10-03 13:05:00'),
  (172, 5, 1, 'La comida llegó como la pedí.', '2026-11-20 02:42:00'),
  (144, 4, 5, 'El sabor estuvo excelente.', '2026-10-04 02:18:00'),
  (162, 4, 5, 'Todo llegó fresco y en buen estado.', '2026-08-09 07:27:00'),
  (194, 4, 5, 'El sabor estuvo excelente.', '2026-09-18 16:50:00'),
  (103, 5, 3, 'Una opción agradable para compartir.', '2026-08-03 06:01:00'),
  (1, 5, 5, 'El sabor estuvo excelente.', '2026-09-18 04:24:00'),
  (68, 3, 4, 'Muy buena atención durante el pedido.', '2026-10-24 05:21:00'),
  (93, 3, 2, NULL, '2026-09-25 04:49:00'),
  (4, 4, 2, 'La comida llegó como la pedí.', '2026-09-17 20:40:00'),
  (46, 5, 3, 'Una opción agradable para compartir.', '2026-10-04 19:39:00'),
  (19, 4, 4, NULL, '2026-10-05 12:50:00'),
  (148, 1, 3, NULL, '2026-09-07 10:17:00'),
  (137, 3, 3, 'La comida llegó como la pedí.', '2026-08-19 18:12:00'),
  (238, 5, 5, NULL, '2026-08-05 09:26:00'),
  (73, 4, 4, NULL, '2026-09-08 03:26:00'),
  (152, 4, 5, NULL, '2026-09-13 15:55:00'),
  (78, 4, 4, NULL, '2026-08-29 19:55:00'),
  (230, 5, 5, NULL, '2026-10-16 03:38:00'),
  (155, 3, 3, NULL, '2026-09-07 07:15:00'),
  (43, 4, 4, 'Una opción agradable para compartir.', '2026-09-11 04:44:00'),
  (23, 4, 5, NULL, '2026-10-15 11:54:00'),
  (7, 5, 4, NULL, '2026-09-28 05:37:00'),
  (27, 3, 5, NULL, '2026-08-14 06:09:00'),
  (102, 3, 5, 'La comida llegó como la pedí.', '2026-08-10 21:07:00'),
  (244, 5, 5, 'El sabor estuvo excelente.', '2026-09-04 12:42:00'),
  (87, 3, 4, NULL, '2026-10-11 02:06:00'),
  (49, 4, 5, NULL, '2026-10-21 20:33:00'),
  (246, 4, 5, 'Llegó caliente y muy bien empacado.', '2026-10-23 03:11:00'),
  (179, 4, 4, 'La comida llegó como la pedí.', '2026-09-04 21:27:00'),
  (2, 5, 5, 'La preparación estuvo muy rica.', '2026-09-28 09:35:00'),
  (201, 4, 5, NULL, '2026-10-24 10:39:00'),
  (112, 5, 4, 'Todo llegó fresco y en buen estado.', '2026-08-18 00:38:00'),
  (181, 2, 5, NULL, '2026-10-25 22:24:00'),
  (6, 4, 5, 'Buena porción y entrega puntual.', '2026-08-28 18:38:00'),
  (96, 4, 2, 'La comida llegó como la pedí.', '2026-09-26 12:05:00'),
  (85, 3, 4, NULL, '2026-10-28 11:00:00'),
  (140, 4, 5, 'El sabor estuvo excelente.', '2026-09-05 16:16:00'),
  (191, 4, 5, NULL, '2026-08-06 18:10:00'),
  (209, 5, 5, NULL, '2026-09-30 13:52:00'),
  (98, 4, 5, 'Buena porción y entrega puntual.', '2026-09-07 14:42:00'),
  (111, 3, 5, 'Llegó caliente y muy bien empacado.', '2026-09-14 16:52:00'),
  (25, 4, 5, 'Todo llegó fresco y en buen estado.', '2026-08-03 01:14:00'),
  (42, 5, 5, 'Todo llegó fresco y en buen estado.', '2026-08-25 19:18:00'),
  (41, 4, 1, NULL, '2026-09-01 23:07:00'),
  (105, 1, 5, NULL, '2026-09-09 04:16:00'),
  (110, 5, 4, NULL, '2026-09-23 14:51:00'),
  (173, 5, 5, NULL, '2026-09-19 11:31:00'),
  (37, 3, 2, 'El sabor estuvo excelente.', '2026-09-19 05:54:00'),
  (45, 3, 2, NULL, '2026-11-03 23:09:00'),
  (145, 3, 5, NULL, '2026-09-11 23:13:00'),
  (226, 2, 5, 'Una opción agradable para compartir.', '2026-08-23 11:21:00'),
  (127, 5, 4, 'Muy buena atención durante el pedido.', '2026-09-19 16:44:00'),
  (122, 5, 5, 'La comida llegó como la pedí.', '2026-08-12 10:54:00'),
  (239, 4, 3, 'Una opción agradable para compartir.', '2026-09-26 10:54:00'),
  (80, 4, 4, NULL, '2026-10-31 10:58:00'),
  (250, 5, 5, 'La preparación estuvo muy rica.', '2026-09-16 18:41:00'),
  (97, 5, 4, 'Muy buena atención durante el pedido.', '2026-10-19 20:17:00'),
  (16, 3, 4, NULL, '2026-08-24 04:49:00'),
  (199, 5, 5, NULL, '2026-08-09 01:17:00'),
  (168, 3, 4, 'Todo llegó fresco y en buen estado.', '2026-09-20 06:32:00'),
  (8, 5, 5, 'Una opción agradable para compartir.', '2026-10-19 00:21:00'),
  (15, 5, 5, 'Buena porción y entrega puntual.', '2026-11-17 11:00:00'),
  (229, 4, 5, NULL, '2026-10-21 02:37:00'),
  (30, 5, 4, 'Una opción agradable para compartir.', '2026-09-27 21:15:00'),
  (40, 3, 5, 'Muy buena atención durante el pedido.', '2026-11-07 20:31:00'),
  (175, 4, 3, 'Muy buena atención durante el pedido.', '2026-10-23 22:30:00'),
  (136, 5, 5, 'Llegó caliente y muy bien empacado.', '2026-11-01 23:12:00'),
  (205, 4, 5, 'Muy buena atención durante el pedido.', '2026-08-27 02:18:00'),
  (21, 5, 5, 'El sabor estuvo excelente.', '2026-08-19 21:01:00'),
  (101, 5, 3, NULL, '2026-11-02 11:14:00'),
  (58, 4, 4, 'Una opción agradable para compartir.', '2026-10-16 15:10:00'),
  (3, 5, 5, NULL, '2026-10-24 15:06:00'),
  (109, 4, 3, NULL, '2026-10-23 18:15:00'),
  (74, 4, 4, 'La comida llegó como la pedí.', '2026-08-04 10:41:00'),
  (204, 3, 5, NULL, '2026-10-31 03:11:00'),
  (192, 4, 4, 'Una opción agradable para compartir.', '2026-11-04 21:42:00'),
  (32, 4, 4, NULL, '2026-10-05 16:55:00'),
  (234, 5, 4, NULL, '2026-11-18 06:40:00'),
  (89, 4, 5, 'Buena porción y entrega puntual.', '2026-10-02 09:32:00'),
  (10, 3, 1, NULL, '2026-10-14 20:19:00'),
  (106, 3, 1, NULL, '2026-10-05 02:24:00'),
  (54, 3, 5, NULL, '2026-09-30 05:15:00'),
  (233, 3, 4, NULL, '2026-09-26 02:59:00'),
  (126, 4, 4, 'Muy buena atención durante el pedido.', '2026-10-28 09:18:00'),
  (70, 5, 4, 'Todo llegó fresco y en buen estado.', '2026-09-23 08:24:00'),
  (56, 4, 3, NULL, '2026-11-17 14:48:00'),
  (59, 5, 4, NULL, '2026-09-05 06:00:00'),
  (147, 4, 4, NULL, '2026-11-09 14:16:00'),
  (130, 3, 2, 'Todo llegó fresco y en buen estado.', '2026-08-19 10:59:00'),
  (216, 5, 2, NULL, '2026-09-19 01:57:00'),
  (117, 5, 3, 'Todo llegó fresco y en buen estado.', '2026-09-03 15:52:00'),
  (213, 4, 4, NULL, '2026-09-15 11:48:00'),
  (94, 4, 5, 'El sabor estuvo excelente.', '2026-08-15 06:34:00'),
  (231, 4, 4, NULL, '2026-11-12 08:50:00'),
  (13, 5, 4, 'Todo llegó fresco y en buen estado.', '2026-08-27 10:24:00'),
  (202, 3, 5, NULL, '2026-09-30 16:15:00'),
  (149, 3, 3, 'La preparación estuvo muy rica.', '2026-09-04 15:57:00'),
  (79, 3, 4, NULL, '2026-08-24 07:59:00'),
  (123, 4, 3, 'Buena porción y entrega puntual.', '2026-09-13 14:19:00'),
  (224, 5, 5, NULL, '2026-10-08 20:09:00'),
  (219, 5, 5, NULL, '2026-09-11 09:24:00'),
  (104, 4, 5, 'La preparación estuvo muy rica.', '2026-10-09 07:42:00'),
  (116, 1, 5, 'Muy buena atención durante el pedido.', '2026-09-08 02:58:00'),
  (197, 5, 5, NULL, '2026-09-26 12:43:00'),
  (52, 5, 5, NULL, '2026-11-02 09:08:00'),
  (33, 5, 3, NULL, '2026-08-04 04:26:00'),
  (158, 5, 5, 'El sabor estuvo excelente.', '2026-09-29 02:04:00'),
  (124, 2, 4, NULL, '2026-08-10 22:01:00'),
  (63, 4, 4, NULL, '2026-11-07 14:20:00'),
  (129, 3, 4, NULL, '2026-09-23 16:47:00'),
  (75, 4, 1, 'Todo llegó fresco y en buen estado.', '2026-08-25 11:45:00'),
  (72, 4, 3, 'La preparación estuvo muy rica.', '2026-09-12 11:39:00'),
  (132, 5, 2, 'Una opción agradable para compartir.', '2026-10-21 03:55:00'),
  (211, 4, 3, NULL, '2026-08-08 13:57:00'),
  (143, 5, 5, NULL, '2026-08-03 09:14:00'),
  (17, 5, 5, NULL, '2026-10-30 20:37:00'),
  (60, 4, 2, NULL, '2026-10-14 16:24:00'),
  (249, 5, 5, 'Todo llegó fresco y en buen estado.', '2026-09-30 02:48:00'),
  (84, 5, 1, 'Una opción agradable para compartir.', '2026-10-14 12:07:00'),
  (156, 4, 5, NULL, '2026-08-02 07:43:00'),
  (159, 5, 3, NULL, '2026-09-20 01:22:00'),
  (34, 4, 4, NULL, '2026-08-19 11:21:00'),
  (83, 5, 4, 'La comida llegó como la pedí.', '2026-10-01 17:27:00'),
  (195, 5, 4, NULL, '2026-08-10 21:23:00'),
  (12, 2, 5, NULL, '2026-08-10 00:04:00'),
  (146, 2, 2, 'Buena porción y entrega puntual.', '2026-10-02 06:51:00'),
  (189, 5, 4, 'Muy buena atención durante el pedido.', '2026-10-31 09:31:00'),
  (107, 4, 4, NULL, '2026-10-20 08:46:00'),
  (99, 5, 4, 'El sabor estuvo excelente.', '2026-10-01 14:38:00'),
  (154, 4, 5, 'Una opción agradable para compartir.', '2026-09-01 11:37:00'),
  (151, 5, 5, 'El sabor estuvo excelente.', '2026-10-06 10:22:00'),
  (210, 3, 1, 'El sabor estuvo excelente.', '2026-11-01 17:38:00'),
  (20, 3, 5, 'Muy buena atención durante el pedido.', '2026-08-13 06:01:00'),
  (185, 4, 5, NULL, '2026-11-13 06:08:00'),
  (28, 5, 4, 'Una opción agradable para compartir.', '2026-08-27 07:48:00'),
  (196, 3, 5, NULL, '2026-09-06 21:50:00'),
  (76, 5, 5, NULL, '2026-09-04 00:42:00'),
  (222, 5, 4, NULL, '2026-10-08 13:23:00'),
  (125, 5, 5, NULL, '2026-08-02 10:36:00'),
  (120, 5, 4, NULL, '2026-08-11 03:04:00'),
  (215, 4, 4, NULL, '2026-11-17 04:25:00'),
  (225, 4, 5, 'Una opción agradable para compartir.', '2026-09-17 02:53:00'),
  (206, 3, 4, NULL, '2026-09-15 00:32:00'),
  (47, 4, 5, 'Buena porción y entrega puntual.', '2026-08-11 17:00:00'),
  (69, 4, 2, NULL, '2026-11-03 02:24:00'),
  (18, 3, 3, NULL, '2026-09-22 16:39:00'),
  (208, 5, 4, 'Muy buena atención durante el pedido.', '2026-08-26 02:35:00'),
  (160, 4, 5, 'La preparación estuvo muy rica.', '2026-09-23 16:50:00'),
  (138, 3, 3, 'Muy buena atención durante el pedido.', '2026-09-22 03:23:00'),
  (228, 4, 3, NULL, '2026-09-25 12:09:00'),
  (35, 3, 5, NULL, '2026-10-16 23:24:00'),
  (166, 3, 3, 'Muy buena atención durante el pedido.', '2026-09-04 15:23:00'),
  (90, 5, 3, 'La preparación estuvo muy rica.', '2026-09-10 10:43:00'),
  (108, 5, 4, 'Todo llegó fresco y en buen estado.', '2026-10-01 09:47:00'),
  (61, 4, 5, NULL, '2026-11-01 11:18:00'),
  (174, 5, 5, 'Todo llegó fresco y en buen estado.', '2026-10-25 18:32:00'),
  (176, 5, 5, 'Todo llegó fresco y en buen estado.', '2026-08-18 04:42:00'),
  (139, 4, 4, NULL, '2026-08-12 14:11:00'),
  (190, 4, 5, NULL, '2026-08-03 20:43:00'),
  (11, 5, 5, 'Llegó caliente y muy bien empacado.', '2026-09-27 03:30:00'),
  (220, 5, 3, 'Buena porción y entrega puntual.', '2026-08-21 04:11:00'),
  (167, 4, 3, 'Buena porción y entrega puntual.', '2026-10-11 03:17:00'),
  (62, 4, 4, NULL, '2026-09-12 23:52:00'),
  (200, 5, 5, NULL, '2026-10-05 07:15:00'),
  (243, 5, 1, NULL, '2026-10-20 20:27:00'),
  (182, 4, 5, 'La comida llegó como la pedí.', '2026-11-13 04:01:00');
