// Si el jugador cae por debajo del límite de la habitación (con un margen de 64 píxeles)
if (y > room_height + 64) {
    respawn_player();
}