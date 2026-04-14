# Detection Summary — team_sample_parched.exe

## Información del binario

| Campo      | Valor |
|------------|-------|
| Nombre     | team_sample_parched.exe |
| Tipo       | PE32 ejecutable (consola) Intel 80386, Windows |
| Secciones  | .text, .rdata, .data, .reloc |
| SHA-256    | f2d53b2d30ff32edb6ad3677b803c309c412266463343ce6bd5f90ec92ab7ba1 |

---

## 1. Detección con YARA

**Archivo:** `team_rule.yar`

La regla fue diseñada con base en las strings únicas y APIs importadas extraídas del binario mediante análisis estático.

### Strings detectadas

| Variable | Valor | Relevancia |
|----------|-------|------------|
| `$magic`   | `MAGIC: edu-malware-sim` | Identificador único del binario |
| `$calc`    | `calc.exe`              | Proceso externo lanzado |
| `$path`    | `C:\temp\dummy.txt`     | Archivo creado en disco |
| `$winexec` | `WinExec`               | API de ejecución de procesos |
| `$create`  | `CreateFileA`           | API de creación de archivos |
| `$sospech` | `Modo sospechoso`       | Cadena de comportamiento anómalo |

### Condición de la regla

- Verifica el header MZ (`uint16(0) == 0x5A4D`) para confirmar que es un PE válido.
- Limita el tamaño a menos de 500 KB (el binario es pequeño, simulado).
- Requiere al menos **3 de 6 strings** para generar match, tolerando ofuscación parcial.

### Resultado

```
yara team_rule.yar team_sample_parched.exe
→ team_sample_parched_detector  team_sample_parched.exe   ✅ MATCH
```

---

## 2. Detección con CAPA

**Archivo:** `capa_report.txt`

CAPA analiza el binario y mapea sus capacidades a técnicas del framework MITRE ATT&CK.

### Capacidades detectadas

| Capacidad | API involucrada | Técnica MITRE ATT&CK |
|-----------|-----------------|----------------------|
| Ejecutar proceso externo | `WinExec("calc.exe")` | T1059 — Command and Scripting Interpreter |
| Crear archivo en disco | `CreateFileA("C:\temp\dummy.txt")` | T1565 — Data Manipulation |
| Evasión por tiempo (sandbox evasion) | `Sleep(1500)` | T1497.003 — Time Based Evasion |
| Uso de binario legítimo del sistema (LOLBin) | `calc.exe` vía WinExec | T1218 — System Binary Proxy Execution |

### Comando ejecutado

```bash
capa team_sample_parched.exe > capa_report.txt
```

---

## 3. Análisis del flujo malicioso

El binario fue compilado con una variable `clave = 5`. En la versión original (`team_sample.exe`), la condición `if (clave == 5)` activa el flujo seguro. En la versión parcheada (`team_sample_parched.exe`), esta condición fue invertida mediante un patch de byte en el opcode de salto condicional (`JE` → `JNE`), activando el flujo sospechoso:

```
[Inicio]
    │
    ▼
clave == 5?  ← condición parchada (ahora evalúa FALSE)
    │
    └─ FALSE ──► "Modo sospechoso"
                    ├─ WinExec("calc.exe")       ← T1059 / T1218
                    ├─ Sleep(1500)               ← T1497
                    └─ CreateFileA(dummy.txt)    ← T1565
```

---

## 4. Conclusión

El binario `team_sample_parched.exe` simula un malware educativo que, al ser parcheado, activa un flujo de comportamiento malicioso. Las técnicas detectadas incluyen ejecución de procesos, creación de archivos y evasión por tiempo, todas mapeadas a MITRE ATT&CK.

La regla YARA creada detecta el binario de forma confiable mediante sus strings únicas y la presencia del header PE, sin requerir ejecución del archivo.
