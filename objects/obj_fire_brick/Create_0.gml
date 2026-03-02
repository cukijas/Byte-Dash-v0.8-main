// Inherit the parent event
event_inherited();

damage = 2;
Fase1Length = 60;
Fase2Length = 120;
Fase3Length = 180;

brickTimer = 0;
dest = false;

fire = instance_create_depth(x,bbox_bottom,depth-1,obj_fire);


function destroyBrick() {
	instance_destroy(fire);
	instance_destroy();
}
