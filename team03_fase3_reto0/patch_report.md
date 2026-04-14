# Patch Report - team_sample.exe

## Descripción del objetivo

El objetivo de esta fase fue modificar el comportamiento del binario para forzar la ejecución del bloque "sospechoso", simulando una técnica básica de patching utilizada en análisis de malware.

---

## Análisis del flujo condicional

Durante el análisis en Cutter, se identificó la siguiente instrucción:


0x004010fa cmp dword [var_8h], 5
0x004010fe jne 0x401121


Esta condición controla el flujo del programa:

- Si el valor es diferente de 5 → se ejecuta el bloque sospechoso
- Si es igual a 5 → se ejecuta el modo seguro

---

## Modificación realizada

Se modificó la instrucción:


jne 0x401121


por:


je 0x401121


Esto invierte la lógica del programa, provocando que cuando el valor sea 5 (caso actual), se ejecute el bloque sospechoso.

---

## Herramienta utilizada

- Cutter (interfaz gráfica de Radare2)

---

## Procedimiento

1. Se cargó el binario en Cutter en modo escritura (-w)
2. Se localizó la cadena "Modo sospechoso"
3. Se accedió a sus referencias (Xrefs)
4. Se identificó el bloque de código asociado
5. Se localizó la instrucción condicional
6. Se modificó el salto de `jne` a `je`
7. Se guardó el binario parcheado como `team_sample_patched.exe`

---

## Comparación de comportamiento

### Binario original

Salida:

MAGIC: edu-malware-sim
Modo seguro


Comportamiento:
- No ejecuta acciones sospechosas
- No abre la calculadora
- No crea archivos

---

### Binario parcheado

Salida:

MAGIC: edu-malware-sim
Modo sospechoso


Comportamiento:
- Ejecuta WinExec → abre la calculadora
- Ejecuta Sleep
- Ejecuta CreateFileA → crea archivo en C:\temp\dummy.txt

---

## Observaciones

Inicialmente, el archivo no se generaba debido a que la ruta `C:\temp` no existía. 
Después de crear manualmente la carpeta, el binario ejecutó correctamente la acción de escritura.

---

## Conclusión

El patching permitió alterar el flujo lógico del programa, forzando la ejecución de funcionalidades simuladas de malware. 
Este tipo de técnica es común en análisis de software malicioso para activar código oculto o modificar comportamientos.
