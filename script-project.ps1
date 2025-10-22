# Script para Configurar Proyecto (JSON Simplificado)
# Este script usa un solo archivo JSON con pares "buscar: reemplazar"

param(
    [Parameter(Mandatory=$false)]
    [string]$ConfigFile = "replacement-rules.json"
)

Write-Host "Configurando proyecto usando JSON simplificado..." -ForegroundColor Green
Write-Host "Archivo de configuracion: $ConfigFile" -ForegroundColor Cyan

# Verificar que el archivo JSON exista
if (-not (Test-Path $ConfigFile)) {
    Write-Host "Error: No se encontro el archivo '$ConfigFile'" -ForegroundColor Red
    Write-Host "Crea el archivo con la estructura requerida y ejecuta el script nuevamente." -ForegroundColor Yellow
    exit 1
}

# Leer archivo JSON
try {
    $config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
    Write-Host "Archivo JSON cargado correctamente" -ForegroundColor Green
} catch {
    Write-Host "Error al leer el archivo JSON: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Leer variables de entorno del archivo .env si existe
$envVariables = @{}
$envFile = "docker-compose\.env"
if (Test-Path $envFile) {
    Write-Host "Cargando variables de entorno desde $envFile..." -ForegroundColor Cyan
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^([^#][^=]+)=(.*)$') {
            $envVariables[$matches[1]] = $matches[2]
            Write-Host "   $($matches[1])=$($matches[2])" -ForegroundColor White
        }
    }
}

# Funcion para resolver variables de entorno en valores
function Resolve-EnvVariables {
    param([string]$value)
    
    # Buscar patrones ${VARIABLE_NAME} y reemplazarlos
    while ($value -match '\$\{([^}]+)\}') {
        $varName = $matches[1]
        $varValue = $envVariables[$varName]
        if ($varValue) {
            $value = $value -replace [regex]::Escape($matches[0]), $varValue
            Write-Host "   Resolviendo ${varName} -> $varValue" -ForegroundColor Yellow
        } else {
            Write-Host "   Variable de entorno no encontrada: $varName" -ForegroundColor Red
            break
        }
    }
    return $value
}

# Mostrar configuracion que se aplicara
Write-Host ""
Write-Host "Reemplazos que se aplicaran:" -ForegroundColor Yellow
$config.replacements.PSObject.Properties | ForEach-Object {
    $resolvedValue = Resolve-EnvVariables -value $_.Value
    Write-Host "   '$($_.Name)' -> '$resolvedValue'" -ForegroundColor White
}

# Procesar cada archivo segun las reglas
Write-Host ""
Write-Host "Procesando archivos..." -ForegroundColor Cyan
$filesProcessed = 0
$replacementsMade = 0

foreach ($file in $config.files) {
    if (Test-Path $file) {
        Write-Host "Procesando: $file" -ForegroundColor Cyan
        
        foreach ($replacement in $config.replacements.PSObject.Properties) {
            $searchText = $replacement.Name
            $replaceText = Resolve-EnvVariables -value $replacement.Value
            
            if ($searchText -ne $replaceText) {
                $beforeContent = Get-Content $file -Raw
                $afterContent = $beforeContent -replace [regex]::Escape($searchText), $replaceText
                
                if ($beforeContent -ne $afterContent) {
                    Set-Content $file -Value $afterContent -NoNewline
                    Write-Host "   '$searchText' -> '$replaceText'" -ForegroundColor Green
                    $replacementsMade++
                }
            }
        }
        $filesProcessed++
    } else {
        Write-Host "Archivo no encontrado: $file" -ForegroundColor Yellow
    }
}

# Eliminar seccion de instrucciones del README
if (Test-Path "README.md") {
    Write-Host ""
    Write-Host "Eliminando seccion de instrucciones del README..." -ForegroundColor Cyan
    
    $readmeContent = Get-Content "README.md" -Raw
    
    # Patron para eliminar desde "## 📝 Instrucciones" hasta "---<br>"
    $pattern = '(?s)## 📝 Instrucciones para personalizar esta plantilla.*?---\s*<br>\s*'
    $cleanedContent = $readmeContent -replace $pattern, ''
    
    if ($readmeContent -ne $cleanedContent) {
        Set-Content "README.md" -Value $cleanedContent -NoNewline
        Write-Host "Seccion de instrucciones eliminada del README" -ForegroundColor Green
    } else {
        Write-Host "No se encontro la seccion de instrucciones para eliminar" -ForegroundColor Yellow
    }
}

# Resumen final
Write-Host ""
Write-Host "Configuracion completada!" -ForegroundColor Green
Write-Host "Resumen:" -ForegroundColor Yellow
Write-Host "   Archivos procesados: $filesProcessed" -ForegroundColor White
Write-Host "   Reemplazos realizados: $replacementsMade" -ForegroundColor White

Write-Host ""
Write-Host "Proximos pasos:" -ForegroundColor Yellow
Write-Host "   1. Revisar los archivos modificados" -ForegroundColor White
Write-Host "   2. Ejecutar: docker-compose -f docker-compose/compose.yml up -d" -ForegroundColor White