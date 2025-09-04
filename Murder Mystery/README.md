# 🔎 SQL Crime Investigation Project

## 📌 Descripción
Este proyecto consiste en el **análisis en PostgreSQL de una base de datos ficticia relacionada con investigaciones criminales**.  
El objetivo es aplicar consultas SQL para responder preguntas clave y descubrir patrones entre crímenes, personas, entrevistas e ingresos.

La base de datos incluye las siguientes tablas:
- `crime_scene_report` → reportes de crímenes (fecha, tipo, ciudad).
- `person` → personas con dirección, licencia y SSN.
- `driver_licence` → información de licencias y vehículos.
- `facebook_event_checkin` → registros de asistencia a eventos.
- `get_fit_now_member / check_in` → membresías y registros en gimnasio.
- `income` → ingresos anuales por SSN.
- `interview` → transcripciones de entrevistas.

---

## 🎯 Objetivos del análisis
1. Identificar los **3 eventos con mayor número de asistentes únicos**.
2. Detectar **personas con múltiples licencias de conducir**.
3. Listar a las **personas que viven en la misma calle donde ocurrió un crimen**.
4. Generar un **ranking de ingresos por ciudad** usando funciones de ventana (`RANK()`).
5. Encontrar **entrevistas relacionadas con crímenes**, uniendo entrevistas con reportes.

---

## 🛠️ Técnicas aplicadas
- **JOINS** (`INNER JOIN`, `CROSS JOIN`) para combinar tablas.
- **Agregaciones** (`COUNT(DISTINCT ...)`, `GROUP BY`, `HAVING`).
- **Funciones de ventana** (`RANK() OVER (PARTITION BY ... ORDER BY ...)`).
- **Filtros avanzados con `LIKE`** para coincidencias de direcciones.
- **Normalización de relaciones** (person → license → income).

---

## 📊 Ejemplos de consultas

### 🔹 Ranking de ingresos por ciudad
```sql
SELECT 
    c.city,
    p.name,
    i.annual_income,
    RANK() OVER (
        PARTITION BY c.city
        ORDER BY i.annual_income DESC
    ) AS ranking
FROM person p
JOIN income i ON p.ssn = i.ssn
JOIN crime_scene_report c ON c.city = p.address_street_name
ORDER BY c.city, ranking;
