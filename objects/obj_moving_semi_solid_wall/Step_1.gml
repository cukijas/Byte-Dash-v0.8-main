
//obtenemos direccion
dir += rotSpd;

// obtenemos las posiciones objetivo

var _xTarget = xstart + lengthdir_x(radius, dir);
var _yTarget = ystart + lengthdir_y(radius, dir);


xspd = _xTarget - x;

yspd = _yTarget - y;

//Movimiento

x += xspd;
y += yspd;