# Atividade-3
Gestor de Arquivos (.bat)

Este script em Batch (Windows) simula um sistema básico de gerenciamento de arquivos, automatizando a criação de pastas, arquivos, logs e backups.

📋 Funcionalidades

Criação de diretórios

Cria as pastas:

C:\Arquivos da Loja
├── Documentacao
├── Informacoes
└── CopiasSeguranca


Verifica se já existem antes de criar.

Criação de arquivos

Gera 3 arquivos dentro da pasta Documentacao:

vendas_dia.txt

produtos.csv

config.ini

Cada arquivo recebe conteúdo de exemplo usando echo.

Registro de atividades

Todas as ações (criação, backup, falhas, etc.) são registradas em:

C:\Arquivos da Loja\Informacoes\registro_de_tarefas.txt


Cada linha contém a data, hora, operação e resultado.

Simulação de backup

Copia os arquivos de Documentacao para CopiasSeguranca.

Cria o arquivo backup_completo.bak com a data e hora do backup.

Relatório final

Gera o arquivo resumo_execucao.txt com:

RELATÓRIO DE EXECUÇÃO
----------------------
Total de arquivos criados
Total de pastas criadas
Data/Hora do backup

🚀 Como usar

Copie o código para um arquivo chamado GestorArquivos.bat

Execute com duplo clique ou pelo Prompt de Comando (cmd)

O script criará automaticamente todas as pastas, arquivos e logs.

📂 Estrutura final gerada
C:\Arquivos da Loja
│   resumo_execucao.txt
│
├── Documentacao
│   ├── vendas_dia.txt
│   ├── produtos.csv
│   └── config.ini
│
├── Informacoes
│   └── registro_de_tarefas.txt
│
└── CopiasSeguranca
    ├── vendas_dia.txt
    ├── produtos.csv
    ├── config.ini
    └── backup_completo.bak

✍️ Autor

Vitor Bruno
