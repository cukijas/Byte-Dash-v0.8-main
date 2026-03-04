
var cam = view_camera[0];
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);


var target_x = x - (cam_w / 2);
var target_y = y - (cam_h / 2);


target_x = clamp(target_x, 0, room_width - cam_w);
target_y = clamp(target_y, 0, room_height - cam_h);

var current_x = camera_get_view_x(cam);
var current_y = camera_get_view_y(cam);

var lerp_speed = 0.1; // Ajusta esto para cambiar la velocidad de suavizado

var new_x = lerp(current_x, target_x, lerp_speed);
var new_y = lerp(current_y, target_y, lerp_speed);


camera_set_view_pos(cam, new_x, new_y);