
// Variables de posición y separación
var sep = 48;
var margen_x = 24;
var margen_y = 24;

var maxCorazones = jugador.vidas_max;

// Primero confirmamos que el jugador existe
var p = instance_find(obj_player, 0);
if (instance_exists(p)) {
    
    // Dibujar corazones con efecto de titileo en el corazón que se acaba de perder
    for (var i = 0; i < maxCorazones; i++) {
        var dibujar = true;

        // Corazón que se acaba de perder → titila
        if (i == p.vidas && p.parpadeoTimer > 0) {
            // Hace que parpadee con módulo para alternar dibujado
            if (p.parpadeoTimer mod 12 < 6) {
                dibujar = false; // No dibujar en este frame para el titileo
            }
        }

        // Dibujar corazón lleno o vacío
       if (i < p.vidas) {
    if (dibujar) {
        draw_sprite(spr_corazon_lleno, 0, margen_x + i * sep, margen_y);
    }
} else {
    // Solo dibujar vacío si no es el que está titilando
    if (!(i == p.vidas && p.parpadeoTimer > 0 && !dibujar)) {
        draw_sprite(spr_corazon_vacio, 0, margen_x + i * sep, margen_y);
    }
}
    // reseteo el alpha por si se dibuja algo con transparencia (por las dudas)
    draw_set_alpha(1);
}
}