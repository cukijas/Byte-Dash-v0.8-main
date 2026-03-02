// Solo buscamos al jugador si no está atacando y no congelado
if instance_exists(obj_player) && !isAttacking && !frozen {
    var _player = obj_player;
    var _distX = abs(x - _player.x);
    var _distY = abs(y - _player.y);

    if (_distX <= visionRangeX && _distY >= visionRangeY) {
        if (timerAttack <= 0) {
            // Iniciar ataque
            face = sign(_player.x - x);
            target = _player;
            target_x = _player.x; // guardamos la posición x actual del jugador
            isAttacking = true;
            attackStarted = false;
            sprite_index = sprAttack;
            image_index = 0;
        }
    }
}

// Movimiento del enemigo volador
yspd = 0;
xspd_attack = 0;

// Mientras está atacando
if isAttacking && hp > 0 {
    // Baja verticalmente
    yspd = 2;

    // Mueve hacia el x guardado del jugador
    var dx = target_x - x;
    if (abs(dx) > 1) {
        xspd_attack = clamp(dx * 0.1, -2, 2); // control de velocidad horizontal hacia el jugador
    }

    // Finaliza el ataque cuando bajó lo suficiente
    if (y >= ystart + 50) {
        isAttacking = false;
        timerAttack = attackCooldown;
    }
}
// Si no está atacando, vuelve a subir
else if (!isAttacking && y > ystart) {
    yspd = -2;

    // También puede volver a su posición horizontal original si querés:
    // xspd_attack = clamp(startX - x, -1.5, 1.5); (opcional)
}

// Aplicamos el movimiento calculado
x += xspd_attack;
y += yspd;

// Heredamos lógica del padre (colisiones, animaciones, daño, etc.)
event_inherited();

// Congelamos temporizador de dirección del padre para que no gire durante vuelo
dirTimer = 1000;
