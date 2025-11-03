@echo off
SETLOCAL EnableDelayedExpansion
CLS
echo Iniciando o Gestor de Arquivos...
echo.

SET DISCO_BASE=C:
SET BASE_DIR=%DISCO_BASE%\GestorArquivos
SET DOCS_DIR=%BASE_DIR%\Documentos
SET LOGS_DIR=%BASE_DIR%\Logs
SET BACKUP_DIR=%BASE_DIR%\Backups
SET LOG_FILE=%LOGS_DIR%\atividade.log

SET /A cont_pastas=0
SET /A cont_arquivos=0

IF NOT EXIST "%BASE_DIR%" ( md "%BASE_DIR%" >nul 2>nul )
IF NOT EXIST "%LOGS_DIR%" ( md "%LOGS_DIR%" >nul 2>nul )

echo [1] Verificando e criando estruturas de pastas...
CALL :logar "Script" "Iniciado"
CALL :criar_pasta "%BASE_DIR%" "Pasta Base"
CALL :criar_pasta "%LOGS_DIR%" "Pasta Logs"
CALL :criar_pasta "%DOCS_DIR%" "Pasta Documentos"
CALL :criar_pasta "%BACKUP_DIR%" "Pasta Backups"

echo [2] Criando arquivos de exemplo...
SET "ARQ1=%DOCS_DIR%\relatorio.txt"
SET "ARQ2=%DOCS_DIR%\dados.csv"
SET "ARQ3=%DOCS_DIR%\config.ini"

(
    echo [RELATORIO DE VENDAS]
    echo Data: %DATE%
    echo Total: 150 unidades
    echo Responsavel: Vitor Bruno
) > "%ARQ1%"
CALL :logar_criacao_arquivo "relatorio.txt" "%ARQ1%"

(
    echo ID,Produto,Valor
    echo 101,Monitor,5500.00
    echo 102,Teclado,150.50
    echo 103,Mouse,89.90
) > "%ARQ2%"
CALL :logar_criacao_arquivo "dados.csv" "%ARQ2%"

(
    echo [Configuracoes]
    echo server=producao.servidor.com
    echo user=batch_user
    echo timeout=30
) > "%ARQ3%"
CALL :logar_criacao_arquivo "config.ini" "%ARQ3%"

echo [3] Simulando backup dos documentos...
SET "DATA_BACKUP=%DATE% %TIME%"

COPY "%DOCS_DIR%\*.*" "%BACKUP_DIR%\" /Y >nul
IF ERRORLEVEL 1 (
    CALL :logar "Backup (Copia de Arquivos)" "Falha"
) ELSE (
    CALL :logar "Backup (Copia de Arquivos)" "Sucesso"
)

SET "BAK_FILE=%BACKUP_DIR%\backup_completo.bak"
echo Backup realizado em: %DATA_BACKUP% > "%BAK_FILE%"
CALL :logar_criacao_arquivo "backup_completo.bak" "%BAK_FILE%"

echo [4] Gerando relatorio final...
SET "RELATORIO_FINAL=%BASE_DIR%\resumo_execucao.txt"

(
    echo RELATÓRIO DE EXECUÇÃO
    echo ----------------------
    echo.
    echo Total de arquivos criados (nesta execucao): !cont_arquivos!
    echo Total de pastas criadas (nesta execucao): !cont_pastas!
    echo.
    echo Data/Hora do backup: %DATA_BACKUP%
) > "%RELATORIO_FINAL%"
CALL :logar_criacao_arquivo "resumo_execucao.txt" "%RELATORIO_FINAL%"

echo.
echo --- Processo Concluido ---
echo Verifique os arquivos em %BASE_DIR%
echo Log de atividades: %LOG_FILE%
echo Relatorio final: %RELATORIO_FINAL%
echo.
PAUSE

ENDLOCAL
GOTO :EOF

:criar_pasta

IF NOT EXIST "%~1" (
    md "%~1"
    IF ERRORLEVEL 1 (
        CALL :logar "Criar %~2" "Falha"
    ) ELSE (
        CALL :logar "Criar %~2" "Sucesso"
        SET /A cont_pastas+=1
    )
) ELSE (
    CALL :logar "Verificar %~2" "Ja existe"
)
GOTO :EOF


:logar_criacao_arquivo

IF EXIST "%~2" (
    CALL :logar "Criar arquivo %~1" "Sucesso"
    SET /A cont_arquivos+=1
) ELSE (
    CALL :logar "Criar arquivo %~1" "Falha"
)
GOTO :EOF


:logar

echo %DATE% %TIME% - %~1 - %~2 >> "%LOG_FILE%"
GOTO :EOF