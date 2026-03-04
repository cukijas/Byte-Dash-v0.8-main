if (alarma_activa == true) {
    draw_set_alpha(0.2); // Nivel de transparencia (0.3 está bien para no tapar el juego)
    
    // Hacemos que cambie de color cada 250 milisegundos (un cuarto de segundo)
    // Usamos 'current_time' que avanza solo.
    if (current_time mod 500 < 250) {
        draw_set_color(c_red); // Medio segundo en rojo
    } else {
        draw_set_color(c_blue); // Medio segundo en amarillo
    }
    
    // Dibujamos el rectángulo con el color que haya tocado
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // ¡Muy importante resetear el alpha y color para que los textos se vean blancos y normales!
    draw_set_alpha(1); 
    draw_set_color(c_white);
}

// Asegúrate de que estamos usando la fuente correcta
draw_set_font(fnt_dialog);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Dibujar la "caja de texto" (un rectángulo oscuro de fondo)
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(0, text_y - padding, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1); // Resetear opacidad

// Dibujar el texto actual
draw_set_color(c_white);
var _current_text = dialog_lines[current_line];
draw_text_ext(text_x, text_y, _current_text, -1, max_width); // Permite salto de línea automático