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

# Obtener nombre del repositorio git y extraer variables
$repoUrl = git remote get-url origin 2>$null
if ($repoUrl) {
    if ($repoUrl -match '/([^/]+?)(\.git)?$') {
            $SCRIPT_REPO_NAME = $matches[1]
            Write-Host "Repositorio detectado: $SCRIPT_REPO_NAME" -ForegroundColor Cyan

            # Extraer usuario de GitHub del repositorio remoto
            if ($repoUrl -match '[:/]([^/]+)/[^/]+\.git$') {
                $SCRIPT_GITHUB_NAME = $matches[1]
                Write-Host "SCRIPT_GITHUB_NAME detectado: $SCRIPT_GITHUB_NAME" -ForegroundColor Cyan
            } else {
                $SCRIPT_GITHUB_NAME = ''
                Write-Host "No se pudo extraer SCRIPT_GITHUB_NAME del repositorio remoto" -ForegroundColor Yellow
            }

            # Separar por guiones
            $repoParts = $SCRIPT_REPO_NAME -split '-'
            # Validar estructura: [project]-[service]-[componente]-[db(optional)]
            if ($repoParts.Length -ge 3) {
                $SCRIPT_PROJECT_NAME = $repoParts[0]
                $SCRIPT_SERVICE_NAME = $repoParts[1]
                $SCRIPT_CONTAINER_NAME = ($repoParts[0..2] -join '-')
                if ($repoParts.Length -ge 4) {
                    $SCRIPT_IMAGE_NAME = ($repoParts[0..3] -join '-')
                } else {
                    $SCRIPT_IMAGE_NAME = $SCRIPT_CONTAINER_NAME
                }
                Write-Host "SCRIPT_PROJECT_NAME: $SCRIPT_PROJECT_NAME" -ForegroundColor Cyan
                Write-Host "SCRIPT_SERVICE_NAME: $SCRIPT_SERVICE_NAME" -ForegroundColor Cyan
                Write-Host "SCRIPT_CONTAINER_NAME: $SCRIPT_CONTAINER_NAME" -ForegroundColor Cyan
                Write-Host "SCRIPT_IMAGE_NAME: $SCRIPT_IMAGE_NAME" -ForegroundColor Cyan
            } else {
                Write-Host "Error: El nombre del repositorio git ('$REPO_NAME') no cumple con la estructura esperada: [project]-[service]-[componente]-[db(optional)]" -ForegroundColor Red
                Write-Host "Por favor, renombra el repositorio git para continuar." -ForegroundColor Yellow
                exit 1
            }
    } else {
        Write-Host "Error: No se pudo extraer el nombre del repositorio de la URL: $repoUrl" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Error: No se encontró URL remota de git (¿es un repo git?)" -ForegroundColor Red
    exit 1
}

# Leer versiones del pom.xml si existe
$pomVariables = @{}
$pomFile = "pom.xml"
if (Test-Path $pomFile) {
    Write-Host "Extrayendo versiones desde $pomFile..." -ForegroundColor Cyan
    $pomContent = Get-Content $pomFile -Raw
    
    # Extraer version de Spring Boot
    if ($pomContent -match '<artifactId>spring-boot-starter-parent</artifactId>\s*<version>([^<]+)</version>') {
        $pomVariables['SCRIPT_SPRING_BOOT_VERSION'] = $matches[1]
        Write-Host "   SCRIPT_SPRING_BOOT_VERSION=$($matches[1])" -ForegroundColor White
    }
    
    # Extraer version de Java
    if ($pomContent -match '<java\.version>([^<]+)</java\.version>') {
        $pomVariables['SCRIPT_JAVA_VERSION'] = $matches[1]
        Write-Host "   SCRIPT_JAVA_VERSION=$($matches[1])" -ForegroundColor White
    }
    
    # Extraer version del proyecto
    if ($pomContent -match '<version>([^<]+)</version>' -and $pomContent -match '<groupId>[^<]+</groupId>\s*<artifactId>[^<]+</artifactId>\s*<version>([^<]+)</version>') {
        $pomVariables['SCRIPT_PROJECT_VERSION'] = $matches[1]
        Write-Host "   SCRIPT_PROJECT_VERSION=$($matches[1])" -ForegroundColor White
    }
}

# Funcion para resolver variables de entorno y pom.xml en valores
function Resolve-EnvVariables {
    param([string]$value)
    
    # Buscar patrones ${VARIABLE_NAME} y reemplazarlos
    while ($value -match '\$\{([^}]+)\}') {
        $varName = $matches[1]
        $varValue = $null

        # Buscar primero en variables definidas en el script
        if (Get-Variable -Name $varName -Scope Script -ErrorAction SilentlyContinue) {
            $varValue = (Get-Variable -Name $varName -Scope Script).Value
            Write-Host "   Resolviendo ${varName} -> $varValue (desde variable definida en script)" -ForegroundColor Yellow
        }
        # Buscar en pom.xml y .env si no se resolvió
        if (-not $varValue) {
            if ($pomVariables.ContainsKey($varName)) {
                $varValue = $pomVariables[$varName]
                Write-Host "   Resolviendo ${varName} -> $varValue (desde pom.xml)" -ForegroundColor Yellow
            } elseif ($envVariables.ContainsKey($varName)) {
                $varValue = $envVariables[$varName]
                Write-Host "   Resolviendo ${varName} -> $varValue (desde .env)" -ForegroundColor Yellow
            }
        }

        if ($varValue) {
            $value = $value -replace [regex]::Escape($matches[0]), $varValue
        } else {
            Write-Host "   Variable no encontrada: $varName" -ForegroundColor Red
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

# Eliminar archivos de configuración y script
Write-Host "Eliminando archivos replacement-rules.json y script-project.ps1..." -ForegroundColor Cyan
Remove-Item -Path "replacement-rules.json" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "script-project.ps1" -Force -ErrorAction SilentlyContinue