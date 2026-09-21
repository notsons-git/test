#!/bin/bash

# GitHub Repository Analyzer
# Usage: ./8_github_stats.sh tensorflow/tensorflow

RESET='\033[0m'
YELLOW='\033[33m'
GREEN='\033[32m'
RED='\033[31m'

if ! command -v curl >/dev/null 2>&1; then
    echo "Ошибка: команда curl не установлена."
    echo "Установите её: sudo apt update && sudo apt install curl"
    exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
    echo "Ошибка: команда jq не установлена."
    echo "Установите её: sudo apt update && sudo apt install jq"
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "Использование: $0 owner/repository"
    echo "Пример: $0 tensorflow/tensorflow"
    exit 1
fi

repo="$1"

if [[ ! "$repo" =~ ^[^/]+/[^/]+$ ]]; then
    echo "Ошибка: укажите репозиторий в формате owner/repository."
    exit 1
fi

url="https://api.github.com/repos/$repo"

response=$(curl -sS -L \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -w '\n%{http_code}' \
    "$url")

curl_status=$?

if [ "$curl_status" -ne 0 ]; then
    echo "Ошибка: не удалось подключиться к GitHub API."
    exit 1
fi

http_code=$(echo "$response" | tail -n 1)
json=$(echo "$response" | sed '$d')

if [ "$http_code" -eq 404 ]; then
    echo "Ошибка: репозиторий '$repo' не найден."
    exit 1
fi

if [ "$http_code" -eq 403 ] || [ "$http_code" -eq 429 ]; then
    echo "Ошибка: GitHub API отклонил запрос. Возможно, превышен лимит запросов."
    exit 1
fi

if [ "$http_code" -lt 200 ] || [ "$http_code" -ge 300 ]; then
    message=$(echo "$json" | jq -r '.message // "Неизвестная ошибка API"')
    echo "Ошибка GitHub API ($http_code): $message"
    exit 1
fi

if ! echo "$json" | jq empty >/dev/null 2>&1; then
    echo "Ошибка: GitHub API вернул некорректный JSON."
    exit 1
fi

name=$(echo "$json" | jq -r '.full_name // "Неизвестно"')
stars=$(echo "$json" | jq -r '.stargazers_count // 0')
forks=$(echo "$json" | jq -r '.forks_count // 0')
issues=$(echo "$json" | jq -r '.open_issues_count // 0')
owner=$(echo "$json" | jq -r '.owner.login // "Неизвестно"')
updated=$(echo "$json" | jq -r '.updated_at // "Неизвестно"')

if [ "$issues" -gt 100 ]; then
    issues_color="$RED"
else
    issues_color="$YELLOW"
fi

echo
echo "╔════════════════════════════════════════════╗"
echo "║      🚀 GitHub Repository Analyzer         ║"
echo "╚════════════════════════════════════════════╝"
echo
echo "📦 Репозиторий: $name"
printf "${YELLOW}⭐ Звёзды:       %s${RESET}\n" "$stars"
printf "${GREEN}🔀 Форки:        %s${RESET}\n" "$forks"
printf "${issues_color}🐛 Open Issues:  %s${RESET}\n" "$issues"
echo "👤 Автор:        $owner"
echo "🕒 Обновлён:     $updated"
echo
