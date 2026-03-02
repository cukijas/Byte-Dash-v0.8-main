// Inherit the parent event
event_inherited();

damage = 2;
face = 0;

// Velocidades iniciales
grav = 0.2;          // gravedad constante
xspd = 0; 
yspd = -2;           // impulso hacia arriba 

if instance_exists(obj_player) {
    var dx = obj_player.x - x;
    var dy = obj_player.y - y;

    xspd = clamp(dx / 30, -4, 4); // velocidad en X según distancia, limitada
    yspd = -4; // impulso vertical inicial
}
depth = -31