--Archivo DDL
-- Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Tabla de Productores
CREATE TABLE Productor (
    id_productor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono TEXT NOT NULL,
    email TEXT NOT NULL,
    ubicacion GEOMETRY(POINT, 4326) NOT NULL, -- Coordenadas con PostGIS
    certificaciones JSONB, -- Atributos flexibles
    telefono_encrypted BYTEA GENERATED ALWAYS AS (pgp_sym_encrypt(telefono, 'my_secret_key')) STORED,
    email_encrypted BYTEA GENERATED ALWAYS AS (pgp_sym_encrypt(email, 'my_secret_key')) STORED
);

-- Tabla de Clientes
CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono TEXT NOT NULL,
    email TEXT NOT NULL,
    ubicacion GEOMETRY(POINT, 4326) NOT NULL,
    telefono_encrypted BYTEA GENERATED ALWAYS AS (pgp_sym_encrypt(telefono, 'my_secret_key')) STORED,
    email_encrypted BYTEA GENERATED ALWAYS AS (pgp_sym_encrypt(email, 'my_secret_key')) STORED
);

-- Tabla de Productos
CREATE TABLE Producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
    disponibilidad JSONB, -- Información sobre temporadas y cantidades
    id_productor INT NOT NULL,
    FOREIGN KEY (id_productor) REFERENCES Productor(id_productor) ON DELETE CASCADE
);

-- Índice para búsquedas avanzadas en Producto (Full-Text Search)
CREATE INDEX idx_producto_descripcion ON Producto USING GIN (to_tsvector('spanish', descripcion));

-- Tabla de Pedidos
CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_productor INT NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('pendiente', 'enviado', 'entregado')),
    codigo_seguimiento TEXT UNIQUE NOT NULL DEFAULT md5(random()::text),
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_productor) REFERENCES Productor(id_productor) ON DELETE CASCADE
);

-- Tabla de Detalle de Pedido (relación N:M entre Pedido y Producto)
CREATE TABLE Detalle_Pedido (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    subtotal NUMERIC(10,2) NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto) ON DELETE CASCADE
);

-- Índices para mejorar rendimiento en consultas espaciales
CREATE INDEX idx_productor_ubicacion ON Productor USING GIST (ubicacion);
CREATE INDEX idx_cliente_ubicacion ON Cliente USING GIST (ubicacion);

-- Índice para optimizar búsquedas en pedidos por estado
CREATE INDEX idx_pedido_estado ON Pedido (estado);
