#!/bin/bash

read -p "Введите число: " number

if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
    echo "Ошибка: введите целое число."
    exit 1
fi

if (( number % 2 == 0 )); then
    echo "Число $number — четное."
else
    echo "Число $number — нечетное."
fi
