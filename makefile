# =========================================================
# Makefile - Fórmula 1 DataWarehouse Pipeline
# =========================================================

# Força o uso do bash no Linux (resolve problema de parênteses)
SHELL := /bin/bash

# Nome do ambiente virtual
VENV := .venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

# Nome do kernel Jupyter
KERNEL_NAME := formula1-env
KERNEL_DISPLAY := Python (F1-DataPipeline)


# ==============================================================

# Cria o ambiente virtual
venv:
	@echo "🔧 Criando ambiente virtual..."
	python3 -m venv $(VENV)
	@echo "✅ Ambiente virtual criado em $(VENV)"

# Instala dependências do projeto
install: venv
	@echo "📦 Instalando dependências..."
	$(PIP) install --upgrade pip
	@if [ -f requirements.txt ]; then $(PIP) install -r requirements.txt; fi
	@echo "✅ Dependências instaladas com sucesso."

# Registra o kernel do Jupyter
kernel: install
	@echo "🧠 Registrando kernel Jupyter..."
	$(PYTHON) -m ipykernel install --user --name=$(KERNEL_NAME) --display-name="$(KERNEL_DISPLAY)"
	@echo '✅ Kernel Jupyter registrado: $(KERNEL_DISPLAY)'

# Abre o Jupyter Notebook usando o ambiente virtual
notebook: kernel
	@echo "🚀 Iniciando Jupyter Notebook..."
	$(VENV)/bin/jupyter notebook

# Atualiza as dependências instaladas
update:
	@echo "⬆️ Atualizando dependências..."
	$(PIP) install --upgrade -r requirements.txt

# Remove ambiente virtual e kernels antigos
clean:
	@echo "🧹 Limpando ambiente..."
	rm -rf $(VENV)
	jupyter kernelspec remove -f $(KERNEL_NAME) || true
	@echo "✅ Ambiente limpo."

# Mostra os comandos disponíveis
help:
	@echo ""
	@echo "==============================="
	@echo "Comandos disponíveis:"
	@echo "==============================="
	@echo " make venv       -> Cria o ambiente virtual (.venv)"
	@echo " make install    -> Instala dependências"
	@echo " make kernel     -> Registra kernel Jupyter"
	@echo " make notebook   -> Abre Jupyter Notebook"
	@echo " make update     -> Atualiza dependências"
	@echo " make clean      -> Remove venv e kernel"
	@echo ""

.PHONY: venv install kernel notebook update clean help
