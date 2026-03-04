// Avanzar a la siguiente línea de texto
current_line += 1;

// Verificar si hemos llegado al final de la lista
if (current_line >= array_length(dialog_lines)) {
    // Al finalizar el diálogo, ir a una room de "Gracias por jugar" o Reiniciar
    show_message("FIN DE LA DEMO - ¡Gracias por jugar!");
    
    // Aquí puedes cambiar a una room de menú:
    // room_goto(rm_main_menu); 
	
	global.dialogo_activo = false;
    
    // O simplemente reiniciar el juego para esta demo:
    game_restart();
    
    // Muy importante: destruir este objeto para que no siga ejecutándose
    instance_destroy(); 
}