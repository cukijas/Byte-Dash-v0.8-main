if sprite_index == spr_player_death {
	audio_play_sound(electric_explosion, 1, false);

	var _lastFrame = sprite_get_number(sprite_index) -1;
	if image_index >= _lastFrame {
		room_restart();
	}	
};


var alphaToDraw = 1; // ← NUEVA VARIABLE PARA MANEJAR EL TITILEO
//inputs
getControls();

if (variable_global_exists("dialogo_activo") && global.dialogo_activo == true) {
    // Forzamos todas las variables de input a 0 (falso)
    rightKey = 0;
    leftKey = 0;
    downKey = 0;
    jumpKey = 0;
    jumpKeyBuffered = 0;
    jumpKeyPressed = 0;
    attackKey = 0;
    dashKey = 0;
    brickKey = 0;
    
    // Opcional: Detenemos cualquier impulso restante (como el dash o el knockback de daño)
    xspd = 0;
}


#region colision plataformas moviles solidas
//Mover al jugador al entrar en contacto con plataformas solidas
var _rightWall = noone;
var _leftWall = noone;
var _bottomWall = noone;
var _topWall = noone;

var _wallList = ds_list_create();

var _amtWalls = instance_place_list(x,y,obj_moving_wall, _wallList,false);

for (var i = 0 ; i < _amtWalls ; i++){
	var _instance = _wallList[| i];
	
	//Buscamos las plataformas mas cercanas en cada direccion
	
	//Derecha
	
	if _instance.bbox_left - _instance.xspd >= bbox_right-1 {
		if !instance_exists(_rightWall) || _instance.bbox_left < _rightWall.bbox_left {

			_rightWall = _instance;
		}
	}
	
	// Izquierda
	
	if _instance.bbox_right - _instance.xspd <= bbox_left + 1 {
		if !instance_exists(_leftWall) || _instance.bbox_right > _leftWall.bbox_right {
			_leftWall = _instance;
			
		}
	}
	
	if _instance.bbox_top - _instance.yspd >= bbox_bottom -1 {
		if !instance_exists(_bottomWall) || _instance.bbox_top < _bottomWall.bbox_top {
			_bottomWall = _instance;
		}
	}
	
	if _instance.bbox_bottom - _instance.yspd <= bbox_top+1 {
		if !instance_exists(_topWall) || _instance.bbox_bottom > _topWall.bbox_top {
			_topWall = _instance;
		
		}
	
	}
	
	
}


ds_list_destroy(_wallList);
	

//Movemos al jugador segun las plataformas encontradas
if instance_exists(_rightWall){
	var _rightDist = bbox_right - x;
	x = _rightWall.bbox_left - _rightDist;
}

if instance_exists(_leftWall) {
	var _leftDist = x - bbox_left;
	x = _leftWall.bbox_right + _leftDist;
}

if instance_exists(_bottomWall){
	var _bottomDist = bbox_bottom - y;
	y = _bottomWall.bbox_top - _bottomDist;
}

if instance_exists(_topWall) {
	var _topDist = y - bbox_top;
	var _targetY = _topWall.bbox_bottom + _topDist;
	
	if !place_meeting(x,_targetY,obj_wall){
		y =_targetY;
	}

}


#endregion

earlyMovePlatXSpd = false;

//No quedar fuera de las plataformas con movimiento ya que se mueven en el begin step
if instance_exists(myFloorPlat) 
&& myFloorPlat.xspd != 0 
&& !place_meeting(x,y+termVel+1,myFloorPlat){
	
	if !place_meeting(x + myFloorPlat.xspd, y ,obj_wall){
		x += myFloorPlat.xspd;
		earlyMovePlatXSpd = true;
	}
}
//Agacharse
if downKey && onGround{
	crouching = true;
}
// cambiamos nuestra collision mask
if crouching {mask_index = crouchSpr;}

//dejar de agacharnos
if crouching && (!downKey || !onGround) {
	//controlamos que sea posible dejar de agacharse
	mask_index = idleSpr;
	
	if !place_meeting(x,y,obj_wall){
		crouching = false;
	}else{
		mask_index = crouchSpr;
	}
}

//Movimiento en X
//Direccion
movDir = rightKey - leftKey ;

if movDir !=0 {face = movDir};

if crouching {movDir = 0};


//calculamos velocidad en x
if onGround {runType = runKey;}
xspd = movDir * movSpd[runType];
if attacking {xspd = movDir * attackingSpd};

if dashKey && dashCooldownTimer <= 0{
	dashTimer = dashDuration;
	dashCooldownTimer = dashCooldown;
};

if dashTimer >0 {
	xspd = face*dashSpd;
	dashTimer--;
}else if dashCooldownTimer > 0 {
	dashCooldownTimer--;
}


if place_meeting(x+xspd,y,obj_damage_player){
	var _instance = instance_place(x+xspd,y,obj_damage_player);
	
	
	if damageTimer <= 0 {
		hp -= _instance.damage;
		vidas -= 1;
		parpadeoTimer = 20; // 30 frames (~0.5s) de titileo
		damageTimer = damageCooldown;
		damager = _instance;
		if damager.x <= x {dirDamage = 1}else {dirDamage = -1};	
		audio_play_sound(prota_dmg, 1, false);
		show_debug_message("vida actual: "+string(hp))
	}
	
}

//Mauri no quiero romper tu estructura de code le ubico aca ( hace que el contador baje 1 por frame)


if (parpadeoTimer > 0) {
    parpadeoTimer -= 1;
	xspd = 3 * dirDamage;
    if (parpadeoTimer mod 6 < 3) {
        alphaToDraw = 0.5;
    }
}else{
	dirDamage = 0;

}


damageTimer--;



image_alpha = alphaToDraw;

//Colisiones en X
var _subPixel = 0.5;
if place_meeting(x + xspd, y, obj_wall){
	var _pixelCheck = _subPixel * sign(xspd);	
	while(!place_meeting(x+_pixelCheck,y,obj_wall)){x += _pixelCheck;};
	//colision
	xspd = 0;
}

//Movimiento en X
x += xspd;

//Movimento en Y
//Gravedad
if coyoteHangTimer > 0 {
	coyoteHangTimer--;
}else{
	yspd += grav;
	setOnGround(false);
	
}
//Limite de velocidad de caida
if yspd > termVel {yspd = termVel};
//Reseteo de variables de salto
if onGround {
	jumpCount = 0;
	jumpHoldTimer = 0;
	airAttackCount = 0;
}else{
	if jumpCount == 0 {jumpCount += 1;};
}
//Salto

//Revisamos si la plataforma es solida
var _floorIsSolid = false;

if instance_exists(myFloorPlat)
&& (myFloorPlat.object_index == obj_wall || object_is_ancestor(myFloorPlat.object_index, obj_wall)){
	_floorIsSolid = true;
}


//Podemos saltar si NO estamos presionando abajo o si el suelo es solido
//Caso contrario pasariamos a traves de la plataforma, el codigo para eso esta mas adelante

if jumpKeyBuffered && ((jumpCount < jumpMax && (!downKey  || _floorIsSolid ) ) || (0 < jumpCount && jumpCount < jumpMax))  {
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
	//Aumentamos la cantidad de saltos que se hicieron
	jumpCount++;
	// Timer de mantener el salto
	jumpHoldTimer = jumpHoldFrames[jumpCount-1]; 
	setOnGround(false);
	
};
/*La idea es mantener la velocidad negativa constante durante una cantidad de frames 
y despues empezar a sumar una velocidad positiva por la gravedad*/
if jumpHoldTimer > 0 {
	yspd = jSpd[jumpCount-1];
	jumpHoldTimer--;
}

if !jumpKey {
	jumpHoldTimer = 0;
}

if dashTimer >0 {
	yspd = 0;
}

middle = (bbox_top - bbox_bottom)/2 ;


if attackKey && !attacking {
	xface = face;
	attacking =true
	
	if !onGround {
		airAttackCount++;
	}
	
};


if attacking  && sprite_index == attackSpr{
	
	
	var _lastFrame = sprite_get_number(sprite_index) -1;
	var _scdLastFrame = sprite_get_number(sprite_index) -3;
	if instance_exists(myAttack){
		myAttack.x += xspd;
	
	}

	
	if floor(image_index) == floor(_scdLastFrame) && !instance_exists(myAttack) {

		var _attack = instance_create_depth(x + (sign(face)*3),bbox_top - middle,depth-1,obj_basic_attack);
		_attack.image_angle = point_direction(0,0,face,0);
		myAttack = _attack;
		myAttack.face = face;
	}else if floor(image_index) == floor(_lastFrame) && instance_exists(myAttack){
		instance_destroy(myAttack); 
		attacking= false;
	};
	
	
	if xface !=face {
		if instance_exists(myAttack){
			instance_destroy(myAttack);
	
		}
		attacking = false;
	}
	if airAttackCount <= airAttackMax {
		yspd = 0;
	} 
	
	
}



//Collisiones hacia arriba

if yspd < 0 && place_meeting(x,y + yspd, obj_wall){
	var _pixelCheck = _subPixel * sign(yspd);
	while !place_meeting(x, y + _pixelCheck, obj_wall){y+=_pixelCheck;};
	//Terminar salto en caso de estar colisionando con un muro encima del jugador
	if yspd <= 0 {jumpHoldTimer=0};
	yspd = 0;
}


//Colisiones de suelos

//Controlar la existencia de plataformas solidas y semisolidas debajo del jugador

var _clampYspd = max(0,yspd);
var _listInstances = ds_list_create(); //Esta lista es para almacenar los objetos con los cuales vamos a hacer contacto

// Ya que la funcion instance_place_list busca un solo tipo de estructura (o estructuras que hereden de la misma)
// Creo un array que guarde el objeto wall comun y el semi solid wall (este es padre de moving semi solid) esto es para poder bucar ambos

var _array = array_create(0);
array_push(_array, obj_wall, obj_semi_solid_wall);


// obtenemos una lista de todas las plataformas que entraran en contacto con el jugador en el siguiente frame
var _listSize = instance_place_list(x, y +1 + _clampYspd + termVel, _array, _listInstances, false); //devuelve el tamaño de la lista

//Recorremos todas las instacias y devolvemos las que tengan la parte mas alta por debajo del jugador

for (var i = 0; i<_listSize ; i++) {
	//Obtenemos una de las instancias
	var _instance =	_listInstances[| i]; // El caracter '|' es necesario
	
	if _instance != forgetSemiSolid //si no es una plataforma de la cual saltamos recientemente
	&& (_instance.yspd <= yspd || instance_exists(myFloorPlat) // si la plataforma va hacia arriba mas rapido que el jugador o si es la plataforma en la que estamos actualmente 
	&& (_instance.yspd > 0 || place_meeting(x, y + 1 + _clampYspd, _instance)) // si se esta moviendo hacia arriba o si en el siguiente frame el jugador va a entrar en contacto con la plataforma
	)
	{
		if _instance.object_index == obj_wall
		|| object_is_ancestor(_instance.object_index,obj_wall)
		|| floor(bbox_bottom) <= ceil(_instance.bbox_top - _instance.yspd) // si la parte de arriba de la plataforma estaba debajo del jugador al comienzo del frame (step)
		{
			if !instance_exists(myFloorPlat) // si no tenemos un plataforma en la que estemos parados
			|| _instance.bbox_top + _instance.yspd <= myFloorPlat.bbox_top + myFloorPlat.yspd // si la instancia va a una mayor velocidad hacia arriba que nuestra plataforma actual
			|| _instance.bbox_top + _instance.yspd <= bbox_bottom // si en el siguiente frame la plataforma va a estar abajo del jugador
			{
				myFloorPlat = _instance;
			
			}
		}
	}
};


//Destruimos la lista
ds_list_destroy(_listInstances);


// Ultimo control de que verdaderamente estamos encima de myFloorPlat
if instance_exists(myFloorPlat) && !place_meeting(x,y + termVel, myFloorPlat){
	myFloorPlat = noone;
}


if instance_exists(myFloorPlat){ // Si estamos parados en una plataforma
	//Mientras no estemos en contacto con nuestra plataforma y no entremos en contacto con una plataforma solida
	//Nos movemos hacia abajo usando el subpixel
	while !place_meeting(x, y + _subPixel,myFloorPlat) && !place_meeting(x,y,obj_wall){y +=_subPixel};
	
	//si la plataforma es semisolida y entramos en contacto con ella nos movemos hacia arriba
	//esto es para evitar salirnos de la parte solida de la plataforma y caernos
	if myFloorPlat.object_index == obj_semi_solid_wall 
	|| object_is_ancestor(myFloorPlat.object_index,obj_semi_solid_wall){
		while place_meeting(x,y, myFloorPlat) { y -= _subPixel};
	};
	y = floor(y);
	yspd = 0;
	setOnGround(true);
}



//Atravesar plataformas semisolidas al saltar mientras nos agachamos
if downKey && jumpKeyPressed{
	
	//Si tenemos una plataforma y esta es una semisolida
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == obj_semi_solid_wall 
	|| object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall)){
		//Revisamos si es que podemos bajar
		//para ello usamos una variable que toma la velocidad de nuestra plataforma y le sumamos uno
		//si es que esta es menor que 1, tomamos el valor 1, esto para asegurar que estemos comprobado correctamente la colision
		
		var _yCheck = max(1, myFloorPlat.yspd + 1); 
		
		//Si NO colisionamos con una pared solida podemos bajar
		if !place_meeting(x,y + _yCheck, obj_wall){
			y += 1; //bajamos
			//heredamos la velocidad de la plataforma (para que no nos agarre apenas bajamos)
			yspd = _yCheck-1;
			forgetSemiSolid = myFloorPlat; // guardamos la plataforma de la que nos bajamos para poder ignorarla
			setOnGround(false); // seteamos la variable que nos indica si estamos en el piso a false
			
			//ya que usamos el boton de salto, tenemos que asegurarnos que el buffer de salto no se active
			//en el sigioente frame. si no lo hacemos vamos a realizar el segundo salto automaticamente
			jumpKeyBufferTimer = 0; 
		}
	}
}


//Si NO existe colision con una pared solida podemos movernos hacia arriba 
//(aca recien se aplica todo lo que calculamos respecto al salto)
if !place_meeting(x,y + yspd,obj_wall){ y += yspd;};


//Si ya no nos encontramos en contacto con el semisolido que estabamos ignorando, liberamos la variable
//de esta forma podemos volver a subirnos a este semisolido
if instance_exists(forgetSemiSolid) && !place_meeting(x,y,forgetSemiSolid){forgetSemiSolid = noone;};


//guardamos la velocidad de nuestra plataforma (si estamos en una)
movePlatXSpd = 0;
if instance_exists(myFloorPlat){movePlatXSpd = myFloorPlat.xspd;};


//Este es el codigo que sirve para mover al jugador en el eje x con la plataforma movil si estamos encima de una

//Si no realizamos el movimiento al comienzo del frame (step)
if !earlyMovePlatXSpd {
	
	//si la plataforma a la que nos subimos va a causar que colisionemos contra un muro solido
	if place_meeting(x + movePlatXSpd, y, obj_wall){
		var _pixelCheck = _subPixel * sign(movePlatXSpd); //variable creada para asegurar que nos acercamos bien al muro
		//movemos al jugador hasta que estemos pegados a la pared
		while !place_meeting(x + _pixelCheck, y, obj_wall){ x += _pixelCheck};
		//estamos contra un muro, la plataforma puede seguir moviendose o no pero ponemos la variable 
		//que usamos para guardar su velocidad en 0 asi despues no nos movemos mas nosotoros
		movePlatXSpd = 0;
	}
	
	//nos movemos en el eje X con la plataforma
	x += movePlatXSpd;
}



//Esto es para seguir a la plataforma en el eje Y
//si estamos en una plataforma y esta es una plataforma movil
if instance_exists(myFloorPlat) && (myFloorPlat.yspd != 0 
|| myFloorPlat.object_index == obj_moving_wall 
|| object_is_ancestor(myFloorPlat.object_index, obj_moving_wall)
|| myFloorPlat.object_index == obj_moving_semi_solid_wall
|| object_is_ancestor(myFloorPlat.object_index,obj_moving_semi_solid_wall))
{
	
	if !place_meeting(x, myFloorPlat.bbox_top, obj_wall)//si la parte superior de la plataforma no entro en contacto con un muro solido
	&& myFloorPlat.bbox_top >= bbox_bottom-termVel //si esta por debajo de lo mas rapido que pued ellegar a car el jugador
		{y = myFloorPlat.bbox_top;} //nos movemos en el eje Y con la plataforma
	
}


//Este codigo es para que al momento de que un muro solido movil impacte al jugador 
//por arriba, lo tire de la plataforma semisolida en la que esta parado


if instance_exists(myFloorPlat)
&& (myFloorPlat.object_index == obj_semi_solid_wall 
|| object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall))
&& place_meeting(x,y,obj_wall)

{
	var _maxPushDist = 5;
	var _PushDist = 0;
	var _startY = y;
	
	while (place_meeting(x,y,obj_wall) && _PushDist <= _maxPushDist){
		y++;
		_PushDist++;
	}
	
	setOnGround(false);
	
	if _PushDist > _maxPushDist {y = _startY};

}


if brickKey && !instance_exists(obj_fire_brick){
	
	var _fireBrick = instance_create_depth(x+16*face,bbox_bottom,depth+1, obj_fire_brick);
	

};
freezeShot();




//Para debugguear sacar cuando no se use mas
//el jugador se pone azul cuando esta atrapado en una pared solida
image_blend = c_white;
if(place_meeting(x,y,obj_wall)) {
	
	image_blend = c_blue;
	

}




//Sprites
if hp <= 0 {
	sprite_index = deathSpr;
	x -=xspd; 
	y -=yspd;
	
	mask_index = -1;
}else if attacking{
	sprite_index = attackSpr;
	mask_index = maskSpr;
	if _tape {
		image_index = 0;
		_tape = false;
	}
}else{
	_tape = true;
	// si la velocidad del jugador en mayor a 0 se pone el sprite de caminar
	if abs(xspd) > 0 {sprite_index = walkSpr;}; 
	//si la velocidad es mayor a la de caminar, se usa el sprite de correr
	if abs(xspd) >= movSpd[1] {sprite_index = runSpr;}; 

	// si la velocidad es 0 el se usa el sprite de estar parado
	if abs(xspd) == 0 {sprite_index = idleSpr;};

	//si el jugador no esta en el piso se usa el sprite de saltar
	if !onGround {sprite_index = jumpSpr;};

	//si el jugador esta agachado se usa el sprite de agacharse
	if crouching {sprite_index = crouchSpr;};
	
	//se usa la misma mask para calcular las colisiones de todos los sprites
	mask_index = maskSpr;
	//menos al momento de agacharse, esta mask tiene la mitad de altura pero lo mismo de ancho que el mask normal
	if crouching {mask_index = crouchSpr;};
}