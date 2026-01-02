#!/bin/bash

# 1. Cargar el entorno de la shell e invocar la función externa
source "$HOME/.zshrc" 2>/dev/null
update_curso > /dev/null

# 2. Obtener rutas basadas en el symlink cursoact
MATERIA="${1:-cursoact}"
RUTA_MATERIA=$(readlink -f "$HOME/notas/$MATERIA")
FECHA=$(date +%d%m%y)

NOMBRE_CLASE_BASE="clase_${FECHA}"
NOMBRE_CLASE_FILE="${NOMBRE_CLASE_BASE}.tex"
MASTER="$RUTA_MATERIA/master.tex"

# 3. Preparación de archivos LaTeX (Inyección en master.tex)
if [ -f "$MASTER" ]; then
    if ! grep -q "\\input{$NOMBRE_CLASE_FILE}" "$MASTER"; then

        while IFS= read -r line; do
            if [ "$line" = '\end{document}' ]; then
                echo '\input{'$NOMBRE_CLASE_FILE'}'
            fi
            echo "$line"
        done < "$MASTER" > "$MASTER.tmp" && mv "$MASTER.tmp" "$MASTER"

        touch "$RUTA_MATERIA/$NOMBRE_CLASE_FILE"
    fi
fi

# 4. SESIÓN NOTAS
if ! tmux has-session -t notas 2>/dev/null; then
    tmux new-session -d -s notas -n "clase" -c "$RUTA_MATERIA"
    tmux send-keys -t notas "nvim $NOMBRE_CLASE_FILE" C-m
    
    # Split para compilación
    tmux split-window -v -t notas -c "$RUTA_MATERIA"
    tmux resize-pane -D 10

    # Ejecución de latexmk con Zathura
    tmux send-keys -t notas "latexmk -pdf -pvc -e '\$pdf_previewer = \"zathura %S\"' master.tex" C-m
    
    tmux select-pane -t notas -U
fi

# 8. CONECTAR
tmux attach-session -t notas
