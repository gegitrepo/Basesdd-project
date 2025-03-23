# 📌 Modelo de Base de Datos - Mercado Agroecológico  

Este documento describe el modelo de base de datos para la plataforma de conexión entre productores y consumidores urbanos.  

## El modelo de base de datos propuesto para el sistema de mercados agroecológicos conecta productores rurales con consumidores urbanos mediante una estructura optimizada en PostgreSQL. La entidad Productor almacena información de los agricultores, incluyendo datos de contacto cifrados y certificaciones en un campo JSONB para mayor flexibilidad. La entidad Producto representa los bienes comercializados, relacionándose con Productor en una relación uno a muchos (1:N) e incluyendo atributos como descripción indexada para Full-Text Search y disponibilidad estacional en JSONB. Los consumidores pueden generar Pedidos, los cuales están vinculados a un Cliente y a un Productor, asegurando trazabilidad en la compra. La entidad Detalle_Pedido establece la relación muchos a muchos (N:M) entre Pedido y Producto, permitiendo registrar múltiples artículos en una orden. Además, tanto Productor como Cliente incluyen un campo de ubicación en formato PostGIS POINT para futuras optimizaciones geoespaciales. Este diseño garantiza escalabilidad, flexibilidad en la gestión de datos semi-estructurados y eficiencia en las búsquedas y consultas espaciales.

## 📊 Diagrama ER  

```mermaid
erDiagram
    PRODUCTOR {
        int id_productor PK
        string nombre
        string telefono
        string email
        point ubicacion
        json certificaciones
    }
    
    PRODUCTO {
        int id_producto PK
        string nombre
        string descripcion
        string tipo
        numeric precio
        json disponibilidad
        int id_productor FK
    }
    
    PEDIDO {
        int id_pedido PK
        int id_cliente FK
        int id_productor FK
        string estado
        string codigo_seguimiento
        timestamp fecha_pedido
    }
    
    DETALLE_PEDIDO {
        int id_detalle PK
        int id_pedido FK
        int id_producto FK
        int cantidad
        numeric subtotal
    }
    
    CLIENTE {
        int id_cliente PK
        string nombre
        string telefono
        string email
        point ubicacion
    }
    
    PRODUCTOR ||--o{ PRODUCTO : "produce"
    CLIENTE ||--o{ PEDIDO : "realiza"
    PRODUCTOR ||--o{ PEDIDO : "recibe"
    PEDIDO ||--o{ DETALLE_PEDIDO : "contiene"
    PRODUCTO ||--o{ DETALLE_PEDIDO : "forma parte de"
