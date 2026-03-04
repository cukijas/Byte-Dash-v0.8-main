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