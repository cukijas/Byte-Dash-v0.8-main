if sprite_index == sprDeath {
	var _lastFramo = sprite_get_number(sprite_index) -1;
	
	if   _lastFramo <= image_index {
		instance_destroy();
	}
	exit;
};


// Recibe daño


if place_meeting(x,y, obj_damage_enemy) || place_meeting(x,y, obj_fire_brick){
	var _array = array_create(0);
	array_push(_array,obj_fire_brick,obj_damage_enemy)
	var _instance = instance_place(x,y,_array);
	//restamos vida
	if (damageTimer <= 0){
		hp -=_instance.damage;
		damageTimer = damageCooldown;
		damager = _instance;
		if damager.x >= x {dirAtack = -1}else{dirAtack = 1};
		
	}
	
	
}else{
	damager = noone;
};


if damageTimer > 0 {
	damageTimer--;
	if damageTimer%8 {image_blend = c_red}else{image_blend=c_white};
	xspd = 2 * dirAtack;
}else {
	image_blend=c_white;

};


//Colisiones en X
var _subPixel = 0.5;
if place_meeting(x + xspd, y, obj_wall){
	var _pixelCheck = _subPixel * sign(xspd);	
	while(!place_meeting(x+_pixelCheck,y,obj_wall)){x += _pixelCheck;};
	//colision
	face *= -1;
	xspd = 0;
}

//Movimiento en X
if damageTimer <= 0 && !isAttacking {
	if x <= maxLeftMov {face = 1;}
	if x >= maxRightMov {face = -1;}
	
	if (dirTimer<=0){
		
		if waitTimer > 0{
			waitTimer--;
			xspd = 0;
		}else{
			face = choose(1,-1);
			dirTimer = 30;
			waitTimer = 15;
		}
	}else{
		dirTimer--;
		xspd = spd*face;
	}
}
x += xspd;




if instance_exists(obj_player) && objAttack != noone {
	var _player = obj_player;
	
	var _distX = abs(x-_player.x);
	var _distY = abs(y-_player.y);
	
	if (_distX <= visionRangeX && _distY <= visionRangeY) {
        

        // Disparar si pasó suficiente tiempo
        if (timerAttack <= 0 && !isAttacking && !frozen)  {
			// Apuntamos hacia él
			face = sign(_player.x - x);
			target = _player ;
			isAttacking = true;
			attackStarted = false;
			sprite_index = sprAttack;
			image_index = 0;
		}
    }
	

}


if (isAttacking) && hp > 0 && objAttack != noone {
    // Solo si aún no disparó
    var _lastFrame = sprite_get_number(sprite_index) - 1;
    
    // Solo crea la bala 1 vez en el último frame
    if (floor(image_index) == _lastFrame && !attackStarted) {
        attackStarted = true;
		
		var _ataque = instance_create_depth(x+attackOffsetX*face,bbox_top+attackOffsetY,depth+1,objAttack)
		
  
    }
    
    // Cuando termina la animación, volvemos al estado normal
    if (image_index >= _lastFrame) {
        isAttacking = false;
        timerAttack = attackCooldown;
        sprite_index = sprIdle;
    }
}



if (timerAttack > 0) {
    timerAttack -= 1;
}





if frozen {
	if freezeTimer > 0 {
		x -=xspd;
		y -=yspd;
		xspd = 0;
		freezeTimer--;
		if freezeTimer <=0 || damageTimer>0{frozen = false;freezeTimer = 0;};
		image_blend = c_blue;
	}else {
		freezeTimer = freezeTime;
		image_blend = c_white;
	}
}

//Sprites
if hp <= 0 && sprite_index != sprDeath{
	sprite_index = sprDeath;
	image_index = 0;
	image_blend = c_white;
	x -=xspd; 
	mask_index = -1;

}else {
	if !isAttacking {
	if abs(xspd) > 0 {sprite_index = sprWalk};
	if abs(xspd) == 0 {sprite_index = sprIdle};
	}
	mask_index = sprIdle;
	
}
