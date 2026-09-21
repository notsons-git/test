#!/bin/bash

read -p "Введите расширение файла (например, txt): " extension

extension="${extension#.}"

if [ -z "$extension" ]; then
    echo "Ошибка: расширение не указано."
    exit 1
fi

echo "Файлы с расширением .$extension в текущей директории:"

found=0
while IFS= read -r -d '' file; do
    echo "./${file#./}"
    found=1
done < <(find . -maxdepth 1 -type f -iname "*.${extension}" -print0)

if [ "$found" -eq 0 ]; then
    echo "Файлы не найдены."
fi
