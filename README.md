# Dell G15 Fan Control (Alienware-WMI)

Este projeto permite o controle manual das ventoinhas do Dell G15 no Linux, utilizando a interface `alienware-wmi` do kernel. O script força um perfil de energia equilibrado e aplica um "boost" constante para evitar o superaquecimento.

## 🚀 Como Funciona o Boost

O valor de boost (0-100) define a velocidade adicional das ventoinhas. No Dell G15, a relação aproximada é que **cada 1 unidade de boost equivale a 50 RPM**.

### Tabela de Referência (Boost vs RPM)

| Boost (Valor) | Velocidade Estimada (RPM) |
| ------------- | ------------------------- |
| 0             | 0 (Velocidade base)       |
| 10            | 500 RPM                   |
| 20            | 1000 RPM                  |
| 30            | 1500 RPM                  |
| 40            | 2000 RPM                  |
| 50            | 2500 RPM                  |
| 60            | 3000 RPM                  |
| 70            | 3500 RPM                  |
| 80            | 4000 RPM                  |
| 90            | 4500 RPM                  |
| 100           | 5000 RPM (Máximo)         |

---

## 🛠️ Instalação por Distribuição

O processo é similar em todas as distros, mas aqui estão os comandos específicos para garantir as permissões e dependências.

### 1. Preparação do Script

Primeiro, mova o script para o diretório de binários e dê permissão de execução (ajuste para o caminho onde você baixou o projeto):

```bash
sudo cp dell-fan-control.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/dell-fan-control.sh
```

### 2. Configuração do Systemd (Serviço e Timer)

Mova os arquivos de sistema para o diretório correto:

```bash
sudo cp dell-fan.service /etc/systemd/system/
sudo cp dell-fan.timer /etc/systemd/system/
```

### 3. Habilitação por Distro

#### 🟦 Fedora

No Fedora, o `systemd` já vem configurado por padrão. Certifique-se de que o kernel está atualizado.

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now dell-fan.timer
```

#### 🌀 Arch Linux

No Arch, certifique-se de que o driver `alienware-wmi` está carregado.

```bash
# Para verificar se o driver está ativo
lsmod | grep alienware_wmi

# Habilitar o timer
sudo systemctl daemon-reload
sudo systemctl enable --now dell-fan.timer
```

#### 🍥 Debian / Ubuntu

No Debian, pode ser necessário rodar como root ou usar o `sudo` em todos os comandos de cópia.

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now dell-fan.timer
```

---

## ⚙️ Customização

Para alterar a velocidade das ventoinhas, edite o arquivo original ou o arquivo em `/usr/local/bin/`:

1. Abra o arquivo: `sudo nano /usr/local/bin/dell-fan-control.sh`
2. Altere a variável `BOOST=50` para o valor desejado (ex: `BOOST=80` para 4000 RPM).
3. Salve e saia. O timer aplicará a mudança em no máximo 5 segundos.

## 🔍 Verificação

Para ver se o serviço está rodando e aplicando o boost:

```bash
systemctl status dell-fan.timer
journalctl -u dell-fan.service
```

---

**Nota:** Este projeto utiliza a interface `hwmon` e `platform_profile`. Se o seu modelo não criar os arquivos em `/sys/class/hwmon/hwmon*/fan*_boost`, verifique se o driver `alienware-wmi` é compatível com sua versão de BIOS.
