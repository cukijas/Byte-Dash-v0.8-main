global.dialogo_activo = true;
alarma_activa=false;
// 1. Configuraciones visuales básicas
padding = 20; // Espacio de borde
text_x = padding;
text_y = display_get_gui_height() - 150; // Posición de la caja de texto (abajo)
max_width = display_get_gui_width() - (padding * 2);

// 2. Definir la lista de oraciones (usando una "array")
dialog_lines = [
    "Troj (Glitcheando): ¡Insolente... código de limpieza...! Has purgado mis nodos superficiales, pero el Core... el Core ya nos pertenece.",
    "A.V.A.: Tu corrupción termina aquí, Troj. He aislado tu proceso. Solo eres un desecho de memoria esperando ser sobrescrito.",
    "Troj: ¿Aislado? Pobre programa... Solo has visto las ramas. La raíz es profunda y *ya está* infectada. Mi derrota... es la clave de activación.",
    "Troj: Disfruta tu victoria efímera, A.V.A. Cuando el Mainframe despierte... entenderás que no eres un antivirus. Eres un síntoma.",
    "(Troj se disuelve por completo en una cascada de código binario corrupto)",
    "A.V.A.: Proceso Troj neutralizado... Amenaza de red... nivel 2. Necesito más permisos de root."
];

current_line = 0; // Índice de la línea actual que estamos leyendo