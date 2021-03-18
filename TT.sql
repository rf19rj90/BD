CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`escolas` (
  `NrEscola` INT NOT NULL AUTO_INCREMENT,
  `Rua` VARCHAR(45) NOT NULL,
  `CodigoPostal` VARCHAR(8) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Contacto` INT NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`NrEscola`))
;
-- -----------------------------------------------------
-- Table `ruasegura2.0`.`instrutores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`instrutores` (
  `NrInstrutor` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Salario` FLOAT NOT NULL,
  `NrCC` INT NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `CodigoPostal` VARCHAR(8) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Contacto` INT NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `escolas_NrEscola` INT NOT NULL,
  PRIMARY KEY (`NrInstrutor`),
  INDEX `fk_instrutores_escolas1_idx` (`escolas_NrEscola` ASC) VISIBLE,
  CONSTRAINT `fk_instrutores_escolas1`
    FOREIGN KEY (`escolas_NrEscola`)
    REFERENCES `ruasegura2.0`.`escolas` (`NrEscola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `ruasegura2.0`.`alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`alunos` (
  `NrAluno` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `NrCC` INT NOT NULL,
  `Contacto` INT NOT NULL,
  `DatadeNascimento` DATE NOT NULL,
  `AtestadoMedico` TINYINT NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `CodigoPostal` VARCHAR(8) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `CodigoF` TINYINT NULL DEFAULT NULL,
  `ConducaoF` TINYINT NULL DEFAULT NULL,
  `NrAulaT` INT NULL DEFAULT NULL,
  `NrAulaP` INT NULL DEFAULT NULL,
  `QntPagou` FLOAT NULL DEFAULT NULL,
  `instrutores_NrInstrutor` INT NOT NULL,
  `escolas_NrEscola` INT NOT NULL,
  PRIMARY KEY (`NrAluno`),
  INDEX `fk_alunos_instrutores1_idx` (`instrutores_NrInstrutor` ASC) VISIBLE,
  INDEX `fk_alunos_escolas1_idx` (`escolas_NrEscola` ASC) VISIBLE,
  CONSTRAINT `fk_alunos_instrutores1`
    FOREIGN KEY (`instrutores_NrInstrutor`)
    REFERENCES `ruasegura2.0`.`instrutores` (`NrInstrutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunos_escolas1`
    FOREIGN KEY (`escolas_NrEscola`)
    REFERENCES `ruasegura2.0`.`escolas` (`NrEscola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ruasegura2.0`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`categorias` (
  `IdCategoria` INT NOT NULL auto_increment,
  `Preco` FLOAT NOT NULL,
  PRIMARY KEY (`IdCategoria`))
;


-- -----------------------------------------------------
-- Table `ruasegura`.`CategoriasAlunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`CategoriasAlunos` (
  `alunos_NrAluno` INT NOT NULL,
  `categorias_IdCategoria` INT NOT NULL,
  INDEX `fk_CategoriasAlunos_alunos1_idx` (`alunos_NrAluno` ASC) VISIBLE,
  INDEX `fk_CategoriasAlunos_categorias1_idx` (`categorias_IdCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_CategoriasAlunos_alunos1`
    FOREIGN KEY (`alunos_NrAluno`)
    REFERENCES `ruasegura2.0`.`alunos` (`NrAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CategoriasAlunos_categorias1`
    FOREIGN KEY (`categorias_IdCategoria`)
    REFERENCES `ruasegura2.0`.`categorias` (`IdCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ruasegura`.`Tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`Tipo` (
  `idTipo` INT NOT NULL auto_increment,
  `Nome` VARCHAR(1) NOT NULL,
  `categorias_IdCategoria` INT NOT NULL,
  PRIMARY KEY (`idTipo`),
  INDEX `fk_Tipo_categorias1_idx` (`categorias_IdCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Tipo_categorias1`
    FOREIGN KEY (`categorias_IdCategoria`)
    REFERENCES `ruasegura2.0`.`categorias` (`IdCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `ruasegura2.0` ;

-- -----------------------------------------------------
-- Table `ruasegura2.0`.`aulas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`aulas` (
  `Horarios` DATETIME NOT NULL,
  `IdAulas` INT NOT NULL auto_increment,
  `escolas_NrEscola` INT NOT NULL,
  `instrutores_NrInstrutor` INT NOT NULL,
  `alunos_NrAluno` INT NOT NULL,
  PRIMARY KEY (`IdAulas`),
  INDEX `fk_aulas_escolas1_idx` (`escolas_NrEscola` ASC) VISIBLE,
  INDEX `fk_aulas_instrutores1_idx` (`instrutores_NrInstrutor` ASC) VISIBLE,
  INDEX `fk_aulas_alunos1_idx` (`alunos_NrAluno` ASC) VISIBLE,
  CONSTRAINT `fk_aulas_escolas1`
    FOREIGN KEY (`escolas_NrEscola`)
    REFERENCES `ruasegura2.0`.`escolas` (`NrEscola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aulas_instrutores1`
    FOREIGN KEY (`instrutores_NrInstrutor`)
    REFERENCES `ruasegura2.0`.`instrutores` (`NrInstrutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aulas_alunos1`
    FOREIGN KEY (`alunos_NrAluno`)
    REFERENCES `ruasegura2.0`.`alunos` (`NrAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ruasegura2.0`.`exames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`exames` (
  `DataExameCodigo` DATETIME NULL DEFAULT NULL,
  `DataExameCond` DATETIME NULL DEFAULT NULL,
  `IdExames` INT NOT NULL auto_increment,
  `alunos_NrAluno` INT NOT NULL,
  PRIMARY KEY (`IdExames`),
  INDEX `fk_exames_alunos1_idx` (`alunos_NrAluno` ASC) VISIBLE,
  CONSTRAINT `fk_exames_alunos1`
    FOREIGN KEY (`alunos_NrAluno`)
    REFERENCES `ruasegura2.0`.`alunos` (`NrAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ruasegura2.0`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`funcionarios` (
  `NrFuncionario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Salario` FLOAT NOT NULL,
  `NrCC` INT NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `CodigoPostal` VARCHAR(8) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Contacto` INT NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `escolas_NrEscola` INT NOT NULL,
  PRIMARY KEY (`NrFuncionario`),
  INDEX `fk_funcionarios_escolas1_idx` (`escolas_NrEscola` ASC) VISIBLE,
  CONSTRAINT `fk_funcionarios_escolas1`
    FOREIGN KEY (`escolas_NrEscola`)
    REFERENCES `ruasegura2.0`.`escolas` (`NrEscola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ruasegura2.0`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`horario` (
  `IdHorario` INT NOT NULL auto_increment,
  `DiaSemana` VARCHAR(10) NOT NULL,
  `Hora` TIME NOT NULL,
  `escolas_NrEscola` INT NOT NULL,
  `instrutores_NrInstrutor` INT NOT NULL,
  INDEX `fk_horario_escolas1_idx` (`escolas_NrEscola` ASC) VISIBLE,
  INDEX `fk_horario_instrutores1_idx` (`instrutores_NrInstrutor` ASC) VISIBLE,
  PRIMARY KEY (`IdHorario`),
  CONSTRAINT `fk_horario_escolas1`
    FOREIGN KEY (`escolas_NrEscola`)
    REFERENCES `ruasegura2.0`.`escolas` (`NrEscola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_instrutores1`
    FOREIGN KEY (`instrutores_NrInstrutor`)
    REFERENCES `ruasegura2.0`.`instrutores` (`NrInstrutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ruasegura2.0`.`viaturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`viaturas` (
  `Matricula` VARCHAR(8) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Ano` YEAR NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Selo` DATE NOT NULL,
  `Seguro` DATE NOT NULL,
  `ValidadeInspecao` DATE NOT NULL,
  `Observacoes` TINYTEXT NULL DEFAULT NULL,
  `Cor` VARCHAR(45) NULL DEFAULT NULL,
  `instrutores_NrInstrutor` INT NOT NULL,
  PRIMARY KEY (`Matricula`),
  INDEX `fk_viaturas_instrutores1_idx` (`instrutores_NrInstrutor` ASC) VISIBLE,
  CONSTRAINT `fk_viaturas_instrutores1`
    FOREIGN KEY (`instrutores_NrInstrutor`)
    REFERENCES `ruasegura2.0`.`instrutores` (`NrInstrutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS `ruasegura2.0`.`CategoriasInstrutores` (
  `instrutores_NrInstrutor` INT NOT NULL,
  `categorias_IdCategoria` INT NOT NULL,
  INDEX `fk_CategoriasInstrutores_instrutores1_idx` (`instrutores_NrInstrutor` ASC) VISIBLE,
  INDEX `fk_CategoriasInstrutores_categorias1_idx` (`categorias_IdCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_CategoriasInstrutores_instrutores1`
    FOREIGN KEY (`instrutores_NrInstrutor`)
    REFERENCES `ruasegura2.0`.`instrutores` (`NrInstrutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CategoriasInstrutores_categorias1`
    FOREIGN KEY (`categorias_IdCategoria`)
    REFERENCES `ruasegura2.0`.`categorias` (`IdCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

use `ruasegura2.0`;
insert into alunos (Nome,NrCC, Contacto, 
DatadeNascimento,AtestadoMedico,Email,Rua,CodigoPostal, 
Localidade, CodigoF, ConducaoF,NrAulaT,NrAulaP,QntPagou ,
Instrutores_NrInstrutor, Escolas_NrEscola) values 
('Francisca Baptista',12383237,934878475,'2000-03-23',0,null,'Rua da Liberdade','4710-023','Braga',0,0,0,0,100,1,1);
insert into alunos (Nome,NrCC, Contacto, 
DatadeNascimento,AtestadoMedico,Email,Rua,CodigoPostal, 
Localidade, CodigoF, ConducaoF,NrAulaT,NrAulaP,QntPagou ,
Instrutores_NrInstrutor, Escolas_NrEscola) values ('Rui Faria',798787879,936526526,'2000-12-19',0,null,'Rua do Bairro','4710-013','Braga',0,0,0,0,200,2,1);
select * from alunos;


insert into instrutores(Nome, 
Salario, 
NrCC,
Rua,
CodigoPostal,
Localidade,
Contacto,
Email,
Escolas_NrEscola) values ('José Bezerro',900,34789879,'Rua São Lourenço','4710-012','Braga',962378223,'joseinseririnstrutorbez@hotmail.com',1);
insert into instrutores(Nome, 
Salario, 
NrCC,
Rua,
CodigoPostal,
Localidade,
Contacto,
Email,
Escolas_NrEscola) values ('Joana Fonseca',1000,43783748,'Rua São José','4710-045','Braga',936747488,'jofo123@hotmail.com',1);
insert into instrutores(Nome, 
Salario, 
NrCC,
Rua,
CodigoPostal,
Localidade,
Contacto,
Email,
Escolas_NrEscola) values ('Rui Pedro',900,347837383,'Rua da Pedra','4710-090','Braga',953763776,'rpedrox@hotmail.com',1);
select * from instrutores;

insert into funcionarios(Nome, 
Salario, 
NrCC,
Rua,
CodigoPostal,
Localidade,
Contacto,
Email,
Escolas_NrEscola) values('Maria Leonor',850,12783927,'Rua São Lourenço','4710-012','Braga',963748345,'josebez@hotmail.com','1');

-- datas exames--
insert into exames (DataExameCodigo,
DataExameCond, 
alunos_NrAluno)values ('2021-03-13',null,2);
select * from exames;

-- horarios--
insert into horario (DiaSemana,
Hora, 
escolas_NrEscola, 
instrutores_NrInstrutor)values ('Segunda','11:00:00',1,1),('Segunda','15:00:00',1,1),('Terça','11:00:00',1,1),('Terça','15:00:00',1,1),('Quarta','11:00:00',1,1),('Quarta','15:00:00',1,1),('Quinta','11:00:00',1,1),('Quinta','18:00:00',1,1),('Sexta','11:00:00',1,1),('Sexta','18:00:00',1,1),('Sábado','11:00:00',1,1);
select * from horario;

-- marcar aulas de conducao--
insert into aulas (Horarios,escolas_NrEscola,instrutores_NrInstrutor,alunos_NrAluno) values ('2020-12-10 15:00:00',1,1,2);


-- viatura do instrutor--
insert into viaturas values ('90-00-NZ','Opel Corsa','2000','Carro','2020-12-20','2021-12-20','2021-10-20',NULL,'Branco',1);
insert into viaturas values ('35-NZ-00','Fiat Punto','2000','Carro','2020-12-20','2021-12-20','2021-10-20',NULL,'Preto',2);
insert into viaturas values ('67-30-HF','BMW Série 1','2000','Carro','2020-12-20','2021-12-20','2021-10-20',NULL,'Branco',3);

-- inserir novo estabelecimento
insert into escolas(Rua ,CodigoPostal,Localidade,Contacto,Email) values ('Rua Antonio Fonseca','4720-012','Braga','253878789',null);
select * from escolas;

select * from categorias;
insert into categorias(Preco) values (500);
select * from tipo;
insert into tipo (Nome,categorias_IdCategoria) values ('A','1');
insert into tipo (Nome,categorias_IdCategoria) values ('B','1');
insert into categoriasalunos values (2,1);
insert into categoriasinstrutores values (1,1);
insert into categoriasinstrutores values (2,1);
insert into categoriasinstrutores values (3,1);


select * from alunos;
select * from funcionarios;
select * from instrutores;
select * from aulas;
select * from categorias;
select * from escolas;
select * from exames;
select * from funcionarios;
select * from horario;
select * from viaturas;