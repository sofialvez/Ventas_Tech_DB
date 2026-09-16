# 🛒 RetailPro - Optimización y Análisis de Datos (Ventas_Tech_DB)

Este repositorio documenta el flujo de trabajo analítico aplicado sobre la base de datos `Ventas_Tech_DB` para **RetailPro**. El proyecto combina consultas SQL optimizadas, análisis transaccional de ventas e integración con IA como copiloto para la documentación técnica.

## 🛠️ Herramientas y Tecnologías
- **Motor de Base de Datos:** T-SQL / SQL Server (compatible con MySQL / PostgreSQL).
- **Procesamiento & Optimización:** SQL, Prompt Engineering (IA como co-piloto).
- **Control de Versiones:** Git & GitHub.

## 📁 Estructura del Repositorio
| Archivo | Descripción |
| :--- | :--- |
| `m4_consultas_negocio.sql` | Análisis mensual, Top 5 productos, clientes recurrentes y métricas de desempeño. |
| `m5_vista_base.sql` | Vista consolidada mediante `INNER JOIN` de 4 tablas (`ventas`, `clientes`, `productos`, `categorias`). |
| `README.md` | Documentación general del proyecto. |

## 🚀 Guía de Ejecución
       
    1. **Clonar el repositorio:**
	git clone https://github.com/sofialvez/Ventas_Tech_DB.git
    2. **Preparar el entorno:** Asegúrate de contar con una instancia activa de SQL Server o el RDBMS de tu preferencia.
    3. **Poblado de datos y Consultas:** Ejecuta en secuencia los scripts SQL cargados en el repositorio para regenerar la vista base y las métricas de negocio.
