#!/bin/bash

read -p "Введите ваше имя: " name

if [ -z "$name" ]; then
    echo "Вы не ввели имя."
    exit 1
fi

echo "Привет, $name!"
