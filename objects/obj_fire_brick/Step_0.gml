if dest {destroyBrick()}

if place_meeting(x,y,obj_damage_player){
	dest = true
}


if brickTimer >= Fase1Length && brickTimer <= Fase2Length{
	image_index = 1;
}else if brickTimer >= Fase2Length && brickTimer <= Fase3Length{
	image_index = 2;
	
	
	
}else if brickTimer > Fase3Length {
	destroyBrick();
}

brickTimer++;
