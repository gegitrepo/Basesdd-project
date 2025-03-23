# 📌 Modelo de Base de Datos - Mercado Agroecológico  

Este documento describe el modelo de base de datos para la plataforma de conexión entre productores y consumidores urbanos.  

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
