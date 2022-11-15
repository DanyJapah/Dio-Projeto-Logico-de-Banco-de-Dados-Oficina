-- MySQL Workbench 
-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE `oficina` ;

-- -----------------------------------------------------
-- Table `oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  ` Ano_Fabricacao` DATE NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Placa` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`),
  INDEX `fk_Veiculo_Cliente_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Veiculo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Servico` (
  `idServico` INT NOT NULL,
  `Tipo_Servico` VARCHAR(45) NULL,
  `Valor_Servico` FLOAT NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Peca` (
  `idPeca` INT NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Valor` FLOAT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Mecanico_Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Mecanico_Funcionario` (
  `idMecanico` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMecanico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`OS_Orcamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`OS_Orcamento` (
  `N_Orcamento` INT NOT NULL,
  `D_Orcamento` VARCHAR(45) NOT NULL,
  `Tipo_Servico` VARCHAR(45) NOT NULL,
  `Valor` FLOAT NOT NULL,
  `Autorizada` TINYINT NULL,
  `Status` ENUM('Aguardando Autorização', 'Em processamento', 'Concluido' 'Entregue') NOT NULL DEFAULT 'Aguardando Autorização',
  `D_Validade` DATE NOT NULL,
  `idVeiculo` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idServico` INT NOT NULL,
  `idPeca` INT NOT NULL,
  `idMecanico` INT NOT NULL,
  PRIMARY KEY (`N_Orcamento`, `idVeiculo`, `idCliente`, `idServico`, `idPeca`, `idMecanico`),
  UNIQUE INDEX `N_Orcamento_UNIQUE` (`N_Orcamento`) ,
  INDEX `fk_OS_Orcamento_Veiculo1_idx` (`idVeiculo`, `idCliente`) ,
  INDEX `fk_OS_Orcamento_Servico1_idx` (`idServico`),
  INDEX `fk_OS_Orcamento_Peca1_idx` (`idPeca`) ,
  INDEX `fk_OS_Orcamento_Mecanico_Funcionario1_idx` (`idMecanico` ) ,
  CONSTRAINT `fk_OS_Orcamento_Veiculo1`
    FOREIGN KEY (`idVeiculo` , `idCliente`)
    REFERENCES `oficina`.`Veiculo` (`idVeiculo` , `idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_Orcamento_Servico1`
    FOREIGN KEY (`idServico`)
    REFERENCES `oficina`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_Orcamento_Peca1`
    FOREIGN KEY (`idPeca`)
    REFERENCES `oficina`.`Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OS_Orcamento_Mecanico_Funcionario1`
    FOREIGN KEY (`Mecanico_Funcionario_idMecanico`)
    REFERENCES `oficina`.`Mecanico_Funcionario` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Ordem de Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Ordem_Servico` (
  `idOS` INT NOT NULL,
  `Valor` FLOAT NULL,
  `D_Inicio` DATE NULL,
  `Status` ENUM( 'Em processamento', 'Concluido' 'Entregue')NOT NULL DEFAULT 'Concluido',
  `D_Conclusão` DATE NULL,
  `OS_NOrcamento` INT NOT NULL,
  `OS_idVeiculo` INT NOT NULL,
  `OS_idCliente` INT NOT NULL,
  `OS_idServico` INT NOT NULL,
  `OS_idPeca` INT NOT NULL,
  `idMecanico` INT NOT NULL,
  PRIMARY KEY (`idOS`, `OS_NOrcamento`, `OS_idVeiculo`, `OS_idCliente`, `OS_idServico`, `OS_idPeca`, `idMecanico`),
  UNIQUE INDEX `N OS_UNIQUE` (`idOS`),
  INDEX `fk_Ordem de Servico_OS_Orcamento1_idx` (`OS_NOrcamento` , `OS_idVeiculo`, `OS_idCliente` , `OS_idServico` , `OS_idPeca`) ,
  INDEX `fk_Ordem de Servico_Mecanico_Funcionario1_idx` (`Mecanico_Funcionario_idMecanico` ),
  CONSTRAINT `fk_Ordem de Servico_OS_Orcamento1`
    FOREIGN KEY (`OS_NOrcamento` , `OS_idVeiculo` , `OS_idCliente` , `OS_idServico` , `OS_idPeca`)
    REFERENCES `oficina`.`OS_Orcamento` (`NOrcamento` , `Veiculo_idVeiculo` , `Veiculo_Cliente_idCliente` , `Servico_idServico` , `Peca_idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_Servico_Mecanico_Funcionario1`
    FOREIGN KEY (`Mecanico_Funcionario_idMecanico`)
    REFERENCES `oficina`.`Mecanico_Funcionario` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Tabela de Preco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Tabela_Preco` (
  `idT_Preco` INT NOT NULL,
  `Tipo_Servico` VARCHAR(45) NULL,
  `Valor_Servico` FLOAT NULL,
  `Servico_idServico` INT NOT NULL,
  PRIMARY KEY (`idT_Preco`, `Servico_idServico`),
  INDEX `fk_T_Preco_Servico1_idx` (`Servico_idServico`),
  CONSTRAINT `fk_Tabela de Preco_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `oficina`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;