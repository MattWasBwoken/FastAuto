/* drop table */
drop table if exists Sede cascade;
drop table if exists Produttore cascade;
drop table if exists Richiesta cascade;
drop table if exists Dipendente cascade;
drop table if exists Veicolo cascade;
drop table if exists Cliente cascade;
drop table if exists Pagamento cascade;
drop table if exists Garanzia cascade;


/* CREAZIONE TABELLE */

CREATE TABLE Sede(
  citta varchar(50) not null,
  indirizzo varchar(100) not null,
  fatturato decimal(10,2) not null,
  PRIMARY KEY (citta)
);

CREATE TABLE Produttore(
  nome varchar(50) not null,
  tempo_consegna int not null,
  tipo_veicolo varchar(50) not null,
  citta_sede varchar(50),
  PRIMARY KEY (nome)
);

CREATE TABLE Richiesta(
  citta_sede varchar(50),
  nome_prod varchar(50),
  PRIMARY KEY(citta_sede, nome_prod),
  FOREIGN KEY (citta_sede) REFERENCES Sede(citta) on update cascade on delete cascade,
  FOREIGN KEY (nome_prod) REFERENCES Produttore(nome) on update cascade on delete cascade
);

CREATE TABLE Dipendente(
  codice int,
  nome varchar(50) not null,
  cognome varchar(50) not null,
  ruolo varchar(50) not null,
  salario decimal(10,2) not null,
  citta_sede varchar(50),
  PRIMARY KEY (codice),
  FOREIGN KEY (citta_sede) REFERENCES Sede(citta) on update cascade on delete cascade
);

CREATE TABLE Veicolo(
  sn int,
  costo decimal(10,2) not null,
  colore varchar(50) not null,
  cilindrata int,
  marca varchar(50) not null,
  modello varchar(50) not null,
  liv_patente varchar(2),
  stato varchar(100),
  km int,
  targa varchar(7),
  motore varchar(50) not null,
  PRIMARY KEY (sn)
);

CREATE TABLE Cliente(
  cf varchar(16),
  nome varchar(50) not null,
  cognome varchar(50) not null,
  telefono varchar(20) not null,
  email varchar(50) not null,
  PRIMARY KEY (cf)
);

CREATE TABLE Pagamento(
  cod int,
  importo decimal(10,2) not null,
  rate int,
  data_emissione date not null,
  IBAN varchar(27) not null,
  citta_sede varchar(50),
  cf_cliente varchar(16),
  sn_veicolo int,
  FOREIGN KEY (citta_sede) REFERENCES Sede(citta) on update cascade on delete cascade,
  FOREIGN KEY (cf_cliente) REFERENCES Cliente(cf) on update cascade on delete cascade,
  FOREIGN KEY (sn_veicolo) REFERENCES Veicolo(sn) on update cascade on delete cascade,
  PRIMARY KEY (cod)
);

CREATE TABLE Garanzia(
  sn_veicolo int,
  tipo varchar(50) not null,
  durata int not null,
  costo_est decimal(10,2),
  FOREIGN KEY (sn_veicolo) REFERENCES Veicolo(sn) on update cascade on delete cascade,
  PRIMARY KEY (sn_veicolo)
);

/* Inserimento dati */

insert into Sede(citta, indirizzo, fatturato) values
  ('Padova', 'Via Roma 12', 36956.55),
  ('Milano', 'Via Verd 89', 41547.00),
  ('Mestre', 'Via Mori 66', 9054.36),
  ('Roma', 'Via Canova 106', 29874.36),
  ('Verona', 'via Rosso 59', 18594.48),
  ('Napoli', 'Viale Monte 7', 16354.25),
  ('Berlino', 'Via Umberto I 33', 40674.00),
  ('Parigi', 'Viale Cervo 55', 39576.22),
  ('Siena', 'Via Aquila 508', 8413.00),
  ('Brescia', 'Via Levi 5', 11594.55),
  ('Parma', 'Via Alghero 27', 15754.44),
  ('Ravenna', 'Via Roma 65', 9454.45),
  ('Foggia', 'Via Ila 45', 17547.44),
  ('Palermo', 'Via Chiesa 68', 24574.87),
  ('Perugia', 'Via Salmi 43', 12657.47),
  ('Trento', 'Via Garibaldi 671', 34574.78);

insert into Produttore(nome, tempo_consegna, tipo_veicolo) values
  ('Audi', 50, 'Automobili'),
  ('BMW', 60, 'Entrambi'),
  ('Mercedes-Benz', 60, 'Automobili'),
  ('Volkswagen', 50, 'Automobili'),
  ('Fiat', 20, 'Automobili'),
  ('Peugeot', 40, 'Entrambi'),
  ('Nissan', 50, 'Automobili'),
  ('Renault', 40, 'Automobili'),
  ('Alfa Romeo', 30, 'Automobili'),
  ('Citroen', 40, 'Automobili'),
  ('Hyundai', 60, 'Automobili'),
  ('Kia', 80, 'Automobili'),
  ('Opel', 30, 'Automobili'),
  ('Toyota', 80, 'Automobili'),
  ('Yamaha', 70, 'Motocicli'),
  ('Ducati', 20, 'Motocicli'),
  ('Honda', 50, 'Entrambi');

insert into Richiesta(citta_sede, nome_prod) values
  ('Padova', 'Audi'),
  ('Padova', 'Nissan'),
  ('Milano', 'Opel'),
  ('Milano', 'Audi'),
  ('Mestre', 'Fiat'),
  ('Roma', 'Renault'),
  ('Roma', 'Volkswagen'),
  ('Verona', 'Alfa Romeo'),
  ('Napoli', 'Nissan'),
  ('Napoli', 'Kia'),
  ('Berlino', 'Peugeot'),
  ('Berlino', 'Renault'),
  ('Siena', 'Volkswagen'),
  ('Brescia', 'Hyundai'),
  ('Parma', 'BMW'),
  ('Ravenna', 'Alfa Romeo'),
  ('Foggia', 'Ducati'),
  ('Palermo', 'Citroen'),
  ('Palermo', 'Alfa Romeo'),
  ('Perugia', 'Honda'),
  ('Trento', 'Toyota'),
  ('Trento', 'Honda');

insert into Dipendente(codice, nome, cognome, ruolo, salario, citta_sede) values
  (443, 'Alessio', 'Fontana', 'Meccanico', 1800, 'Padova'),
  (114, 'Giovanni', 'Moretti', 'Consulente Vendite', 1700, 'Padova'),
  (099, 'Roberto', 'Barbieri', 'Consulente Vendite', 1600, 'Milano'),
  (087, 'Carlo', 'Marini', 'Meccanico', 1400, 'Milano'),
  (005, 'Paolo', 'Russo', 'Meccanico', 1300, 'Roma'),
  (117, 'Paola', 'Gentile', 'Apprendista', 600, 'Roma'),
  (015, 'Gennaro', 'Messina', 'Meccanico', 1200, 'Verona'),
  (066, 'Augusto', 'Gatti', 'Consulente Vendite', 1900, 'Mestre'),
  (022, 'Teodoro', 'Silvestri', 'Consulente Vendite', 1650, 'Verona'),
  (098, 'Augusta', 'Acuto', 'Manager', 3000, 'Padova'),
  (088, 'Alberto', 'Milari', 'Consulente Vendite', 1540, 'Verona'),
  (007, 'Mario', 'Greco', 'Esperto Centralinista', 2000, 'Padova'),
  (302, 'Luigi', 'Ricci', 'Esperto Centralinista', 1900, 'Napoli'),
  (096, 'Silvano', 'Sala', 'Meccanico', 1450, 'Napoli'),
  (058, 'Ivano', 'Bassi', 'Consulente Vendite', 1860, 'Berlino'),
  (298, 'Ugo', 'Valente', 'Manager', 2900, 'Milano'),
  (062, 'Enzo', 'Alti', 'Apprendista', 600, 'Berlino'),
  (189, 'Ettore', 'Motta', 'Manager', 2700, 'Mestre'),
  (076, 'Alvise', 'Olivia', 'Esperto Elettrico', 2800, 'Milano'),
  (214, 'Andrea', 'Massa', 'Manager', 3200, 'Roma'),
  (057, 'Lorenzo', 'Lazzari', 'Manager', 4000, 'Verona'),
  (008, 'Francesco', 'Merlo', 'Manager', 3600, 'Napoli'),
  (119, 'Alessandro', 'Sorrentino', 'Esperto Elettrico', 2400, 'Berlino'),
  (025, 'Matteo', 'Napoli', 'Consulente Vendite', 1950, 'Roma'),
  (092, 'Matteo', 'Moroni', 'Consulente Vendite', 2500, 'Parigi'),
  (041, 'Michele', 'Chiesa', 'Meccanico', 1700, 'Parigi'),
  (183, 'Mattia', 'Cipriani', 'Consulente Vendite', 2960, 'Parma'),
  (033, 'Renata', 'Bini', 'Consulente Vendite', 2000, 'Siena'),
  (001, 'Daniele', 'Trota', 'Manager', 4000, 'Siena'),
  (170, 'Giovanna', 'Barbaro', 'Impiegata', 2200, 'Brescia'),
  (248, 'Leonardo', 'Ferrari', 'Meccanico', 2200, 'Parma'),
  (304, 'Francesco', 'Binachi', 'Consulente Vendite', 2540, 'Ravenna'),
  (54, 'Alessandro', 'Marino', 'Meccanico', 1800, 'Ravenna'),
  (654, 'Lorenzo', 'Rizzo', 'Consulente Vendite', 2000, 'Foggia'),
  (387, 'Mattia', 'Moreti', 'Manager', 3100, 'Berlino'),
  (64, 'Tommaso', 'Fontana', 'Manager', 2600, 'Parigi'),
  (49, 'Gabriele', 'Santoro', 'Consulente Vendite', 2050, 'Brescia'),
  (347, 'Andrea', 'Giordano', 'Consulente Vendite', 2300, 'Foggia'),
  (641, 'Riccardo', 'Costa', 'Meccanico', 1760, 'Foggia'),
  (314, 'Edoardo', 'Mancini', 'Consulente Vendite', 2100, 'Palermo'),
  (155, 'Sofia', 'De Luca', 'Meccanico', 2800, 'Padova'),
  (395, 'Giulia', 'Esposito', 'Meccanico', 1600, 'Palermo'),
  (254, 'Aurora', 'Gallo', 'Meccanico', 2740, 'Perugia'),
  (268, 'Alice', 'Serra', 'Meccanico', 1630, 'Perugia'),
  (237, 'Beatrice', 'Sala', 'Meccanico', 1720, 'Trento'),
  (348, 'Emma', 'Ferri', 'Manager', 3500, 'Parma'),
  (168, 'Matilde', 'Longo', 'Consulente Vendite', 2400, 'Trento');

insert into Veicolo(sn, costo, colore, cilindrata, marca, modello, liv_patente, stato, km, targa, motore) values
  (784604, 55000.00, 'nero perlato', 4000, 'BMW', 'M3', null, null, null, null, 'benzina'),
  (306918, 14000.00, 'bianco', 1100, 'Fiat', 'Panda', null, null, null, null, 'diesel'),
  (632681, 40000.00, 'grigio opaco', 2000, 'Audi', 'A4', null, null, null, null, 'benzina'),
  (241608, 29000.00, 'acciaio', 1300, 'Mercedes-Benz', 'Classe A', null, null, null, null, 'benzina'),
  (315686, 22000.00, 'bianco', 1000, 'Volkswagen', 'Polo', null, null, null, null, 'diesel'),
  (200616, 27000.00, 'nero', 1400, 'Volkswagen', 'Golf', null, null, null, null, 'benzina'),
  (259862, 38000.00, 'verde scuro', 1500, 'Peugeot', '308', null, null, null, null, 'ibrida'),
  (492578, 17000.00, 'giallo', 1200, 'Peugeot', '208', null, null, null, null, 'diesel'),
  (164815, 28000.00, 'rosso', 1600, 'Nissan', 'Juke', null, null, null, null, 'ibrida'),
  (323428, 27000.00, 'blu scuro', 1300, 'Renault', 'Captur', null, null, null, null, 'ibrida'),
  (550888, 49000.00, 'platino', 2100, 'Alfa Romeo', 'Giulia', null, null, null, null, 'benzina'),
  (462345, 55000.00, 'nero', 2100, 'Alfa Romeo', 'Stelvio', null, null, null, null, 'benzina'),
  (468486, 18000.00, 'grigio scuro', 1300, 'Citroen', 'C3', null, null, null, null, 'benzina'),
  (605329, 17000.00, 'azzurro', 1200, 'Hyundai', 'i20', null, null, null, null, 'diesel'),
  (247553, 24000.00, 'lime', 1600, 'Hyundai', 'Kona', null, null, null, null, 'ibrida'),
  (528279, 34000.00, 'rosso', 1600, 'Kia', 'Sportage', null, null, null, null, 'ibrida'),
  (892807, 17000.00, 'grigio', 1200, 'Opel', 'Corsa', null, null, null, null, 'benzina'),
  (456710, 26000.00, 'nero', 1500, 'Toyota', 'Yaris', null, null, null, null, 'benzina'),
  (988491, 14000.00, 'nero', 600, 'Yamaha', 'R6', 'A3', null, null, null, 'benzina'),
  (263043, 8000.00, 'bianco e nero', 700, 'Yamaha', 'MT07', 'A2', null, null, null, 'benzina'),
  (466952, 23000.00, 'nero', 1000, 'Ducati', 'Panigale', 'A3', null, null, null, 'benzina'),
  (762003, 16000.00, 'rosso', 900, 'Ducati', 'Desertx', 'A2', null, null, null, 'benzina'),
  (495980, 35000.00, 'grigio', 2000, 'Honda', 'Civic', null, null, null, null, 'benzina'),
  (986145, 6000.00, 'grigio', 300, 'Honda', 'Forza 350', 'A2', null, null, null, 'benzina'),
  (896165, 85000.00, 'grigio', null, 'Audi', 'E-tron', null, null, null, null, 'elettrica'),
  (224240, 63000.00, 'bianco', null, 'BMW', 'i4', null, null, null, null, 'elettrica'),
  (870856, 37000.00, 'arancione', null, 'Citroen', 'E-C4', null, null, null, null, 'elettrica'),
  (174815, 32000.00, 'grigio', null, 'Honda', 'E', null, null, null, null, 'elettrica'),
  (340017, 47000.00, 'grigio chiaro', null, 'Hyundai', 'Ioniq 5', null, null, null, null, 'elettrica'),
  (259998, 50000.00, 'bianco', null, 'Kia', 'EV6', null, null, null, null, 'elettrica'),
  (939498, 55000.00, 'blu scuro', null, 'Mercedes-Benz', 'EQA', null, null, null, null, 'elettrica'),
  (954560, 35000.00, 'blu chiaro', null, 'Peugeot', 'E-208', null, null, null, null, 'elettrica'),
  (287126, 37000.00, 'bianco', null, 'Renault', 'Megane E-tech', null, null, null, null, 'elettrica'),
  (988664, 53000.00, 'bianco', null, 'Volkswagen', 'ID.4', null, null, null, null, 'elettrica'),
  (336236, 25000.00, 'grigio scuro', 2000, 'BMW', 'Serie 3', null, 'graffi sulla carrozzeria', 125000, 'BT518PA', 'diesel'),
  (623901, 8000.00, 'rosso', 1100, 'Fiat', 'Panda', null, null, 151000, 'EY346DG', 'benzina'),
  (917733, 18000.00, 'grigio scuro', 1400, 'Audi', 'A3', null, 'assenti sensori pressione gomme', 62000, 'CN724KS', 'benzina'),
  (725470, 19000.00, 'grigio', 1300, 'Mercedes-Benz', 'Classe A', null, 'scarico perde', 75000, 'DA327GZ', 'benzina'),
  (337059, 14000.00, 'nero', 1100, 'Volkswagen', 'Polo', null, null, 82000, 'CM631WY', 'diesel'),
  (908131, 22000.00, 'grigio', 1500, 'Volkswagen', 'Golf', null, 'telecamera posteriore non funzionante', 77000, 'CH923UF', 'benzina'),
  (787222, 23000.00, 'rosso', 1500, 'Peugeot', '3008', null, null, 94000, 'EW120RS', 'benzina'),
  (802458, 13000.00, 'bianco', 1100, 'Peugeot', '208', null, 'batteria da cambiare', 108000, 'DI516TX', 'diesel'),
  (190123, 18000.00, 'grigio scuro', 1300, 'Nissan', 'Qashqai', null, 'sospensioni non ottimali', 91000, 'DR612NE', 'benzina'),
  (477562, 13000.00, 'giallo', 1000, 'Renault', 'Clio', null, 'specchietto elettrico non regolabile', 54000, 'CT912YT', 'diesel'),
  (145026, 12000.00, 'rosso', 1400, 'Alfa Romeo', 'Mito', null, 'sedili posteriori rovinati', 89000, 'DS122TV' , 'benzina'),
  (323855, 24000.00, 'bianco', 1600, 'Hyundai', 'Tucson', null, null, 78000, 'EL282BH', 'benzina'),
  (171663, 21000.00, 'grigio', 1200, 'Citroen', 'C4', null, 'ricarica batteria lenta', 47000, 'CB813CI', 'ibrida');

insert into Cliente(cf, nome, cognome, telefono, email) values
  ('RSSMRA62T48R447T', 'Mario', 'Rossi', '3241110000', 'mario.rossi.62@gmail.com'),
  ('VRDLGU78G12T112F', 'Luigi', 'Verdi', '3441121354', 'luigi.verdi@libero.it'),
  ('FRIMTT92N65R432W', 'Matteo', 'Fiori', '3142354362', 'matteofioriposta@virgilio.it'),
  ('CNTNCL54R83G945P', 'Nicola', 'Conte', '3941110000', 'nicolacontemail@inwind.it'),
  ('DTRNCL66I02N295L', 'Niccolò', 'Auditore', '3325467531', 'niccaud@gmail.com'),
  ('MRONCL60O55M264B', 'Nicole', 'Moro', '3234566424', 'moronicole@gmail.com'),
  ('RBRSRA88V84K654N', 'Sara', 'Ruberti', '3987543414', 'sara.ruberti.sushi@gmail.com'),
  ('MRGLCA82S36L366M', 'Alice', 'Margherita', '3346575641', 'alimarghe@outlook.com'),
  ('NNTLVS99P85R845C', 'Alvise', 'Ninte', '3697523474', 'alviseninte99@libero.it'),
  ('FRRNDR92R93T356M', 'Andrea', 'Ferrari', '3096523123', 'ferrandrea@gmail.com'),
  ('MNTFRN42T27Q645D', 'Francesca', 'Monti', '3546565413', 'francesca.monti.famiglia@yahoo.com'),
  ('DRGMTT39S22E743G', 'Matteo', 'Draghi', '3978654631', 'draghimatteo@gmail.com'),
  ('MGALSE95G56D264F', 'Elisa', 'Magò', '3787064352', 'elisamago.mago@gmail.com'),
  ('BLUNTN77K84C555K', 'Antonio', 'Blu', '3213257879', 'anton10@outlook.com'),
  ('BRCNGL67R92V512H', 'Angelo', 'Berici', '3120000232', 'angeloberic.11@gmail.com'),
  ('GNENCL82P15D835Y', 'Nicoletta', 'Eugenei', '3543020843', 'nicoeuganei.nicoletta@virgilio.it'),
  ('CHLDVD84L24F926R', 'Davide', 'Chili', '3657895746', 'davide.chili2@yahoo.com'),
  ('LMBLSS84Q33G265Y', 'Alessandro', 'Lamborghini', '3325365436', 'alessandro10lamborghini@gmail.com'),
  ('DCTDRA95W95J461T', 'Dario', 'Ducati', '3547685773', 'dd.darioducati@gmail.com'),
  ('CKOSFO85T75M751U', 'Sofia', 'Cook', '3978675645', 'sof.cook@outlook.com'),
  ('MSKLSE63V45P815L', 'Elsa', 'Musk', '3123414767', 'elsa.musk.elon@gmail.com'),
  ('LTMMCH93G73Y715G', 'Michele', 'Ultimo', '3987657453', 'michelel0.ultimo@libero.it'),
  ('CNDSBR50N29T571M', 'Sabrina', 'Canada', '3234565433', 'sabrina.canada50@libero.it'),
  ('ZNZSTF62M37R102Q', 'Stefano', 'Zenzi', '3786842342', 'stef.zenzi@yahoo.com'),
  ('LIUCNZ94G04Q480T', 'Cinzia', 'Iulie', '3325463667', 'cinzia94iulie@gmail.com');

insert into Pagamento(cod, importo, rate, data_emissione, IBAN, citta_sede, cf_cliente, sn_veicolo) values
  (001, 16240.00, null, '2022-02-14', 'IT11X0300203280574512966989', 'Mestre', 'MRGLCA82S36L366M', 306918),
  (002, 68450.00, 24, '2022-02-18', 'IT49X0300203280115955978195', 'Parma', 'FRRNDR92R93T356M', 784604),
  (003, 24080.00, null, '2022-03-04', 'IT82N0300203280412876925945', 'Siena', 'CHLDVD84L24F926R', 315686),
  (004, 31870.00, null, '2022-03-21', 'IT05F0300203280998614535217', 'Parigi', 'BRCNGL67R92V512H', 241608),
  (005, 38000.00, null, '2022-04-02', 'IT74O0300203280158854193244', 'Berlino', 'NNTLVS99P85R845C', 259862),
  (006, 31400.00, 12, '2022-04-09', 'IT84B0300203280152835191584', 'Padova', 'MNTFRN42T27Q645D', 164815),
  (007, 29950.00, 36, '2022-04-17', 'IT08A0300203280953524176662', 'Roma', 'DCTDRA95W95J461T', 323428),
  (008, 58230.00, null, '2022-04-22', 'IT84Z0300203280826731357989', 'Verona', 'GNENCL82P15D835Y', 462345),
  (009, 26200.00, 12, '2022-05-07', 'IT13W0300203280178146245267', 'Brescia', 'BLUNTN77K84C555K', 247553),
  (010, 18810.00, null, '2022-05-11', 'IT62N0300203280187289226766', 'Milano', 'LMBLSS84Q33G265Y', 892807),
  (011, 14000.00, null, '2022-05-19', 'IT91C0300203280452686165177', 'Parigi', 'DTRNCL66I02N295L', 988491),
  (012, 25280.00, 24, '2022-05-26', 'IT17R0300203280284787526952', 'Foggia', 'CNDSBR50N29T571M', 466952),
  (013, 37240.00, null, '2022-06-10', 'IT13G0300203280358976842787', 'Trento', 'CKOSFO85T75M751U', 495980),
  (014, 32000.00, null, '2022-06-17', 'IT45F0300203280695381663222', 'Perugia', 'DRGMTT39S22E743G', 174815),
  (015, 40260.00, 24, '2022-06-22', 'IT60E0300203280716482518983', 'Berlino', 'RBRSRA88V84K654N', 287126),
  (016, 92860.00, 36, '2022-06-30', 'IT28H0300203280253258835572', 'Milano', 'RSSMRA62T48R447T', 896165),
  (017, 18000.00, null, '2022-07-09', 'IT24M0300203280475859431795', 'Padova', 'LIUCNZ94G04Q480T', 917733),
  (018, 22000.00, null, '2022-07-15', 'IT65J0300203280676815959859', 'Roma', 'FRIMTT92N65R432W', 908131),
  (019, 18000.00, 12, '2022-07-24', 'IT26X0300203280381396454844', 'Napoli', 'LTMMCH93G73Y715G', 190123),
  (020, 12000.00, null, '2022-08-02', 'IT19I0300203280114527374556', 'Ravenna', 'MGALSE95G56D264F', 145026),
  (021, 35000.00, null, '2022-05-03', 'IT64P0300203280795755948474', 'Napoli', 'MRONCL60O55M264B', 528279),
  (022, 26000.00, null, '2022-02-11', 'IT07E0300203280696686742574', 'Trento', 'MSKLSE63V45P815L', 456710),
  (023, 50000.00, null, '2022-03-18', 'IT38P0300203280329557424992', 'Palermo', 'ZNZSTF62M37R102Q', 550888),
  (024, 21000.00, 24, '2022-08-29', 'IT81Y0300203280134366152734', 'Palermo', 'VRDLGU78G12T112F', 171663);

insert into Garanzia(sn_veicolo, tipo, durata, costo_est) values
  (306918, 'legale', 2, null),
  (784604, 'legale', 2, null),
  (315686, 'estesa', 4, 600.00),
  (241608, 'legale', 2, null),
  (259862, 'legale', 2, null),
  (164815, 'legale', 2, null),
  (323428, 'estesa', 3, 200.00),
  (462345, 'legale', 2, null),
  (247553, 'legale', 2, null),
  (892807, 'estesa', 4, 700.00),
  (988491, 'legale', 2, null),
  (466952, 'legale', 2, null),
  (495980, 'legale', 2, null),
  (174815, 'legale', 2, null),
  (287126, 'estesa', 5, 850.00),
  (896165, 'legale', 2, null),
  (917733, 'legale usato', 1, null),
  (908131, 'estesa usato', 4, 550.00),
  (190123, 'legale usato', 1, null),
  (145026, 'legale usato', 1, null),
  (528279, 'legale', 2, null),
  (456710, 'legale', 2, null),
  (550888, 'estesa', 4, 1500.00),
  (171663, 'estesa usato', 2, 150.00);


/* Query */
/*1. Contare il numero di clienti con garanzia maggiore o uguale a 3 anni*/
SELECT COUNT(Cl.cf) AS NumGarEstese, Gar.durata
FROM Cliente AS Cl, Pagamento AS Pag, Veicolo AS Vei, Garanzia AS Gar
WHERE Cl.cf = Pag.cf_cliente AND Pag.sn_veicolo = Vei.sn AND Vei.sn = Gar.sn_veicolo AND Gar.durata >= 3
GROUP BY(Gar.durata);

/*2. Selezionare i modelli di veicoli venduti con un importo maggiore di 35000 euro ordinandole in ordine decrescente*/
SELECT DISTINCT Vei.modello, Pag.importo
FROM Veicolo AS Vei, Pagamento AS Pag
WHERE Vei.sn = Pag.sn_veicolo AND Pag.importo >= 35000
ORDER BY(Pag.importo) DESC;

/*3. Selezionare le marche e i modelli dei veicoli vendute dalla sede di Milano */
SELECT Vei.marca, Vei.modello, Se.citta
FROM Sede AS Se, Pagamento AS Pag, Veicolo AS Vei
WHERE Se.citta = Pag.citta_sede AND Pag.sn_veicolo = Vei.sn AND Se.citta = 'Milano';

/*4. Calcolare l'importo totale delle vendite effettuate dalle sedi con un numero di dipendenti maggiore di 5*/
SELECT SUM(Pag.importo) AS SommaTot, Se.citta, COUNT(Dip.codice) AS NumDip
FROM Pagamento AS Pag, Sede AS Se, Dipendente AS Dip
WHERE Se.citta = Pag.citta_sede AND Se.citta = Dip.citta_sede
GROUP BY(Se.citta)
HAVING (COUNT(Dip.codice) >= 5);

/*5. Selezionare i clienti che hanno acquistato una auto usata con più di 70000 km, raggruppando per marca, ordinandoli per i km in modo decrescente*/
SELECT Cl.nome, Cl.cognome, Vei.km, Vei.marca
FROM Cliente AS Cl, Pagamento AS Pag, Veicolo AS Vei
WHERE Cl.cf = Pag.cf_cliente AND Pag.sn_veicolo = Vei.sn AND Vei.km > 70000
GROUP BY(Cl.cf, Vei.km,Vei.marca)
ORDER BY (Vei.km) DESC;

/*6. Selezionare i meccanici nelle sedi in cui sono state vendute veicoli per una somma maggiore di 70000 euro, ordinandoli per il loro salario */
SELECT Dip.nome, Dip.cognome, Dip.salario, SUM(Pag.importo) AS SommaTot, Se.citta
FROM Pagamento AS Pag, Sede AS Se, Dipendente AS Dip
WHERE Se.citta = Pag.citta_sede AND Se.citta = Dip.citta_sede
GROUP BY(Dip.nome, Dip.cognome, Dip.salario,Se.citta)
HAVING (SUM(Pag.importo) > 70000)
ORDER BY Dip.salario DESC;

/*7. Selezionare i clienti che hanno scelto il pagamento a rate, calcolando l'importo delle rate arrotondato e ordinandole in modo decrescente*/
SELECT Cl.nome, Cl.cognome, ROUND(Pag.importo/Pag.rate) AS Importo_Rate
FROM Cliente AS Cl, Pagamento AS Pag
WHERE Cl.cf = Pag.cf_cliente AND Pag.rate is not null
ORDER BY (Pag.importo/Pag.rate) DESC;

/* Indici */
CREATE INDEX Indice_Veicolo ON Veicolo(sn);
