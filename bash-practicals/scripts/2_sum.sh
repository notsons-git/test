#!/bin/bash

read -p "Введите первое число: " first
read -p "Введите второе число: " second

if ! [[ "$first" =~ ^-?[0-9]+$ ]] || ! [[ "$second" =~ ^-?[0-9]+$ ]]; then
    echo "Ошибка: введите целые числа."
    exit 1
fi

echo "Сумма: $((first + second))"
