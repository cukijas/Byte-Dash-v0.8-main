

if place_meeting(x,y,obj_enemy){
	
	var _instance = instance_place(x,y,obj_enemy);
	_instance.frozen = true;
	instance_destroy();
}


if time >= shotLimit {
	instance_destroy();
	
}

xspd = spd*dir;

x += xspd;

time++