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

finalCamX = _camX;
finalCamY = _camY;
