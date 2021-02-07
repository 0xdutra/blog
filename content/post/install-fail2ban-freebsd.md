---
author: Gabriel Dutra
title: Utilizando o fail2ban para bloquear brute-forte no SSH (FreeBSD)
date: "2021-01-24"
tags: [
    "FreeBSD"
]
categories: [
    "Security"
]

archives: "01/2021"
---

Como instalar e configurar o fail2ban no FreeBSD.
<!--more-->

## Instalando o fail2ban

No FreeBSD, você pode instalar os pacotes via pkg ou compilando o port.

Via pkg, use: 

```bash
pkg install py37-fail2ban-0.11.2
```

Ou compile o ports: 

```bash
cd /usr/ports/security/py-fail2ban/ && make install clean
```

OBS: Caso opte por compilar, certifique-se que você já tenha baixo a arvore de ports, caso ainda não tenha, use os seguintes comandos: `portsnap fetch && portsnap extract`.

## Criando jail no fail2ban

Agora é necessário criarmos uma jail no fail2ban para "monitorar" o SSH.

```bash
vim /usr/local/etc/fail2ban/jail.d/ssh.local
```

Adicione o conteúdo abaixo

```bash
[ssh]

enabled = true
filter = sshd
action = ipfw[name=SSH, port=ssh, protocol=tcp]
logpath = /var/log/auth.log
findtime = 600
maxretry = 10
bantime = -1
```

Note que o bantime está setado para `-1`, isso significa que os IPS ficarão banidos
para sempre.

## Iniciando e habilitando o fail2ban no boot do sistema

```bash
service fail2ban start
```

```bash
sysrc fail2ban_enable="YES"
```

## Comandos uteis

Para listar as jails configuradas utilize o comando: 

```bash<!-- more -->

Caso deseja verificar os IP's que estão bloqueados, basta adiciona o nome da jail no comando status 

```bash
fail2ban-client status ssh
```
