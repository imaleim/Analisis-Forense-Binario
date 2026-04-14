# Informe Final — Análisis Forense de team_sample.exe

## 1. Resumen Ejecutivo

En este proyecto se realizó un análisis forense completo de un binario educativo diseñado para simular comportamientos típicos de malware. 

Se aplicaron técnicas de análisis estático, ingeniería inversa, patching, debugging dinámico y detección mediante YARA y CAPA.

El objetivo principal fue comprender el comportamiento del ejecutable sin ejecutarlo inicialmente, modificar su lógica interna y confirmar su comportamiento en tiempo de ejecución.

Los resultados demuestran que el binario, aunque benigno, es capaz de simular acciones como ejecución de procesos, creación de archivos y evasión básica mediante temporización.

---

## 2. Descripción del binario

El binario `team_sample.exe` fue desarrollado en C++ como un programa educativo que simula comportamientos sospechosos bajo ciertas condiciones.

El programa contiene:

- Una cadena identificadora: `MAGIC: edu-malware-sim`
- Una variable interna (`clave`) que controla el flujo de ejecución
- Dos modos de operación:
  - **Modo seguro**
  - **Modo sospechoso**

En el modo sospechoso, el programa ejecuta:

- `WinExec("calc.exe")` → abre la calculadora
- `Sleep(1500)` → introduce retardo
- `CreateFileA("C:\temp\dummy.txt")` → crea archivo en disco

Esto permite simular comportamiento típico de malware sin representar un riesgo real.

---

## 3. Técnicas aplicadas

### 3.1 Análisis estático

Se analizaron:

- Strings relevantes (indicadores de comportamiento)
- Imports (APIs de Windows)
- Secciones del ejecutable (PE)

Esto permitió inferir el comportamiento sin ejecutar el archivo.

---

### 3.2 Ingeniería inversa

Utilizando **:contentReference[oaicite:0]{index=0}**, se identificó:

- Función principal
- Flujo condicional (`if`)
- Llamadas a APIs críticas

Se reconstruyó la lógica del programa, confirmando que el comportamiento depende de una variable interna.

---

### 3.3 Patching

Con **:contentReference[oaicite:1]{index=1}**, se modificó el flujo del programa:

- Se cambió `jne` por `je`
- Se forzó la ejecución del modo sospechoso

Esto permitió activar manualmente el comportamiento tipo malware.

---

### 3.4 Debugging dinámico

Se utilizó **:contentReference[oaicite:2]{index=2}** para:

- Colocar breakpoints
- Ejecutar paso a paso
- Observar registros y memoria

Se confirmó la ejecución real del código y el uso de APIs del sistema.

---

### 3.5 Detección con YARA y CAPA

Se desarrolló una regla YARA basada en strings únicas del binario.

Además, se utilizó **:contentReference[oaicite:3]{index=3}** para identificar capacidades como:

- Ejecución de procesos
- Creación de archivos
- Evasión por tiempo

---

## 4. Hallazgos clave

- El binario contiene lógica condicional que oculta comportamiento sospechoso
- El comportamiento malicioso puede activarse mediante patching
- Se identificaron APIs típicas de malware:
  - WinExec
  - CreateFileA
  - Sleep
- CAPA clasificó correctamente las capacidades del binario
- YARA permitió detección basada en patrones estáticos

---

## 5. Limitaciones del análisis

- El binario es simple y no incluye técnicas avanzadas de ofuscación
- No se analizaron variantes del mismo ejecutable
- El análisis dinámico fue realizado en un entorno controlado (máquina virtual)
- No se incluyó tráfico de red ni persistencia

---

## 6. Conclusiones

El proyecto permitió aplicar de manera práctica un flujo completo de análisis de malware.

Se logró:

- Comprender el comportamiento de un binario sin ejecutarlo
- Modificar su lógica interna mediante patching
- Confirmar su ejecución mediante debugging
- Detectarlo utilizando herramientas automatizadas

Este tipo de ejercicios es fundamental para desarrollar habilidades en análisis forense y ciberseguridad ofensiva y defensiva.

El binario analizado cumple su propósito educativo al simular técnicas comunes utilizadas por malware real.