### [Вернуться на Главную](/README.md)

# Docker

Технические термины:

- **Хост** - основная операционная система, в которая установлена на вашем компьютере

- **Контейнер** - изолированное программное пространство (**Sandbox**, песочница), в котором можно создавать особое программное окружение для работы приложений. Благодаря изоляции нет конфликтов между приложениями (если приложения не сетевые - в них могут быть конфликты из-за портов). Docker-контейнеры <u>эфемерны</u> (скоропреходящие, непрочные, мимолётные, временные), поэтому для сохранения данных, конфигураций и файлов проекта необходимо использовать именованные тома (named volumes) или bind mounts. Контейнер представляет собой подобие виртуальной машины. В основном в контейнерах работают различные операционные системы на базе Linux. Но Windows тоже можно установить в Docker-контейнер (WinBoat). Контейнеры слабо взаимодействуют в хостом (можно управлять уровнем изоляции - в ручную предоставлять доступ к различным опциям хоста).

- **Виртуальная машина** - это программная среда, которая эмулирует работу полноценного компьютера: у неё есть свой процессор, оперативная память, диск, сетевая карта и т. д. Внутри ВМ можно установить операционную систему (например, Linux в Windows или наоборот) и запускать приложения так, будто они работают на реальном железе.

- **Гостевая ОС, гость** - операционная система, установленная в контейнер или виртуальная машина

## Получить Docker

### Структура документа

- **Windows**

    - Включить подситему **Windows для Linux** (WSL 2.0).

    - [Загрузить и установить **Docker-Desktop**](https://www.docker.com/products/docker-desktop/) или в **PowerShell** - `winget install Docker.DockerDesktop`

    - Выполнять авторизацию в **Docker-Desktop** (можно через Google), указать personal или *Skip*;

    - Перезагрузить компьютер;

    - Запустить **Docker Desktop** (можно добавить в автозагрузку для удобства);

    - Перезапустить систему

- **MacOS**

    - Установка **Docker Desktop** через **Homebrew**

    - **Homebrew** (очень рекомендуется для macOS), вы можете установить Docker Desktop с помощью одной команды:

    ```shell

    brew install --cask docker

    ```

    - Убедитесь, что **Homebrew** установлен: Если нет, установите его.

    Выполните команду в Терминале:

    ```shell

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    ```

    - Запустите Docker: После установки запустите приложение **Docker Desktop** из папки "Приложения".
> Важно: Docker Desktop использует виртуализацию и требует, чтобы на вашем **Mac** был включен фреймворк **HyperKit**. Приложение автоматически настраивает все необходимые компоненты.

- **Linux**

    - [Требования к обородуванию и ОС](https://docs.docker.com/desktop/setup/install/linux/)

    - **Ubuntu**

        - `sudo apt update sudo apt install ca-certificates curl gnupg lsb-release -y`

        - `sudo mkdir -p /etc/apt/keyrings curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`

        - `echo \ "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`

        - `sudo apt update sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y`

        - `sudo systemctl status docker`

        - `sudo docker run hello-world`

        - `reboot`

    - **Alt Linux 11**

        - `su-`

        - `apt-get install docker-engine docker-compose`

        - `usermod ИМЯ_ПОЛЬЗОВАТЕЛЯ -aG docker`

        - `systemctl enable --now docker`

        - `reboot`

> Важно перезагрузить компьютер после включения WSL 2.0 и установки Docker!

### Быстрый старт

Начало работы

Проверить Docker:

```shell

docker --version

```

или подробно:

```shell

docker version

```

- **Docker образ** и **Docker image** - это файл, типа .iso, образ, который содержит всё необходимое для создания контейнера с нужной средой: ОС, код, библиотеки, зависимости, системные иснтрументы и конфигурации. Образ неизменяем. Если надо что-то поменять, то приходится создавать новый образ из старого. Из Docker-образа создаются Docker-контейнеры

- **Docker контейнер** - это изолированный процесс, который создаётся из Docker образа. В нём можно свободно создавать, запускать, останавливать и удалять контейнеры. Каждый контейнер изолирован от других и от хоста (основной системы). Контейнер подобен виртуальной машине. Внутри каждого контейнера кипит своя жизнь.

Примеры установки и управления контейнерами

#### Hello-world

Установить и запустить тестовый **Docker-контейнер**

```shell

docker run hello-world

```

> Эта команда загрузит образ, установит его, создаст и запустит контейнер и сразу остановит.

#### Управление контейнером и образом, базовые команды

Показать запущенные контейнеры:

```shell

docker ps

```

Покзать все контейнеры, включая остановленные:

```shell

docker ps -a

```

Подробная информация о контейнере

```shell

docker inspect hello-world

```

Показать все имеющиеся Docker-образы

```shell

docker images

```

Показать детальную информацию по выбранному образу

```shell

docker image inspect hello-world

```

Командой `docker ps` получить id или имя контейнера, затем удалить указанный контейнер

```shell

docker rm 6f72bfc0ed02

```

Получить сводку по диску Docker

```shell

docker system df

```

Получить сводку по всем томам

```shell

docker volume ls

```

```shell

# Список томов с размером

docker system df -v

```

Очистить все ненужные тома

```shell

docker volume prune -a

```

и для кэша всех сборок

```shell

docker builder prune

```

> Удаление контейнера не приводит к удалению Docker образа!

Удалить выбранный образ:

- Сначала остановить удаляемый контейнер

  - `docker stop` или `docker compose down`

- Определить имя Docker образа:

```shell

docker images

```

- Удалить:

```shell

docker rmi hello-world

```

#### Установка и запуск из готового образа Welcome to Docker

Загрузить образ, создать и запустить контейнер

```shell

docker run -d -p 8088:80 --name welcome-to-docker docker/welcome-to-docker

```

- `-d` - запуск в фоном режиме

- `-p` - проброс порта

- `--name` - понятное имя контейнера

Если нужно только получить готовый образ, без создания и запуска контейнера, то

```shell

docker pull welcome-to-docker

```

Получить состояние созданного и запущенного контейнера:

```shell

docker ps -a

```

Получить информацию по загруженному образу:

```shell

docker inspect welcome-to-docker

```

Проверить защенный конейнер **Nginx**

```shell
http://localhost:8088

```

Зайти в контейнер

```shell

docker exec -it welcome-to-docker /bin/sh

```

или

```shell

MSYS_NO_PATHCONV=1 docker exec -it welcome-to-docker /bin/sh

```

Повыполнять разные команды:

Показать ин-фу по ОС

```shell

uname -a

```

```shell

cat /etc/os-release

```

Диспетчер ресурсов

```shell

top

```

```shell

tree

```

Обновить источники приложений

```shell

apk update && apk upgrade

```

Установить приложение

```shell

apk add fastfetch

```

Запустить приложение

```shell

fastfetch

```

Выйти из контейнера

```shell

exit

```

### Ссылки

- [Docker Reminder](https://www.altlinux.org/Docker_Reminder)

Docker Desktop: The #1 Containerization Tool for Developers | Docker
Docker Desktop is collaborative containerization software for developers. Get started and download Docker Desktop today on Mac, Windows, or Linux.
