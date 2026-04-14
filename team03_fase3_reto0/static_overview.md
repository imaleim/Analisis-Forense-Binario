# Static Analysis Overview — team_sample.exe

## 🔹 Descripción general

Se realizó un análisis estático del binario `team_sample.exe` con el objetivo de identificar su estructura, cadenas relevantes, funciones importadas y posible comportamiento sin ejecutar el programa.

El análisis se llevó a cabo utilizando la herramienta Ghidra, permitiendo observar los componentes internos del ejecutable.

---

## 🔹 Extracción de cadenas (Strings)

Se identificaron las siguientes cadenas relevantes dentro del binario:

* "MAGIC: edu-malware-sim"
* "Modo seguro"
* "Modo sospechoso"
* "calc.exe"
* "C:\temp\dummy.txt"

Estas cadenas sugieren que el programa puede ejecutar la calculadora del sistema y crear un archivo en el directorio temporal.

Además, la presencia de mensajes como "Modo seguro" y "Modo sospechoso" indica que el programa contiene lógica condicional que modifica su comportamiento.

---

## 🔹 Extracción de imports

Se identificaron las siguientes funciones importadas relevantes:

* WinExec
* Sleep
* CreateFileA

Estas funciones pertenecen a la API de Windows y permiten:

* Ejecutar programas del sistema (WinExec)
* Introducir pausas en la ejecución (Sleep)
* Crear archivos en el sistema (CreateFileA)

La presencia de estas funciones sugiere que el programa puede realizar acciones típicas de software potencialmente malicioso.

---

## 🔹 Análisis de secciones PE

Se identificaron las siguientes secciones dentro del ejecutable:

* .text: contiene el código ejecutable del programa
* .rdata: almacena datos de solo lectura, como cadenas de texto
* .data: contiene variables globales utilizadas por el programa
* .reloc: sección utilizada para la reubicación en memoria

Estas secciones corresponden a la estructura estándar de archivos ejecutables en formato PE (Portable Executable) en sistemas Windows.

---

## 🔹 Identificación de estructuras

Durante el análisis se observaron datos almacenados en las secciones `.data` y `.rdata`, principalmente cadenas de texto utilizadas por el programa para mostrar mensajes y definir rutas de archivos.

No se identificaron estructuras complejas, pero sí el uso de variables simples que controlan el flujo del programa.

---

## 🔹 Hipótesis del comportamiento

Con base en el análisis realizado, se puede inferir que el programa tiene la capacidad de ejecutar acciones potencialmente sospechosas bajo ciertas condiciones.

El binario contiene referencias a la ejecución de la calculadora (`calc.exe`) y a la creación de un archivo en la ruta `C:\temp\dummy.txt`, lo que indica interacción con el sistema operativo.

Asimismo, se identificaron funciones importadas que permiten ejecutar procesos, pausar la ejecución y manipular archivos.

La presencia de lógica condicional sugiere que el programa puede alternar entre un modo seguro y un modo sospechoso, activando comportamientos similares a los de malware únicamente cuando se cumplen ciertas condiciones internas.

---

## 🔹 Conclusión

El análisis estático permitió identificar características típicas de programas que interactúan con el sistema operativo, incluyendo ejecución de procesos y manipulación de archivos.

Aunque el programa es benigno, simula comportamientos asociados a malware, lo que lo hace adecuado para fines educativos y análisis forense.
