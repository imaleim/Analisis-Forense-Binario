rule team_sample_parched_detector {
    meta:
        author      = "Team 03"
        description = "Detecta el binario edu-malware-sim team_sample_parched.exe"
        date        = "2025"
        hash        = "f2d53b2d30ff32edb6ad3677b803c309c412266463343ce6bd5f90ec92ab7ba1"

    strings:
        $magic   = "MAGIC: edu-malware-sim" ascii
        $calc    = "calc.exe" ascii
        $path    = "C:\\temp\\dummy.txt" ascii
        $winexec = "WinExec" ascii
        $create  = "CreateFileA" ascii
        $sospech = "Modo sospechoso" ascii

    condition:
        uint16(0) == 0x5A4D and
        filesize < 500KB and
        3 of ($magic, $calc, $path, $winexec, $create, $sospech)
}
