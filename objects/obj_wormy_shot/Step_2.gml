// Movimiento parabólico
yspd += grav;
x += xspd;
y += yspd;

// Colisión con el suelo o fuera de la room
if x < 0 || x > room_width || y > room_height {
    instance_destroy();
}