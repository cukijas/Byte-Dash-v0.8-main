event_inherited();

// Definición de variables
damage = 2;
Fase1Length = 60;
Fase2Length = 120;
Fase3Length = 120;
Fase4Length = 120;
Fase5Length = 120;

brickTimer = 0;
dest = false;

// Crear el fuego
fire = instance_create_depth(x, bbox_bottom, depth - 1, obj_fire);

// Definir la función de destrucción
function destroyBrick() {
    instance_destroy(fire);
    instance_destroy();
}