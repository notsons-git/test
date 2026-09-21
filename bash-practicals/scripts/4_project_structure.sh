#!/bin/bash

read -p "Введите название проекта [my-project]: " project
project=${project:-my-project}

if [[ ! "$project" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Ошибка: используйте только латинские буквы, цифры, _ или -."
    exit 1
fi

mkdir -p "$project/css" "$project/js"

cat > "$project/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Project</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Hello, world!</h1>
    <script src="js/script.js"></script>
</body>
</html>
EOF

cat > "$project/css/style.css" <<'EOF'
body {
    font-family: Arial, sans-serif;
}
EOF

cat > "$project/js/script.js" <<'EOF'
console.log("Project loaded!");
EOF

echo "Структура проекта создана:"
echo "$project/"
echo "├── index.html"
echo "├── css/"
echo "│   └── style.css"
echo "└── js/"
echo "    └── script.js"
