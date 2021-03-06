-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema proyecto_manufacturas_arsegin
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto_manufacturas_arsegin
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_manufacturas_arsegin` DEFAULT CHARACTER SET utf8 ;
USE `proyecto_manufacturas_arsegin` ;

-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`roles` (
  `id_Rol` INT NOT NULL,
  `rol` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Rol`),
  UNIQUE INDEX `id_Rol_UNIQUE` (`id_Rol` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`usuarios` (
  `id_Usuario` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `Roles_id_Rol` INT NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  UNIQUE INDEX `id_Usuario_UNIQUE` (`id_Usuario` ASC),
  INDEX `fk_Usuarios_Roles1_idx` (`Roles_id_Rol` ASC),
  CONSTRAINT `fk_Usuarios_Roles1`
    FOREIGN KEY (`Roles_id_Rol`)
    REFERENCES `proyecto_manufacturas_arsegin`.`roles` (`id_Rol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`claves`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`claves` (
  `usuario` VARCHAR(100) NOT NULL,
  `Clave` VARCHAR(100) NULL DEFAULT NULL,
  `Usuarios_id_Usuario` VARCHAR(15) NOT NULL,
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  INDEX `fk_Claves_Usuarios1_idx` (`Usuarios_id_Usuario` ASC),
  CONSTRAINT `fk_Claves_Usuarios1`
    FOREIGN KEY (`Usuarios_id_Usuario`)
    REFERENCES `proyecto_manufacturas_arsegin`.`usuarios` (`id_Usuario`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`cliente` (
  `cod_Cliente` VARCHAR(100) NOT NULL,
  `cliente` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `celular` VARCHAR(15) NOT NULL,
  `RUC` VARCHAR(15) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `persona_Contacto` VARCHAR(50) NOT NULL,
  `Usuarios_id_Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_Cliente`),
  UNIQUE INDEX `cliente_UNIQUE` (`cliente` ASC),
  UNIQUE INDEX `RUC_UNIQUE` (`RUC` ASC),
  UNIQUE INDEX `cod_Cliente_UNIQUE` (`cod_Cliente` ASC),
  INDEX `fk_Cliente_Usuarios1_idx` (`Usuarios_id_Usuario` ASC),
  CONSTRAINT `fk_Cliente_Usuarios1`
    FOREIGN KEY (`Usuarios_id_Usuario`)
    REFERENCES `proyecto_manufacturas_arsegin`.`usuarios` (`id_Usuario`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`compras` (
  `id_Compras` VARCHAR(45) NOT NULL,
  `no_Factura` VARCHAR(50) NOT NULL,
  `proveedor` VARCHAR(50) NOT NULL,
  `fecha` VARCHAR(20) NOT NULL,
  `factura` BLOB NOT NULL,
  `valor_Total` DOUBLE NOT NULL,
  `estado` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_Compras`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`cotizacion` (
  `no_Cotizacion` VARCHAR(50) NOT NULL,
  `fecha` VARCHAR(15) NOT NULL,
  `tipo_Pago` VARCHAR(50) NOT NULL,
  `v_Subtotal` DOUBLE NOT NULL,
  `IVA` DOUBLE NOT NULL,
  `valor_Total` DOUBLE NOT NULL,
  `Usuarios_id_Usuario` VARCHAR(45) NOT NULL,
  `Cliente_cod_Cliente` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`no_Cotizacion`),
  UNIQUE INDEX `no_Cotizacion_UNIQUE` (`no_Cotizacion` ASC),
  INDEX `fk_Cotizacion_Cliente1_idx` (`Cliente_cod_Cliente` ASC),
  INDEX `fk_Cotizacion_Usuarios1_idx` (`Usuarios_id_Usuario` ASC),
  CONSTRAINT `fk_Cotizacion_Cliente1`
    FOREIGN KEY (`Cliente_cod_Cliente`)
    REFERENCES `proyecto_manufacturas_arsegin`.`cliente` (`cod_Cliente`),
  CONSTRAINT `fk_Cotizacion_Usuarios1`
    FOREIGN KEY (`Usuarios_id_Usuario`)
    REFERENCES `proyecto_manufacturas_arsegin`.`usuarios` (`id_Usuario`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`detalle_cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`detalle_cotizacion` (
  `id_Cotizacion` INT NOT NULL AUTO_INCREMENT,
  `cantidad` TEXT NOT NULL,
  `codigo` TEXT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `v_Unitario` TEXT NOT NULL,
  `v_Total` TEXT NOT NULL,
  `Cotizacion_no_Cotizacion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Cotizacion`),
  UNIQUE INDEX `Cotizacion_no_Cotizacion_UNIQUE` (`Cotizacion_no_Cotizacion` ASC),
  INDEX `fk_Detalle_Cotizacion_Cotizacion1_idx` (`Cotizacion_no_Cotizacion` ASC),
  CONSTRAINT `fk_Detalle_Cotizacion_Cotizacion1`
    FOREIGN KEY (`Cotizacion_no_Cotizacion`)
    REFERENCES `proyecto_manufacturas_arsegin`.`cotizacion` (`no_Cotizacion`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`factura` (
  `no_Factura` VARCHAR(50) NOT NULL,
  `fecha` VARCHAR(45) NOT NULL,
  `v_Subtotal` DOUBLE NOT NULL,
  `IVA` DOUBLE NOT NULL,
  `valor_Total` DOUBLE NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `Usuarios_id_Usuario` VARCHAR(50) NOT NULL,
  `observaciones` TEXT NULL DEFAULT NULL,
  `Cliente_cod_Cliente` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`no_Factura`),
  UNIQUE INDEX `no_Factura_UNIQUE` (`no_Factura` ASC),
  INDEX `fk_Factura_Cliente1_idx` (`Cliente_cod_Cliente` ASC),
  INDEX `fk_Factura_Usuarios1_idx` (`Usuarios_id_Usuario` ASC),
  CONSTRAINT `fk_Factura_Cliente1`
    FOREIGN KEY (`Cliente_cod_Cliente`)
    REFERENCES `proyecto_manufacturas_arsegin`.`cliente` (`cod_Cliente`),
  CONSTRAINT `fk_Factura_Usuarios1`
    FOREIGN KEY (`Usuarios_id_Usuario`)
    REFERENCES `proyecto_manufacturas_arsegin`.`usuarios` (`id_Usuario`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`detalle_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`detalle_factura` (
  `id_Detalle_Factura` INT NOT NULL AUTO_INCREMENT,
  `cantidad` TEXT NOT NULL,
  `codigo` TEXT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `v_Unitario` TEXT NOT NULL,
  `v_Total` TEXT NOT NULL,
  `Factura_no_Factura` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Detalle_Factura`),
  UNIQUE INDEX `id_Orden_Compra_UNIQUE` (`id_Detalle_Factura` ASC),
  INDEX `fk_Detalle_Factura_Factura1_idx` (`Factura_no_Factura` ASC),
  CONSTRAINT `fk_Detalle_Factura_Factura1`
    FOREIGN KEY (`Factura_no_Factura`)
    REFERENCES `proyecto_manufacturas_arsegin`.`factura` (`no_Factura`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`proveedor` (
  `id_Proveedor` VARCHAR(45) NOT NULL,
  `proveedor` VARCHAR(100) NOT NULL,
  `RUC` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `productos` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_Proveedor`),
  UNIQUE INDEX `RUC_UNIQUE` (`RUC` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`orden_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`orden_compra` (
  `id_Orden_Compra` VARCHAR(50) NOT NULL,
  `fecha` VARCHAR(15) NOT NULL,
  `v_Subtotal` DOUBLE NOT NULL,
  `IVA` DOUBLE NOT NULL,
  `valor_Total` DOUBLE NOT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_Pago` VARCHAR(20) NOT NULL,
  `Usuarios_id_Usuario` VARCHAR(45) NOT NULL,
  `Proveedor_id_Proveedor` VARCHAR(45) NOT NULL,
  `Compras_id_Compras` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_Orden_Compra`),
  UNIQUE INDEX `id_Orden_Compra_UNIQUE` (`id_Orden_Compra` ASC),
  INDEX `fk_Orden_Compra_Proveedor1_idx` (`Proveedor_id_Proveedor` ASC),
  INDEX `fk_Orden_Compra_Compras1_idx` (`Compras_id_Compras` ASC),
  INDEX `fk_Orden_Compra_Usuarios1_idx` (`Usuarios_id_Usuario` ASC),
  CONSTRAINT `fk_Orden_Compra_Compras1`
    FOREIGN KEY (`Compras_id_Compras`)
    REFERENCES `proyecto_manufacturas_arsegin`.`compras` (`id_Compras`),
  CONSTRAINT `fk_Orden_Compra_Proveedor1`
    FOREIGN KEY (`Proveedor_id_Proveedor`)
    REFERENCES `proyecto_manufacturas_arsegin`.`proveedor` (`id_Proveedor`),
  CONSTRAINT `fk_Orden_Compra_Usuarios1`
    FOREIGN KEY (`Usuarios_id_Usuario`)
    REFERENCES `proyecto_manufacturas_arsegin`.`usuarios` (`id_Usuario`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`detalle_orden_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`detalle_orden_compra` (
  `id_Detalle_Compra` VARCHAR(50) NOT NULL,
  `cantidad` TEXT NOT NULL,
  `codigo` TEXT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `v_Unitario` TEXT NOT NULL,
  `v_Total` TEXT NOT NULL,
  `Orden_Compra_id_Orden_Compra` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Detalle_Compra`),
  UNIQUE INDEX `id_Orden_Compra_UNIQUE` (`id_Detalle_Compra` ASC),
  INDEX `fk_Detalle_Orden_Compra_Orden_Compra1_idx` (`Orden_Compra_id_Orden_Compra` ASC),
  CONSTRAINT `fk_Detalle_Orden_Compra_Orden_Compra1`
    FOREIGN KEY (`Orden_Compra_id_Orden_Compra`)
    REFERENCES `proyecto_manufacturas_arsegin`.`orden_compra` (`id_Orden_Compra`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`maquilas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`maquilas` (
  `id_Maquila` VARCHAR(45) NOT NULL,
  `maquila` VARCHAR(50) NOT NULL,
  `RUC` VARCHAR(15) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `servicio` TEXT NOT NULL,
  PRIMARY KEY (`id_Maquila`),
  UNIQUE INDEX `RUC_UNIQUE` (`RUC` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`orden_produccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`orden_produccion` (
  `numero_Orden` VARCHAR(50) NOT NULL,
  `fecha` VARCHAR(20) NOT NULL,
  `v_Pagar` DOUBLE NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  `observaciones` TEXT NULL DEFAULT NULL,
  `Maquilas_id_Maquila` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`numero_Orden`),
  INDEX `fk_Orden_Produccion_Maquilas1_idx` (`Maquilas_id_Maquila` ASC),
  CONSTRAINT `fk_Orden_Produccion_Maquilas1`
    FOREIGN KEY (`Maquilas_id_Maquila`)
    REFERENCES `proyecto_manufacturas_arsegin`.`maquilas` (`id_Maquila`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`detalle_orden_produccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`detalle_orden_produccion` (
  `id_Detalle_Orden_Produccion` INT NOT NULL AUTO_INCREMENT,
  `cantidad` TEXT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `v_Unitario` TEXT NOT NULL,
  `v_Total` TEXT NOT NULL,
  `Orden_Produccion_numero_Orden` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Detalle_Orden_Produccion`),
  INDEX `fk_Detalle_Orden_Produccion_Orden_Produccion1_idx` (`Orden_Produccion_numero_Orden` ASC),
  CONSTRAINT `fk_Detalle_Orden_Produccion_Orden_Produccion1`
    FOREIGN KEY (`Orden_Produccion_numero_Orden`)
    REFERENCES `proyecto_manufacturas_arsegin`.`orden_produccion` (`numero_Orden`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`funcionalidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`funcionalidades` (
  `no_Funcionalidad` INT NOT NULL,
  `funcionalidad` VARCHAR(100) NOT NULL,
  `id_Funcionalidades` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_Funcionalidades`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`funcionalidades_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`funcionalidades_roles` (
  `id_Funcionalidades_Roles` INT NOT NULL AUTO_INCREMENT,
  `Funcionalidades_id_Funcionalidades` INT NOT NULL,
  `Roles_id_Rol` INT NOT NULL,
  PRIMARY KEY (`id_Funcionalidades_Roles`),
  INDEX `fk_Funcionalidades_has_Roles_Roles1_idx` (`Roles_id_Rol` ASC),
  INDEX `fk_Funcionalidades_has_Roles_Funcionalidades1_idx` (`Funcionalidades_id_Funcionalidades` ASC),
  CONSTRAINT `fk_Funcionalidades_has_Roles_Funcionalidades1`
    FOREIGN KEY (`Funcionalidades_id_Funcionalidades`)
    REFERENCES `proyecto_manufacturas_arsegin`.`funcionalidades` (`id_Funcionalidades`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Funcionalidades_has_Roles_Roles1`
    FOREIGN KEY (`Roles_id_Rol`)
    REFERENCES `proyecto_manufacturas_arsegin`.`roles` (`id_Rol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`inventario` (
  `codigo` VARCHAR(50) NOT NULL,
  `precio_Venta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`producto` (
  `codigo` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `cantidad_Disponible` INT NOT NULL,
  `precio_Compra` DOUBLE NOT NULL,
  `proveedor` VARCHAR(100) NOT NULL,
  `Inventario_codigo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC),
  INDEX `fk_Producto_Inventario1_idx` (`Inventario_codigo` ASC),
  CONSTRAINT `fk_Producto_Inventario1`
    FOREIGN KEY (`Inventario_codigo`)
    REFERENCES `proyecto_manufacturas_arsegin`.`inventario` (`codigo`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`proveedor_compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`proveedor_compras` (
  `Compras_id_Compras` VARCHAR(50) NOT NULL,
  `Proveedor_id_Proveedor` VARCHAR(45) NOT NULL,
  INDEX `fk_Proveedor_Compras_Compras1_idx` (`Compras_id_Compras` ASC),
  INDEX `fk_Proveedor_Compras_Proveedor1_idx` (`Proveedor_id_Proveedor` ASC),
  CONSTRAINT `fk_Proveedor_Compras_Compras1`
    FOREIGN KEY (`Compras_id_Compras`)
    REFERENCES `proyecto_manufacturas_arsegin`.`compras` (`id_Compras`),
  CONSTRAINT `fk_Proveedor_Compras_Proveedor1`
    FOREIGN KEY (`Proveedor_id_Proveedor`)
    REFERENCES `proyecto_manufacturas_arsegin`.`proveedor` (`id_Proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `proyecto_manufacturas_arsegin`.`proveedor_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_manufacturas_arsegin`.`proveedor_producto` (
  `Producto_codigo` VARCHAR(50) NOT NULL,
  `Proveedor_id_Proveedor` VARCHAR(45) NOT NULL,
  INDEX `fk_Proveedor_Producto_Producto1_idx` (`Producto_codigo` ASC),
  INDEX `fk_Proveedor_Producto_Proveedor1_idx` (`Proveedor_id_Proveedor` ASC),
  CONSTRAINT `fk_Proveedor_Producto_Producto1`
    FOREIGN KEY (`Producto_codigo`)
    REFERENCES `proyecto_manufacturas_arsegin`.`producto` (`codigo`),
  CONSTRAINT `fk_Proveedor_Producto_Proveedor1`
    FOREIGN KEY (`Proveedor_id_Proveedor`)
    REFERENCES `proyecto_manufacturas_arsegin`.`proveedor` (`id_Proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `proyecto_manufacturas_arsegin` ;

-- -----------------------------------------------------
-- procedure Editar_Compras
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Editar_Compras`( id varchar(50), no_Fac varchar(45), proveedor varchar(100), fecha varchar(20), factura mediumblob, valor Double, estado varchar(100) )
BEGIN
UPDATE Compras SET estado = estado WHERE id_Compras = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure actualizar_Informacion_Usuario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_Informacion_Usuario`( id varchar(15), nom varchar(50), ape varchar(50), cor varchar(100), rol int, clave varchar(100) )
BEGIN
UPDATE Usuarios SET id_Usuario = id, nombre = nom, apellido = ape, correo = cor, Roles_id_Rol = rol  WHERE  id_Usuario = clave;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Ciudades
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Ciudades`(id varchar(20))
BEGIN
SELECT DISTINCT ciudad FROM Cliente WHERE Usuarios_id_Usuario = id OR id = "Todos";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Clientes
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Clientes`( Cliente varchar(100), id varchar(15) )
BEGIN
select * from Cliente where (cod_Cliente = cliente OR cliente = "Todos") AND (Usuarios_id_Usuario = id OR id = "Todos");
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Datos_Usuario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Datos_Usuario`( usua varchar(100), ced varchar(100) )
BEGIN
SELECT usu.id_Usuario, usu.nombre, usu.apellido, usu.correo, cla.usuario, cla.Clave, usu.Roles_id_Rol FROM Claves cla INNER JOIN  Usuarios usu ON cla.Usuarios_id_Usuario = usu.id_Usuario WHERE cla.usuario = usua and usu.id_Usuario = ced;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Funcion_Rol
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Funcion_Rol`( funcion int )
BEGIN
SELECT * FROM Roles WHERE id_Rol = funcion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Funcionalidades
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`Manufacturas_Arsegin`@`localhost` PROCEDURE `consulta_Funcionalidades`( cod int )
BEGIN
SELECT funcionalidad FROM Funcionalidades WHERE no_Funcionalidad IN( SELECT id_Rol FROM Roles WHERE id_Rol = cod );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Inventario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Inventario`( valor_Codigo varchar(50) )
BEGIN
SELECT * FROM Inventario inv INNER JOIN (SELECT prod.codigo, prod.descripcion, prod.cantidad_Disponible, prod.precio_Compra, prod.proveedor  FROM Producto prod WHERE prod.codigo LIKE CONCAT( valor_Codigo, "%" ) ) as pro ON inv.codigo = pro.codigo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Inventario_Descripcion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Inventario_Descripcion`( valor_Descripcion varchar(100) )
BEGIN
SELECT * FROM Inventario inv INNER JOIN (SELECT prod.codigo, prod.descripcion, prod.cantidad_Disponible, prod.precio_Compra, prod.proveedor  FROM Producto prod WHERE prod.descripcion LIKE CONCAT( '%', valor_Descripcion, '%' ) ) as pro ON inv.codigo = pro.codigo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Maquila
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Maquila`( valor_Maquila varchar(50) )
BEGIN
SELECT * FROM Maquilas WHERE id_Maquila = valor_Maquila OR valor_Maquila = "Todos";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Producto
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`Manufacturas_Arsegin`@`localhost` PROCEDURE `consulta_Producto`( valor_Producto varchar(30) )
BEGIN
select * from Producto where descripcion LIKE CONCAT( valor_Producto, "%" );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Proveedor
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Proveedor`( valor_Proveedor varchar(100) )
BEGIN
select * from Proveedor where id_Proveedor = valor_Proveedor OR proveedor LIKE CONCAT( valor_Proveedor, "%" );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Proveedor_Producto
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Proveedor_Producto`( valor_Proveedor varchar(100) )
BEGIN
select * from Proveedor where productos LIKE CONCAT('%',valor_Proveedor,'%');
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Reporte_Cliente
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Reporte_Cliente`( ciudades varchar(100), usuario varchar(15) )
BEGIN
select * from Cliente where  (Usuarios_id_Usuario = usuario OR usuario = "Todos") AND (ciudad = ciudades OR ciudades = "Todos");
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Rol_Sesion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Rol_Sesion`(IN usu varchar(100))
BEGIN
SET @d = CONCAT('SHOW GRANTS FOR ', usu);
PREPARE stmt FROM @d;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Roles
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Roles`( )
BEGIN
SELECT rol FROM Roles;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Usuario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`Manufacturas_Arsegin`@`localhost` PROCEDURE `consulta_Usuario`( usu varchar(100), cla varchar(100) )
BEGIN
SELECT Roles_id_Rol, nombre, apellido FROM Usuarios WHERE id_Usuario IN( SELECT Usuarios_id_Usuario FROM Claves WHERE usuario = usu and clave = cla );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Usuarios
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_Usuarios`( usu varchar(100) )
BEGIN
SELECT usu.id_Usuario, usu.nombre, usu.apellido, usu.correo, usu.Roles_id_Rol FROM Usuarios usu INNER JOIN Claves cla ON usu.id_Usuario = cla.Usuarios_id_Usuario WHERE cla.usuario = usu;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Compras_Ingresadas
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Compras_Ingresadas`( proveedor varchar(100) )
BEGIN
SELECT co.id_Compras, co.no_Factura, co.proveedor, co.fecha, co.factura, co.valor_Total, co.estado FROM Compras co INNER JOIN  Orden_Compra ord ON co.id_Compras = ord.Compras_id_Compras WHERE co.proveedor = proveedor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Cotizacion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Cotizacion`( cliente varchar(100), emisor varchar(100) )
BEGIN
SELECT * FROM Cotizacion co INNER JOIN  Detalle_Cotizacion de ON co.no_Cotizacion = de.Cotizacion_no_Cotizacion and (co.Usuarios_id_Usuario = emisor OR emisor = "Todos") WHERE co.no_Cotizacion  = cliente or cliente = "Todos"; 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Cotizaciones_Fechas
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Cotizaciones_Fechas`( cliente varchar(100), emisor varchar(100), fecha_Inicio varchar(15), fecha_Final varchar(15) )
BEGIN
SELECT * FROM Cotizacion co INNER JOIN  Detalle_Cotizacion de ON co.no_Cotizacion = de.Cotizacion_no_Cotizacion and (co.Usuarios_id_Usuario = emisor OR emisor = "Todos") WHERE co.no_Cotizacion  = cliente or cliente = "Todos" AND (co.fecha BETWEEN	fecha_Inicio AND fecha_Final); 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Factura
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Factura`( numero varchar(100), ven varchar(100) )
BEGIN
SELECT * FROM Factura fa INNER JOIN  Detalle_Factura de ON fa.no_Factura = de.Factura_no_Factura and (fa.Usuarios_id_Usuario = ven OR ven = "Todos") WHERE fa.no_Factura = numero or numero = "Todos";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Facturas_Adeudadas
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Facturas_Adeudadas`( cliente varchar(100), tipo varchar(100), emisor varchar(100) )
BEGIN
SELECT fa.no_Factura, fa.fecha, fa.v_Subtotal, fa.IVA, fa. valor_Total, fa.Estado, fa.Cliente_cod_Cliente, de.cantidad, de.codigo, de.descripcion, de.v_Unitario, de.v_Total, fa.Usuarios_id_Usuario, fa.observaciones FROM Factura fa INNER JOIN  Detalle_Factura de ON fa.no_Factura = de.Factura_no_Factura AND (fa.Usuarios_id_Usuario = emisor OR emisor = "Todos" ) WHERE fa.Cliente_cod_Cliente = cliente and (fa.Estado = tipo or tipo = "Todas");
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Facturas_Fechas
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Facturas_Fechas`( numero varchar(100), ven varchar(100), fecha_Inicio varchar(15), fecha_Final varchar(15) )
BEGIN
SELECT * FROM Factura fa INNER JOIN  Detalle_Factura de ON fa.no_Factura = de.Factura_no_Factura and (fa.Usuarios_id_Usuario = ven OR ven = "Todos") WHERE fa.no_Factura = numero or numero = "Todos" AND (fecha BETWEEN	fecha_Inicio AND fecha_Final);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Inventario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`Manufacturas_Arsegin`@`localhost` PROCEDURE `consultar_Inventario`( descripcion_Producto varchar(100) )
BEGIN
SELECT * FROM Inventario inv INNER JOIN (SELECT prod.codigo, prod.descripcion, prod.cantidad_Disponible, prod.precio_Compra, prod.proveedor  FROM Producto prod WHERE prod.descripcion = descripcion_Producto ) as pro ON inv.codigo = pro.codigo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Orden_Compra
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Orden_Compra`( id_Compra varchar(100), emisor varchar(100) )
BEGIN
SELECT * FROM Orden_Compra ord INNER JOIN  Detalle_Orden_Compra de ON ord.id_Orden_Compra = de.Orden_Compra_id_Orden_Compra and (ord.Usuarios_id_Usuario = emisor OR emisor = "Todos") WHERE ord.id_Orden_Compra = id_Compra or  id_Compra = "Todos";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Orden_Compra_Ingresadas
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Orden_Compra_Ingresadas`( proveedor varchar(100) )
BEGIN
SELECT * FROM Orden_Compra ord INNER JOIN  Detalle_Orden_Compra de ON ord.id_Orden_Compra = de.Orden_Compra_id_Orden_Compra WHERE ord.Proveedor_id_Proveedor = proveedor && ( ord.Compras_id_Compras IS NOT NULL );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Orden_Compras
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Orden_Compras`( proveedor varchar(100) )
BEGIN
SELECT * FROM Orden_Compra ord INNER JOIN  Detalle_Orden_Compra de ON ord.id_Orden_Compra = de.Orden_Compra_id_Orden_Compra WHERE ord.Proveedor_id_Proveedor = proveedor && ( ord.Compras_id_Compras IS NULL && ord.estado = "Aprobado" );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Orden_Produccion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Orden_Produccion`( id varchar(100) )
BEGIN
SELECT * FROM Orden_Produccion ord INNER JOIN  Detalle_Orden_Produccion de ON ord.numero_Orden = de.Orden_Produccion_numero_Orden WHERE ord.numero_Orden = id OR id = "Todas";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Orden_Produccion_Fechas
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Orden_Produccion_Fechas`( fecha_Inicio varchar(20), fecha_Final varchar(20) )
BEGIN
SELECT * FROM Orden_Produccion ord INNER JOIN  Detalle_Orden_Produccion de ON ord.numero_Orden = de.Orden_Produccion_numero_Orden WHERE ord.fecha BETWEEN fecha_Inicio AND fecha_Final;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Ordenes_Fechas
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Ordenes_Fechas`( id_Compra varchar(100), emisor varchar(100) , fecha_Inicio varchar(15), fecha_Final varchar(15) )
BEGIN
SELECT * FROM Orden_Compra ord INNER JOIN  Detalle_Orden_Compra de ON ord.id_Orden_Compra = de.Orden_Compra_id_Orden_Compra and (ord.Usuarios_id_Usuario = emisor OR emisor = "Todos") WHERE ord.id_Orden_Compra = id_Compra or  id_Compra = "Todos" AND (fecha BETWEEN	fecha_Inicio AND fecha_Final);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Pagos_Adeudados
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Pagos_Adeudados`( prov varchar(100), esta varchar(100) )
BEGIN
SELECT co.id_Compras, co.no_Factura, co.proveedor, co.fecha, co.factura, co.valor_Total, co.estado FROM Compras co INNER JOIN  Orden_Compra ord ON co.id_Compras = ord.Compras_id_Compras WHERE  co.proveedor = prov and ( co.estado=esta or esta="Todos");
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultar_Usuarios_Registrados
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_Usuarios_Registrados`( id varchar(50) )
BEGIN
SELECT * FROM Usuarios WHERE id_Usuario = id OR id = "Todos";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Cliente
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Cliente`( cod varchar(100), cli varchar(100), dir varchar(50), cd varchar(50), tlf varchar(15), cel varchar(15), ruc varchar(20), cor varchar(100), persona varchar(50), empleado varchar(15))
BEGIN
insert into Cliente values( cod, cli, dir, cd, tlf, cel, ruc, cor, persona, empleado);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Compras
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Compras`(id varchar(45), no_Factura varchar(50), proveedor varchar(100), fecha varchar(20), factura mediumblob, valor double, estado varchar(100) )
BEGIN
INSERT INTO Compras VALUES(id, no_Factura, proveedor, fecha, factura, valor, estado );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Cotizacion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Cotizacion`( no_Cotizacion varchar(50), fecha varchar(15), tipo_Pago varchar(50), v_Subtotal double, iva double, valor_Total double, cliente varchar(100), emisor varchar(100), cantidad TEXT, codigo TEXT, descripcion TEXT, v_Unitario TEXT, v_Total TEXT )
BEGIN
INSERT INTO Cotizacion VALUES( no_Cotizacion, fecha, tipo_Pago, v_Subtotal, iva, valor_Total,  emisor, cliente );
INSERT INTO Detalle_Cotizacion( cantidad, codigo, descripcion, v_Unitario, v_Total, Cotizacion_no_Cotizacion ) VALUES ( cantidad, codigo, descripcion, v_Unitario, v_Total, no_Cotizacion );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Factura
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Factura`( no_Factura varchar(50), fecha varchar(15), v_Subtotal double, iva double, valor_Total double, estado varchar(20), cliente varchar(100), cantidad TEXT, codigo TEXT, descripcion TEXT, v_Unitario TEXT, v_Total TEXT, vendedor varchar(100), observaciones TEXT )
BEGIN
INSERT INTO Factura VALUES( no_Factura, fecha, v_Subtotal, iva, valor_Total, estado, vendedor, observaciones, cliente );
INSERT INTO Detalle_Factura( cantidad, codigo, descripcion, v_Unitario, v_Total, Factura_no_Factura ) VALUES ( cantidad, codigo, descripcion, v_Unitario, v_Total, no_Factura );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Inventario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Inventario`( cod varchar(15),  des varchar(100), can_dis int, pre_Co double, precio_Ve double, prov varchar(50) )
BEGIN
INSERT INTO Inventario VALUES( cod, precio_Ve );
INSERT INTO Producto VALUES( cod, des, can_dis, pre_Co, prov, cod );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Maquila
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Maquila`( id varchar(45), maq varchar(50), ruc varchar(15), dir varchar(100), tel varchar(15), ser text  )
BEGIN
INSERT INTO Maquilas VALUES( id, maq, ruc, dir, tel, ser );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Orden_Compra
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Orden_Compra`( no_Orden varchar(50), fecha varchar(15), v_Subtotal double, iva double, valor_Total double, est varchar(45), tipo_Pago varchar(20), solicitante varchar(100), proveedor varchar(100), cantidad TEXT, codigo TEXT, descripcion TEXT, v_Unitario TEXT, v_Total TEXT )
BEGIN
INSERT INTO Orden_Compra(id_Orden_Compra, fecha, v_Subtotal, IVA, valor_Total, estado, tipo_Pago, Usuarios_id_Usuario, Proveedor_id_Proveedor) VALUES( no_Orden, fecha, v_Subtotal, iva, valor_Total, est, tipo_Pago, solicitante, proveedor );
INSERT INTO Detalle_Orden_Compra VALUES ( no_Orden, cantidad, codigo, descripcion, v_Unitario, v_Total, no_Orden );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Orden_Produccion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Orden_Produccion`( no_Orden varchar(50), fecha varchar(15), valor_Pagar double, estado varchar(20), observaciones text, maquila varchar(100), cantidad TEXT, descripcion TEXT, v_Unitario TEXT, v_Total TEXT )
BEGIN
INSERT INTO Orden_Produccion VALUES( no_Orden, fecha, valor_Pagar, estado, observaciones, maquila );
INSERT INTO Detalle_Orden_Produccion( cantidad, descripcion, v_Unitario, v_Total, Orden_Produccion_numero_Orden ) VALUES ( cantidad, descripcion, v_Unitario, v_Total, no_Orden );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Proveedor
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Proveedor`( id_Prov varchar(45), prov varchar(100), ruc varchar(20), dir varchar(100), cor varchar(100), tlf varchar(20), pro text )
BEGIN
insert into Proveedor values( id_Prov, prov, ruc, dir, cor, tlf, pro );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure crear_Usuario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_Usuario`( id varchar(15), nom varchar(50), ape varchar(50), cor varchar(100), IN usu varchar(100), IN cla varchar(100), rol int, funcion varchar(100))
BEGIN

SET @s = CONCAT('CREATE USER "',usu,'"@"localhost" IDENTIFIED BY "',cla,'"');

SET @d = CONCAT('GRANT "',funcion,'" TO "',usu,'"@"localhost"');

SET @e = CONCAT('SET DEFAULT ROLE "',funcion,'" TO "',usu,'"@"localhost"');


PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

PREPARE stmt FROM @d;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

PREPARE stmt FROM @e;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

INSERT INTO Usuarios VALUES( id, nom, ape, cor, rol);
INSERT INTO Claves(usuario, Usuarios_id_Usuario) VALUES( usu, id );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Clientes
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Clientes`( cod varchar(45), cli varchar(100), dir varchar(50), cd varchar(50), tlf varchar(15), cel varchar(15), ruc varchar(15), cor varchar(100), persona varchar(50), empleado varchar(15) )
BEGIN
UPDATE Cliente SET cliente = cli, direccion = dir, ciudad = cd, telefono = tlf, celular = cel, RUC = ruc, correo = cor, persona_Contacto = persona, Usuarios_id_Usuario = empleado WHERE cod_Cliente = cod;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Cotizacion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Cotizacion`( no_Cotiza varchar(50), fec varchar(15), tipo_Pa varchar(50), v_Subto double, iv double, valor_To double, cli varchar(100), emisor varchar(100), cant TEXT, cod TEXT, des TEXT, v_Unit TEXT, v_To TEXT )
BEGIN
UPDATE Cotizacion SET no_Cotizacion = no_Cotiza, fecha = fec, tipo_Pago = tipo_Pa, v_Subtotal = v_Subto, iva = iv, valor_Total = valor_To , Usuarios_id_Usuario = emisor WHERE no_Cotizacion = no_Cotiza;
UPDATE Detalle_Cotizacion SET cantidad = cant, codigo = cod, descripcion = des, v_Unitario = v_Unit, v_Total = v_To, Cotizacion_no_Cotizacion =  no_Cotiza WHERE Cotizacion_no_Cotizacion = no_Cotiza;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Factura
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Factura`( no_Factu varchar(100), fec varchar(15), v_Subto double, iv double, valor_To double, esta varchar(20), cli varchar(100), cant TEXT, cod TEXT, des TEXT, v_Unit TEXT, v_To TEXT, ven varchar(100), obs TEXT )
BEGIN
UPDATE Factura SET fecha = fec, v_Subtotal = v_Subto, IVA = iv, valor_Total = valor_To , Estado = esta, Usuarios_id_Usuario = ven, observaciones = obs, Cliente_cod_Cliente = cli WHERE no_Factura = no_Factu;
UPDATE Detalle_Factura SET cantidad = cant, codigo = cod, descripcion = des, v_Unitario = v_Unit, v_Total = v_To WHERE Factura_no_Factura = no_Factu;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Factura_Orden_Compra
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Factura_Orden_Compra`( no_Ord varchar(50) )
BEGIN
UPDATE Orden_Compra SET Compras_id_Compras = no_Ord  WHERE  id_Orden_Compra = no_Ord;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Inventario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Inventario`( cod varchar(50),  des varchar(100), can_dis int, pre_Co double, precio_Ve double, prov varchar(50) )
BEGIN
UPDATE Inventario SET precio_Venta = precio_Ve WHERE codigo = cod;
UPDATE Producto SET descripcion = des, cantidad_Disponible = can_dis, precio_Compra = pre_Co, proveedor = prov WHERE codigo = cod;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Maquila
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Maquila`( id varchar(45), maq varchar(50), ruci varchar(15), dir varchar(100), tel varchar(15), ser text  )
BEGIN
UPDATE Maquilas SET maquila = maq, RUC = ruci, direccion = dir, telefono = tel, servicio = ser  WHERE id_Maquila = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Orden_Compra
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Orden_Compra`( no_Ord varchar(50), fec varchar(15), v_Subto double, iv double, valor_To double, est varchar(45), tipo_Pag varchar(20), soli varchar(100), prov varchar(100), cant TEXT, cod TEXT, des TEXT, v_Unit TEXT, v_Tot TEXT )
BEGIN
UPDATE Orden_Compra SET id_Orden_Compra = no_Ord, fecha = fec, v_Subtotal = v_Subto, iva = iv, valor_Total = valor_To, estado = est, tipo_Pago = tipo_Pag, Usuarios_id_Usuario = soli,  Proveedor_id_Proveedor = prov, Compras_id_Compras = Compras_id_Compras WHERE  id_Orden_Compra = no_Ord;
UPDATE Detalle_Orden_Compra SET id_Detalle_Compra = no_Ord, cantidad = cant, codigo = cod, descripcion = des, v_Unitario = v_Unit, v_Total = v_Tot, Orden_Compra_id_Orden_Compra = no_Ord WHERE Orden_Compra_id_Orden_Compra = no_Ord;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Orden_Produccion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Orden_Produccion`( no_Orden varchar(50), fec varchar(15), valor_Paga double, esta varchar(20), obs text, maqui varchar(100), cant TEXT, des TEXT, v_Unit TEXT, v_To TEXT )
BEGIN
UPDATE Orden_Produccion SET numero_Orden = no_Orden, fecha = fec, v_Pagar = valor_Paga, estado = esta, observaciones = obs WHERE  numero_Orden = no_Orden;
UPDATE Detalle_Orden_Produccion SET cantidad = cant, descripcion = des, v_Unitario = v_Unit, v_Total = v_To, Orden_Produccion_numero_Orden = no_Orden WHERE Orden_Produccion_numero_Orden = no_Orden;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Proveedor
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_Proveedor`( id_Prov varchar(50), prov varchar(100), ruc varchar(20), dir varchar(100), cor varchar(100), tlf varchar(20), pro text )
BEGIN
UPDATE Proveedor SET proveedor = prov, RUC = ruc, direccion = dir, correo = cor, telefono = tlf, productos = pro WHERE id_Proveedor = id_Prov;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editar_Usuario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`Manufacturas_Arsegin`@`localhost` PROCEDURE `editar_Usuario`( id varchar(15), nom varchar(50), ape varchar(50), cor varchar(100), usu varchar(100), cla varchar(100), rol int )
BEGIN
UPDATE Usuarios SET id_Usuario = id, nombre = nom, apellido = ape, correo = cor, Roles_id_Rol = rol  WHERE  id_Usuario = id;
UPDATE Claves SET usuario = usu, Clave = cla, Usuarios_id_Usuario = id WHERE Usuarios_id_Usuario = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminar_Clientes
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_Clientes`( valor_Cliente varchar(100) )
BEGIN
delete from Cliente where cod_Cliente = valor_Cliente;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminar_Inventario
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_Inventario`( cod varchar(50) )
BEGIN
delete from Inventario where codigo = cod;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminar_Maquila
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_Maquila`( valor_Maquila varchar(100) )
BEGIN
delete from Maquilas WHERE id_Maquila = valor_Maquila;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminar_Proveedor
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_Proveedor`( valor_Proveedor varchar(100) )
BEGIN
delete from Proveedor where id_Proveedor = valor_Proveedor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Codigo_Cliente
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Codigo_Cliente`( )
BEGIN
SELECT MAX(cod_Cliente) FROM Cliente;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Codigo_Maquila
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Codigo_Maquila`( )
BEGIN
SELECT MAX(id_Maquila) FROM Maquilas;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Codigo_Proveedor
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Codigo_Proveedor`( )
BEGIN
SELECT MAX(id_Proveedor) FROM Proveedor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Compra
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Compra`( )
BEGIN
SELECT MAX(id_Compra) FROM Compras;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Cotizacion
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Cotizacion`( )
BEGIN
SELECT MAX( no_Cotizacion ) FROM Cotizacion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Factura
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Factura`( )
BEGIN
SELECT MAX( no_Factura ) FROM Factura;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Orden
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Orden`( )
BEGIN
SELECT MAX( numero_Orden ) FROM Orden_Produccion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure numero_Orden_Compra
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `numero_Orden_Compra`( )
BEGIN
SELECT MAX( id_Orden_Compra ) FROM Orden_Compra;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure recuperacion_Clave
-- -----------------------------------------------------

DELIMITER $$
USE `proyecto_manufacturas_arsegin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `recuperacion_Clave`(IN usu varchar(100), IN cla varchar(100))
BEGIN
SET @s = CONCAT('SET PASSWORD FOR "',usu,'"@"localhost" ="', cla,'"');

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
