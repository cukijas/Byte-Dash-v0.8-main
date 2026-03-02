//Funciones del jugador

function setOnGround(_val = true){
	if _val == true{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames
	}else{
		onGround = false;
		coyoteHangTimer = 0;
		myFloorPlat = noone;
	}
}

function checkForSemiSolidPlat(_x, _y){
	var _found = noone;
	if yspd >=0 && place_meeting(_x,_y,obj_semi_solid_wall){
		var _list = ds_list_create();
		var _listSize = instance_place_list(_x,_y, obj_semi_solid_wall,_list,false);
		for (var i = 0; i < _listSize; i++){
			var _instance = _list[| i];
			if _instance != forgetSemiSolid && floor(bbox_bottom) <= ceil(_instance.bbox_top - _instance.yspd){
				_found = _instance;
				i = _listSize;
			}
		}
		ds_list_destroy(_list);
	}
	return _found;
}

controlsSetup();

depth = -30;


hp = 20;
damageTimer = 0;
damageCooldown = 20;
damager = noone;
dirDamage = 0;

//Sprites


maskSpr = spr_player_idle;
idleSpr = spr_player_idle;
walkSpr = spr_player_walk;
runSpr = spr_player_run;
jumpSpr = spr_player_jump;
crouchSpr = spr_player_crouch;
deathSpr = spr_player_death;
attackSpr = spr_player_attack;

_tape = false;
//Movimiento


face = 1;
xface = 0;
movDir = 0;
runType = 0;
movSpd[0] = 3;
movSpd[1] = 4;

xspd = 0;
yspd = 0;

//Variables de estado
crouching = false;



//Saltar

grav = 0.275;
termVel = 8;
jSpd[0] = -4.15;
jSpd[1] = -4.15;

jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;
jumpHoldFrames[0] = 10;
jumpHoldFrames[1] = 5;
onGround = 1;


//Coyote Time

coyoteHangFrames = 4;
coyoteHangTimer = 0; 



//Plataformas q se mueven

forgetSemiSolid = noone;
earlyMovePlatXSpd = false;
downSlopeSemiSolid = noone;
myFloorPlat = noone;
movePlatXSpd = 0;

//Atacar
myAttack = noone;
middle = 0;
airAttackMax = 2;
airAttackCount = 0;
attacking = false;
attackingSpd = 1;


//dash
dashSpd = 10;
dashDuration = 5;
dashTimer = 0;
dashCooldownTimer = 0;
dashCooldown = 60;
dashAirHold = 4;

//Vidas
vidas = 10; // vidas actuales (por ahora 10)
vidas_max = 10; // hud automatico?
parpadeoTimer = 0;

function freezeShot() {
	if fsKey && !instance_exists(obj_freeze_shot){
		var _freezeShot = instance_create_depth(x,bbox_top - middle,depth+31, obj_freeze_shot);
		_freezeShot.image_angle = point_direction(0,0,face,0);
		_freezeShot.dir = face;
		show_debug_message(face);
	}


}


