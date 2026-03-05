if texto == "Volver a Menu"
{
	room_goto(menu);

}
if texto == "Jugar"
{
	room_goto(Room1);

}
if texto == "Salir"
{
	game_end();

}
if texto == "Configuracion"
{
	room_goto(config);
}