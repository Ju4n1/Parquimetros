#-------------------------------------------------------------------------
# Carga de datos de Prueba

INSERT INTO Conductores VALUES (11111111,111,"Gonzalo","Gonzalez","Belgrano 123","291-1111111");
INSERT INTO Conductores VALUES (22222222,222,"Fernando","Fernandez","Sarmiento 456","291-2222222");
INSERT INTO Conductores VALUES (33333333,333,"Eber","Luduenia","Juan M. Rosas 789","291-3333333");
INSERT INTO Conductores VALUES (44444444,444,"Martin","Martinez","San Matin 114","291-4444444");
INSERT INTO Conductores VALUES (55555555,555,"Rodrigo","Rodriguez","Presidente Peron 12","291-5555555");
INSERT INTO Conductores VALUES (66666666,666,"Alvaro","Alvarez","Alvear 23","2923-666666");
INSERT INTO Conductores VALUES (77777777,777,"Hernan","Hernandez","Primera Junta 1810","011-7777777");
INSERT INTO Conductores VALUES (88888888,888,"Armando","Paredes","Paraguay 88",NULL);
INSERT INTO Conductores VALUES (99999999,999,"Esteban","Quito","Mitre 300",NULL);
INSERT INTO Conductores VALUES (10101010,010,"Elsa","Pato","Moreno 69","474333");

INSERT INTO Automoviles VALUES ("AAA111","Ford","Falcon","Verde",88888888);
INSERT INTO Automoviles VALUES("BBB222","Fiat","600","Rojo",99999999);
INSERT INTO Automoviles VALUES("CCC333","Chevrolet","Chevy","Celeste",22222222);
INSERT INTO Automoviles VALUES("DDD444","Peugeot","404","Blanco",44444444);
INSERT INTO Automoviles VALUES("EEE555","Renault","12","Celeste",11111111);
INSERT INTO Automoviles VALUES("FFF666","Citroen","3cv","Amarillo",66666666);
INSERT INTO Automoviles VALUES("GGG777","Dodge","1500","Gris",10101010);
INSERT INTO Automoviles VALUES("HHH888","Siam Di Tella","1500","Verde agua",55555555);
INSERT INTO Automoviles VALUES("III999","Rambler","Ambassador","Plateado",33333333);
INSERT INTO Automoviles VALUES("JJJ010","Renault","Torino","Vino tinto",77777777);

INSERT INTO Tipos_Tarjeta VALUES ("jubilado",0.10);
INSERT INTO Tipos_Tarjeta VALUES ("estudiante",0.05);
INSERT INTO Tipos_Tarjeta VALUES ("discapacitado",0.15);
INSERT INTO Tipos_Tarjeta VALUES("sin descuento",0.00);

INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (700.50,"estudiante","AAA111");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (100.60,"sin descuento","AAA111");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (000.30,"sin descuento","BBB222");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (100.50,"sin descuento","BBB222");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (500.18,"jubilado","CCC333");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (43.10,"sin descuento","DDD444");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (740.90,"sin descuento","EEE555");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (210.35,"discapacitado","FFF666");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (301.10,"jubilado","GGG777");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (517.50,"estudiante","HHH888");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (609.60,"jubilado","III999");
INSERT INTO Tarjetas (saldo, tipo, patente) VALUES (870.90,"sin descuento","JJJ010");

INSERT INTO Inspectores VALUES (0001,12345678,"Nestor","Pitana",MD5("penal"));
INSERT INTO Inspectores VALUES (0002,87654321,"Saul","Laberni",MD5("tirolibre"));
INSERT INTO Inspectores VALUES (0003,78456123,"Diego","Ceballos",MD5("offside"));
INSERT INTO Inspectores VALUES (0004,32165487,"German","Delfino",MD5("pique"));

INSERT INTO Ubicaciones VALUES("San Martin",1300,43.43);
INSERT INTO Ubicaciones VALUES("San Martin",1350,59.90);
INSERT INTO Ubicaciones VALUES("Belgrano",100,70.91);
INSERT INTO Ubicaciones VALUES("Belgrano",764,40.50);
INSERT INTO Ubicaciones VALUES("Juan M. Rosas",14,37.25);
INSERT INTO Ubicaciones VALUES("Moreno",666,81.40);
INSERT INTO Ubicaciones VALUES("Moreno",2000,90.05);
INSERT INTO Ubicaciones VALUES("Presidente Peron",120,33.12);
INSERT INTO Ubicaciones VALUES("Alvear",320,47.80);
INSERT INTO Ubicaciones VALUES("Mitre",444,55.00);
INSERT INTO Ubicaciones VALUES("Primera Junta",1000,60.50);
INSERT INTO Ubicaciones VALUES("Sarmiento",69,30.25);
INSERT INTO Ubicaciones VALUES("Paraguay",1235,75.25);
INSERT INTO Ubicaciones VALUES("Paraguay",3000,90.12);
INSERT INTO Ubicaciones VALUES("Almirante Brown",2540,49.67);

INSERT INTO Parquimetros VALUES (1234, 1, 100, "Belgrano");
INSERT INTO Parquimetros VALUES (5678, 2, 3000, "Paraguay");
INSERT INTO Parquimetros VALUES (9012, 3, 1235, "Paraguay");
INSERT INTO Parquimetros VALUES (3456, 4, 666, "Moreno");
INSERT INTO Parquimetros VALUES (7890, 5, 2000, "Moreno");
INSERT INTO Parquimetros VALUES (1235, 6, 1300, "San Martin");
INSERT INTO Parquimetros VALUES (4976, 7, 1350, "San Martin");
INSERT INTO Parquimetros VALUES (4444, 8, 444, "Mitre");
INSERT INTO Parquimetros VALUES (1275, 9, 320, "Alvear");
INSERT INTO Parquimetros VALUES (7778, 10, 69, "Sarmiento");

INSERT INTO Estacionamientos VALUES (1,1234,'2020:11:24','19:30:00',NULL,NULL);
INSERT INTO Estacionamientos VALUES (6,5678,'2020:03:20','13:32:45','2020:03:20','18:40:00');
INSERT INTO Estacionamientos VALUES (3,9012,'2020:04:27','09:30:00',NULL,NULL);
INSERT INTO Estacionamientos VALUES (2,3456,'2020:05:02','07:32:32',NULL,NULL);
INSERT INTO Estacionamientos VALUES (10,7890,'2020:05:05','18:40:00','2020:05:05','20:30:00');
INSERT INTO Estacionamientos VALUES (7,7890,'2020:05:05','18:42:45','2020:05:05','22:15:03');
INSERT INTO Estacionamientos VALUES (9,1275,'2020:06:20','09:30:00',NULL,NULL);
INSERT INTO Estacionamientos VALUES (8,4444,'2020:07:06','18:40:00',NULL,NULL);
INSERT INTO Estacionamientos VALUES (5,4444,'2020:07:19','18:40:00','2020:07:20','09:22:01');
INSERT INTO Estacionamientos VALUES (4,1275,'2020:11:10','10:15:05',NULL,NULL);

INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0001, "Sarmiento",69, 'Lu', 'T');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0002, "Belgrano",100, 'Ma', 'M');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0002, "Moreno",2000, 'Mi', 'M');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0003, "San Martin",1350, 'Ju', 'M');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0003, "Paraguay",1235, 'Vi', 'M');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0004, "Paraguay",3000, 'Lu', 'T');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0004, "Alvear",320, 'Ma', 'T');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0001, "Moreno",666, 'Mi', 'T');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0002, "San Martin",1300, 'Ju', 'T');
INSERT INTO Asociado_con (legajo, calle, altura, dia, turno) VALUES (0004, "Mitre",444, 'Vi', 'T');

INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:03:12','13:32:45',"AAA111",1);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:04:10','16:30:50',"BBB222",2);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:04:12','16:32:03',"CCC333",3);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:05:05','09:40:55',"DDD444",4);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:05:20','13:19:02',"AAA111",5);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:07:24','12:12:30',"AAA111",6);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:07:24','18:00:00',"EEE555",7);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:08:03','08:10:45',"FFF666",8);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:08:07','09:32:03',"AAA111",9);
INSERT INTO Multa (fecha, hora, patente, id_asociado_con) VALUES ('2020:09:02','13:32:12',"GGG777",10);

INSERT INTO Accede VALUES (0001, 1234, '2020:01:13', '15:00:00');
INSERT INTO Accede VALUES (0002, 5678, '2020:01:13', '14:23:23');
INSERT INTO Accede VALUES (0003, 9012, '2020:01:13', '15:44:20');
INSERT INTO Accede VALUES (0004, 3456, '2020:01:13', '16:11:57');
INSERT INTO Accede VALUES (0001, 7890, '2020:01:13', '15:35:32');
INSERT INTO Accede VALUES (0002, 1235, '2020:01:13', '17:22:32');
INSERT INTO Accede VALUES (0001, 4976, '2020:01:13', '16:52:44');
INSERT INTO Accede VALUES (0001, 1234, '2020:01:13', '20:00:25');
INSERT INTO Accede VALUES (0002, 3456, '2020:01:13', '09:41:28');
INSERT INTO Accede VALUES (0004, 9012, '2020:01:13', '10:23:37');
