#!/bin/bash

password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)

if [ "${#password}" -ne 8 ]; then
    echo "Ошибка: не удалось сгенерировать пароль."
    exit 1
fi

echo "Случайный пароль: $password"
