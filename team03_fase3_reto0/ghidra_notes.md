# Ingeniería inversa con Ghidra — team_sample.exe

## 🔹 Función principal

![main](CAPTURAS/mainunctions.png)

Se identificó la función principal del programa mediante el análisis en Ghidra. Aunque no aparece explícitamente con el nombre `main`, se determinó que esta función contiene la lógica principal del programa debido a la presencia de cadenas relevantes y llamadas a funciones del sistema.

Dentro de esta función se realizan operaciones de impresión de mensajes, evaluación de condiciones y ejecución de funciones de la API de Windows.



---

## 🔹 Flujo de ejecución

![flujo](CAPTURAS/Iflogic.png)

El programa inicia mostrando la cadena "MAGIC: edu-malware-sim".

Posteriormente, se define una variable interna que controla el flujo del programa. Se evalúa una estructura condicional `if`, donde se compara el valor de esta variable.

* Si la condición es verdadera, el programa entra en un modo seguro y muestra el mensaje "Modo seguro".
* Si la condición es falsa, el programa entra en un modo sospechoso y ejecuta varias acciones adicionales.

Este flujo demuestra que el comportamiento del programa depende de una condición interna que determina qué acciones se ejecutan.

---

## 🔹 Llamadas a API relevantes

![api](CAPTURAS/API.png)

Durante el análisis se identificaron varias llamadas a funciones de la API de Windows:

* WinExec → utilizada para ejecutar programas externos (como la calculadora)
* Sleep → introduce una pausa en la ejecución del programa
* CreateFileA → permite la creación de archivos en el sistema

Estas funciones son comúnmente utilizadas por programas que interactúan directamente con el sistema operativo.

---

## 🔹 Reconstrucción de estructura

![variable](CAPTURAS/Variable.png)

Se identificó una variable interna utilizada para controlar el flujo del programa. Esta variable es comparada dentro de una estructura condicional `if`.

Dependiendo de su valor, el programa decide si ejecutar un comportamiento seguro o un comportamiento sospechoso.

Aunque se trata de una estructura simple, demuestra cómo una variable puede controlar completamente la lógica de ejecución del programa.

---

## 🔹 Análisis general

El análisis en Ghidra permitió comprender completamente el comportamiento del binario sin necesidad de ejecutarlo.

Se identificó que el programa simula comportamientos típicos de malware, incluyendo la ejecución de programas externos y la creación de archivos, pero solo bajo ciertas condiciones.

Esto lo convierte en un binario educativo adecuado para prácticas de análisis forense.
