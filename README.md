# Análisis Forense de Binario — Fase 3

## Información del equipo

- **Equipo:** Team04  
- **Materia:** Seguridad en Tecnologías de la Información  
- **Proyecto:** Análisis Forense Completo de un Binario  

### Integrantes
- **Alejandra Itzel Ojeda Valdez** — GitHub: imaleim  
- **Joustin Joel Martinez Carranza** — GitHub: Joustin21  
- **Luis Santiago Cantú Niño** — GitHub: sqntii  

---

## Objetivo

Realizar un análisis forense completo de un binario educativo, aplicando técnicas de:

- Análisis estático
- Ingeniería inversa
- Patching
- Debugging dinámico
- Detección con YARA
- Clasificación con CAPA

---

## Descripción del binario

El binario `team_sample.exe` es un programa educativo que simula comportamiento tipo malware.

Dependiendo de una condición interna, puede:

- Ejecutar la calculadora (`calc.exe`)
- Crear un archivo en `C:\temp\dummy.txt`
- Introducir retrasos en la ejecución

---

## Herramientas utilizadas
## 🛠️ Herramientas utilizadas

- Sistema: Máquina virtual con Windows 10  
- Análisis estático: Ghidra  
- Ingeniería inversa / Patching: Cutter / Radare2  
- Debugging: x64dbg  
- Detección: YARA  
- Clasificación: CAPA  
- Compilación: MSVC (C++)
---

