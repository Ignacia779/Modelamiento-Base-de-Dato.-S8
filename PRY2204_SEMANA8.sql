CREATE TABLE SERVICIO (
  id_servicio NUMBER(3),
  descripcion VARCHAR2(100) NOT NULL,
  costo NUMBER(7),
  CONSTRAINT servicio_pk PRIMARY KEY (id_servicio)
);

CREATE TABLE MANTENCION (
  num_mantencion NUMBER(4),
  cod_sucursal NUMBER(3),
  fecha_ingreso DATE,
  fecha_salida DATE,
  patente_auto CHAR(8),
  id_empleado NUMBER(4),
  estado VARCHAR2(15) CHECK (estado IN ('Reserva','Ingresado','Entregado','Anulado')),
  CONSTRAINT mantencion_pk PRIMARY KEY (num_mantencion, cod_sucursal),
  CONSTRAINT mant_fk_sucursal FOREIGN KEY (cod_sucursal)
    REFERENCES SUCURSAL(cod_sucursal),
  CONSTRAINT mant_fk_empleado FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE DETALLE_SERVICIO (
  num_mantencion NUMBER(4),
  cod_sucursal NUMBER(3),
  id_servicio NUMBER(3),
  cantidad NUMBER(4,2),
  descuento_serv NUMBER(4,2),
  CONSTRAINT detalle_servicio_pk PRIMARY KEY (num_mantencion, cod_sucursal, id_servicio),
  CONSTRAINT det_serv_fk_mantencion FOREIGN KEY (num_mantencion, cod_sucursal)
    REFERENCES MANTENCION(num_mantencion, cod_sucursal),
  CONSTRAINT det_serv_fk_servicio FOREIGN KEY (id_servicio)
    REFERENCES SERVICIO(id_servicio)
);

CREATE TABLE CLIENTE (
  rut NUMBER(8),
  dv CHAR(1) CHECK (dv IN ('0','1','2','3','4','5','6','7','8','9','K')),
  pnombre VARCHAR2(20) NOT NULL,
  snombre VARCHAR2(20),
  apaterno VARCHAR2(20) NOT NULL,
  amaterno VARCHAR2(20),
  telefono VARCHAR2(12),
  email VARCHAR2(40),
  tipo_cli CHAR(1),
  CONSTRAINT cliente_pk PRIMARY KEY (rut),
  CONSTRAINT cliente_un_email UNIQUE (email)
);
CREATE TABLE MARCA (
  id_marca NUMBER(2),
  descripcion VARCHAR2(20),
  CONSTRAINT marca_pk PRIMARY KEY (id_marca)
);

CREATE TABLE MODELO (
  id_modelo NUMBER(5),
  marca_id NUMBER(2),
  descripcion VARCHAR2(20),
  CONSTRAINT modelo_pk PRIMARY KEY (id_modelo, marca_id),
  CONSTRAINT modelo_fk_marca FOREIGN KEY (marca_id)
    REFERENCES MARCA(id_marca)
);
CREATE TABLE TIPO_AUTOMOVIL (
  id_tipo CHAR(3),
  descripcion VARCHAR2(20),
  CONSTRAINT tipo_auto_pk PRIMARY KEY (id_tipo)
);
CREATE TABLE AUTOMOVIL (
  patente CHAR(8),
  annio NUMBER(4),
  cant_puertas NUMBER(1),
  km NUMBER(6),
  color VARCHAR2(30),
  cod_tipo_auto CHAR(3),
  cod_modelo NUMBER(5),
  cod_marca NUMBER(2),
  cl_rut NUMBER(8),
  CONSTRAINT automovil_pk PRIMARY KEY (patente),
  CONSTRAINT automovil_fk_cliente FOREIGN KEY (cl_rut)
    REFERENCES CLIENTE(rut),
  CONSTRAINT automovil_fk_modelo FOREIGN KEY (cod_modelo, cod_marca)
    REFERENCES MODELO(id_modelo, marca_id),
  CONSTRAINT automovil_fk_tipo FOREIGN KEY (cod_tipo_auto)
    REFERENCES TIPO_AUTOMOVIL(id_tipo)
);
CREATE TABLE ESTANDAR (
  cl_rut NUMBER(8),
  puntaje_fidelidad NUMBER(8),
  CONSTRAINT estandar_pk PRIMARY KEY (cl_rut),
  CONSTRAINT estandar_fk_cliente FOREIGN KEY (cl_rut)
    REFERENCES CLIENTE(rut)
);

CREATE TABLE PREMIUM (
  cl_rut NUMBER(8),
  pesos_clientes NUMBER(10),
  monto_credito NUMBER(10),
  CONSTRAINT premium_pk PRIMARY KEY (cl_rut),
  CONSTRAINT premium_fk_cliente FOREIGN KEY (cl_rut)
    REFERENCES CLIENTE(rut)
);
INSERT INTO PAIS (nom_pais) VALUES ('Chile');
INSERT INTO PAIS (nom_pais) VALUES ('Peru');
INSERT INTO PAIS (nom_pais) VALUES ('Colombia');

CREATE SEQUENCE seq_ciudad START WITH 165 INCREMENT BY 5;
INSERT INTO CIUDAD (id_ciudad, nom_ciudad, cod_pais)
VALUES (seq_ciudad.NEXTVAL, 'Santiago', 9);

INSERT INTO CIUDAD (id_ciudad, nom_ciudad, cod_pais)
VALUES (seq_ciudad.NEXTVAL, 'Lima', 12);

INSERT INTO CIUDAD (id_ciudad, nom_ciudad, cod_pais)
VALUES (seq_ciudad.NEXTVAL, 'Bogotá', 15);

INSERT INTO SUCURSAL (id_sucursal, nom_sucursal, calle, num_calle, cod_ciudad)
VALUES ('S01', 'Providencia', 'Av. Libertadores', 234, 165);

INSERT INTO SUCURSAL (id_sucursal, nom_sucursal, calle, num_calle, cod_ciudad)
VALUES ('S02', '4 esquinas', 'Av. Barquita', 669, 170);

INSERT INTO SUCURSAL (id_sucursal, nom_sucursal, calle, num_calle, cod_ciudad)
VALUES ('S03', 'El Cafe', 'Av. El Monte', 900, 175);

CREATE SEQUENCE seq_servicio START WITH 400 INCREMENT BY 2;

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (seq_servicio.NEXTVAL, 'Cambio Luces', 45000);

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (seq_servicio.NEXTVAL, 'Desabolladura', 67000);

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (seq_servicio.NEXTVAL, 'Revisión Frenos', 30000);

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (seq_servicio.NEXTVAL, 'Cambio Puerta Trasera', 50000);

INSERT INTO MECANICO (pnombre, snombre, apaterno, amaterno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES ('Pedro', 'Jose', 'Balmaceda', 'Pascal', NULL, 759000, 23980, NULL);

INSERT INTO MECANICO (pnombre, snombre, apaterno, amaterno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor)
VALUES ('Sandra', 'Alexandra', 'Lecler', 'S.', 0, 659000, 22358, 460);

INSERT INTO MANTENCION (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida, patente_auto, cod_mecanico, estado)
VALUES (101, 'S01', TO_DATE('12-04-2023','DD-MM-YYYY'), NULL, NULL, 481, 'Reserva');

INSERT INTO MANTENCION (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida, patente_auto, cod_mecanico, estado)
VALUES (102, 'S02', TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), NULL, 502, 'Entregado');

INSERT INTO MANTENCION (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida, patente_auto, cod_mecanico, estado)
VALUES (103, 'S02', TO_DATE('09-10-2023','DD-MM-YYYY'), NULL, NULL, 502, 'Anulado');

INSERT INTO MANTENCION (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida, patente_auto, cod_mecanico, estado)
VALUES (104, 'S03', TO_DATE('11-08-2023','DD-MM-YYYY'), TO_DATE('18-08-2023','DD-MM-YYYY'), NULL, 509, 'Entregado');

INSERT INTO MANTENCION (num_mantencion, cod_sucursal, fecha_ingreso, fecha_salida, patente_auto, cod_mecanico, estado)
VALUES (105, 'S03', TO_DATE('03-12-2023','DD-MM-YYYY'), NULL, NULL, 509, 'Ingresado');

COMMIT;

INSERT INTO DETALLE_SERVICIO (mantencion_num, cod_servicio, cantidad, descuento_serv)
VALUES (101, 400, 1, 0);

INSERT INTO DETALLE_SERVICIO (mantencion_num, cod_servicio, cantidad, 0)
VALUES (102, 402, 1, 0);

INSERT INTO DETALLE_SERVICIO (mantencion_num, cod_servicio, cantidad, descuento_serv)
VALUES (103, 404, 2, 0.1);

INSERT INTO DETALLE_SERVICIO (mantencion_num, cod_servicio, cantidad, descuento_serv)
VALUES (104, 406, 1, 0);

INSERT INTO DETALLE_SERVICIO (mantencion_num, cod_servicio, cantidad, descuento_serv)
VALUES (105, 404, 1, 0);

INSERT INTO DETALLE_SERVICIO (mantencion_num, cod_servicio, cantidad, descuento_serv)
VALUES (105, 400, 1, 0.05);

COMMIT;

SELECT 
  cod_mecanico AS "ID MECANICO",
  pnombre || ' ' || apaterno AS "NOMBRE MECANICO",
  sueldo AS "SALARIO",
  monto_impuestos AS "IMPUESTO ACTUAL",
  ROUND(monto_impuestos * 0.8) AS "IMPUESTO REBAJADO",
  sueldo - ROUND(monto_impuestos * 0.8) AS "SUELDO CON REBAJA IMPUESTOS"
FROM MECANICO
WHERE bono_jefatura IS NULL
  AND monto_impuestos < 40000
ORDER BY monto_impuestos DESC, apaterno ASC;

SELECT 
  cod_mecanico AS "IDENTIFICADOR",
  pnombre || ' ' || snombre || ' ' || apaterno AS "MECANICO",
  sueldo AS "SALARIO ACTUAL",
  ROUND(sueldo * 0.05) AS "AJUSTE",
  sueldo + ROUND(sueldo * 0.05) AS "SUELDO_REAJUSTADO"
FROM MECANICO
WHERE (sueldo BETWEEN 600000 AND 900000)
   OR cod_supervisor IS NULL
ORDER BY sueldo ASC, (pnombre || ' ' || snombre || ' ' || apaterno) DESC;

SELECT table_name FROM user_tables;

SELECT constraint_name, table_name, constraint_type 
FROM user_constraints 
WHERE owner = 'PRY2204_S8';

SELECT * FROM PAIS;
SELECT * FROM CIUDAD;
SELECT * FROM SUCURSAL;
SELECT * FROM MECANICO;
SELECT * FROM MANTENCION;
SELECT * FROM DETALLE_SERVICIO;

SELECT table_name FROM user_tables WHERE table_name = 'MANTENCION';

DESC MANTENCION;
INSERT INTO MANTENCION (num_mantencion, cod_sucursal, fecha_ingreso, id_empleado, estado)
VALUES (301, 101, SYSDATE, 1, 'Reserva');

SELECT table_name FROM user_tables WHERE table_name = 'DETALLE_SERVICIO';

INSERT INTO MANTENCION (num_mantencion, cod_sucursal, fecha_ingreso, id_empleado, estado)
VALUES (301, 101, SYSDATE, 1, 'Reserva');

INSERT INTO DETALLE_SERVICIO (num_mantencion, cod_sucursal, id_servicio, cantidad, descuento_serv)
VALUES (301, 101, 1, 2, 0.10);

INSERT INTO SERVICIO (id_servicio, descripcion, costo)
VALUES (1, 'Cambio de aceite', 25000);
INSERT INTO DETALLE_SERVICIO (num_mantencion, cod_sucursal, id_servicio, cantidad, descuento_serv)
VALUES (301, 101, 1, 2, 0.10);

SELECT 
  m.num_mantencion,
  m.cod_sucursal,
  m.fecha_ingreso,
  m.estado,
  s.descripcion AS nombre_servicio,
  s.costo,
  d.cantidad,
  d.descuento_serv,
  (s.costo * d.cantidad) * (1 - d.descuento_serv) AS total_final
FROM MANTENCION m
JOIN DETALLE_SERVICIO d 
  ON m.num_mantencion = d.num_mantencion 
 AND m.cod_sucursal = d.cod_sucursal
JOIN SERVICIO s 
  ON d.id_servicio = s.id_servicio;

SELECT * FROM MANTENCION;
SELECT * FROM DETALLE_SERVICIO;
SELECT * FROM SERVICIO;
