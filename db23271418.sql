-- Crear la base de datos 
CREATE DATABASE IF NOT EXISTS extra2;
USE extra2;

-- Tabla: categorias
CREATE TABLE categorias (
    id_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla: clientes
CREATE TABLE clientes (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(50),
    email VARCHAR(100)
);

-- Tabla: proveedores
CREATE TABLE proveedores (
    id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(50),
    email VARCHAR(100)
);

-- Tabla: unidades
CREATE TABLE unidades (
    id_unidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla: productos
CREATE TABLE productos (
    id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT,
    id_proveedor INT,
    id_unidad INT,
    codigo_barras VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    FOREIGN KEY (id_unidad) REFERENCES unidades(id_unidad)
);

-- Tabla: inventario
CREATE TABLE inventario (
    id_inventario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL UNIQUE,
    cantidad INT NOT NULL,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: empleados
CREATE TABLE empleados (
    id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla: ventas
CREATE TABLE ventas (
    id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabla: detalle_ventas
CREATE TABLE detalle_ventas (
    id_detalle INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: compras
CREATE TABLE compras (
    id_compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    id_categoria INT,
    id_unidad INT,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_unidad) REFERENCES unidades(id_unidad)
);

-- Tabla: detalles_compras
CREATE TABLE detalles_compras (
    id_detalle_compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: pagos
CREATE TABLE pagos (
    id_pago INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    metodo_pago ENUM('efectivo','tarjeta','transferencia') NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);


-- Paso 1: Insertar un empleado (requerido por la tabla usuarios)
INSERT INTO empleados (nombre, cargo, salario)
VALUES ('Marco Antonio', 'Administrador', 10000.00);

-- Paso 2: Obtener el ID del empleado recién insertado
-- (opcional si sabes que es el primer registro y será id_empleado = 1)

-- Paso 3: Insertar el usuario con la contraseña
INSERT INTO usuarios (id_empleado, username, password)
VALUES (1, 'marco', '1234');


-- Primero, asegurémonos de tener los proveedores correctos
TRUNCATE TABLE proveedores;

-- Insertar proveedores con IDs específicos
INSERT INTO proveedores (id_proveedor, nombre, telefono, direccion, email) VALUES 
(1, 'David Distribuciones', '9617237288', 'Av. Reforma 150, CDMX', 'david12@gmail.com'),
(2, 'Emilio Suministros', '9617237299', 'Blvd. López Mateos 200, Guadalajara', 'emizz@gmail.com'),
(3, 'Cristopher Alimentos', '9617237300', 'Av. Constitución 500, Monterrey', 'macal43@gmail.com');

-- Asegurarnos de tener las categorías necesarias
TRUNCATE TABLE categorias;

INSERT INTO categorias (id_categoria, nombre) VALUES 
(1, 'Electrónicos'),
(2, 'Alimentos'),
(3, 'Bebidas'),
(4, 'Limpieza'),
(5, 'Ropa');

-- Asegurarnos de tener las unidades necesarias
TRUNCATE TABLE unidades;

INSERT INTO unidades (id_unidad, nombre) VALUES 
(1, 'Pieza'),
(2, 'Paquete'),
(3, 'Caja'),
(4, 'Litro'),
(5, 'Kilogramo');

-- Insertar productos con referencias correctas
INSERT INTO productos (nombre, precio, stock, id_categoria, id_proveedor, id_unidad, codigo_barras) VALUES
('Coca-Cola 600ml', 18.50, 120, 3, 1, 1, '61218243036'),
('Sabritas Adobadas 45g', 15.00, 200, 2, 2, 2, '91827364554'),
('Bimbo Pan Blanco Grande', 42.00, 50, 2, 3, 3, '92759802354'),
('Fabuloso Lavanda 1L', 28.00, 80, 4, 1, 4, '81624324048'),
('Jarrito Mandarina 500ml', 12.00, 150, 3, 2, 1, '71421283542'),
('Boing Mango 1L', 16.00, 100, 3, 3, 4, '10987654321'),
('Maruchan Camarón', 14.00, 180, 2, 1, 2, '59368534066'),
('Coronita 210ml', 22.00, 90, 3, 2, 1, '2327141820'),
('Aceite Capullo 1L', 45.00, 60, 2, 3, 4, '01426371264'),
('Leche Lala Entera 1L', 26.50, 70, 2, 1, 4, '8362856261'),
('Tostitos Nacho', 20.00, 110, 2, 2, 2, '76291641114'),
('Pepsi 600ml', 16.00, 130, 3, 3, 1, '0479204852'),
('Nescafé Clásico 50g', 42.00, 40, 2, 1, 2, '4812162024'),
('Zote Blanco', 18.00, 85, 4, 2, 3, '51015202530'),
('Gamesa Emperador Chocolate', 15.00, 200, 2, 3, 2, '36912151821'),
('Mazapan De la Rosa', 6.50, 300, 2, 1, 2, '12345678'),
('Salsa Valentina 370ml', 22.00, 75, 2, 2, 1, '0192836470'),
('Choco Milk 250ml', 10.00, 180, 3, 3, 1, '54321678910'),
('Ariel 1kg', 65.00, 45, 4, 1, 3, '102030405060'),
('Pinguinos Marinela', 14.00, 120, 2, 2, 2, '2468101214');

-- Actualizar el inventario
TRUNCATE TABLE inventario;
INSERT INTO inventario (id_producto, cantidad)
SELECT id_producto, stock FROM productos;
