
//con F11 se pone y saca la pantalla completa :D
if keyboard_check_pressed(vk_f11){
	window_set_fullscreen(!window_get_fullscreen());
};


// salir si no existe un jugador
if !instance_exists(obj_player) {exit};


// variables del tamaño de la camara
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

// coordenadas del jugador (target de la camara)

var _camX = obj_player.x - _camWidth/2; 
var _camY = obj_player.y - _camHeight/2;



//Limitar la camara al final del nivel

_camX = clamp(_camX,0, room_width - _camWidth);
_camY = clamp(_camY,0,room_height - _camHeight);



// suavizado de movimiento de camara

finalCamX += (_camX - finalCamX) * camTrailSpd;
finalCamY += (_camY - finalCamY) * camTrailSpd;



// aplicamos las coordenadas a la camara
camera_set_view_pos(view_camera[0],finalCamX, finalCamY);


