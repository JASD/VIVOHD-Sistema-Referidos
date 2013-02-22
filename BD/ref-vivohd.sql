/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     22/02/2013 11:20:12 a.m.                     */
/*==============================================================*/


drop table if exists CLIENTE;

drop table if exists CONTRATO;

drop table if exists PERFIL;

drop table if exists RECOMENDADO;

drop table if exists TELEFONO;

drop table if exists USUARIO;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE
(
   DUI_CLIENTE          char(10) not null,
   DUI_REFERIDOR_CLIENTE char(10),
   PRIMER_NOMBRE_CLIENTE varchar(64) not null,
   SEGUNDO_NOMBRE_CLIENTE varchar(64),
   TERCER_NOMBRE_CLIENTE varchar(64),
   PRIMER_APELLIDO_CLIENTE varchar(64) not null,
   SEGUNDO_APELLIDO_CLIENTE varchar(64),
   DIRECCION_CLIENTE    varchar(255) not null,
   EMAIL_CLIENTE        varchar(64),
   FORMA_PAGO_CLIENTE   varchar(32) not null,
   NUMERO_CUENTA_CLIENTE varchar(32),
   ESTADO_CLIENTE       bool not null,
   NUMERO_CONTRATO_CLIENTE smallint not null,
   NUMERO_CONTRATO_REFERIDOR_CLIENTE smallint,
   NUMERO_REFERIDOS_CLIENTE smallint not null,
   primary key (DUI_CLIENTE)
);

/*==============================================================*/
/* Table: CONTRATO                                              */
/*==============================================================*/
create table CONTRATO
(
   CORRELATIVO_CONTRATO bigint not null,
   DUI_CLIENTE          char(10) not null,
   FECHA_CONTRATO       datetime not null,
   primary key (CORRELATIVO_CONTRATO, DUI_CLIENTE)
)
auto_increment = 1;

/*==============================================================*/
/* Table: PERFIL                                                */
/*==============================================================*/
create table PERFIL
(
   ID_PERFIL            smallint not null,
   NOMBRE_PERFIL        varchar(16),
   DESCRIPCION_PERFIL   varchar(128),
   primary key (ID_PERFIL)
)
auto_increment = 1;

/*==============================================================*/
/* Table: RECOMENDADO                                           */
/*==============================================================*/
create table RECOMENDADO
(
   ID_RECOMENDADO       bigint not null,
   DUI_CLIENTE          char(10) not null,
   PRIMER_NOMBRE_RECOMENDADO varchar(64) not null,
   SEGUNDO_NOMBRE_RECOMENDADO varchar(64),
   TERCER_NOMBRE_RECOMENDADO varchar(64),
   PRIMER_APELLIDO_RECOMENDADO varchar(64) not null,
   SEGUNDO_APELLIDO_RECOMENDADO varchar(64),
   TELEFONO_RECOMENDADO char(9),
   primary key (ID_RECOMENDADO, DUI_CLIENTE)
)
auto_increment = 1;

/*==============================================================*/
/* Table: TELEFONO                                              */
/*==============================================================*/
create table TELEFONO
(
   NUMERO_TELEFONO      char(8) not null,
   DUI_CLIENTE          char(10) not null,
   TIPO_TELEFONO        varchar(32),
   primary key (NUMERO_TELEFONO)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO
(
   ID_USUARIO           varchar(8) not null,
   DUI_CLIENTE          char(10),
   ID_PERFIL            smallint not null,
   PASSWORD_USUARIO     varchar(64) not null,
   ESTADO_USUARIO       bool,
   primary key (ID_USUARIO)
);

alter table CLIENTE add constraint FK_CLIENTE_TIENE_REFERIDO foreign key (DUI_REFERIDOR_CLIENTE)
      references CLIENTE (DUI_CLIENTE) on delete restrict on update restrict;

alter table CONTRATO add constraint FK_CLIENTE_TIENE_CONTRATO foreign key (DUI_CLIENTE)
      references CLIENTE (DUI_CLIENTE) on delete restrict on update restrict;

alter table RECOMENDADO add constraint FK_CLIENTE_TIENE_RECOMENDADO foreign key (DUI_CLIENTE)
      references CLIENTE (DUI_CLIENTE) on delete restrict on update restrict;

alter table TELEFONO add constraint FK_CLIENTE_TIENE_TELEFONO foreign key (DUI_CLIENTE)
      references CLIENTE (DUI_CLIENTE) on delete restrict on update restrict;

alter table USUARIO add constraint FK_CLIENTE_TIENE_USUARIO foreign key (DUI_CLIENTE)
      references CLIENTE (DUI_CLIENTE) on delete restrict on update restrict;

alter table USUARIO add constraint FK_USUARIO_TIENE_PERFIL foreign key (ID_PERFIL)
      references PERFIL (ID_PERFIL) on delete restrict on update restrict;

